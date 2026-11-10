Custom configurations extend the audit coverage of built-in baselines. They can also apply approved settings when packaged and assigned for remediation. The two built-in baseline policy definitions used for the audit exercise remain audit-only.

The following workflow separates auditing from applying changes.

| Workflow step | Tool or action |
|---|---|
| **Author configuration** | Define the desired state with PowerShell DSC and platform-compatible resources |
| **Package configuration** | Create an `Audit` package with `New-GuestConfigurationPackage` |
| **Test locally** | Inspect compliance on a disposable test VM |
| **Publish package** | Upload the ZIP to an authorized, reachable HTTPS location |
| **Create and import policy** | Generate an audit definition with `New-GuestConfigurationPolicy` and import it into Azure |
| **Assign and review** | Assign the audit policy to an eligible pilot and review findings |
| **Prepare enforcement** | Build and test a separate `AuditAndSet` package, publish it, and generate a deployment policy |
| **Deploy approved changes** | Configure the assignment identity and initial remediation for existing machines |

## When to use custom configurations

Contoso Manufacturing has requirements that built-in baselines don't address. Factory automation software requires a particular registry DWORD on its Windows Server hosts. The manufacturing execution system also relies on the Contoso Manufacturing Scheduler service. Linux application hosts need an approved TLS configuration for communication with industrial controllers.

Custom configurations can audit organization-specific values and, with suitable resource implementations, apply approved changes. They can manage registry values, inspect application settings, and verify service state or file permissions.

> [!NOTE]
> Before writing a resource, inspect whether the selected baseline supports an approved `BaselineSettings` override for your audit requirement. The customizable-baseline portal experience is in preview and isn't available in Azure Government or sovereign clouds. Keep approved settings in source control and review exclusions as exceptions, not evidence that a machine was hardened. Baseline customization doesn't enable the audit-only policies to apply changes. Review the baseline JSON's rule-selection and exclusion semantics before using an exported payload, because listing only selected rules can remove the other rules from audit coverage.
>
> Separately, a remediation-capable baseline exposed through the public-preview catalog can apply selected settings using its own opt-in controls. This doesn't change the capabilities of an audit-only policy definition or ZIP.

## Set up the authoring environment

The `GuestConfiguration` PowerShell module packages, tests, and generates policies for custom configurations. This Windows example uses the documented `PSDesiredStateConfiguration` 2.0.7 compiler and project-owned class-based resources. The resource implementation and manifest are part of the exercise, not assumed built-in modules.

> [!IMPORTANT]
> Use a disposable supported Windows test VM with a currently supported PowerShell 7 release that meets the authoring requirements. Run the following commands in an elevated PowerShell 7 session on that test VM. Local package testing installs a test agent and requires elevation. Don't run remediation tests on a production server or your ordinary workstation.
>
> Install the Contoso application before testing its service configuration. `ContosoScheduler` is an example internal service name, not a service included with Windows. Replace it with the application's actual service name. The service must exist, be correctly configured, and not be disabled. This exercise doesn't install application binaries, change service credentials, or configure service startup type.

Install and import the authoring modules:

```powershell
Install-Module -Name GuestConfiguration -Scope CurrentUser -ErrorAction Stop
Install-Module -Name PSDesiredStateConfiguration -RequiredVersion 2.0.7 -Scope CurrentUser -ErrorAction Stop
Import-Module -Name GuestConfiguration -ErrorAction Stop
Import-Module -Name PSDesiredStateConfiguration -RequiredVersion 2.0.7 -ErrorAction Stop
```

The policy-publication steps require `Az.Resources` and its `Az.Accounts` dependency. `GuestConfiguration` doesn't install them automatically. In the same disposable lab environment, install `Az.Resources` if a supported version isn't already available through an existing Azure PowerShell installation:

```powershell
Install-Module -Name Az.Resources -Repository PSGallery -Scope CurrentUser -ErrorAction Stop
Import-Module -Name Az.Resources -ErrorAction Stop
Get-Command -Name New-AzPolicyDefinition, Connect-AzAccount, Get-AzContext -ErrorAction Stop
```

If the necessary modules are already installed, skip the installation command and retain the import and command-availability check.

Keep the same authoring session for the directory, module-path, and compilation steps. Create a versioned directory for the exercise's resource module:

