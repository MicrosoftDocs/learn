Select the policy owner before choosing deployment commands. A policy can be successfully removed from disk and then return because a management system still declares it required. Windows Server 2025 supports an inbox CiTool and an OSConfig-based experience. ConfigCI provides the authoring cmdlets used with custom policies and supplements.

Use this comparison to choose the appropriate responsibility boundary.

| Component or method | Main responsibility | Important limit |
| --- | --- | --- |
| ConfigCI | Create, edit, merge, identify, version, and compile policy XML | Compilation doesn't sign or activate a policy. |
| CiTool | List, activate, update, refresh, and remove policies | CiTool doesn't author rules or replace a management system's desired state. |
| Microsoft.OSConfig | Manage declared Windows Server 2025 App Control state and correct drift | Use OSConfig to change/remove OSConfig-managed state. |
| App Control Wizard | Optional graphical authoring and event-log interpretation | Install on an appropriate authoring client; no wizard dependency is required for the core PowerShell techniques. |
| Existing deployment system | Deliver approved artifacts and collect per-target results | It needs explicit targeting, integrity checks, and failure handling. |
| Legacy App Control Group Policy setting | Deploy a single-policy-format policy | It's not a native multiple-policy deployment mechanism. |

A Group Policy startup script can invoke a supported deployment technique, but that's different from the legacy **Deploy App Control for Business** setting. Keep the distinction clear when migrating an existing GPO.

## Inventory policy state with CiTool

To inventory policy state, run this read-only command in elevated PowerShell 7 on the target server.

```powershell
$ErrorActionPreference = 'Stop'
$json = & "$env:windir\System32\CiTool.exe" --list-policies -json
if ($LASTEXITCODE -ne 0) {
    throw "CiTool inventory failed: $LASTEXITCODE"
}
$policies = ($json | ConvertFrom-Json).Policies
$policies | Format-List *
```

Record each policy ID, base ID, name, version, signing status, and active state. Keep the full inventory when diagnosing unexpected restrictions.

`IsEnforced` in CiTool inventory describes active policy state. Don't use it alone as the audit/enforcement switch. Inspect the policy's options and policy-load event data. A friendly name containing `Audit` is a label, not proof of its current rules.

## Prepare OSConfig

The Windows Server 2025 OSConfig App Control defaults are opt-in. Installing Windows Server 2025 doesn't automatically configure these audit policies.

Acquire an approved version of `Microsoft.OSConfig`. On an authorized internet-connected preparation system, the following saves a specified version for controlled distribution.

```powershell
$ErrorActionPreference = 'Stop'
$version = Read-Host 'Enter the approved Microsoft.OSConfig version'
New-Item -Path 'C:\ModuleStaging' -ItemType Directory -Force | Out-Null
Save-Module -Name Microsoft.OSConfig -RequiredVersion $version `
    -Repository PSGallery -Path 'C:\ModuleStaging'
