An assessment compares observed state with approved intent. Before collecting commands, record what you expect: which nodes exist, which volumes should be encrypted, which features should be enabled, and which baseline applies.

This prevents a common mistake: treating a short list of successful results as proof that all expected resources were examined. An omitted or unreachable node is an evidence gap, not a passing result.

## Distinguish the host protections

BitLocker, antivirus, and application control address different threats. The following comparison explains what each result can support.

| Control | What it protects | What it doesn't establish |
| --- | --- | --- |
| BitLocker | Data at rest on protected volumes, including deployment-created infrastructure and workload volumes when enabled | Application authorization, data-in-transit protection, or recoverability without keys |
| Microsoft Defender Antivirus | Detection and prevention of malware under its configured protection settings | Approval of every executable or complete workload posture management |
| App Control for Business | Which drivers and applications can execute under the applicable policies | Whether allowed software is free of vulnerabilities or appropriate for a business process |
| SMB signing | Integrity and authenticity checks for SMB messages | Confidentiality of the message contents |
| SMB encryption | Confidentiality and integrity for the SMB traffic to which it applies | Encryption of every other network protocol or every VM migration path |

Server Message Block (SMB) is a protocol used for file and storage communication. Signing and encryption are different controls. A signed connection isn't necessarily encrypted.

BitLocker is also different from access control. After an authorized system unlocks a volume, software with sufficient permissions can access the data. Encryption at rest doesn't remove the need to control administrators and applications.

## Prepare a node inspection

Use an approved administrative console or remote desktop connection to sign in to a node with authorized local administrator or deployment-user credentials. At an administrative command prompt, enter `powershell.exe -NoProfile` to open Windows PowerShell for the installed Windows modules. If you're working from a desktop interface, open **Windows PowerShell** with **Run as administrator**.

Use the PowerShell environment supported by the installed Azure Local module. Don't install replacement platform modules, change execution policy, or enable broad credential delegation to make a sample run. If a command isn't available, check the solution version and baseline installation before proceeding.

The following commands record context without retrieving secret values:

```powershell
$ErrorActionPreference = 'Stop'

[pscustomobject]@{
    Node = $env:COMPUTERNAME
    ObservedAtUtc = (Get-Date).ToUniversalTime().ToString('o')
    PowerShellVersion = $PSVersionTable.PSVersion.ToString()
}

Get-CimInstance -ClassName Win32_OperatingSystem |
    Select-Object Caption, Version, BuildNumber

Get-Module -ListAvailable -Name AzureStackOSConfigAgent, BitLocker, Defender |
    Select-Object Name, Version

Get-Command Get-AzsSecurity, Get-AzsSecurityPolicyIntent,
    Get-ASAppControlPolicyMode, Get-ASLocalAppControlPolicyInfo |
    Select-Object Name, Source, Version
```

The operating-system build isn't the Azure Local solution version. Record the solution version from the instance's approved deployment or update inventory as well. If a required module or command is absent, mark that portion of the assessment incomplete rather than substituting an unrelated Windows command.

## Inspect encryption and antivirus

In the same authorized node session, run:

```powershell
$ErrorActionPreference = 'Stop'

Get-BitLockerVolume |
    Select-Object MountPoint, VolumeStatus, ProtectionStatus, EncryptionMethod

Get-MpComputerStatus |
    Select-Object AMServiceEnabled, AntivirusEnabled, RealTimeProtectionEnabled,
        AntivirusSignatureLastUpdated
```

Interpret `VolumeStatus` and `ProtectionStatus` together. A fully encrypted volume can have protection suspended. In that case, the disk's encrypted state doesn't provide the same assurance as active protector enforcement. Compare the returned volume inventory with the volumes that the approved design expects on that node.

For antivirus, distinguish enabled services from effective, current protection. Review whether real-time protection is enabled and whether the signature timestamp meets your organization's update policy. Don't invent a universal acceptable signature age: disconnected update paths and organizational requirements can differ, and this module's cloud-connected scope doesn't excuse stale protection.

These projections deliberately omit key protectors and recovery passwords. A general assessment doesn't need the values that could unlock a volume. If recovery testing requires a secret, retrieve it through the separately approved recovery workflow.

An error, missing expected volume, disabled service, or stale signature timestamp requires investigation. Compare the result with maintenance records and the supported product guidance. Don't fix it by applying a generic Windows hardening or tuning script to the hosts.

## Inspect baseline features and application control

Azure Local uses *App Control for Business*, formerly Windows Defender Application Control (WDAC), to restrict which drivers and applications can run on its physical hosts. Application control is enabled by default. Microsoft supplies base policies that trust the operating-system and Azure Local components needed by the platform and include rules that block software considered unsafe. In **Enforced** mode, code that isn't permitted by the effective policies is blocked, and application-control events provide evidence for investigation. In **Audit** mode, code that would otherwise be blocked can run while events are recorded, so audit mode doesn't provide the same preventive protection.

