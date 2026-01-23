
Microsoft best practices for ransomware protection are based on a three step approach:

1. Prepare your recovery plan
2. Limit the scope of the damage
3. Make it hard to get in

## Phase 1. Prepare your recovery plan

This phase is designed to minimize the monetary incentive from ransomware attackers by making it:

- Harder to access and disrupt systems or encrypt or damage key organization data.
- Easier for your organization to recover from an attack without paying the ransom.

>[!Note]
>While restoring many or all enterprise systems is a difficult endeavor, the alternative is paying an attacker for a recovery key they may or may not deliver, and using tools written by the attackers to try to recover systems and data. Don't fall into that trap.
>

## Phase 2. Limit the scope of damage

Make the attackers work a lot harder to gain access to multiple business critical systems through privileged access roles. Limiting the attacker’s ability to get privileged access makes it much harder to profit off of an attack on your organization, making it more likely they'll give up and go elsewhere.
Privileged access protection is critical because attackers need elevated permissions to:
- Move laterally across your environment
- Access and encrypt critical business systems
- Disable security controls and backup systems
- Cause widespread organizational damage

Key strategies to limit scope include:

- **Secure privileged accounts** with strong multifactor authentication (MFA), passwordless authentication, and risk-based conditional access policies
- **Implement Just-In-Time (JIT) and Just-Enough-Access (JEA)** using Microsoft Entra Privileged Identity Management (PIM) to provide time-limited, approval-based access to critical resources
- **Use Privileged Access Workstations (PAWs)** for administrative tasks to isolate privileged activities from standard user activities
- **Segment administrative networks** to prevent lateral movement from compromised user systems to privileged infrastructure
- **Monitor privileged access** continuously with enhanced logging, alerting, and anomaly detection
- **Protect intermediary systems** such as jump servers, domain controllers, and identity infrastructure with extra security controls
## Phase 3. Make it hard to get in

This last set of tasks is important to raise friction for entry but will take time to complete as part of a larger security journey. The goal of this phase is to make the attackers' work *much* harder as they try to obtain access to your on-premises or cloud infrastructures at the various common points of entry. There are many tasks, so it’s important to prioritize your work here based on how fast you can accomplish them with your current resources.

While many of these will be familiar and easy to quickly accomplish, it’s critically important that ***your work on phase 3 should not slow down your progress on phases 1 and 2!***

<!-- END Source: (/security/compass/protect-against-ransomware)
-->
## Backup and Restore plan with Azure Backup
<!-- START Source: (/azure/security/fundamentals/backup-plan-to-protect-against-ransomware)
-->
### Azure Backup

Azure Backup provides security to your backup environment, both when your data is in transit and at rest. With Azure Backup, you can back up:

- On-premises files, folders, and system state
- Entire Windows/Linux VMs
- Azure Managed Disks
- Azure file shares to a storage account
- SQL Server databases running on Azure VMs
- SAP HANA databases running on Azure VMs

The backup data is stored in Azure storage and the guest or attacker has no direct access to backup storage or its contents. With virtual machine backup, the backup snapshot creation and storage is done by Azure fabric where the guest or attacker has no involvement other than quiescing the workload for application consistent backups. With SQL and SAP HANA, the backup extension gets temporary access to write to specific blobs. In this way, even in a compromised environment, existing backups can't be tampered with or deleted by the attacker.

Azure Backup provides multiple layers of ransomware protection:

- **Immutable vaults**: Enable immutable vaults to prevent deletion or modification of backup data for a specified retention period. Once immutability is enabled, it can't be disabled, providing strong protection against malicious deletion.
- **Multi-User Authorization (MUA)**: Require multiple users to approve critical operations like disabling soft delete or modifying backup policies, preventing a single compromised admin account from sabotaging backups.
- **Soft delete**: Deleted backup data is retained for 14 additional days, allowing recovery even if backups are deleted by an attacker or accidentally.
- **Security PIN**: Require a security PIN for critical operations to add an extra authentication layer.
- **Encryption**: All backup data is encrypted at rest using Azure Storage encryption and in transit using HTTPS/TLS.

Azure Backup provides built-in monitoring and alerting capabilities to view and configure actions for events related to Azure Backup. Backup Reports serve as a one-stop destination for tracking usage, auditing of backups and restores, and identifying key trends at different levels of granularity. Using Azure Backup's monitoring and reporting tools can alert you to any unauthorized, suspicious, or malicious activity as soon as they occur.

AI-powered capabilities enhance backup protection:
- **Anomaly detection** uses machine learning to identify unusual backup patterns that may indicate a ransomware attack in progress
- **Intelligent alerting** reduces false positives by learning normal backup behavior and flagging genuine threats
- **Predictive analytics** can forecast potential backup failures or capacity issues before they impact recovery capabilities

Checks have been added to make sure only valid users can perform various operations. These include adding an extra layer of authentication. As part of adding an extra layer of authentication for critical operations, you're prompted to enter a security PIN before modifying online backups.

### What to do before an attack

As mentioned earlier, you should assume that at some point in time you'll fall victim to a ransomware attack. Identifying your business-critical systems and applying best practices before an attack will get you back up and running as quickly as possible. 

### What to do during an attack

If you're attacked, your prioritized backup list becomes your prioritized restore list. Before you restore, validate again that your backup is good. You may be able to look for malware inside the backup.

### Post attack or simulation

After a ransomware attack or an incident response simulation, take the following steps to improve your backup and restore plans as well as your security posture:

1. Identify lessons learned where the process didn't work well (and opportunities to simplify, accelerate, or otherwise improve the process)
2. Perform root cause analysis on the biggest challenges. Ensure there's enough detail for solutions to address the right problems considering people, process, and technology.
3. Investigate and remediate the original breach (engage the [Microsoft Detection and Response Team (DART)](https://www.microsoft.com/security/blog/2019/03/25/dart-the-microsoft-cybersecurity-team-we-hope-you-never-meet/) to help)
4. Update your backup and restore strategy based on lessons learned and opportunities. Prioritize based on highest impact and quickest implementation steps first.
<!-- END Source: (/azure/security/fundamentals/backup-plan-to-protect-against-ransomware)
-->