```powershell
$resourceRoot = Join-Path (Get-Location) 'resource-modules'
$moduleFolder = Join-Path $resourceRoot 'ContosoMachineConfig\1.0.0'
New-Item -ItemType Directory -Path $moduleFolder -Force -ErrorAction Stop | Out-Null
```

### Implement the Windows resources

Save the following code as `ContosoMachineConfig.psm1` in `$moduleFolder`. This is a locally maintained exercise module, not a Microsoft-distributed module to install from the Gallery. Each resource implements `Get`, `Test`, and `Set`. Its `Reasons` property describes a configuration mismatch. Missing services and access errors are surfaced rather than silently treated as success.

```powershell
class ContosoMachineConfigReason {
    [DscProperty()]
    [string] $Code

    [DscProperty()]
    [string] $Phrase
}

[DscResource()]
class ContosoRegistryDword {
    [DscProperty(Key)]
    [string] $Key

    [DscProperty(Key)]
    [string] $ValueName

    [DscProperty(Mandatory)]
    [int] $Value

    [DscProperty(NotConfigurable)]
    [bool] $Present

    [DscProperty(NotConfigurable)]
    [bool] $IsDword

    [DscProperty(NotConfigurable)]
    [ContosoMachineConfigReason[]] $Reasons

    [ContosoRegistryDword] Get() {
        $current = [ContosoRegistryDword]::new()
        $current.Key = $this.Key
        $current.ValueName = $this.ValueName
        $current.Reasons = @()

        if (Test-Path -LiteralPath $this.Key -ErrorAction Stop) {
            $registryKey = Get-Item -LiteralPath $this.Key -ErrorAction Stop
            try {
                if ($registryKey.GetValueNames() -contains $this.ValueName) {
                    $current.Present = $true
                    $current.IsDword = $registryKey.GetValueKind($this.ValueName) -eq [Microsoft.Win32.RegistryValueKind]::DWord
                    if ($current.IsDword) {
                        $current.Value = [int] $registryKey.GetValue($this.ValueName)
                    }
                }
            }
            finally {
                $registryKey.Close()
            }
        }

        if (-not ($current.Present -and $current.IsDword -and $current.Value -eq $this.Value)) {
            $reason = [ContosoMachineConfigReason]::new()
            $reason.Code = 'ContosoRegistryDword:ContosoRegistryDword:ValueMismatch'
            $reason.Phrase = "Expected DWORD '$($this.ValueName)' at '$($this.Key)' with value $($this.Value)."
            $current.Reasons = @($reason)
        }

        return $current
    }

    [bool] Test() {
        $current = $this.Get()
        return $current.Present -and $current.IsDword -and $current.Value -eq $this.Value
    }

    [void] Set() {
        if (-not (Test-Path -LiteralPath $this.Key -ErrorAction Stop)) {
            New-Item -Path $this.Key -Force -ErrorAction Stop | Out-Null
        }
        New-ItemProperty -LiteralPath $this.Key -Name $this.ValueName `
            -Value $this.Value -PropertyType DWord -Force -ErrorAction Stop | Out-Null
    }
}

[DscResource()]
class ContosoRunningService {
    [DscProperty(Key)]
    [string] $Name

    [DscProperty(NotConfigurable)]
    [string] $State

    [DscProperty(NotConfigurable)]
    [ContosoMachineConfigReason[]] $Reasons

    [ContosoRunningService] Get() {
        $service = Get-Service -Name $this.Name -ErrorAction Stop
        $current = [ContosoRunningService]::new()
        $current.Name = $this.Name
        $current.State = $service.Status.ToString()
        $current.Reasons = @()
        if ($current.State -ne 'Running') {
            $reason = [ContosoMachineConfigReason]::new()
            $reason.Code = 'ContosoRunningService:ContosoRunningService:NotRunning'
            $reason.Phrase = "Service '$($this.Name)' is $($current.State); expected Running."
            $current.Reasons = @($reason)
        }
        return $current
    }

    [bool] Test() {
        return $this.Get().State -eq 'Running'
    }