When supported third-party software needs to run on a host, administrators can deploy a narrowly scoped customer supplemental policy through Azure Local's policy-management workflow. The supplemental policy extends the permitted software without replacing the Microsoft base policies. Inspect the active mode and policy inventory on the intended nodes to confirm that the approved configuration is actually applied. Application control complements antivirus: it controls permission to execute rather than deciding whether a file matches malware detection criteria. Host application-control policies don't automatically configure equivalent controls inside guest VMs or replace authorization within Contoso's clinical applications.

Azure Local installs the `AzureStackOSConfigAgent` module for security-baseline management. Use local feature inspection to make the observation boundary explicit:

```powershell
$ErrorActionPreference = 'Stop'

Get-AzsSecurity -FeatureName DriftControl -Local
Get-AzsSecurity -FeatureName VBS -Local
Get-AzsSecurity -FeatureName HVCI -Local
Get-AzsSecurity -FeatureName CredentialGuard -Local
Get-AzsSecurity -FeatureName SMBSigning -Local
Get-AzsSecurity -FeatureName SMBClusterEncryption -Local
```

Record each result with its feature name, node, and observation time. Repeat local inspection across the approved node inventory. A `True` result for one feature on one node isn't a complete baseline report or a measurement of every runtime protection.

Review recorded customizations and application-control information separately:

```powershell
Get-AzsSecurityPolicyIntent
Get-ASAppControlPolicyMode
Get-ASLocalAppControlPolicyInfo
```

`Get-AzsSecurityPolicyIntent` lists cluster customizations. It doesn't list every baseline default or customizations made only on one node. An empty customization list doesn't mean that the cluster has no security configuration.

`Get-ASAppControlPolicyMode` reports application-control modes per node. The expected production mode is normally `Enforced`. `Get-ASLocalAppControlPolicyInfo` reports policies on the node where it runs. Compare policy identity, version, mode, and whether the policy is Microsoft-provided with the approved inventory.

Starting in version 2610, the Azure Local cmdlets use App Control names. Earlier WDAC names remain aliases on 2610, but use the current names for new operational documentation. Older names in an existing script don't, by themselves, mean the script is broken.

Cluster-wide `Get-AzsSecurity` scopes have documented connection requirements, including Credential Security Support Provider (CredSSP) or remote desktop for certain queries. CredSSP delegates credentials, which changes the exposure of those credentials. Use only a specifically approved connection method. Don't enable delegation broadly to simplify evidence collection.

## From observation to finding

Separate the following conclusions in the assessment record:

- **Observed and consistent**: The expected resource was inspected, and the result matches approved intent.
- **Observed and inconsistent**: The resource was inspected, and a specific result differs from approved intent.
- **Not established**: The resource, command, runtime state, or required evidence couldn't be inspected.

For example, "Node 2 couldn't be reached" isn't equivalent to "Node 2 is noncompliant," but neither conclusion supports closing the review. Assign an owner to resolve the evidence gap.

Match the inspection scope to the conclusion you need to support. Run the node commands in an authorized administrative session using the deployment-installed modules. On an upgraded deployment, the newer baseline-management commands, including `Get-AzsSecurityPolicyIntent`, depend on the security baseline having been properly applied. A missing command is an assessment gap to investigate, not a reason to install an unrelated module or report the control as compliant.

For `Get-AzsSecurity -FeatureName <name>`, choose one of the following scope switches. The returned Boolean value is `True` or `False`, but its meaning depends on the selected scope.

| Scope switch | Evidence returned | Connection requirement |
| --- | --- | --- |
| `-Local` | The named feature's state on the connected node. This is the default when no scope switch is supplied. | Can run through a regular remote PowerShell session. |
| `-PerNode` | A separate result for each node, which lets you identify differences between nodes. | Requires an approved CredSSP session or Remote Desktop Protocol (RDP) connection. |
| `-AllNodes` | One Boolean result computed across the nodes, rather than a node-by-node inventory. | Requires an approved CredSSP session or RDP connection. |
| `-Cluster` | The feature value recorded in the orchestrator's configuration store. This isn't independent proof of each node's current runtime state. | Requires an approved CredSSP session or RDP connection. |

Use per-node evidence when you need to establish coverage or locate a discrepancy. If a suitable cluster-wide connection isn't authorized, run `-Local` separately on every expected node and retain the results together. Don't enable broad credential delegation simply to obtain a combined report.

