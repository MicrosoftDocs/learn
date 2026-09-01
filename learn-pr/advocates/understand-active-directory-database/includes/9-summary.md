In this module, you learned about the Active Directory database and SYSVOL. Specifically you learned:

- AD DS presents the logical directory and stores its hosted replicas in a local ESE database.
- SYSVOL is a domain-scoped file hierarchy replicated by DFSR.
- The stores use different client protocols, replication engines, evidence sources, and recovery procedures.
- DFSR configuration is stored in AD DS, so the engines are separate but not independent of directory configuration.
- `NTDS.dit` contains only the replicas hosted by one domain controller.
- ESE commits directory writes through write-ahead transaction logging.
- A dirty shutdown starts supported soft recovery and doesn't, by itself, prove corruption.
- Online maintenance reclaims internal space but doesn't normally shrink `NTDS.dit`.
- Writable domain controllers originate ordinary directory changes; read-only domain controllers normally receive them.
- Healthy AD DS replication doesn't prove healthy SYSVOL replication, and the reverse is also true.
- A GPO spans a GPC in AD DS and a GPT in SYSVOL.
- GPC and GPT versions can temporarily diverge because their changes follow separate replication paths.
- System-state backup protects AD DS and SYSVOL as coordinated system-state components.
- The Windows Server 2025 Database 32k pages optional feature is a forest-wide, irreversible backup and recovery decision.

## Continue learning

- [Troubleshoot Active Directory Domain Services replication](/training/modules/troubleshoot-active-directory-replication/)
- [Distributed File System Replication overview](/windows-server/storage/dfs-replication/dfs-replication-overview)
- [Group Policy overview for Windows Server](/windows-server/identity/ad-ds/manage/group-policy/group-policy-overview)
- [Back up and restore an Active Directory server](/windows/win32/ad/backing-up-and-restoring-an-active-directory-server)
- [Active Directory forest recovery procedures](/windows-server/identity/ad-ds/manage/forest-recovery-guide/ad-forest-recovery-procedures)
- [Windows Server Inside Out (Microsoft Press)](https://aka.ms/WSInsideOut)