    [void] Set() {
        Start-Service -Name $this.Name -ErrorAction Stop
    }
}
```

Create the manifest that exports the two resources, then add the resource directory to the authoring session's module search path:

```powershell
New-ModuleManifest `
    -Path (Join-Path $moduleFolder 'ContosoMachineConfig.psd1') `
    -RootModule 'ContosoMachineConfig.psm1' `
    -ModuleVersion '1.0.0' `
    -DscResourcesToExport @('ContosoRegistryDword', 'ContosoRunningService') `
    -FunctionsToExport @() `
    -CmdletsToExport @() `
    -VariablesToExport @() `
    -AliasesToExport @() `
    -ErrorAction Stop

$env:PSModulePath = $resourceRoot + [IO.Path]::PathSeparator + $env:PSModulePath
```

### Compile the configuration

After the module files and manifest exist, save the following as `ContosoFactoryBaseline.ps1` in the working directory. Resources appear directly inside the configuration. The DSC 2.0 workflow doesn't support a `Node` block.

```powershell
Configuration ContosoFactoryBaseline {
    Import-DscResource -ModuleName 'ContosoMachineConfig' -ModuleVersion '1.0.0'

    ContosoRegistryDword FactoryProtocolEnabled {
        Key = 'HKLM:\Software\Contoso\Factory'
        ValueName = 'ProtocolEnabled'
        Value = 1
    }

    ContosoRunningService ManufacturingScheduler {
        Name = 'ContosoScheduler'
    }
}

ContosoFactoryBaseline -OutputPath '.\output'
```

Load the script in the prepared authoring session:

```powershell
. .\ContosoFactoryBaseline.ps1
```

The compiler creates `.\output\localhost.mof`. This compiled configuration becomes the packaging input. The authoring environment needs the resource module on `PSModulePath` so the packager can include it. Managed machines receive those dependencies in the ZIP and use the agent's execution environment.

## Package and test an audit configuration

Create an audit-only package and evaluate it on the disposable test VM:

```powershell
New-GuestConfigurationPackage `
    -Name 'ContosoFactoryBaseline' `
    -Configuration '.\output\localhost.mof' `
    -Type Audit `
    -Path '.\packages-audit' `
    -ErrorAction Stop

Get-GuestConfigurationPackageComplianceStatus `
    -Path '.\packages-audit\ContosoFactoryBaseline.zip' `
    -ErrorAction Stop
```

The ZIP contains the compiled configuration, resource dependencies, and metadata. Review per-resource results, not just the overall status. On the isolated test VM, test missing or incorrect registry values, the wrong registry value type, a stopped existing service, and an already compliant machine. Confirm that a missing service or access error produces an actionable failure.

## Publish a package with authorized access

Machine Configuration packages must be downloadable over HTTPS by the target machines. Azure Blob Storage is the recommended host, but suitable repository or web-server HTTPS locations are also supported. Public blobs and appropriately scoped read-only shared access signature (SAS) URLs are options, not requirements. Plan SAS renewal if you use that method.

For this example, use a private Blob Storage container and system-assigned identity downloads:

1. Create or select a storage account and container. Disable anonymous access and configure the required storage network path.
1. Using the Azure portal or Storage Explorer with an identity authorized to write blob data, upload `.\packages-audit\ContosoFactoryBaseline.zip` as `v1.0.0-audit/ContosoFactoryBaseline.zip`. Record the HTTPS blob URL.
1. Grant each target machine's system-assigned identity **Storage Blob Data Reader** at the container scope. These download permissions are separate from the policy assignment identity's deployment permissions.
1. Confirm that every pilot machine can resolve and reach both the Machine Configuration service and the content location. A working service connection doesn't prove that a private package URL is reachable.

> [!NOTE]
> System-assigned identity package downloads are supported for Azure VMs and Arc-enabled servers. Don't apply the Azure VM user-assigned identity download example unchanged to Arc. Storage authorization doesn't create a private network route. Check DNS, outbound HTTPS, and any storage private endpoints or firewall rules independently.

## Create, import, and assign the audit policy

Replace the tenant and subscription placeholders with the intended values, sign in to Azure PowerShell interactively, and inspect the resulting context:

```powershell
Connect-AzAccount -Tenant '<tenant-id>' -Subscription '<subscription-id>' -ErrorAction Stop
Get-AzContext -ErrorAction Stop
```

Continue only when the context identifies the intended tenant and subscription. Confirm separately that the signed-in identity can create policy definitions in the target management group. Signing in or selecting a subscription doesn't grant management-group permissions or authority to create role assignments.

Replace the storage URL and management-group placeholder below. The local ZIP must be byte-for-byte identical to the published blob.

```powershell
$auditPackagePath = (Resolve-Path '.\packages-audit\ContosoFactoryBaseline.zip' -ErrorAction Stop).Path
$auditContentUri = 'https://<storage-account>.blob.core.windows.net/<private-container>/v1.0.0-audit/ContosoFactoryBaseline.zip'
$managementGroupId = '<management-group-id>'

