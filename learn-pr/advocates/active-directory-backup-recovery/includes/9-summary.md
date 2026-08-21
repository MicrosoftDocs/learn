In this module, you learned about how to backup and restore Active Directory environment. You learned to:

- Design backup coverage from RTO, RPO, topology, and trust boundaries.
- Validate last-known-safe backups through health, replication, incident, compatibility, catalog, key, and restore-test evidence.
- Select object, controller, domain, or forest recovery by incident scope.
- Separate AD DS database authority from SYSVOL authority.
- Recover the first writable controller in each forest-recovery domain with authoritative SYSVOL.
- Recover operations master roles, RID state, trusts, DNS, and global catalog capacity at the correct domain or forest scope.
- Reset the writable `krbtgt` account twice in each recovered domain, waiting longer than that domain's effective maximum Kerberos ticket lifetime and proving replication convergence before the second reset; handle RODC `krbtgt_<number>` accounts separately.
- Evaluate VM-Generation ID safeguards without treating snapshots as the only backup.
- Require replication, DNS, SYSVOL, time, authentication, security, trust, application, and business gates before reconnection.

## Learn more

- [Back up the system state data](/windows-server/identity/ad-ds/manage/forest-recovery-guide/ad-forest-recovery-backing-up-system-state)
- [Windows Server Backup command reference](/windows-server/administration/windows-commands/windows-server-backup-command-reference)
- [Determine how to recover the forest](/windows-server/identity/ad-ds/manage/forest-recovery-guide/ad-forest-recovery-determine-how-to-recover)
- [Enable and use Active Directory Recycle Bin](/windows-server/identity/ad-ds/get-started/adac/active-directory-recycle-bin)
- [Restore-ADObject](/powershell/module/activedirectory/restore-adobject)
- [Perform a nonauthoritative restore of Active Directory Domain Services](/windows-server/identity/ad-ds/manage/forest-recovery-guide/ad-forest-recovery-perform-nonauthoritative-restore)
- [Perform an authoritative synchronization of Distributed File System Replication replicated SYSVOL](/windows-server/identity/ad-ds/manage/forest-recovery-guide/ad-forest-recovery-authoritative-recovery-sysvol)
- [Force authoritative or nonauthoritative Distributed File System Replication SYSVOL synchronization](/troubleshoot/windows-server/group-policy/force-authoritative-non-authoritative-synchronization)
- [Perform a full server recovery](/windows-server/identity/ad-ds/manage/forest-recovery-guide/ad-forest-recovery-perform-full-server-recovery)
- [Restore-DnsServerPrimaryZone](/powershell/module/dnsserver/restore-dnsserverprimaryzone)
- [Recover a single domain within a multidomain forest](/windows-server/identity/ad-ds/manage/forest-recovery-guide/ad-forest-recovery-recover-single-domain-multidomain-forest)
- [Active Directory forest recovery procedures](/windows-server/identity/ad-ds/manage/forest-recovery-guide/ad-forest-recovery-procedures)
- [Perform the initial forest recovery](/windows-server/identity/ad-ds/manage/forest-recovery-guide/ad-forest-recovery-perform-initial-recovery)
- [Redeploy remaining domain controllers](/windows-server/identity/ad-ds/manage/forest-recovery-guide/ad-forest-recovery-restore-additional-dcs)
- [Seize an operations master role](/windows-server/identity/ad-ds/manage/forest-recovery-guide/ad-forest-recovery-seizing-operations-master-role)
- [Invalidate the current relative identifier pool](/windows-server/identity/ad-ds/manage/forest-recovery-guide/ad-forest-recovery-invaildate-rid-pool)
- [Raise the available relative identifier pool](/windows-server/identity/ad-ds/manage/forest-recovery-guide/ad-forest-recovery-raise-rid-pool)
- [Reset the krbtgt password](/windows-server/identity/ad-ds/manage/forest-recovery-guide/ad-forest-recovery-reset-the-krbtgt-password)
- [Reset a trust password](/windows-server/identity/ad-ds/manage/forest-recovery-guide/ad-forest-recovery-reset-trust)
- [Virtualized Domain Controller Architecture](/windows-server/identity/ad-ds/get-started/virtual-dc/virtualized-domain-controller-architecture)
- [Recover from a Golden group Managed Service Account attack](/troubleshoot/windows-server/windows-security/recover-from-golden-gmsa-attack)
