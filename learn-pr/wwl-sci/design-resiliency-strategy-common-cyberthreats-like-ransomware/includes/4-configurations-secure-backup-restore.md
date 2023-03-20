To help you protect your backup data and meet the security needs of your business, Azure Backup provides confidentiality, integrity, and availability assurances against deliberate attacks and abuse of your valuable data and systems. Consider the following security guidelines for your Azure Backup solution:

### Authentication and authorization using Azure role-based access control (Azure RBAC)

- Azure role-based access control (Azure RBAC) enables fine-grained access management, segregation of  duties within your team and granting only the amount of access to users necessary to perform their jobs.

- If you’ve multiple workloads to back up (such as Azure VMs, SQL databases, and PostgreSQL databases) and you've multiple stakeholders to manage those backups, it is important to segregate their responsibilities so that user has access to only those resources they’re responsible for. Azure role-based access control (Azure RBAC) enables granular access management, segregation of duties within your team, and granting only the types of access to users necessary to perform their jobs.

- You can also segregate the duties by providing minimum required access to perform a particular task. For example, a person responsible for monitoring the workloads shouldn't have access to modify the backup policy or delete the backup items. Azure Backup provides three built-in roles to control backup management operations: Backup contributors, operators, and readers. Learn more here..

- Azure role-based access control (Azure RBAC) also provides the flexibility to build Custom Roles based on your individual requirements. If you’re unsure about the types of roles recommended for specific operation, you can utilize the built-in roles provided by Azure role-based access control (Azure RBAC) and get started.

  The following diagram explains about how different Azure built-in roles work:

    ![Diagram explains about how different Azure built-in roles work.](https://learn.microsoft.com/azure/backup/media/guidance-best-practices/different-azure-built-in-roles-actions.png)

  - In the above diagram, _User2_ and _User3_ are Backup Readers. Therefore, they have the permission to only monitor the backups and view the backup services.

  - In terms of the scope of the access,

    - _User2_ can access only the Resources of Subscription1, and User3 can access only the Resources of Subscription2. 
    - _User4_ is a Backup Operator. It has the permission to enable backup, trigger on-demand backup, trigger restores, along with the capabilities of a Backup Reader. However, in this scenario, its scope is limited only to Subscription2. 
    - _User1_ is a Backup Contributor. It has the permission to create vaults, create/modify/delete backup policies, and stop backups, along with the capabilities of a Backup Operator. However, in this scenario, its scope is limited only to _Subscription1_.

- Storage accounts used by Recovery Services vaults are isolated and can't be accessed by users for any malicious purposes. The access is only allowed through Azure Backup management operations, such as restore.

### Encryption of data in transit and at rest

Encryption protects your data and helps you to meet your organizational security and compliance commitments.

* Within Azure, data in transit between Azure storage and the vault is protected by HTTPS. This data remains within the Azure network.

* Backup data is automatically encrypted using Microsoft-managed keys. Alternatively, you can use your own keys, also known as customer managed keys. Also, using CMK encryption for backup doesn't incur additional costs. However, the use of Azure Key Vault, where your key is stored, incur costs, which are a reasonable expense in return for the higher data security.

* Azure Backup supports backup and restore of Azure VMs that have their OS/data disks encrypted with Azure Disk Encryption (ADE).

### Protection of backup data from unintentional deletes  with soft-delete

You may encounter scenarios where you’ve mission-critical backup data in a vault, and it gets deleted accidentally or erroneously. Also,  a malicious actor may delete your production backup items. It’s often costly and time-intensive to rebuild those resources and can even cause crucial data loss. Azure Backup provides safeguard against accidental and malicious deletion with the Soft-Delete feature by allowing you to recover those resources after they are deleted.

With soft-delete, if a user deletes the backup (of a VM, SQL Server database, Azure file share, SAP HANA database), the backup data is retained for 14 additional days, allowing the recovery of that backup item with no data loss. The additional 14 days retention of backup data in the soft delete state doesn't incur any cost.

### Multi-User Authorization (MUA)

**How would you protect your data if your administrator goes rogue and compromises your system?**

Any administrator that has the privileged access to your backup data has the potential to cause irreparable damage to the system. A rogue admin can delete all your business-critical data or even turn off all the security measures that may leave your system vulnerable to cyber-attacks.

Azure Backup provides you with the Multi-User Authorization (MUA) feature to protect you from such rogue administrator attacks. Multi-user authorization helps protect against a rogue administrator performing destructive operations (that is, disabling soft-delete), by ensuring that every privileged/destructive operation is done only after getting approval from a security administrator. 

### Ransomware Protection

- Direct access to Azure Backup data to encrypt by malicious actor is ruled out, as all operations on backup data can only be performed through Recovery-Services vault or Backup Vault, which can be secured by Azure role-based access control (Azure RBAC) and MUA.

- By enabling soft-delete on backup data (which is enabled by default) will hold deleted data for 14 days (at free of cost). Disabling soft-delete can be protected using MUA. 

- Use longer retention (weeks, months, years) to ensure clean backups (not encrypted by ransomware) don’t expire prematurely, and there’re strategies in place for early detection and mitigation of such attacks on source data.

### Monitoring and alerts of suspicious activity

You may encounter scenarios where someone tries to breach into your system and maliciously turn off the security mechanisms, such as disabling Soft Delete or attempts to perform destructive operations, such as deleting the backup resources. 

Azure Backup provides security against such incidents by sending you critical alerts over your preferred notification channel (email, ITSM, Webhook, runbook) by creating an Action Rule on top of the alert.

## Hybrid environments

Azure Backup service uses the Microsoft Azure Recovery Services (MARS) agent to back up and restore files, folders, and the volume or system state from an on-premises computer to Azure. MARS now provides security features: a passphrase to encrypt before upload and decrypt after download from Azure Backup, deleted backup data is retained for an additional 14 days from the date of deletion, and critical operation (ex. changing a passphrase) can be performed only by users who have valid Azure credentials.

<!--
END: Source - /azure/backup/guidance-best-practices
-->
<!--
START: Source - /azure/backup/backup-azure-security-feature
-->
Concerns about security issues, like malware, ransomware, and intrusion, are increasing. These security issues can be costly, in terms of both money and data. To guard against such attacks, Azure Backup now provides security features to help protect hybrid backups. You can enable and leverage these features to protect on-premises workloads using **Microsoft Azure Backup Server (MABS)**, **Data Protection Manager (DPM)**, and **Microsoft Azure Recovery Services (MARS) agent**. These features include:

-   **Prevention**. An additional layer of authentication is added whenever a critical operation like changing a passphrase is performed. This validation is to ensure that such operations can be performed only by users who have valid Azure credentials.
-   **Alerting**. An email notification is sent to the subscription admin whenever a critical operation like deleting backup data is performed. This email ensures that the user is notified quickly about such actions.
-   **Recovery**. Deleted backup data is retained for an additional 14 days from the date of the deletion. This ensures recoverability of the data within a given time period, so there's no data loss even if an attack happens. Also, a greater number of minimum recovery points are maintained to guard against corrupt data.