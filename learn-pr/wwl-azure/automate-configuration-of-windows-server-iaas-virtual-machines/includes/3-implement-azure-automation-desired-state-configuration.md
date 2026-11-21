Azure Machine Configuration helps Contoso declare, apply, and assess settings inside its Windows Server VMs. A declarative configuration describes the required state rather than a sequence of administrative actions. For example, a configuration can require particular IIS settings and report when they differ from that baseline.

A *package* contains a compiled configuration and its dependencies. A *guest assignment* associates that package with a machine. An *Azure Policy assignment* can deploy the guest assignment and surface its compliance status. The policy assignment and guest assignment are different resources.

This unit explains the prerequisites and deployment sequence. Read the commands as illustrations of the workflow, not as a self-contained lab. Package-dependent execution requires a separately obtained, maintained artifact and its implementation-specific compilation instructions.

> [!NOTE]
> Azure Machine Configuration custom audit and configuration policies are generally available. Azure Automation State Configuration is scheduled to retire on September 30, 2027. The Windows DSC VM extension has a separate retirement date of March 31, 2028. These announcements don't retire Azure Automation runbooks.

## Understand configuration evaluation

A Desired State Configuration (DSC) resource exposes Get, Test, and Set operations. Test determines whether its declared settings are satisfied. During an applying operation, a compliant resource doesn't need Set. If Test reports noncompliance and remediation is enabled, Set attempts to restore the desired state. Get returns current settings for reporting. These operations aren't an unconditional Get-Test-Set sequence that changes the machine on every evaluation.

The package, policy, and guest assignment have separate controls:

| Control | Purpose |
| --- | --- |
| Package type `Audit` or `AuditAndSet` | Determines whether the package can report only or also apply settings. |
| Policy effect `auditIfNotExists` or `deployIfNotExists` | Determines the Azure Policy audit or deployment behavior. |
| Guest assignment type `Audit` | Reports machine state without changing it. |
| Guest assignment type `ApplyAndMonitor` | Applies configuration, then reports subsequent drift without automatically correcting it. |
| Guest assignment type `ApplyAndAutoCorrect` | Applies configuration and corrects subsequent drift during guest evaluation. |

Use the case-sensitive guest assignment values shown in the table. They aren't Azure Policy enforcement modes. A resource must implement the required changes, and its package must permit them. Changing the assignment type doesn't make an audit-only implementation capable of applying settings.

Windows PowerShell DSC uses a Local Configuration Manager (LCM), but that isn't the Machine Configuration agent's control plane. In that earlier model, `ApplyOnly` applies a delivered configuration without ongoing drift checks after success. `ApplyAndMonitor` reports later drift, and `ApplyAndAutoCorrect` corrects it. Each mode can apply a newly delivered configuration. The LCM defaults are 30 minutes for pull refresh (`RefreshFrequencyMins`) and 15 minutes for consistency evaluation (`ConfigurationModeFrequencyMins`). Those settings don't control Machine Configuration.

## Prepare the target VM

Use an existing, isolated Windows Server 2025 Azure VM. In an authenticated Azure administration session, select the intended subscription and ensure you have permission to manage VM extensions, managed identities, policy definitions and assignments, and the required role assignments.

> [!CAUTION]
> If you're reusing a VM, preserve its existing user-assigned identities and check applications that request a managed identity token without selecting an identity. A VM with one user-assigned identity and no system-assigned identity defaults to that user-assigned identity. Enabling a system-assigned identity changes the default. Configure affected applications to request their intended user-assigned identity explicitly, or use a clean lab VM. Don't copy their permissions to the new identity.

Prepare the VM before assigning a configuration:

1. Register the `Microsoft.GuestConfiguration` resource provider in the subscription if it isn't already registered.
1. Enable the VM's system-assigned managed identity. Preserve any user-assigned identities already attached to the VM.
1. Install the Windows Machine Configuration extension with automatic upgrades enabled.
1. Confirm the deployed Windows Machine Configuration agent supports both applying settings and downloading packages with the VM's system-assigned identity. Applying settings has a documented base minimum of 1.26.24, but this private-package scenario requires version 1.29.98.0 or later. Use current tooling that generates guest assignments with API version 2024-04-05 or later. Keep the extension current with automatic upgrades rather than deliberately pinning these minimums.
1. Permit outbound TCP 443 to the Machine Configuration service endpoints for the VM's Azure cloud and region, the documented service storage endpoints, and the custom package's HTTPS host. For the documented public-endpoint network security group (NSG) approach, both the `AzureArcInfrastructure` and `Storage` service tags are required. Apply your organization's network restrictions and confirm DNS and routing as well as identity authorization.

