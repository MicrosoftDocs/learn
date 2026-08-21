Domain recovery sits between single domain controller recovery and forest recovery. Perform domain recovery only when damage is confined to one domain naming context and the shared forest state remains trustworthy.

## Establish the boundary

Domain-scoped recovery requires evidence that these partitions remain trustworthy:

- Schema.
- Configuration.
- Forest DNS application partition.
- Unaffected domain naming contexts.

Examples that can remain domain-scoped:

- Widespread deletion in one domain.
- Corruption of one domain naming context.
- Loss of every writable controller in one domain while parent services remain trusted.

Examples that normally escalate you to forest recovery include:

- Schema corruption.
- Configuration corruption.
- Enterprise-wide privileged compromise.
- Forest DNS corruption that affects directory location.
- Multiple domains with no trustworthy shared state.
- Inability to isolate every writable controller with unsafe changes.

> [!NOTE]
> When you're uncertain about the scope of the boundary, involve Microsoft Support or the approved incident authority.

## Evaluate parent-child dependencies

A child domain depends on forest services that can include:

- Parent DNS delegation.
- Forest-root `_msdcs` data.
- Transitive trust hierarchy.
- Schema and configuration replication.
- Global catalog data.
- Enterprise administration.
- Cross-domain group membership.
- Universal groups.
- Time hierarchy.

Inventory application dependencies on:

- Users from other domains.
- Resource groups in the affected domain.
- Service principal names.
- Cross-domain constrained delegation.
- Trust authentication.

## Decide whether healthy domains remain online

Healthy domains can remain online only when:

- Shared forest partitions are trustworthy.
- Unsafe replication can be blocked.
- DNS resolution can be controlled.
- Privileged administration remains trustworthy.
- The incident isn't a forest-wide compromise.
- Healthy domains won't accept stale or corrupt state.

Isolate healthy domains or escalate to forest recovery when those conditions fail.

Global catalog partial replicas require special treatment during single-domain recovery in a multidomain forest. Plan to rehost or unhost affected global catalog data, or remove lingering objects through the supported procedure. Don't assume that restoring the affected domain naming context alone makes every global catalog consistent.

## Select the first writable controller

Choose a trusted writable backup for the affected domain. Don't use a read-only domain controller backup.

Selection evidence must include:

- Exact backup time and source.
- AD DS health.
- Replication state.
- Incident timeline.
- Change history.
- VSS and catalog state.
- Restore-test result.
- Platform compatibility.
- Key and credential availability.
- Expected data loss.
- Effective lifetime limit and recovery-point age, gated as described in **Approve and protect the recovery-point record before DSRM**, recorded separately for each domain's selected backup, including whether each lifetime came from an explicitly configured attribute or a documented default.
- Approval.

The selected controller becomes the first recovered writable controller for that domain.

## Establish SYSVOL authority

Determine SYSVOL authority for the affected domain by doing the following:

1. Recover AD DS nonauthoritatively from the trusted backup.
1. Establish the first writable controller's SYSVOL as authoritative.
1. Validate the domain naming context.
1. Validate DNS required by the domain.
1. Recover the three domain operations master roles.
1. Confirm that every writable controller in the domain that you aren't restoring is isolated and can't reconnect.
1. Clean up the metadata of each of those controllers and remove their stale DNS records, including NS and SRV records.
1. Complete the domain security state described in **Complete domain security state**, including RID Master ownership and RID pool handling, the `krbtgt` decision recorded for this recovery, and any required trust resets. Keep the domain controller computer-account two-reset sequence scoped to forest recovery unless the approved Microsoft-supported plan for this incident explicitly extends it.
1. Validate AD DS, SYSVOL, DNS, the replication boundary, and authentication on the first recovered controller.
1. Add replacement controllers only by clean promotion, or by an approved supported domain controller cloning or Install from Media process.
1. Admit a retained controller only after a completed supported AD-aware nonauthoritative AD DS or system-state restore. Then perform nonauthoritative SYSVOL synchronization from the selected authoritative source, and validate AD DS and SYSVOL independently before admission. A replacement controller instead requires a completed clean rebuild and promotion, or an approved supported cloning or Install from Media process; it isn't admitted as a retained restored controller. SYSVOL synchronization repairs SYSVOL only; it doesn't provision a controller and doesn't make a restored AD DS database nonauthoritative.

> [!WARNING]
> Use this isolated first-controller procedure for the single approved authoritative SYSVOL source in the recovered domain. Don't create multiple authoritative sources or splice in the `msDFSR-Enabled` transitions from the coordinated all-DC repair procedure. When multiple otherwise healthy, online DCs require SYSVOL repair, use [Force authoritative and nonauthoritative synchronization for DFSR-replicated SYSVOL](/troubleshoot/windows-server/group-policy/force-authoritative-non-authoritative-synchronization).

## Recover domain operations masters

A non-root domain has three flexible single master operations roles:

- PDC Emulator.
- RID Master.
- Infrastructure Master.

During recovery operations, you may need to seize these roles from a failed domain controller. You can do this using the following command:

```powershell
$targetDc = 'DC01.child.contoso.com'
$server = Get-ADDomainController `
    -Identity $targetDc `
    -Server $targetDc `
    -ErrorAction Stop

