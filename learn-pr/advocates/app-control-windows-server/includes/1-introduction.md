Code integrity policies define which applications, scripts, and drivers can run on Windows. App Control for Business is a Windows security feature that applies these policies across a device to audit or block unapproved code.

> [!NOTE]
> An application allowlist is also an operational dependency. A policy that blocks an unauthorized tool provides protection. A policy that blocks a storage driver, replication component, or recovery agent can turn that protection into an outage.

Contoso operates a Windows Server 2025 Hyper-V cluster and several domain controllers. Its security team wants to restrict code execution so that only known authorized code can be executed on these computers. Contoso's infrastructure team must retain VM mobility, authentication, DNS, backup, and recovery.

This module assumes the following configuration: 

- Use a production-signed Windows Server 2025 build for the OSConfig default policies. Flight-signed binaries aren't permitted by those policies and can prevent startup. Record the OS build and cumulative update rather than relying only on the product name.
- Start every example in elevated, **64-bit PowerShell 7.4 or later on Windows**. Use a supported release and record the approved minor and patch version. PowerShell 7 is separately installed software; it doesn't replace inbox Windows PowerShell 5.1.
- Keep Windows PowerShell 5.1 available. The ConfigCI, OSConfig, and FailoverClusters examples explicitly create local 5.1 workers. This is PowerShell 7 orchestration, not a claim that those modules execute natively in PowerShell 7.

Inventory the reference server before making changes. These commands are read-only.

```powershell
#requires -Version 7.4
#requires -PSEdition Core
#requires -RunAsAdministrator
$ErrorActionPreference = 'Stop'
if ($PSVersionTable.PSEdition -ne 'Core' -or
    $PSVersionTable.PSVersion.Major -ne 7 -or
    $PSVersionTable.PSVersion -lt [version]'7.4' -or
    -not $IsWindows -or -not [Environment]::Is64BitProcess) {
    throw 'Use 64-bit PowerShell 7.4 or later on Windows.'
}
Get-CimInstance -ClassName Win32_OperatingSystem |
    Select-Object Caption, Version, BuildNumber
$PSVersionTable | Format-List
Get-Module -ListAvailable -Name PowerShellGet, Hyper-V, ActiveDirectory |
    Select-Object Name, Version, Path
```

Install the management components appropriate to the workload. Hyper-V and ActiveDirectory have native PowerShell 7 support when their Windows Server management features are installed. `PowerShellGet` supplies `Save-Module` for package preparation.

## Keep runtime boundaries explicit

The examples use the following execution boundaries.

| Work | Execution environment | Reason |
| --- | --- | --- |
| CIM, events, XML inspection, hashes, Hyper-V, and AD queries | PowerShell 7 | These operations don't require a legacy worker. |
| CiTool, SignTool, and native directory diagnostics | Native executable invoked from PowerShell 7 | A native utility isn't a Windows PowerShell dependency. |
| ConfigCI authoring and compilation | Explicit Windows PowerShell 5.1 worker | Microsoft's PowerShell 7 guidance uses Windows PowerShell compatibility for ConfigCI. |
| OSConfig and cluster inventory | Explicit Windows PowerShell 5.1 worker | Don't assume native compatibility for the selected package or server build. OSConfig XML processing can also call ConfigCI. |
| Remote policy deployment | Explicit PowerShell 7 endpoint on the target | The caller's runtime doesn't select the remote runtime automatically. |

`New-PSSession -UseWindowsPowerShell` starts a local Windows PowerShell 5.1 process. `Invoke-Command -Session` runs the enclosed script block there. Each example removes only its own worker in `finally`, including after failure. These local workers don't require enabling WinRM.

Inspect legacy modules inside their actual runtime. PowerShell 7's default module listing can omit an installed Windows PowerShell module.

```powershell
$ErrorActionPreference = 'Stop'
$winPS51 = New-PSSession -UseWindowsPowerShell
try {
    Invoke-Command -Session $winPS51 -ScriptBlock {
        $ErrorActionPreference = 'Stop'
        if ($PSVersionTable.PSEdition -ne 'Desktop' -or
            $PSVersionTable.PSVersion -lt [version]'5.1' -or
            -not [Environment]::Is64BitProcess) {
            throw 'The worker must use 64-bit Windows PowerShell 5.1.'
        }
        [pscustomobject]@{
            Version = $PSVersionTable.PSVersion.ToString()
            Edition = $PSVersionTable.PSEdition
            LanguageMode = $ExecutionContext.SessionState.LanguageMode
        }
        Get-Module -ListAvailable -Name ConfigCI, Microsoft.OSConfig,
            FailoverClusters | Select-Object Name, Version, Path
    } | Format-List *
} finally {
    Remove-PSSession -Session $winPS51
}
```

An absent PowerShell module in the intended runtime is a preparation issue. `ConfigCI` supplies authoring cmdlets. OSConfig and FailoverClusters are needed only for their respective examples. Stage OSConfig where Windows PowerShell 5.1 can discover the approved version.

Local Windows PowerShell 5.1 sessions run on the current computer, under the current identity, with that computer's files and controls. Run OSConfig examples locally on the intended Windows Server 2025 test server, not on an unrelated administration client. Variables from PowerShell 7 reach these sessions only through explicit arguments.

Remoting serializes parameters and results. Keep typed ConfigCI rule objects and their consuming commands in one worker; return paths or inspection records instead. Don't rely on implicit compatibility loading or use `-SkipEditionCheck` as a compatibility fix.