The following command installs the extension after the identity prerequisite is complete. Replace the resource group and VM placeholders with your lab values:

```powershell
$resourceGroupName = '<lab-resource-group>'
$vmName = '<lab-vm-name>'
$vm = Get-AzVM -ResourceGroupName $resourceGroupName -Name $vmName

Set-AzVMExtension `
    -Publisher 'Microsoft.GuestConfiguration' `
    -ExtensionType 'ConfigurationforWindows' `
    -Name 'AzurePolicyforWindows' `
    -TypeHandlerVersion '1.0' `
    -ResourceGroupName $resourceGroupName `
    -Location $vm.Location `
    -VMName $vmName `
    -EnableAutomaticUpgrade $true
```

`EnableAutomaticUpgrade` permits subsequent upgrades of the installed extension. It isn't the same control as selecting a current minor version during deployment. Package URLs, configuration parameters, and assignment modes belong to guest assignments, not the extension's settings.

> [!NOTE]
> The Machine Configuration agent is different from the general Azure VM agent. The `TypeHandlerVersion '1.0'` value in the extension-installation command doesn't prove that the required Machine Configuration agent build is running. Confirm the deployed agent version before assigning a package, then confirm successful package download after the assignment is delivered.

For multiple VMs, assign the **Deploy prerequisites to enable Guest Configuration policies on virtual machines** initiative. The same default-identity caveat applies when this initiative enables a system-assigned identity. Complete its required identity and extension remediation for existing resources before depending on those prerequisites. Direct setup is sufficient for this single-VM workflow.

Machine Configuration doesn't require an Automation account or a Log Analytics workspace. No inbound RDP or WinRM opening is required merely to deliver guest assignments. The VM's identity authenticates it to Machine Configuration, but authorization doesn't replace network connectivity.

Use the regional endpoint table in the Machine Configuration network requirements reference to identify the correct destinations for your cloud and region. NSG service tags don't configure DNS, grant blob access, or bypass a Storage firewall. The `AzureArcInfrastructure` tag's name doesn't mean an Azure VM must be onboarded as an Arc-enabled server.

## Prepare a compatible configuration package

Use a maintained configuration and resource implementation that supports Windows Server 2025 and the current guest runtime. The package's source, dependency versions, ownership, managed settings, and expected compliance reasons should be known before you deploy it.

> [!IMPORTANT]
> This workflow explains deployment and drift behavior but isn't a self-contained lab. The `ContosoIis` package and its implementation-specific compilation instructions aren't supplied. Don't run package-dependent commands until you have a maintained artifact that explicitly manages W3SVC's running state and has been tested on the target VM. The one-time IIS installation script isn't a replacement for that package.

The service-state example assumes IIS is already installed. An approved service-only package doesn't install a missing role unless its implementation explicitly manages that outcome. Don't copy the inbox `WindowsFeature` resource or a `Node "localhost"` configuration unchanged into Machine Configuration. An archived resource module isn't a supported replacement just because an older tutorial uses it.

Author and compile the configuration on a Windows machine with a supported PowerShell 7 runtime, Azure PowerShell, and the current `GuestConfiguration` module. Import the documented DSC compiler version explicitly so that an incompatible major version isn't selected:

```powershell
Install-Module -Name GuestConfiguration
Install-Module -Name PSDesiredStateConfiguration -RequiredVersion 2.0.7
Import-Module -Name PSDesiredStateConfiguration -RequiredVersion 2.0.7
```

These are authoring dependencies, not instructions to replace the VM's guest agent. Follow the approved configuration's compilation instructions. In this example, rename the compiled `localhost.mof` to `ContosoIis.mof` and package it as `ContosoIis.zip`. Keep the configuration identity consistent with the metadata generated from that package.

The Azure guest-assignment resource name is separate and can include a suffix added by the policy generator. Record the actual guest-assignment name and resource ID rather than assuming that the resource is named exactly `ContosoIis`. Preserve the generated suffix when inspecting, updating, or cleaning up the resource.

With the compiled artifact at `.\ContosoIis\ContosoIis.mof`, create the package:

```powershell
$mof = (Resolve-Path '.\ContosoIis\ContosoIis.mof').Path

New-GuestConfigurationPackage `
    -Name 'ContosoIis' `
    -Configuration $mof `
    -Type AuditAndSet `
    -Path . `
    -Force