Move-ADDirectoryServerOperationMasterRole `
    -Identity $server `
    -Server $targetDc `
    -OperationMasterRole PDCEmulator, RIDMaster, InfrastructureMaster `
    -Force `
    -PassThru `
    -ErrorAction Stop
```

Preconditions:

- The controller is the approved recovery target.
- The domain is isolated as designed.
- The commands run in an elevated Windows PowerShell session in normal AD DS mode on the target domain controller or an approved RSAT host with the AD DS tools installed, and the writable target is reachable through Active Directory Web Services. `netdom query` requires elevation; don't mistake a nonelevated failure for a locator failure.
- A Domain Admin for this domain performs the seizure.
- Every former role holder is permanently blocked and will never reconnect.

To validate the movement of these roles:

```powershell
$targetDc = 'DC01.child.contoso.com'
$domainName = 'child.contoso.com'
$queryCredential = Get-Credential -Message "Domain Admin for $domainName"

Get-ADDomain `
    -Identity $domainName `
    -Server $targetDc `
    -Credential $queryCredential `
    -ErrorAction Stop |
    Select-Object PDCEmulator, RIDMaster, InfrastructureMaster

netdom query "/domain:$domainName" "/server:$targetDc" `
    "/userD:$domainName\<domain-admin>" /passwordD:* FSMO
```

On the isolated recovery network, recovery DNS and DC Locator must locate `$domainName`. Treat a locator failure as a recovery-DNS problem and an authentication failure as a credentials or isolation problem; neither is role-placement evidence. Confirm the `Get-ADDomain` result against the recovered controller named in `$targetDc`.

## Recover DNS

To recover Active Directory Integrated DNS during isolated recovery:

- Configure the first child-domain controller to use the recovered forest-root DNS service until authoritative child-domain DNS is available.
- Restore domain-partition and `DomainDnsZones` data through AD DS recovery.
- Validate required `ForestDnsZones` data from the recovered forest services.
- Restore file-backed zones and local settings separately.
- Restore delegations and conditional forwarders.
- Remove stale records for retired controllers.

> [!WARNING]
> Don't point recovered controllers to untrusted production DNS servers.

## RID protection

Relative identifiers combine with the domain SID to create security identifiers. A writable domain controller allocates RIDs from a local pool supplied by the domain RID Master. RID space is finite, so recovery actions must follow the supported forest-recovery procedure.

For each recovered domain:

1. Confirm RID Master ownership and complete required metadata cleanup.
1. Raise `rIDAvailablePool` on `CN=RID Manager$,CN=System,<domain DN>` by 100,000, or by a larger approved amount when measured post-backup RID consumption shows that 100,000 is insufficient.
1. Read the value back from the intended RID Master and confirm the change.
1. Determine whether the selected recovery path already invalidated or discarded the restored domain controller's local RID pool.
1. Manually invalidate the local pool only when the recovery path didn't do so, such as full-server or bare-metal recovery without a subsequent system-state recovery.
1. Validate RID allocation and security-principal creation.

Raise the available pool once in every recovered domain. `rIDAvailablePool` is a large integer: its lower part is the start of the next pool, and its upper part is the domain RID limit. Adding 100,000 to the whole value advances the lower part by 100,000. For example, increasing `4611686014132422708`, whose lower part is 2100, produces `4611686014132522708`, whose next pool starts at 102100.

Use the documented ADSI Edit or LDP procedure for this large-integer write. Connect explicitly to the RID Master, record the current value, calculate and approve the replacement, replace the attribute, and then refresh the object and confirm the exact value. Don't substitute an unreviewed script in a recovery runbook.

Before raising the value, check the remaining RID space. Event 16656 is written by a domain controller requesting a pool when the domain is within one percent of the artificial ceiling. Event 16657 is written by the RID Master when the ten-percent-remaining ceiling is reached; the RID Master then stops issuing pools and sets `msDS-RIDPoolAllocationEnabled` to `FALSE` on `CN=RID Manager$`. Diagnose abnormal consumption before setting that attribute to `TRUE`. Don't use the irreversible 31-bit RID-space unlock as a routine recovery action.

A system-state restore already invalidates the restored controller's local RID pool, and a supported VM-Generation ID safe restore discards it. Don't invalidate the pool a second time merely because the runbook contains an invalidation step. If manual invalidation is required, run it in normal AD DS mode on the recovered writable domain controller, not in DSRM or on a read-only domain controller. Use an identity that has read permission on `rIDManagerReference` and the **Change-RID-Master** control access right. Confirm a new Directory-Services-SAM event 16654, and stop if the RID Master is unavailable, the event isn't recorded within the approved runbook window, or RID allocation doesn't recover. Acquisition of a new pool is asynchronous; the next security-principal creation normally fails once and succeeds on retry after allocation.

## Complete domain security state

When domain-scoped recovery rolls the domain back to a trusted point, perform the applicable domain-specific forest-recovery tasks:

- Confirm RID Master ownership and required metadata cleanup, then raise the domain's available RID pool once by the approved safe amount.
- Determine whether the recovery path already discarded the restored controller's local RID pool, and invalidate it manually only when required.
- Decide and record whether this recovery requires the writable `krbtgt` two-reset sequence, then run it when it does. Run it whenever the recovery responds to compromise, and in every recovered domain during full forest recovery. When you run it, perform the first reset, wait longer than the greater of the effective maximum user-ticket and service-ticket lifetimes for that domain, prove that the first reset replicated to every intended writable controller, then perform the second reset and prove convergence again.
- Distinguish the writable domain `krbtgt` account from each RODC `krbtgt_<number>` account.
- Rebuild RODCs and address cached credential exposure according to the incident.
- Reset each affected trust through the paired one-sided procedure in **Recover trusts per trust**, using the same recovery secret on both sides.
- Validate trust direction, transitivity, selective authentication, SID filtering, and application use.

> [!NOTE]
> Don't apply RID, `krbtgt`, or trust actions as one forest-wide operation. Record the decision and evidence for this recovered domain.

Don't clean-promote or otherwise add replacement controllers to the recovered domain until every retired writable controller is isolated, its metadata and stale DNS records are removed, required operations-master and RID state is complete, and the first recovered controller passes AD DS, SYSVOL, DNS, replication-boundary, and authentication validation. No controller that existed before the recovery may return after roles are seized and metadata is cleaned.

A controller that held the RID Master role in the restored backup must not resume RID issuance until stale controller metadata is removed. After cleanup and any role seizure, always validate RID Master ownership, `dcdiag /test:RidManager`, available-pool state, and successful security-principal creation.

Scope the security resets to the recovery you're actually performing, and record the decision:

- **Full forest recovery.** Run the computer-account two-reset sequence on the sole recovered writable controller in every recovered domain, and run the writable `krbtgt` two-reset sequence in every recovered domain. Microsoft's forest-recovery procedure requires both.
- **Recovery that responds to compromise, at any scope.** Complete the writable `krbtgt` two-reset sequence for each affected domain and reset the affected trust passwords, because credential material must be assumed exposed.
- **Availability-only single-domain recovery.** Microsoft's single-domain guidance doesn't itself impose the `krbtgt` resets, so treat them as incident-runbook hardening: record an explicit decision, and default to running the two-reset sequence whenever compromise can't be excluded or the recovery point predates unexplained authentication activity. Keep the computer-account reset out of this scope unless the approved Microsoft-supported plan explicitly extends it, because that reset deliberately breaks replication with controllers that existed before the recovery.

## Forest recovery

Forest recovery rebuilds a trusted directory from selected backups. It's an involved, complex process and should be undertaken as a last resort. Escalate to forest recovery if:

- Schema or configuration trust fails.
- Forest DNS can't be trusted.
- Enterprise privileged identities are compromised.
- Several domains require rollback.
- Trust hierarchy can't be repaired safely.
- Unsafe writable controllers can't all be isolated.
- The last-known-safe time can't be established.

Forest recovery is justified when responders can't trust the forest's shared state or can't contain the incident at a smaller scope.

Examples:

- Forest-wide privileged compromise.
- Schema corruption.
- Configuration partition corruption.
- Ransomware affecting writable controllers across domains.
- Unsafe changes replicated throughout the forest.
- Multiple domain failures with no trustworthy shared state.

> [!IMPORTANT]
> Forest recovery restores a trusted directory state. It doesn't prove attacker eviction or remediate every persistence mechanism.

## Establish trusted recovery control

Before restoration:

- Preserve evidence.
- Shut down or isolate writable production controllers.
- Use clean administrative workstations.
- Use trusted installation media.
- Build an isolated recovery network.
- Retrieve recovery credentials and keys outside the forest.
- Select one trusted writable backup per domain.
- Effective lifetime limit and recovery-point age, gated as described in **Approve and protect the recovery-point record before DSRM**, recorded separately for each domain's selected backup, including whether each lifetime came from an explicitly configured attribute or a documented default.
- Approve expected data loss.
- Assign owners for adjacent dependencies.

RODCs don't originate normal directory changes. They can provide cached local authentication in some availability incidents. During compromise, continued RODC use requires an explicit risk decision. Rebuild every RODC after writable recovery.

## Sequence domain recovery

When performing forest recovery, you recover:

1. Forest-root domain.
1. Parent domains.
1. Child domains.
1. One writable controller per domain.
1. Additional controllers after each domain is stable.

:::image type="content" source="../media/forest-recovery-sequence.svg" alt-text="Diagram that shows the forest recovery sequence from isolation through reconnection.":::

Parallel domain recovery can reduce time only when parent DNS, trust, operational control, and staffing dependencies remain satisfied.

## Recover the forest-root controller

For the selected first writable forest-root controller:

1. Confirm isolation.
1. Restore from the approved trusted backup for the forest-root domain after it passes the effective-lifetime test in the unit 5 **Approve and protect the recovery-point record before DSRM** gate, and retain that domain's record.
1. Recover AD DS nonauthoritatively.
1. Establish SYSVOL authoritatively.
1. Configure DNS for isolated operation.
1. Validate startup and apply the initial-synchronization exception if necessary.
1. In a multidomain forest, remove the global catalog role soon after restore if this controller held it before the failure. A single-domain forest is the documented exception.
1. Seize all five operations master roles.
1. Clean up the metadata of every other writable controller in the forest-root domain that you aren't restoring from backup.