# Generate once for a new definition; retain this ID for updates.
$auditPolicyId = (New-Guid).Guid

$auditPolicyParameters = @{
    PolicyId = $auditPolicyId
    ContentUri = $auditContentUri
    LocalContentPath = $auditPackagePath
    DisplayName = 'Audit approved Contoso factory settings'
    Description = 'Audits registry and existing-service settings on tagged application hosts'
    Platform = 'Windows'
    PolicyVersion = '1.0.0'
    Mode = 'Audit'
    Path = '.\policies-audit'
    Tag = @{ Workload = 'ContosoFactory' }
}

$auditPolicy = New-GuestConfigurationPolicy @auditPolicyParameters -UseSystemAssignedIdentity -ErrorAction Stop

New-AzPolicyDefinition `
    -Name 'contoso-factory-baseline-audit' `
    -Policy $auditPolicy.Path `
    -ManagementGroupName $managementGroupId `
    -ErrorAction Stop
```

`LocalContentPath` supplies the artifact information for the authorized-download scenario. `-Platform Windows` selects an operating system, not an installed application. Tag the intended application hosts with `Workload=ContosoFactory`. The tag filter is generated into the definition and isn't an editable assignment parameter.

In **Azure Policy > Definitions**, select the imported audit policy and choose **Assign**. Begin with a small resource-group pilot within the management group. Confirm that its machines match the OS and workload filters and have the required application installed.

> [!IMPORTANT]
> For each custom policy assignment intended to cover Arc-enabled servers, set `IncludeArcMachines` to `true` in the assignment parameters. The generated parameter defaults to the string `"false"`. When supplying a PowerShell parameter object, use `IncludeArcMachines = 'true'`, not a Boolean value.
>
> Configure Arc inclusion independently for the audit assignment, the enforcement assignment, and any separate Linux assignment. Enabling it on the built-in baseline assignments doesn't enable it on custom assignments. `Platform='Windows'` still excludes Linux machines, and the workload tag must still match.
>
> `UseSystemAssignedIdentity` selects the package-download identity. It doesn't grant storage permissions or opt Arc machines into policy scope. Retain the package-access checks and review applicable hybrid charges.

Review the latest guest-assignment report, evaluation time, and per-resource reasons. Investigate missing reports, package authorization failures, and execution errors before interpreting a result as setting drift.

## Build and test a change-capable package

An audit-only ZIP can't apply settings merely because the policy mode changes. After reviewing the audit findings, build a separate `AuditAndSet` artifact:

```powershell
New-GuestConfigurationPackage `
    -Name 'ContosoFactoryBaseline' `
    -Configuration '.\output\localhost.mof' `
    -Type AuditAndSet `
    -Path '.\packages-enforce' `
    -ErrorAction Stop
```

> [!WARNING]
> `Start-GuestConfigurationPackageRemediation` changes the machine on which it runs. Run the following commands only in an elevated PowerShell 7 session on the approved disposable test VM. Confirm the final report, application behavior, and recovery procedure. A successful command alone doesn't prove that the workload remains healthy.

```powershell
$packagePath = '.\packages-enforce\ContosoFactoryBaseline.zip'

Get-GuestConfigurationPackageComplianceStatus -Path $packagePath -ErrorAction Stop
Start-GuestConfigurationPackageRemediation -Path $packagePath -ErrorAction Stop
Get-GuestConfigurationPackageComplianceStatus -Path $packagePath -ErrorAction Stop
```

Repeat the noncompliant and compliant test cases. Confirm that settings can be corrected repeatedly without unintended changes. A disabled or missing application service must be repaired through the application's deployment process rather than hidden by the resource.

## Deploy approved custom remediation

Upload the exact tested `AuditAndSet` ZIP to a different versioned location, such as `v1.0.0-enforce/ContosoFactoryBaseline.zip`, using the same access controls. Don't overwrite the audit artifact.

