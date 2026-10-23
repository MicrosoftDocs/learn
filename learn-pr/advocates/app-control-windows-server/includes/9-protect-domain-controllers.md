A domain controller failure can affect authentication, DNS, replication, and access to the tools needed to repair the failure. Treat policy distribution and recovery access as part of the identity infrastructure.

The example domain controller runs Windows Server 2025, AD DS, and DNS. It can be physical or virtual. A virtual domain controller's guest policy remains separate from the Hyper-V host policy.

## Identify required execution paths

Inventory what actually executes on the domain controller. Don't equate "stored on the domain controller" with "executed on the domain controller."

The following dependencies require explicit consideration.

| Dependency | Role in the workload | Validation focus |
| --- | --- | --- |
| AD DS and its supporting binaries | Directory storage and requests | Directory queries, authentication, and service recovery. |
| DNS | Name resolution and service discovery | Client resolution and relevant DNS health checks. |
| Kerberos and Netlogon | Authentication and domain operations | Real client logon and service authentication. |
| DFS Replication and SYSVOL | Replicate and expose policy/script content | SYSVOL availability, replication health, and Group Policy processing on a test client. |
| Windows Time | Supports time-sensitive authentication | Correct time source and acceptable synchronization. |
| Backup and recovery agents | Restore supported directory state | System-state backup and an isolated recovery rehearsal. |
| Identity sensors and EDR | Observe and protect the server | Sensor health and approved update behavior. |
| Password filters or authentication extensions | Extend sensitive authentication processes | Approved versions, signing requirements, and functional tests. |
| Administrative tools and scripts | Operate and recover the domain controller | Actual remote and local administrative contexts. |

LSASS protection and other process-signing requirements remain separate constraints. An App Control allow rule isn't permission to weaken protected-process requirements for an incompatible authentication extension.

SYSVOL can contain scripts that execute on clients. A broad CI allowance for SYSVOL on the domain controller neither authorizes those client executions nor proves that the scripts should run on the domain controller.

## Capture health before and after

On the example domain controller, run these read-only checks. The DNS and Active Directory components must be installed for this specific example.

```powershell
$ErrorActionPreference = 'Stop'
Import-Module ActiveDirectory
Get-Service -Name NTDS, DNS, KDC, Netlogon, DFSR, W32Time
Get-ADReplicationPartnerMetadata -Target $env:COMPUTERNAME -Scope Server |
    Select-Object Server, Partner, LastReplicationSuccess, LastReplicationResult
```

Identify critical role holders from an authorized AD administration environment.

```powershell
$ErrorActionPreference = 'Stop'
Import-Module ActiveDirectory
Get-ADDomain |
    Select-Object PDCEmulator, RIDMaster, InfrastructureMaster
Get-ADForest |
    Select-Object SchemaMaster, DomainNamingMaster
```

Then run directory diagnostics and review their actual results. These native tools don't change CI policy.

```powershell
& dcdiag.exe /test:Advertising /test:Replications /test:SysVolCheck /test:DNS
if ($LASTEXITCODE -ne 0) {
    throw "dcdiag reported an unsuccessful exit: $LASTEXITCODE"
}
& repadmin.exe /replsummary
if ($LASTEXITCODE -ne 0) {
    throw "repadmin reported an unsuccessful exit: $LASTEXITCODE"
}
```

Read the test results even when the process exit is zero. Compare replication failures with the prechange baseline, investigate new failures, and confirm client-side authentication and DNS operation.

Neither service state nor a successful replication query proves that backup, recovery, or a sensor update works. Exercise those paths separately.

## Stage the domain controller rollout

Pilot a designated domain controller. Don't link an unproven policy to every domain controller through a broad domain or OU assignment.

Use the following sequence to protect identity availability:

1. Verify healthy alternative authentication and DNS capacity for affected sites.
1. Identify critical role holders and avoid simultaneous changes to interdependent domain controllers.
1. Confirm replication health and recent supported backups.
1. Apply the candidate to the designated pilot and retain independent recovery access.
1. Validate authentication, DNS, replication, SYSVOL, client Group Policy processing, administration, sensors, and backup.
1. Perform the required restart and repeat the relevant checks.
1. Expand only after the identity workload owner approves the result.

When domain controllers are virtual, also coordinate their placement. Updating every Hyper-V host that carries them can remove the redundancy preserved by a careful guest-policy rollout.

## Preserve an independent recovery path

Directory Services Restore Mode (DSRM) supports AD DS recovery. It's not an App Control bypass. Rehearse the interaction between directory recovery, policy recovery, and any required startup-mode changes.

Keep recovery credentials, BitLocker material, policy artifacts, and authorized signing access available when normal domain authentication is unavailable.

A VM checkpoint isn't a replacement for a supported domain controller backup or forest-recovery plan. A restored machine can also contain older policy artifacts; account for signed-policy version and protection state before treating restoration as a simple rollback.

Keep signing and policy distribution under appropriately protected administration. General-purpose installer trust that's convenient for member servers might be inappropriate for a domain controller.