Example:

```powershell
$targetDc = 'DC01.contoso.com'
$server = Get-ADDomainController `
    -Identity $targetDc `
    -Server $targetDc `
    -ErrorAction Stop

Move-ADDirectoryServerOperationMasterRole `
    -Identity $server `
    -Server $targetDc `
    -OperationMasterRole SchemaMaster, DomainNamingMaster, PDCEmulator, RIDMaster, InfrastructureMaster `
    -Force `
    -PassThru `
    -ErrorAction Stop
```

This example is valid only when `$targetDc` is the approved first writable controller in the forest-root domain. Run the example and validation from an elevated Windows PowerShell session in normal AD DS mode on the target domain controller or an approved RSAT host with the AD DS tools installed. The writable target must be reachable through Active Directory Web Services. `netdom query` requires elevation; don't mistake a nonelevated failure for a locator failure. If Active Directory Web Services isn't available, use the documented local [`ntdsutil roles` seizure procedure](/windows-server/identity/ad-ds/manage/forest-recovery-guide/ad-forest-recovery-seizing-operations-master-role).

Required privilege and execution context:

- Domain Admins for PDC Emulator, RID Master, and Infrastructure Master.
- Enterprise Admins for Domain Naming Master.
- Schema Admins for Schema Master.
- Isolated recovery network.
- Every former role holder permanently blocked and prohibited from reconnecting.

Expected result: forest roles and forest-root domain roles are owned by the recovered controller. On the isolated recovery network, recovery DNS and DC Locator must locate `$domainName`. Treat a locator failure as a recovery-DNS problem and an authentication failure as a credentials or isolation problem; neither is role-placement evidence. Confirm the `Get-ADDomain` result against the recovered controller named in `$targetDc`.

Retain the output as recovery evidence. Stop if any role points to a former holder or a former holder can reconnect.

### Handle initial synchronization on an isolated operations master

A restarted controller that holds operations master roles doesn't advertise as a domain controller until inbound and outbound replication with its known replica partners succeeds. During recovery, those partners are deliberately unreachable, so AD DS can remain unavailable and block startup validation and role seizure.

Apply this exception only when both conditions are true:

- The restored controller hosts one or more operations master roles.
- The controller can't reach its known replica partners because recovery isolation is in effect.

```powershell
New-ItemProperty `
    -Path 'HKLM:\System\CurrentControlSet\Services\NTDS\Parameters' `
    -Name 'Repl Perform Initial Synchronizations' `
    -PropertyType DWord `
    -Value 0 `
    -Force
```

Restart the controller so AD DS reads the changed value, then continue startup validation and role seizure.

Record the controller name, change time, approver, and the removal step. This value suppresses a startup safety check and is a temporary recovery measure, not a configuration standard.

> [!WARNING]
> Don't apply this exception by default and don't leave it in place. Until its reset, a controller that holds operations master roles advertises and serves clients before it has proven replication health with its partners.

## Recover each non-root domain

For the first writable controller in every non-root domain:

1. Use the approved trusted backup for that domain after it passes the effective-lifetime test in the unit 5 **Approve and protect the recovery-point record before DSRM** gate, and retain that domain's record.
1. Recover AD DS nonauthoritatively.
1. Establish SYSVOL authoritatively.
1. Validate the domain naming context.
1. Configure DNS to use recovered trusted services.
1. In a multidomain forest, remove the global catalog role soon after restore if this controller held it before the failure.
1. Seize the three domain operations master roles.
1. Clean up the metadata of every other writable controller in that domain that you aren't restoring from backup.
1. Validate trust and application dependencies.

Example:

```powershell
$targetDc = 'DC01.child.contoso.com'
$domainName = 'child.contoso.com'
$queryCredential = Get-Credential -Message "Domain Admin for $domainName"

$server = Get-ADDomainController `
    -Identity $targetDc `
    -Server $targetDc `
    -Credential $queryCredential `
    -ErrorAction Stop

Move-ADDirectoryServerOperationMasterRole `
    -Identity $server `
    -Server $targetDc `
    -Credential $queryCredential `
    -OperationMasterRole PDCEmulator, RIDMaster, InfrastructureMaster `
    -Force `
    -PassThru `
    -ErrorAction Stop

Get-ADDomain `
    -Identity $domainName `
    -Server $targetDc `
    -Credential $queryCredential `
    -ErrorAction Stop |
    Select-Object PDCEmulator, RIDMaster, InfrastructureMaster

netdom query "/domain:$domainName" "/server:$targetDc" `
    "/userD:$domainName\<domain-admin>" /passwordD:* FSMO
```

Repeat with the selected writable controller and a Domain Admin for each domain. Run in an elevated Windows PowerShell session in normal AD DS mode on the target domain controller or an approved RSAT host with the AD DS tools installed. `netdom query` requires elevation; don't mistake a nonelevated failure for a locator failure.

On the isolated recovery network, recovery DNS and DC Locator must locate `$domainName`. Treat a locator failure as a recovery-DNS problem and an authentication failure as a credentials or isolation problem; neither is role-placement evidence. Confirm the `Get-ADDomain` result against the recovered controller named in `$targetDc`.