## App Control configuration requirements

App Control for Business is built into Windows Server 2016 and later. You configure and deploy Code Integrity policies rather than install a separate App Control server role. This module targets Windows Server 2025 Standard and Datacenter, including Server Core and Desktop Experience, on physical servers or virtual machines.

Distinguish the requirements for App Control itself from those of optional protections and the tools used in this module.

| Area | Requirement |
| --- | --- |
| Windows Server version and policy features | Use a supported, serviced Windows Server build. Windows Server 2016 and 2019 support single-policy format; multiple-policy format, supplemental policies, and FilePath rules require Windows Server 2022 or later. The inbox CiTool and OSConfig examples in this module require Windows Server 2025. |
| Administrative permissions | Run local policy deployment and configuration commands in an elevated session with administrator rights on the target server. Updating a protected signed policy also requires a replacement signed by an authorized policy signer; administrator rights alone aren't sufficient. |
| Hardware and virtualization | App Control adds no specific hardware requirement beyond those of the operating system. It doesn't require a Trusted Platform Module (TPM), the Hyper-V server role, or virtualization-based security. Memory integrity, also called hypervisor-protected code integrity (HVCI), is a separate protection with its own hardware, firmware, and driver requirements. Other Windows Server and organizational security requirements still apply. |
| Secure Boot | UEFI Secure Boot must be enabled for the anti-tampering protection of signed App Control policies. It isn't a prerequisite for basic unsigned-policy enforcement. For a virtual server, the guest's firmware configuration must support Secure Boot if you require this protection. |

Prepare the tools for the management path you select:

- **PowerShell and ConfigCI:** The examples require elevated, 64-bit PowerShell 7.4 or later, with Windows PowerShell 5.1 retained for the specified compatibility sessions. This is an example requirement, not a requirement of the App Control enforcement engine. ConfigCI must be available where you author or compile policies; a target server doesn't need authoring tools merely to enforce an already compiled policy.
- **OSConfig-managed policies:** Install an approved version of `Microsoft.OSConfig` on each server managed through this path. Its default policies require a production-signed Windows Server 2025 build; flight-signed binaries can prevent startup. OSConfig isn't required for the custom-policy path, and its default App Control policies aren't enabled just by installing Windows Server.
- **Optional authoring and signing tools:** The App Control Wizard is an optional graphical authoring tool, not a target-server prerequisite. For the policy-signing examples, install Windows SDK SignTool and provide an approved RSA code-signing certificate with access to its protected private key in the signing environment. Neither the signing tools nor the private key belongs on every target server.

Before activating a policy, identify the applications, drivers, scripts, management agents, and recovery tools that the server must run. Prepare a representative nonproduction server and independent recovery access. Begin with audit and workload testing before enforcement; meeting the platform requirements doesn't establish that a policy is safe for production.

## Separate CI policy authoring separate from production workloads 

You should only author policies on a trusted reference server or administrative workstation. Your authoring environment must permit the required ConfigCI and XML operations. Use a separate authoring environment rather than disabling production controls to make an example run. Keep private signing keys off ordinary target servers. Running as administrator doesn't remove Constrained Language Mode restrictions from an already controlled session.

Running commands in a Windows PowerShell 5.1 compatibility session doesn't bypass App Control policies or PowerShell language-mode restrictions. The code executed in that session must also be permitted by the applicable security policies. The examples require an execution context that permits the operation. Where a controlled server requires file-based trust, use an approved worker script with fixed, validated inputs rather than weakening script enforcement.

Authorize the selected `pwsh.exe`, its runtime assemblies, required modules, and approved installation/update path in every applicable policy family. Retain the required Windows PowerShell worker dependencies. Don't assume that a template allowing inbox Windows PowerShell also allows PowerShell 7, or broaden trust to all Microsoft software merely to make an example run.

The examples in this module use the following working locations. Create the directories on the appropriate test or authoring system, restrict write access to authorized administrators, and substitute your approved paths.

| Location | Purpose | Security requirement |
| --- | --- | --- |
| `C:\AppControl\Source` | Maintained policy XML | Only policy authors can modify it. |
| `C:\AppControl\Build` | Compiled and signed release artifacts | Prevent substitution after approval. |
| `C:\AppControl\Evidence` | EVTX files and deployment results | Protect operational and file-path information. |
| `C:\AppControl\Certificates` | Public `.cer` files | These aren't private-key backups. |
| `C:\ApprovedSoftware` | Curated application samples | Include approved files only; don't treat the directory as an execution allow rule. |

Code blocks are focused techniques, not one script to paste into production. Each changing example identifies whether it changes an offline artifact or a test server. Related examples name their input artifacts explicitly.

## Prepare recovery before activation

Audit mode is a safer starting point, but not a guarantee of zero impact. Script hosts can change behavior while auditing, and policy evaluation can add overhead.

Complete these preparations before activating even an audit candidate:

- Establish an out-of-band console path and verify that an authorized operator can use it.
- Retrieve approved recovery credentials, recovery media, and any BitLocker recovery material.
- Preserve the current policy sources, binaries, versions, and deployment ownership.
- Identify workload capacity, maintenance windows, and the conditions that stop rollout.
- Rehearse recovery on a representative nonproduction server.

Recovery mustn't depend entirely on the server being recovered. A domain controller outage can also affect authentication to a deployment share or signing service. A Hyper-V host outage can remove the VM that contains your normal management tools. Keep server roles separate. 