Generate and import a separate enforcement definition:

```powershell
$enforcePackagePath = (Resolve-Path '.\packages-enforce\ContosoFactoryBaseline.zip' -ErrorAction Stop).Path
$enforceContentUri = 'https://<storage-account>.blob.core.windows.net/<private-container>/v1.0.0-enforce/ContosoFactoryBaseline.zip'

# This is a different definition from the audit policy.
$enforcePolicyId = (New-Guid).Guid

$enforcePolicyParameters = @{
    PolicyId = $enforcePolicyId
    ContentUri = $enforceContentUri
    LocalContentPath = $enforcePackagePath
    DisplayName = 'Apply approved Contoso factory settings'
    Description = 'Maintains approved registry and existing-service settings on tagged application hosts'
    Platform = 'Windows'
    PolicyVersion = '1.0.0'
    Mode = 'ApplyAndAutoCorrect'
    Path = '.\policies-enforce'
    Tag = @{ Workload = 'ContosoFactory' }
}

$enforcePolicy = New-GuestConfigurationPolicy @enforcePolicyParameters -UseSystemAssignedIdentity -ErrorAction Stop

New-AzPolicyDefinition `
    -Name 'contoso-factory-baseline-enforce' `
    -Policy $enforcePolicy.Path `
    -ManagementGroupName $managementGroupId `
    -ErrorAction Stop
```

Assign the deployment policy to the approved pilot, configure its managed identity, and grant the roles listed in the generated definition's `roleDefinitionIds`. The portal can create those role assignments only when the operator has the required authority. Scripted assignment requires explicit role grants. If the pilot includes Arc-enabled servers, explicitly set `IncludeArcMachines` to `true` on this enforcement assignment too.

> [!IMPORTANT]
> Existing noncompliant machines need an initial remediation deployment for the custom enforcement policy, not just for the prerequisite initiative. Select **Create a remediation task** during portal assignment or create a task afterward. Inspect the deployment result and guest-assignment state. After successful deployment, `ApplyAndAutoCorrect` corrects later drift locally at the next evaluation. You don't need recurring Azure Policy remediation tasks for continuous correction.

Use `ApplyAndMonitor` when you want to monitor guest-only drift without continuous correction. It isn't a guarantee that changes happen only when an administrator manually starts a remediation task. With Azure Policy enforcement enabled, Azure VM resource updates, such as changing tags, resizing the VM, or attaching a disk, can cause the configuration to be reapplied. Updating the guest-assignment resource can also trigger remediation, even when its properties don't change. Account for these triggers in the approved rollout and expand the assignment only after the application owner approves the pilot.

`DoNotEnforce` controls Azure Policy's enforcement of the policy effect. It doesn't act as a stop switch for an already deployed `ApplyAndAutoCorrect` guest assignment. Use the documented guest-assignment controls when remediation must stop, and restore earlier settings separately when necessary.

Check for conflicting desired states from Group Policy, other management tools, and other packages. Record original settings and a restoration procedure. Implement approved exceptions through scope controls or an authorized policy exemption. An exemption alone doesn't remove an existing guest assignment. Delete that guest assignment when scanning must stop and confirm that another applicable assignment won't recreate coverage.

> [!WARNING]
> The machine tag `CustomGuestConfigurationSetPolicy=disable` disables remediation for custom content only. It doesn't disable Microsoft's built-in content, stop all auditing, or undo settings already changed. Confirm that the agent has received the change before relying on it, then use an approved restoration procedure if settings must be reverted. Assignment deletion isn't rollback, and manually created guest assignments can require separate cleanup.

`ApplyAndAutoCorrect` can return a compliant result after correcting drift. The compliance dashboard isn't a complete history of every corrected change. Use additional operational telemetry when that history is required.

## Protect and maintain package releases

> [!IMPORTANT]
> Never put passwords, tokens, private keys, or confidential application data in a package. Its resources and dependencies run with high local privileges. Review the content and keep the uncompressed package within the documented 100-MB limit.

Treat published releases as immutable. For a changed release, publish the tested artifact to a new versioned URL, increase `PolicyVersion`, and rerun the policy generator so its content hash matches the final ZIP. Sign before generating that hash when signing is required. Retain previous artifacts and the approved restoration procedure.