If Active Directory Web Services isn't available, use the local `ntdsutil roles` seizure procedure. Retain validation output, permanently block every former holder, and stop if a former holder can reconnect. The initial-synchronization exception applies here too when a restored non-root controller holds domain operations master roles and can't reach its replica partners.

## Clean up metadata for controllers you aren't restoring

Metadata cleanup is a required recovery step, not optional housekeeping. In every recovered domain, clean up the metadata of each writable controller in that domain that you aren't restoring from backup.

Cleanup removes the directory data that identifies a controller to the replication system:

- Server object.
- NTDS Settings object.
- Computer account.
- Replication connection objects.
- Domain controller locator DNS records.

Use one of these workflows while connected explicitly to the intended recovered controller:

- **Active Directory Users and Computers:** Open the removed controller's domain and **Domain Controllers** OU. Delete the controller's computer object, select **This Domain Controller is permanently offline and can no longer be demoted...**, and acknowledge global catalog and role-holder prompts as applicable. Current ADUC performs metadata cleanup automatically.
- **Active Directory Administrative Center:** Delete the controller object and follow the current delete-controller prompts. Current ADAC in RSAT automatically removes the server and computer objects. Verify the result rather than adding a separate Sites and Services sequence to this workflow.
- **Active Directory Sites and Services:** Under **Sites** > site > **Servers** > removed controller, delete **NTDS Settings** first. Select the `permanently-offline` option and acknowledge global catalog and role-holder prompts. Then delete the now-empty server object. Don't delete a server object that still has child objects used by another application.

If cleanup returns **Access is denied**, inspect both the controller computer object and its NTDS Settings object. Under the approved cleanup change, clear **Protect object from accidental deletion**, retry cleanup, and retain evidence of that protection change. In ADUC, enable **Advanced Features** to display the **Object** tab. `ntdsutil metadata cleanup` remains the command-line alternative.

> [!IMPORTANT]
> Until the metadata of every other controller in the domain is removed, a restored controller that held the RID Master role doesn't assume that role and can't issue new RIDs. Event ID 16650 in the System log records the failure. Event ID 16648 records success after cleanup completes.

Cleanup also prevents duplicate NTDS Settings objects if AD DS is later installed on a controller in a different site, and stops the Knowledge Consistency Checker from building replication links to controllers that no longer exist.

Perform cleanup from a recovered controller in the same domain, and record:

- Each controller removed.
- The operator and approval.
- Evidence that the removed controller can't return, replicate, or register.

Stop if a controller you intend to remove can still reconnect to the recovery network.

Verify removal in ADUC or ADAC, Active Directory Sites and Services, `repadmin /viewlist *`, the approved domain-controller inventory, replication connections, and DNS. Don't delete an object solely because one console no longer displays it.

## Recover DNS

The recovery design must identify which data returns through AD DS:

- Domain naming context zones.
- `DomainDnsZones`.
- `ForestDnsZones`.

Recover separately:

- File-backed zones.
- Conditional forwarders not stored in AD DS.
- Server-local forwarder settings.
- Policies.
- Customized root hints.
- External delegations.

For each file-backed primary zone, restore the approved zone file and recreate or verify the zone definition on the recovered DNS server. Reload it through the Windows Server 2025 DNS Server recovery procedure, then validate records, transfers, dynamic-update policy, delegation, and resolution. AD DS recovery doesn't restore this data or server-local DNS settings.

During isolation:

- The forest-root controller uses an approved isolated DNS design.
- Child-domain controllers use recovered forest-root DNS until their domain DNS is authoritative.
- No recovered controller queries an untrusted production DNS server.

Remove stale NS, CNAME, A, AAAA, and SRV records for retired controllers. In the `_msdcs` and domain zones, delete the NS records of controllers removed through metadata cleanup, then confirm that their locator SRV records are gone. To speed up SRV record removal, run:

```powershell
$removedControllerFqdn = Read-Host 'Enter the FQDN of the removed controller'
nltest.exe "/dsderegdns:$removedControllerFqdn"
```

Confirm that the records don't return through replication or dynamic registration.

## Control global catalog recovery

Global catalog data contains partial replicas from other domains. In a multidomain forest, remove the global catalog role soon after restoring a controller that held it before the failure. Clear **Global Catalog** on the controller's NTDS Settings object, or run locally from an elevated prompt:

```console
repadmin.exe /options DC_NAME -IS_GC
```

A single-domain forest is the documented exception; removing the global catalog isn't required there. The lingering-object risk occurs when the restored global catalog backup is newer than the backup used for the writable authoritative controller of another domain. The restored global catalog can retain objects in that domain's partial replica that no longer exist in the recovered authoritative domain and can replicate those objects to other global catalogs.

After the required domains and directory partitions are restored, connected on the isolated seed network, replicated, and validated, add a global catalog in the forest-root domain. Confirm full partition synchronization and Directory Service event 1119, or equivalent current readiness evidence, before directing ordinary authentication or applications to it. Don't add or readd global catalog capacity merely because a server is online.

### Repair global catalog data after single-domain recovery

Recovering one domain to an earlier trusted point can leave newer partial replicas of that domain on global catalog servers in other domains. Those replicas can contain objects and attributes that no longer exist in the recovered domain.