```

Review the package and dependencies through your software supply process. For these workers, copy `C:\ModuleStaging\Microsoft.OSConfig\<version>` into `C:\Program Files\WindowsPowerShell\Modules\Microsoft.OSConfig\<version>` on the target. Replace `<version>` with the approved version and preserve the package's directory structure. Restrict write access to administrators. This doesn't require internet access from a domain controller.

For an approved online installation, start the following from PowerShell 7 on the test server. Installing inside the 5.1 worker selects its AllUsers module location rather than PowerShell 7's separate directory.

```powershell
$ErrorActionPreference = 'Stop'
$version = Read-Host 'Enter the approved Microsoft.OSConfig version'
$winPS51 = New-PSSession -UseWindowsPowerShell
try {
    Invoke-Command -Session $winPS51 -ArgumentList $version -ScriptBlock {
        param([string]$ModuleVersion)
        $ErrorActionPreference = 'Stop'
        Install-Module -Name Microsoft.OSConfig -RequiredVersion $ModuleVersion `
            -Repository PSGallery -Scope AllUsers
    }
} finally {
    Remove-PSSession -Session $winPS51
}
```

Don't apply the entire Windows Server security baseline merely to use App Control. Import the same approved module version for configuration, queries, promotion, and removal.

OSConfig can retain Windows PowerShell dependencies even when called from PowerShell 7. For example, version 1.4.10 converts XML through ConfigCI and registers a daily task that invokes `PowerShell.exe`. Don't rewrite vendor-managed tasks or describe this management path as Windows PowerShell-free.

## Apply and query OSConfig audit state

This example changes an isolated Windows Server 2025 test server. Run it elevated after confirming recovery access and checking for conflicting policy owners.

```powershell
$ErrorActionPreference = 'Stop'
$version = Read-Host 'Enter the approved Microsoft.OSConfig version'
$winPS51 = New-PSSession -UseWindowsPowerShell
try {
    Invoke-Command -Session $winPS51 -ArgumentList $version -ScriptBlock {
        param([string]$ModuleVersion)
        $ErrorActionPreference = 'Stop'
        Import-Module Microsoft.OSConfig -RequiredVersion $ModuleVersion
        Set-OSConfigDesiredConfiguration `
            -Scenario 'AppControl\WS2025\DefaultPolicy\Audit' -Default
        Set-OSConfigDesiredConfiguration `
            -Scenario 'AppControl\WS2025\AppBlockList\Audit' -Default
    }
} finally {
    Remove-PSSession -Session $winPS51
}
```

The default allow policy and application blocklist are separate policies. Both have an `Enforce` scenario, introduced later after the enforcement gate.

Query the declared policy information without hiding ineffective entries.

```powershell
$ErrorActionPreference = 'Stop'
$version = Read-Host 'Enter the approved Microsoft.OSConfig version'
$winPS51 = New-PSSession -UseWindowsPowerShell
try {
    Invoke-Command -Session $winPS51 -ArgumentList $version -ScriptBlock {
        param([string]$ModuleVersion)
        $ErrorActionPreference = 'Stop'
        Import-Module Microsoft.OSConfig -RequiredVersion $ModuleVersion
        $configuration = Get-OSConfigDesiredConfiguration -Scenario AppControl
        $configuration.Value.PSObject.Properties |
            ForEach-Object { $_.Value.PolicyInfo }
    } | Format-List *
} finally {
    Remove-PSSession -Session $winPS51
}
```

Compare `IsEffective` and the reported policy information with CiTool inventory, policy options, and event 3099. Successful configuration submission isn't sufficient evidence of successful activation.

## Link a supplement to the real OSConfig base

OSConfig-provided bases are unsigned. Extend the selected allow base with a reviewed supplemental policy rather than assuming that its default trust is sufficient for every agent.

The following example changes a new, reviewed XML artifact, then submits it to OSConfig on the test server. It assumes `OSConfig-HyperV.xml` already contains only approved workload rules. Don't reuse the custom-base supplement from another design without reviewing its identity and purpose.

```powershell
$ErrorActionPreference = 'Stop'
$version = Read-Host 'Enter the approved Microsoft.OSConfig version'
$json = & "$env:windir\System32\CiTool.exe" --list-policies -json
if ($LASTEXITCODE -ne 0) {
    throw "CiTool inventory failed: $LASTEXITCODE"
}
$matches = @(($json | ConvertFrom-Json).Policies | Where-Object {
    $_.FriendlyName -eq 'AllowMicrosoft_WS2025_Audit'
})
if ($matches.Count -ne 1) {
    throw 'Identify exactly one intended OSConfig allow base before continuing.'
}
$baseId = ([guid]$matches[0].PolicyID).ToString('B')
$supplement = 'C:\AppControl\Source\OSConfig-HyperV.xml'
$winPS51 = New-PSSession -UseWindowsPowerShell
try {
    Invoke-Command -Session $winPS51 `
        -ArgumentList $version, $baseId, $supplement -ScriptBlock {
        param(
            [string]$ModuleVersion,
            [string]$BasePolicyId,
            [string]$SupplementPath
        )
        $ErrorActionPreference = 'Stop'
        Import-Module ConfigCI
        Import-Module Microsoft.OSConfig -RequiredVersion $ModuleVersion
        Set-CIPolicyIdInfo -FilePath $SupplementPath `
            -SupplementsBasePolicyID $BasePolicyId -PolicyName 'OSConfig-HyperV'
        Set-OSConfigDesiredConfiguration `
            -Scenario AppControl -Name Policies -Value $SupplementPath
    }
} finally {
    Remove-PSSession -Session $winPS51
}
```

Confirm the friendly name against the inventory for your installed package. Its use here selects an intended policy; the discovered GUID establishes the actual link. Never substitute a GUID copied from an unrelated example.

After a mode or base-policy change, verify supplemental links again. If the target base identity changes, prepare correctly linked supplements as part of the transition.

## Understand drift and migration

OSConfig normally reevaluates drift on a four-hour cycle. Deleting an OSConfig-managed policy with CiTool alone leaves its desired state unchanged, so OSConfig can restore it.

An existing management agent or GPO can produce the same symptom. Identify the authoritative owner rather than repeatedly deleting the policy.

Use this order when replacing a legacy or differently managed policy on Windows Server 2025:

1. Inventory the existing format, identity, version, active state, and deployment source.
1. Preserve a recoverable copy and document the replacement's intended trust.
1. Create a multiple-policy-format replacement with deliberate identities and supplemental links.
1. Audit the replacement alongside existing controls and account for their enforced decisions.
1. Rehearse activation and retirement in a test environment.
1. Change the old deployment source and retire its policy only through an approved transition.

Don't clear all Code Integrity files to make migration easier. That can remove unrelated protections and, for signed policies, cause boot failure.