For App Control inspection, connect to a node with authorized local administrator or deployment-user credentials. `Get-ASAppControlPolicyMode` returns the mode per node, whereas `Get-ASLocalAppControlPolicyInfo` reports policies on the connected node. For each expected policy, compare its identifier, name, version, mode, Microsoft-provided status, and last-applied time with the approved inventory. Repeat the local inventory query on the other nodes. A successful response from one node doesn't establish that the same policy reached every node.

Distinguish a requested configuration from a completed change. An approved App Control mode change can take two to three minutes to propagate through the orchestrator, so query the mode again before recording the final result. Changes to VBS, Credential Guard, DRTM, and HVCI require a restart to take effect. Changes to SMB signing or in-cluster SMB encryption apply to newly established SMB connections, while existing sessions retain their previously negotiated settings. Account for these conditions when interpreting evidence, and don't restart nodes or interrupt connections merely to complete an unapproved inspection.

## Govern vulnerabilities and supported security updates

A security baseline describes intended configuration. A *vulnerability* is a weakness that could be exploited even when that configuration is correct. A host can match its baseline while running a component with a newly disclosed vulnerability. Likewise, an executable permitted by App Control can still contain a security flaw. Configuration compliance, signature freshness, and vulnerability remediation are related evidence, not interchangeable results.

Maintain an inventory that connects each node and workload to its Azure Local solution version, operating-system build, platform agents, OEM firmware and drivers, guest operating system, and application versions. Assign owners to review Microsoft and OEM security advisories and relevant vendor notices. Where an advisory identifies a Common Vulnerabilities and Exposures (CVE) record, associate that identifier with the affected assets and installed versions. A severity score alone doesn't establish local exposure. Consider exploit activity, reachable attack paths, privileges required, existing protections, and clinical-service impact.

Use assessment methods supported for the resource being examined. In the Azure Local 2610 Defender for Cloud guidance, Microsoft Defender Vulnerability Management isn't supported for Azure Local hosts. Don't deploy an arbitrary vulnerability-scanning agent simply to clear that recommendation. Record the applicability decision and use supported inventory, advisory, and assessment evidence. Guest VMs have their own operating-system and service support requirements, which must be evaluated separately. An unsupported host recommendation isn't permission to ignore a known vulnerability.

Azure Local solution updates coordinate the operating system, core agents and services, and validated platform dependencies. OEM driver and firmware updates can participate through a *Solution Builder Extension (SBE)*, which packages partner-specific update content. Identify the supported OEM path for the installed hardware. Use the Azure Local update experience in the Azure portal or the supported Azure Local PowerShell workflow. Don't independently update hosts through the generic Azure Update Manager Machines experience, the Updates pane of an individual machine (Machine - Azure Arc) resource, Windows Update, SConfig, Windows Admin Center, manual Cluster-Aware Updating, or third-party patching tools. Updating individual platform components outside the coordinated workflow can produce an unsupported combination. The solution update doesn't patch customer guest operating systems or applications.

Apply the following remediation workflow:

1. **Establish applicability.** Match the advisory to the affected product, version, configuration, and nodes or workloads. Preserve the evidence for an affected, unaffected, or unresolved conclusion.
1. **Prioritize and assign.** Set an accountable owner and risk-based completion deadline. Escalate active exploitation or an exposed critical service rather than waiting automatically for the next routine maintenance window.
1. **Choose a supported treatment.** Identify the supported target release or OEM remediation and its prerequisites. If no supported fix is available, engage the appropriate support team and approve a time-bounded mitigation with a review date. Don't disable drift control or protection features as an undocumented workaround.
1. **Prepare the change.** Check cluster and storage health, witness availability, remaining workload capacity, and usable recovery material. Agree the maintenance impact with workload owners. Follow the supported update sequence and stop conditions rather than assuming that a rolling update guarantees uninterrupted application service.
1. **Confirm the outcome.** Record the installed versions and completion state for every intended node. Recheck baseline intent, App Control enforcement, antivirus health, event delivery, and required application behavior. Confirm that the affected component is actually remediated, not merely that an update request was accepted.
1. **Close or escalate residual risk.** Close the finding only when its completion criteria are met. Record failed or deferred nodes explicitly, retain the temporary mitigation if still required, and obtain a new decision before its expiry.

Review the supported release window as well as individual vulnerabilities. The lifecycle guidance for this release requires remaining within six months of the most recent Azure Local feature release. Azure resource bridge also requires solution updates within one year to maintain certificate validity and VM functionality. That longer certificate-related limit doesn't replace the shorter platform support requirement or justify delaying a security fix. A platform version that still runs can fall outside support, and a support window isn't an acceptable deadline for an actively exploited issue.

For Contoso, the platform team owns host remediation, workload owners own guest and application remediation, and the security authority tracks unresolved exposure across both.