Inventory every global catalog that hosts a partial replica of the recovered domain. Select and test one of these strategies:

1. Unhost the recovered domain partition from every global catalog outside the recovered domain, forest-wide, and only then rehost it from a trusted writable domain controller in the recovered domain.
1. Detect and remove lingering objects by using a trusted writable domain controller in the recovered domain as the authoritative source.

Don't combine the strategies without a reviewed recovery design.

#### Plan unhost and rehost operations

Before rebuilding a **Global Catalog’s read-only partial replica** of another domain partition:

- Confirm that the selected source controller contains the trusted recovered domain partition.
- Inventory every global catalog that holds the partial replica.
- Preserve enough global catalog capacity for unaffected domains and applications.
- Sequence operations by site to control replication traffic.
- Estimate the time and bandwidth required to rehost the partition.
- Identify applications that depend on universal groups, address-book data, or forest-wide searches.
- Define stop conditions for replication failure, insufficient capacity, or application impact.

Run the operation in two ordered phases. Don't interleave them.

Phase 1. Unhost forest-wide:

1. Run `repadmin /unhost` on every global catalog in every domain of the forest that you didn't recover.
1. Confirm that no global catalog outside the recovered domain still holds a partial replica of the recovered domain.
1. Don't rehost anything until that confirmation is complete for the whole forest.

> [!NOTE]
> Between the two phases, no global catalog outside the recovered domain can serve that domain's partial replica. Plan sign-in continuity first. Use the built-in RID-500 Administrator credential for each domain, and apply `IgnoreGCFailures` only under the conditions and removal requirements described later in this unit.

Phase 2. Rehost by site:

1. Rehost the partition from the trusted source controller in the recovered domain.
1. Complete one controller per site first, then validate replication of the rehosted partition.
1. Rehost the remaining controllers in that site, then move to the next site.

`repadmin /unhost` and `repadmin /rehost` are expert commands. Confirm current syntax with `repadmin /experthelp` before use.

> [!WARNING]
> Don't rehost any global catalog while another global catalog still holds the stale partial replica of the recovered domain. The rehosting server can source stale objects from it and reintroduce the inconsistency this procedure exists to remove.

#### Plan lingering-object removal

When retaining the partial replica and removing lingering objects:

- Use a trusted writable controller in the recovered domain as the source of truth.
- Confirm the source naming context and directory service object identity.
- Run advisory or detection steps before removing data.
- Review every reported object and preserve evidence.
- Remove the global catalog role from the source controller when required by the approved procedure.
- Validate all affected naming contexts after cleanup.

Stop if the source controller can't be proven trustworthy or if reported objects aren't explained by the recovery-point rollback.

#### Validate multidomain consistency

Validate:

- Cross-domain group membership.
- Universal groups.
- Global catalog searches.
- Parent-child and external trusts.
- Name suffix routing.
- Address-book or directory-search applications.
- Cross-domain authorization.
- Replication load and latency.

Single-domain recovery is complete only when every global catalog contains a consistent partial replica of the recovered domain and dependent applications accept the restored identity state.

## Reset controller computer-account passwords

Restored domain controller account state can be inconsistent with the recovered directory.

Reset the computer-account password on the first recovered writable controller in each domain, and reset it twice.

**Run on:** the recovered Windows Server 2025 domain controller, in an elevated local console.

```powershell
Reset-ComputerMachinePassword
```

Run the command a second time. Computer-account password history holds two passwords, so a single reset leaves the prefailure password usable and lets prerecovery controllers continue to replicate from the recovered controller.

Preconditions:

- The controller is the sole recovered writable controller in that domain.
- Forest recovery is approved and the recovery network is isolated.
- Operations master roles have been seized and metadata cleanup is complete for that domain.

> [!WARNING]
> Perform this only on the sole recovered writable controller in each domain during forest recovery. The reset breaks replication with controllers that existed before the recovery. That outcome is intended. Don't treat it as a failure and don't retry or roll back the recovery because of it.

Validate on the recovered controller only:

- AD DS starts and the controller advertises within the isolated recovery network.
- Directory Service and Netlogon events show no unexplained errors.
- Replication converges across the approved seed topology after the recovered controllers are joined to a common isolated network.

Don't validate replication against prerecovery controllers. Those controllers must not return to the recovered forest.

## Reset `krbtgt` per domain

Every domain has its own writable `krbtgt` account. Reset it twice in each affected domain.

Sequence:

1. Confirm the domain is stable.
1. Perform the first reset.
1. Wait longer than the greater of the effective **Maximum lifetime for user ticket** and **Maximum lifetime for service ticket** values for that domain, and prove replication convergence across every intended writable controller.
1. Validate authentication and ticket issuance.
1. Perform the second reset.
1. Prove replication convergence again, then validate ticket issuance and dependent applications.

Ten hours is sufficient between resets only when both effective maximums remain at their default 10-hour values. Record the effective policy source and calculated minimum wait; don't assume that Default Domain Policy supplies the effective settings.

To reset `krbtgt`, run the following as a Domain Admin for the recovered domain:

```powershell
$domainName = 'child.contoso.com'
$seedDc = 'DC01.child.contoso.com'
$domain = Get-ADDomain `
    -Identity $domainName `
    -Server $seedDc `
    -ErrorAction Stop
$pdc = [string]$domain.PDCEmulator
$newPassword = Read-Host 'Temporary random password' -AsSecureString

Set-ADAccountPassword `
    -Identity 'krbtgt' `
    -Server $pdc `
    -Reset `
    -NewPassword $newPassword `
    -ErrorAction Stop
```

Run the complete two-reset sequence separately in every recovered domain. RODCs have separate `krbtgt_<number>` accounts; this procedure doesn't reset them. If an RODC will be recovered, don't delete its account. Address that account, cached credentials, and the RODC through the approved recovery or rebuild plan.

Don't perform the second `krbtgt` reset before convergence. Doing so can invalidate tickets and create broad authentication failure.

## Recover trusts per trust

This per-trust procedure applies to domain-scoped and forest-scoped recovery alike; the recovery scope changes which trusts are affected, not how each one is reset.

For every affected trust:

1. Record the trust type, direction, trusting or incoming side, and trusted or outgoing side, and determine which side must be reset first.
1. Generate and protect one approved high-entropy recovery secret outside the forest.
1. Before resetting a side, confirm name resolution, network connectivity, and Kerberos-tolerant time for that side and every recovery dependency currently available to it. When both sides are online, complete those checks for both before either remaining reset and before final verification. Treat a locator or name-resolution failure as missing recovery DNS, not as a trust fault.
1. Confirm the required authority before running anything: an elevated Command Prompt, and Domain Admin rights in the domain whose side you're resetting, or the explicit `/userO` and `/passwordO` credentials for it. Run `netdom experthelp trust` and verify the installed version's expert `/resetOneSide` syntax.
1. If the other side is another domain being recovered, reset the currently restored trusting side on its first controller even if the paired domain doesn't yet exist on the recovery network, after the currently restored side passes the preceding dependency checks. When the paired domain's first controller is restored, perform the equivalent DNS, connectivity, and time checks for that side and its available dependencies, then reset it with the identical secret. Complete the checks for both sides before final trust verification.
1. If the other side is an external forest or domain administered by a separate organization or team, coordinate the external-side reset and secret exchange with that administrator instead of treating it as another recovered-domain step.
1. Run each side's command exactly one *successful* time. Microsoft states that each `/resetOneSide` command resets the trust password twice internally, so a second successful run desynchronizes the paired secret. If a run fails because of syntax, elevation, credentials, locator, or time issues, record the exact error, confirm that the trust secret wasn't changed, correct the cause, and only then retry. Never rerun after a successful run.
1. After both sides are set, validate the trust and retain the output as evidence:

   ```console
   netdom trust <trusting-domain> /domain:<trusted-domain> /verify
   ```

   Verifying a specific trust requires Domain Admin rights in both domains, or explicit `/usero` and `/passwordo` credentials, from an elevated Command Prompt.
1. Validate direction, transitivity, secure-channel behavior, and application use, along with selective authentication and SID filtering where the trust type supports them.

> [!WARNING]
> Follow the exact expert command syntax and secret-handling procedure in [Reset a trust password on one side of the trust](/windows-server/identity/ad-ds/manage/forest-recovery-guide/ad-forest-recovery-reset-trust). The `/passwordT` value appears on the command line, so avoid transcripts, scripts, and ticket text that would retain it.

Track and validate each trust independently; don't describe trust recovery as one forest-wide action.

## Redeploy additional controllers

Redeploy additional controllers only after the cleanup and validation gates for the recovered domain are satisfied, and only through clean promotion or an approved supported cloning or Install from Media process.

Prefer clean promotion of replacement domain controllers. Alternatives that can accelerate recovery include:

- Virtualized domain controller cloning from a trusted recovered source.
- Install from Media created from a trusted recovered writable controller.

These methods reduce replication traffic. They aren't backups.

For every added controller:

- Use trusted media.
- Use recovered DNS.
- Validate site placement.
- Validate inbound and outbound replication.
- Validate nonauthoritative SYSVOL.
- Add global catalog role only when required.

## To address identity compromise

Create explicit decisions for:

- Built-in privileged accounts.
- Delegated privileged accounts and groups.
- Service accounts.
- Stored credentials.
- Group managed service accounts (gMSAs).
- KDS root keys.
- Certificates and private keys.
- Federation signing and decryption keys.
- Directory synchronization.
- Endpoints and domain controllers.
- Hypervisors and management systems.
- Backup servers and catalogs.
- Privileged access workstations.

### Investigate directory persistence

Forest recovery restores a selected directory state. It doesn't prove that attacker persistence has been removed.

Search the recovered directory and supporting infrastructure for:

- Unauthorized membership in Enterprise Admins, Domain Admins, Schema Admins, built-in operator groups, backup-administrator groups, and delegated administration groups.
- Modified AdminSDHolder permissions and unexpected protected-object access control.
- Unexpected `SIDHistory` values.
- Access control entries that grant replication, directory synchronization, password reset, ownership, write-all-properties, or extended rights.
- Unauthorized replication rights that permit credential replication.
- Shadow credentials stored through unexpected key-credential links.
- Rogue domain controller accounts, server objects, NTDS Settings objects, connection objects, or replication partners.
- Suspicious service principal names, unconstrained delegation, constrained delegation, and resource-based constrained delegation.
- Malicious Group Policy settings, WMI filters, startup scripts, sign-in scripts, central-store files, and scheduled tasks.
- Unauthorized DNS records, zones, delegations, policies, and name-resolution changes.
- Modified certificate templates, enrollment permissions, enterprise certification authority objects, or certificate mappings.
- Password filters, authentication packages, security support providers, services, drivers, and local scheduled tasks on domain controllers.

Preserve evidence for every unexplained change. Don't remove evidence before the incident-response owner approves collection.

### Build a credential rotation matrix

For every credential or key category, record:

- Exposure decision.
- Owning team.
- Recovery or rotation method.
- Required dependency order.
- Replication or propagation interval.
- Validation test.
- Completion evidence.

Include:

- Enterprise Admins, Domain Admins, Schema Admins, built-in operators, delegated administrators, backup administrators, and recovery administrators.
- Emergency and break-glass accounts.
- User passwords when credential exposure can't be bounded.
- Domain controller and member-computer account passwords.
- Service accounts and application credentials.
- Group managed service accounts (gMSAs) and Key Distribution Service root keys.
- Windows LAPS passwords.
- DSRM credentials.
- Trust passwords.
- Certificate private keys.
- Federation signing and decryption keys.
- Directory-synchronization connector credentials.
- Cloud credentials, API keys, secrets-vault credentials, and automation credentials.

Sequence rotations so that dependent services retain a valid authentication path. Validate replication and application behavior before invalidating the previous credential where the supported procedure permits overlap.

### Rebuild untrusted systems

Rebuild rather than restore systems whose operating system or management state can't be trusted. This decision can apply to:

- Domain controllers.
- Administrative workstations.
- Jump hosts.
- Hypervisors.
- Backup servers.
- Monitoring and endpoint-security systems.
- Network-management systems.
- Certificate, federation, and synchronization servers.

Use trusted media, verified updates, clean administration, and new credentials.

Don't reconnect clients, servers, appliances, or applications until their owners provide evidence that they can't reintroduce malware, stolen credentials, malicious configuration, or attacker persistence.

Security sign-off must identify:

- Persistence locations investigated.
- Findings remediated.
- Credentials and keys rotated.
- Systems rebuilt.
- Residual risk.
- Monitoring required after reconnection.

If the AD database was compromised, evaluate creation of a new KDS root key and recreation of gMSAs under the current Golden gMSA recovery guidance.

> [!WARNING]
> Follow the exact `KdsSvc` sequence for the selected [Golden gMSA recovery scenario](/troubleshoot/windows-server/windows-security/recover-from-golden-gmsa-attack).

## After recovery

After you complete recovery:

- Take new trusted backups.
- Validate them.
- Retire recovery media according to policy.
- Reset `Repl Perform Initial Synchronizations` to `1` on every controller where you set it to `0`.
- On every domain controller where `IgnoreGCFailures` was changed, load the shared record functions, reload the protected persisted prior-state record, and restore the prior DWORD data for `HKLM\SYSTEM\CurrentControlSet\Control\Lsa\IgnoreGCFailures`, or remove the value when the record shows it was previously absent, then restart that domain controller so the change takes effect. When the value already equals the recorded prior state, the reversal block records an already-satisfied reversal. If the record is `Pending` or an `Applied` reversal is indeterminate, an approver runs the reconciliation block; `ConfirmApplied` is available only to `Pending`, while `RestorePriorState` can complete either status as terminal `Reconciled` after verification. Coordinate this restart with the `Repl Perform Initial Synchronizations` reversal above when the same controller holds operations master roles. A readable record that the validator or its file ACL rejects, including an unrecognized schema, malformed or inconsistent data, an unknown status, or ACL drift, is never acted on, guessed at, or deleted: it goes to the approver-controlled readable-invalid disposition, which preserves the bytes and a protected sidecar and requires the prior state to come from independent approved evidence rather than from the rejected record. A record that can't be unprotected or JSON-loaded uses the separate unreadable-record quarantine on the same terms. In both cases, restore the prior state from that independent approved evidence as a separate approver-directed step and never delete the artifact. After restart, validate normal logon, universal-group evaluation, forest-wide queries, and `nltest /server:<affected-dc> /dsgetdc:<forest-root-fqdn> /gc /force`. Declare normal global catalog enforcement restored only when prior state was absent or `0`; a prior `1` reinstates a separate exception. Finally, archive a validated terminal record through the intrinsic terminal-only helper, or retain the quarantined artifact and its sidecar, before any later approved enable phase.
- Complete root-cause remediation.
- Update the runbook.

**Run on:** each Windows Server 2025 domain controller where the exception was applied, in an elevated local console.

```powershell
Set-ItemProperty `
    -Path 'HKLM:\System\CurrentControlSet\Services\NTDS\Parameters' `
    -Name 'Repl Perform Initial Synchronizations' `
    -Value 1
```

Restart the controller so AD DS reads the restored value, then confirm that the controller still advertises and that replication with the recovered topology remains healthy.