$zip = (Resolve-Path '.\ContosoIis.zip').Path
```

Required resource modules must be available through the authoring environment's `PSModulePath` so the tooling can package their dependencies. `-Configuration` takes the compiled MOF, not the original script. Keep the uncompressed package within 100 MB, and don't include credentials or other secrets.

## Test and publish the package

Copy the package to the disposable Windows Server test machine with the required tooling and IIS installed. No active assignment or other controller should restore W3SVC during this local test. In an elevated PowerShell 7 session, set the path to the copied ZIP and inspect the initial state:

```powershell
$testZip = (Resolve-Path 'C:\Lab\ContosoIis.zip').Path

Get-Service -Name 'W3SVC' -ErrorAction Stop
Get-GuestConfigurationPackageComplianceStatus -Path $testZip
```

Confirm that the approved package requires W3SVC to be running, that the service exists and is running, and that its resource result is compliant. If the role or service is missing, prepare the test fixture before testing service-state drift.

> [!CAUTION]
> Package remediation testing changes the machine on which the command runs. Use an isolated test server with no production workload, not your normal authoring workstation. Stopping W3SVC interrupts the lab website.

Introduce the same controlled service-state change used in the walkthrough:

```powershell
Stop-Service -Name 'W3SVC' -ErrorAction Stop
Get-Service -Name 'W3SVC' -ErrorAction Stop
Get-GuestConfigurationPackageComplianceStatus -Path $testZip
```

Require both a stopped service and a fresh noncompliant result for the service's running state before continuing. A missing module, absent service, or execution error isn't evidence of this drift. If another controller restarts W3SVC, resolve that interference before testing repair.

Apply the package, then inspect the service and a new compliance result:

```powershell
Start-GuestConfigurationPackageRemediation -Path $testZip -Verbose
Get-Service -Name 'W3SVC' -ErrorAction Stop
Get-GuestConfigurationPackageComplianceStatus -Path $testZip
```

Confirm that W3SVC reports `Running` and that the fresh package result is compliant. If repair fails, capture the reason and restore the lab service separately if needed. Don't count manual recovery or an originally compliant no-op as successful package repair.

Subsequently confirm the package works under the deployed guest agent, which runs as LocalSystem on Windows. Local success doesn't prove remote package access, permissions, effective assignment type, or deployed-agent compatibility.

Publish the exact tested ZIP to an approved private Blob Storage container with anonymous access disabled. Record its HTTPS URI. Grant the **VM's system-assigned identity** Storage Blob Data Reader at the appropriate container or storage scope, and ensure the VM can reach the blob. Identity authorization doesn't bypass a storage firewall.

> [!NOTE]
> A private Blob Storage container disables anonymous content access. It doesn't by itself put the traffic on a private network. This walkthrough uses identity-authenticated package downloads over reachable HTTPS endpoints. If your environment requires Private Link, configure Machine Configuration service connectivity and package-storage connectivity separately using the documented requirements. A Storage private endpoint alone doesn't establish private connectivity to the Machine Configuration service.

Retain the source and dependency versions alongside your versioned artifact. The policy-generation tooling records a content hash for the package. If the ZIP changes, regenerate the corresponding metadata and deploy the intended version. Don't replace a package silently while leaving assignments with an old hash.

## Create and assign the policy

Return to the authoring session where `$zip` identifies the same tested package and confirm the intended authenticated subscription. Set `$contentUri` to the private blob's HTTPS address. For a new lab, the following example uses a new GUID as both the generator's policy ID and the Azure definition resource name. A dedicated resource group doesn't isolate a subscription-level policy definition name.

The definition can deploy an `ApplyAndMonitor` guest assignment for the walkthrough's first deployment. That assignment applies the configuration, then reports subsequent drift without automatically correcting it:

```powershell
$contentUri = 'https://<storage-account>.blob.core.windows.net/<container>/ContosoIis.zip'
$policyFolder = New-Item -Path '.\policies' -ItemType Directory -Force
$policyId = (New-Guid).Guid

$policyConfig = @{
    PolicyId         = $policyId
    ContentUri       = $contentUri
    DisplayName      = 'Configure the Contoso IIS lab server'
    Description      = 'Apply the approved configuration and assess drift.'
    Path             = $policyFolder.FullName
    Platform         = 'Windows'
    PolicyVersion    = '1.0.0'
    Mode             = 'ApplyAndMonitor'
    LocalContentPath = $zip
}

$generatedPolicy = New-GuestConfigurationPolicy @policyConfig `
    -UseSystemAssignedIdentity `
    -ExcludeArcMachines

$policyFile = $generatedPolicy.Path

