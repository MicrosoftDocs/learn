When you need data governance features beyond those built into Microsoft Fabric, Microsoft Purview provides comprehensive data governance capabilities.

In the last unit, we reviewed the built-in governance features of Microsoft Fabric. Let's assume you work for a health care provider and new regulations mean you need stricter governance for data stored in Microsoft Fabric. Now, you want to investigate what features Microsoft Purview includes that can help you comply with new regulations.

In this unit, you'll learn what capabilities Microsoft Purview adds to the built-in data governance and compliance capabilities available in Microsoft Fabric.

## What is Microsoft Purview?

Microsoft Purview is a set of solutions that you can use to govern, protect, and manage data wherever it resides. It has three pillars: data governance, data security, and risk and compliance. Purview includes data governance tools for data discovery, classification, and cataloging and can be used to gain a clear understanding of your data landscape. Purview automates the identification of sensitive information and provides a centralized repository for metadata. Use it to find, manage, and govern data across various environments, both on-premises and in the cloud.

Purview also supports data security and risk and compliance management with features that monitor regulatory adherence and assess data vulnerabilities. It integrates with other Microsoft services and third-party tools. By streamlining data access controls, enforcing policies, and delivering insights into data lineage, Purview can help you maintain data integrity, comply with regulations, and use data effectively for strategic decision-making.

The Purview solutions can be accessed via the Microsoft Purview Portal.

![A diagram showing Microsoft Purview pillars.](../media/purview-areas.png)

## What are some of the Purview tools?

Microsoft Purview enables you to discover, manage, and protect Fabric data using Purview tools. Purview can be configured to scan your Fabric item and present data governance findings in the Purview Hub located in Fabric or in Purview itself. To unlock the following capabilities, register your Fabric tenant in Microsoft Purview. 

### Microsoft Purview Data Map
Data Map can be used to scan all of your data assets, to capture metadata about them and to identify sensitive data. It captures metadata about data in existing analytics, software-as-a-service, and operational systems in hybrid, on-premise, and multicloud environments. There's a built-in scanning and classification system that keeps the Data Map updated.

### Microsoft Purview Unified Catalog

The Purview Unified Catalog is a searchable catalog of your scanned data where you curate, grant access to and, improve the health of your data.  

In the Purview Unified Catalog, you can inventory of all your data assets, their metadata, and their lineage so you can understand the topography of your data estate. You can search for and browse datasets, and view metadata, data lineage, classification, and sensitivity labels. The Unified Catalog promotes collaboration because users can annotate datasets with tags to improve discoverability.

Suppose you work at a health care provider and regulations require you to control who can access patient records. In the Unified Catalog, users and administrators can:

- Discover where patient records are held by searching for keywords.
- Label documents and items as patient records to differentiate them from other, less sensitive information.
- Use access policies to manage self-service access requests to patient records.

### Microsoft Purview Information Protection

Information Protection is used to classify, label, and protect sensitive data throughout your organization. By applying customizable sensitivity labels, you can classify records. Then policies can define access controls and enforce encryption. These labels follow the data wherever it goes, whether in emails, documents, or cloud storage, and integrate with other tools like Data Loss Prevention (DLP) to prevent unauthorized sharing. This helps organizations meet compliance requirements while safeguarding data against accidental exposure or malicious threats.

If, for example, you worked as a data steward at a health care provider, you could use Information Protection to:

- Identify data items that contain patient information, even when item titles don't identify them as patient records.
- Train classifiers to spot patient records automatically.
- Protect records with policies to encrypt data and impose Information Rights Management (IRM).

### Microsoft Purview Data Loss Prevention (DLP)

DLP helps protect sensitive information with policies that automatically detect, monitor, and control the sharing or movement of sensitive data. Administrators can customize rules to block, restrict, or alert when sensitive data is transferred to prevent accidental or malicious data leaks.

If you worked at a health care provider, you would need to ensure that users don't share patient records with external parties, either accidentally or maliciously. DLP can prevent such transfers on information labeled as patient records.

### Microsoft Purview Audit

Auditing solutions in Purview are used to search for activities performed in Microsoft services by users and admins. User activities such as creating files or accessing Fabric items are automatically logged and appear in the Purview audit log.

Thorough auditing is an important protection for the policies you apply to patient records. For example, if a malicious administrator changes DLP policies so that they can copy a patient record to a USB device, this change is recorded and can be identified during later investigations.

## Learn more

- [Use Microsoft Purview to govern Microsoft Fabric](/fabric/governance/microsoft-purview-fabric)
- [Learn about Microsoft Purview](/purview/purview)