Updating a policy definition can affect existing assignments that reference it. First create a separately named candidate definition with a new generator `PolicyId` and assign it only to an isolated pilot. Use pilot machines outside existing conflicting enforcement assignments. After validating the candidate, promote the release into the original definition resources rather than accidentally creating replacement definitions.

For an update to an original definition, retain both its generator `PolicyId` and its actual Azure resource identity. In this example, the imported resource names are `contoso-factory-baseline-audit` and `contoso-factory-baseline-enforce` at `$managementGroupId`. Reimport the revised JSON using the same `New-AzPolicyDefinition -Name` and management-group scope for the definition being updated. Recording only the generator GUID isn't enough when the import uses a different explicit resource name.

After promotion, evaluate the original policy assignments and inspect their existing guest assignments, not just the candidate pilot's assignments. Confirm the expected `contentUri`, `contentHash`, and `assignmentType`, then review fresh reports and application behavior. Run scoped remediation for eligible noncompliant deployments where required. If a guest assignment still references old content, diagnose the update path and use the supported guest-assignment update or deployment workflow before declaring the rollout complete. A policy metadata-version increment or a compliant result alone doesn't establish which package is running.

> [!WARNING]
> Don't leave a pilot machine under two `ApplyAndAutoCorrect` assignments with conflicting desired values. Prefer isolated pilot machines. If reusing an existing target, first prevent the old policy from recreating its enforcement assignment, remove the old guest assignment as appropriate, and verify that the old enforcement has stopped before activating candidate enforcement. An exemption alone doesn't stop the existing guest assignment, and assignment deletion doesn't restore earlier settings.

Changing only a URL or overwriting a blob can leave the policy's integrity hash mismatched. Diagnose download, hash, and execution errors using the guest-assignment report and agent logs before widening deployment. Don't delete and recreate every guest assignment as a routine update step without establishing that the specific update requires it.

> [!NOTE]
> Package signing is optional. If you require signed packages, sign before publication and policy generation, distribute the appropriate public trust material to the targets, and configure `GuestConfigPolicyCertificateValidation=enabled`. Signing doesn't encrypt a package or replace storage authorization. Any signing change also changes the artifact used for hash generation.

## Author for Linux and other assessment tools

Linux custom packages also use compiled PowerShell DSC configurations with Linux-compatible class-based resources. In a separate Linux authoring session on a supported Ubuntu version, follow the PowerShell 7 authoring requirements and install `PSDesiredStateConfiguration` version `3.0.0-beta1` with `-AllowPrerelease`. This is the documented Machine Configuration authoring module, not a replacement workflow based on standalone DSC v3 JSON or YAML.

The Windows registry and service resources in this exercise aren't Linux resources. For Contoso's Linux TLS requirement, implement a resource that reads the actual target application's TLS configuration, evaluates approved cipher requirements, and reports per-setting reasons. Add a `Set` implementation and an application-specific reload procedure only after testing their impact. Package the Linux configuration separately and generate its policy with `-Platform Linux`. The same security intent doesn't imply identical settings or cipher syntax on both operating systems.

Set `IncludeArcMachines` to `true` on the separate Linux assignment when it must include Arc-enabled Linux servers. The Windows policy's platform filter doesn't cover those machines.

Integrating a third-party assessment tool is an advanced alternative. Develop a DSC wrapper resource that installs or invokes the tool and translates its results, include its content and dependencies, and meet its licensing requirements. A raw third-party profile isn't input to the DSC packaging command.

## Contoso's custom configuration application

Contoso's Windows package audits the factory protocol DWORD and the state of the existing manufacturing scheduler service. After a successful pilot, a separately packaged and tested deployment applies the approved settings to tagged application hosts. A separate Linux-compatible configuration assesses TLS settings on the appropriate Linux hosts.

Operators review noncompliance in Azure Policy. If Contoso requires notifications, the team separately configures an Azure Policy state-change Event Grid subscription and a Logic App or other notification handler, filtered to the relevant assignment and compliance state. This reports evaluated configuration state, not immediate service-health events. Application monitoring remains necessary for real-time availability needs.

Built-in baseline audits and custom assignments provide shared compliance visibility. Targeted remediation adds controlled correction of approved settings without treating every server as the same application host or promising that a compliant report establishes complete workload security.