if (-not (Test-Path -LiteralPath $policyFile -PathType Leaf)) {
    throw 'Policy generation did not return an existing JSON file.'
}

$labSubscriptionId = (Get-AzContext -ErrorAction Stop).Subscription.Id
if ([string]::IsNullOrWhiteSpace($labSubscriptionId)) {
    throw 'Select the authenticated lab subscription before publishing.'
}

$policyDefinitionName = $policyId
$labDefinition = New-AzPolicyDefinition `
    -SubscriptionId $labSubscriptionId `
    -Name $policyDefinitionName `
    -Policy $policyFile `
    -ErrorAction Stop
$labDefinitionId = $labDefinition.Id
```

The generator's `Path` is an output directory. Publish the JSON file identified by the returned object's `Path` property instead of assuming its filename.

> [!NOTE]
> Keep the same policy GUID, Azure policy-definition name, definition scope, and policy assignment when updating this lab. Don't rerun the `New-Guid` initialization for an update. Retain `$labSubscriptionId`, `$policyDefinitionName`, `$labDefinitionId`, `$policyConfig`, and the policy assignment ID. If you're continuing an existing lab with a different definition name, record and reuse its actual name and ID instead of renaming it mid-exercise.

`-Mode` controls the generated policy's guest-assignment behavior. `-UseSystemAssignedIdentity` enables package download with the VM identity. It doesn't create the policy-assignment identity. `-ExcludeArcMachines` keeps this example focused on Azure VMs.

Assign the returned definition, identified by `$labDefinitionId`, to the isolated resource group containing the lab VM. A display name alone doesn't uniquely identify the definition. Configure the policy-assignment managed identity and grant the roles declared in the generated definition's `roleDefinitionIds`. The assignment portal can create those role grants when the operator is authorized. Command-line assignment requires explicit handling of them.

Keep the two identity roles distinct:

| Identity | Required purpose |
| --- | --- |
| VM system-assigned identity | Authenticates the guest to Machine Configuration and, with the appropriate blob-read role, downloads the private package. |
| Policy-assignment managed identity | Performs the authorized Azure resource deployments or modifications required by the policy. |

For the already-existing VM, select **Create a remediation task** when assigning the policy, or create the initial remediation task after evaluation. Let the task finish and diagnose failed deployments before continuing. Confirm the delivered guest-assignment type, detailed results, and actual settings inside the VM. A task only targets noncompliant resources. If an initial audit assignment already reports compliance, follow the conditional baseline procedure in the walkthrough rather than assuming the task applied the configuration.

> [!NOTE]
> A compliant audit result and a compliant applying assignment can both look green. Check the effective guest-assignment type before comparing drift behavior. A policy evaluation request reads the latest reported state; it doesn't force an immediate in-guest evaluation.

This example's intended first applying mode is `ApplyAndMonitor`. In GuestConfiguration 4.12.0, leave the generated `EnableAutoRemediation` parameter at the string `"false"` for both phases of this manual-remediation comparison. That value doesn't block an explicit remediation deployment. The walkthrough later delivers an `ApplyAndAutoCorrect` assignment, after which the guest agent corrects drift without another policy remediation task for each occurrence.

Finish VM prerequisite changes before assigning the custom policy, and avoid VM-resource updates during drift observation. With default Azure Policy enforcement, a qualifying VM resource update can trigger another deployment. Don't let another configuration engine enforce conflicting values for the same settings.

## Understand evaluation timing

The Machine Configuration agent checks for new or changed guest assignments every five minutes and reevaluates an assigned configuration on a 15-minute interval by default. Configurations run sequentially, so long-running work can delay subsequent evaluation. Azure Policy reporting adds a separate evaluation stage.

Requesting an Azure Policy evaluation retrieves the latest reported guest state. It doesn't force a new check inside the VM. Don't interpret a successful Azure deployment or an unchanged portal result as proof that the guest has already applied the configuration.

## Additional reading

Use these references for the current prerequisites, authoring contract, and policy workflow:

- [Machine Configuration prerequisites](/azure/governance/machine-configuration/overview/02-setup-prerequisites).
- [Machine Configuration network requirements and regional endpoints](/azure/governance/machine-configuration/overview/03-network-requirements).
- [Install the Machine Configuration extension](/azure/virtual-machines/extensions/guest-configuration).
- [Create configuration package artifacts](/azure/governance/machine-configuration/how-to/develop-custom-package/2-create-package).
- [Create custom policy definitions](/azure/governance/machine-configuration/how-to/create-policy-definition).
- [DSC 2.0 compatibility and resource support](/powershell/dsc/overview?view=dsc-2.0).
