Protection and recovery preserve the relationship between the directory database, SYSVOL, the operating system, and the domain controller's identity.

## Use application-consistent system-state backup

Ensure that your backup tools can create an application-consistent system-state backup. An AD-compatible, application-consistent domain-controller system-state backup protects coordinated components, including:

- AD DS.
- SYSVOL.
- The registry.
- Boot and protected system files.
- Other installed system-state components.

The backup application must use supported Windows backup interfaces while AD DS is installed. You perform restoration of AD DS offline, commonly by starting the domain controller in Directory Services Restore Mode (DSRM).

System-state backups can contain credential material, trust secrets, private keys, and security policy. Apply:

- Encryption at rest and in transit.
- Access limited to designated recovery operators.
- Separate administrative credentials.
- Monitoring and immutable retention where supported.
- Regular restore tests in an isolated environment.
- DSRM password management and auditing.

You can't use the following items as substitutes for application-consistent system-state backups:

- A copy of `NTDS.dit`.
- A copy of the ESE logs.
- A copy of the SYSVOL folder.
- A generic disk image taken without application consistency.
- An uncoordinated virtual machine checkpoint.

This is because raw copies of these files don't establish a transactionally consistent set or a supported domain-controller restore state.

## Distinguish recovery authority

The word *authoritative* applies to different systems:

| Operation | Meaning |
| --- | --- |
| Nonauthoritative AD DS restore | Restore a domain controller, then let newer directory changes replicate from partners |
| Authoritative AD DS object restore | Reassert selected directory objects so the restored state replicates outward |
| Nonauthoritative SYSVOL synchronization | Rebuild a SYSVOL replica from an upstream member |
| Authoritative SYSVOL synchronization | Designate one SYSVOL copy as the source for the replication group |

## Understand virtual machine Generation ID

Generation ID allows you to use snapshots with virtualized domain controllers without worrying that recovering from a snapshot will adversely impact database and SYSVOL replication. Generation-aware hypervisors expose a virtual machine Generation ID to supported domain controllers. When AD DS detects an unexpected change, it can assign a new invocation ID and discard its current relative identifier pool before resuming normal operation.

This safeguard reduces update sequence number rollback risk. Generation ID doesn't make a virtual machine checkpoint an application consistent system-state backup. This is because:

- Changes originated after the restored point can be lost.
- Application-consistent backup and restore remain required.
- The virtualization host and virtual disk remain high-value security boundaries.
- Unsupported copying or attachment of an old virtual disk can bypass expected safeguards.

## Plan for Windows Server 2025 database pages

Windows Server 2025 introduces the **Database 32k pages optional feature** for AD DS.

The larger page format improves directory scalability, including larger database capacity and multi-valued attributes that can hold approximately 3,200 values.

Behavior depends on deployment history:

| Domain controller state | Database behavior |
| --- | --- |
| New Windows Server 2025 installation or newly promoted replica | Uses a 32-kilobyte-capable database in 8-kilobyte simulation mode until the forest-wide optional feature is enabled |
| In-place upgrade to Windows Server 2025 | Retains the existing 8-kilobyte database format |
| Forest after optional-feature enablement | Uses 32-kilobyte pages and can't return to 8-kilobyte simulation mode |

Before enablement:

- The forest and every domain must operate without replication errors.
- Every domain controller must run Windows Server 2025 or later and have a 32-kilobyte-capable database.
- Domain and forest functional levels must be Windows Server 2025 or later.
- Global catalog and operations-master role holders must have verified backups.
- Backup software must be tested with the 32-kilobyte format.

Enablement is irreversible. After enablement, 8-kilobyte backup media can't restore a Windows Server 2025 domain controller except as part of a complete authoritative forest-recovery strategy. The larger page size can also increase memory use.

> [!WARNING]
> Treat the optional feature as a forest-wide backup and recovery decision, not a per-server performance setting.

For current guidance, see:

- [Database 32k pages for Active Directory on Windows Server](/windows-server/identity/ad-ds/32k-pages-optional-feature)
- [Virtualizing domain controllers with Hyper-V](/windows-server/identity/ad-ds/get-started/virtual-dc/virtualized-domain-controllers-hyper-v)
- [Back up and restore an Active Directory server](/windows/win32/ad/backing-up-and-restoring-an-active-directory-server)
- [Active Directory forest recovery procedures](/windows-server/identity/ad-ds/manage/forest-recovery-guide/ad-forest-recovery-procedures)
