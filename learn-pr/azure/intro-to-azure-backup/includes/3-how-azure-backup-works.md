<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: state what's in this unit and how it aligns to the 'describe' learning objective.

    Pattern:
        One paragraph of 2-3 sentences:
            Sentence 1: State that this unit addresses ("how it works").
            Sentence 2: State that this unit targets this learning objective: "Describe how <features> of <product> work to <solve problem>."
            Sentence 3-4 (optional): Give the rationale ("helps you decide if it will meet your needs").
        Table-of-contents as a bulleted list (do not simply list every heading you'll have on the page, group them into about 3 high-level areas).

    Heading: none

    Example: "Here, we'll discuss how Logic Apps works behind the scenes. You'll learn about all the pieces of Logic apps and see how they fit together into an app. This knowledge will help you decide whether Logic Apps will work for you without any customization. In cases where you do need to create custom components, you'll be able to determine how difficult it will be.
        * Connectors, triggers, actions
        * Control actions
        * Logic Apps Designer"
-->
Let's take a look at how Azure Backup works to provide the data protection you need. You'll learn how the different aspects of the backup service make it easy to backup various types of data and how it offers security for your backups as well. We'll discover these aspects of the Azure Backup Service:

* Workload integration layer - Backup Extension. Integration with the actual workload (such as Azure VM or Azure Blobs) happen at this layer.
* Data Plane- Access Tiers. Three access tiers where the backups could be stored:
    * Snapshot tier: in customer’s subscription
    * Standard tier
    * Archive tier
* Data Plane- Availability and Security. The backup data is replicated across zones or regions (based on the redundancy specified by the user).
* Management Plane – Recovery Services vault/ Backup Vault and Backup Center. Vault provides an interface for the user to interact with the backup service.

<!-- 2. Chunked content-------------------------------------------------------------------------------------

    Goal:
        Cover the components of <product> and how they work.
        Repeat this pattern multiple times as needed.

    Pattern:
        Break the content into 'chunks' where each chunk has three things:
            1. An H2 or H3 heading describing the goal of the chunk.
            2. 1-3 paragraphs of text, with a strong lead sentence in the first paragraph.
            3. Visual like an image, table, list, code sample, or blockquote.

    [Learning-unit structural guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-structure-learning-content?branch=master)
-->

<!-- Pattern for simple topic -->
## What data is backed up and how?
The simplest explanation for Azure Backup is that it backs up data, machine state, and workloads, running on on-premises machines and VM instances, to the Azure cloud.

For on-premises Windows machines, you can backup directly to Azure with the Azure Backup Microsoft Azure Recovery Services (MARS) agent. Alternatively, you can backup these Windows machines to a backup server, perhaps a System Center Data Protection Manager (DPM) or Microsoft Azure Backup Server (MABS). You can then back up that server to a Recovery Services vault in Azure.

If you are using Azure VMs, you can back up these Azure VMs directly. Azure Backup installs a backup extension to the Azure VM agent that is running on the VM, which allows backing up the entire VM. If you only want to back up the files and folders on the VM, you can do by running the MARS agent.

Azure Backup stores backed-up data in vaults - Recovery Services vaults and Backup vaults. A vault is an online-storage entity in Azure that's used to hold data, such as backup copies, recovery points, and backup policies.

### Supported backup types

Azure Backup supports full backups and incremental backups.  Your initial back will be a full backup type. The incremental backup is used by DPM/MABS for disk backups, and used in all backups to Azure. As the name suggests, incremental backups only focus on blocks of data that have changed since the previous back.

Azure Backup also supports SQL Server backup types. The following table outlines the support for SQL Server type backups.

| Type | Description | Usage |
| --- | --- | --- |
| Full | A full database backup backs up the entire database. It contains all the data in a specific database or in a set of filegroups or files. A full backup also contains enough logs to recover that data. | At most, you can trigger one full backup per day.  You can choose to make a full backup on a daily or weekly interval. |
| Differential | A differential backup is based on the most recent, previous full-data backup. It captures only the data that's changed since the full backup | At most, you can trigger one differential backup per day. You can't configure a full backup and a differential backup on the same day. |
| Transaction Log | A log backup enables point-in-time restoration up to a specific second. | At most, you can configure transactional log backups every 15 minutes. |

## Workload integration layer - Backup Extension
A backup extension, specific to each workload, is installed on the source VM or a worker VM. At the time of backup (as defined by the user in the Backup Policy), the backup extension generates the backup which could be:

* storage - snapshots in case of Azure VM or Azure Files.

* stream backup in case of databases like SQL or HANA running in VMs.

The backup data is eventually transferred to the data plane (Azure Backup managed storage) via secure Azure networks (Network Security Groups (NSG), Firewalls, or more sophisticated private end points).

Visual (image, table, list, code sample, blockquote)
Paragraph (optional)
Paragraph (optional)

## Data Plane- Access Tiers
There are three access tiers where the backups could be stored:

* Snapshot tier: in customer’s Azure subscription

* Standard tier

* Archive tier (Preview) - Customers rely on Azure Backup for storing backup data including their Long-Term Retention (LTR) backup data with retention needs being defined by the organization's compliance rules. In most cases, the older backup data is rarely accessed and is only stored for compliance needs.

    Azure Backup supports backup of long-term retention points in the archive tier

All tiers offer different recovery time objectives (RTO) and are priced differently.

Paragraph (optional)
Visual (image, table, list, code sample, blockquote)
Paragraph (optional)
Paragraph (optional)

## Data Plane- Availability and Security
The backup data is replicated across zones or regions (based on the redundancy specified by the user).  

The data is kept safe by encrypting it.

Paragraph (optional)
Visual (image, table, list, code sample, blockquote)
Paragraph (optional)
Paragraph (optional)

## Management Plane – Recovery Services vault/ Backup Vault and Backup Center
Vault provides an interface for the user to interact with the backup service.  

Azure Backup Policies within each vault define when the backups should get triggered and how long they need to be retained.

Information of jobs are aggregated across vaults and presented as Backup Center.
Paragraph (optional)
Visual (image, table, list, code sample, blockquote)
Paragraph (optional)
Paragraph (optional)

<!-- Pattern for complex topic -->
## H2 heading
Strong lead sentence; remainder of paragraph.
Visual (image, table, list, code sample, blockquote)
### H3 heading
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list, code sample, blockquote)
Paragraph (optional)
### H3 heading
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list, code sample, blockquote)
Paragraph (optional)

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->