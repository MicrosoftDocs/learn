
Data Discovery & Classification is built into Azure SQL Database. It provides advanced capabilities for discovering, classifying, labeling, and reporting the sensitive data in your databases.

Your most sensitive data might include business, financial, healthcare, or personal information. Discovering and classifying this data can play a pivotal role in your organization's information-protection approach. It can serve as infrastructure for:

 -  Helping to meet standards for data privacy and requirements for regulatory compliance.
 -  Various security scenarios, such as monitoring (auditing) and alerting on anomalous access to sensitive data.
 -  Controlling access to and hardening the security of databases that contain highly sensitive data.

Data Discovery & Classification is part of the Advanced Data Security offering, which is a unified package for advanced SQL security capabilities. You can access and manage Data Discovery & Classification via the central **SQL Advanced Data Security** section of the Azure portal.

:::image type="content" source="../media/az500-database-class-f12d2e6e.png" alt-text="Screenshot of the Discovery and Classification page with classification choices, like Confidential, shown.":::


Classifying your data and identifying your data protection needs helps you select the right cloud solution for your organization. Data classification enables organizations to find storage optimizations that might not be possible when all data is assigned the same value. Classifying (or categorizing) stored data by sensitivity and business impact helps organizations determine the risks associated with the data. After your data has been classified, organizations can manage their data in ways that reflect their internal value instead of treating all data the same way.

Data classification can yield benefits such as compliance efficiencies, improved ways to manage the organization’s resources, and facilitation of migration to the cloud. Some data protection solutions—such as encryption, rights management, and data loss prevention—have moved to the cloud and can help mitigate cloud risks. However, organization must be sure to address data classification rules for data retention when moving to the cloud.

Data exists in one of three basic states: at **rest**, in **process**, and in **transit**. All three states require unique technical solutions for data classification, but the applied principles of data classification should be the same for each. Data that is classified as confidential needs to stay confidential when at rest, in process, or in transit.

Data can also be either **structured** or **unstructured**. Typical classification processes for structured data found in databases and spreadsheets are less complex and time-consuming to manage than those for unstructured data such as documents, source code, and email. Generally, organizations will have more unstructured data than structured data.

Regardless of whether data is structured or unstructured, it’s important for organizations to manage data sensitivity. When properly implemented, data classification helps ensure that sensitive or confidential data assets are managed with greater oversight than data assets that are considered public distribution.

### Protect data at rest

Data encryption at rest is a mandatory step toward data privacy, compliance, and data sovereignty.

| **Best practice**                                                          | **Solution**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| -------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Apply disk encryption to help safeguard your data.                         | Use Microsoft Azure Disk Encryption, which enables IT administrators to encrypt both Windows infrastructure as a service (IaaS) and Linux IaaS virtual machine (VM) disks. Disk encryption combines the industry-standard BitLocker feature and the Linux DM-Crypt feature to provide volume encryption for the operating system (OS) and the data disks. ‎Azure Storage and Azure SQL Database encrypt data at rest by default, and many services offer encryption as an option. You can use Azure Key Vault to maintain control of keys that access and encrypt your data. |
| Use encryption to help mitigate risks related to unauthorized data access. | Encrypt your drives before you write sensitive data to them.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |

Organizations that don’t enforce data encryption are risk greater exposure to data-integrity issues. For example, unauthorized users or malicious hackers might steal data in compromised accounts or gain unauthorized access to data coded in Clear Format. To comply with industry regulations, companies also must prove that they are diligent and using correct security controls to enhance their data security.

### Protect data in transit

Protecting data in transit should be an essential part of your data protection strategy. Because data is moving back and forth from many locations, we generally recommend that you always use SSL/TLS protocols to exchange data across different locations. In some circumstances, you might want to isolate the entire communication channel between your on-premises and cloud infrastructures by using a VPN.

For data moving between your on-premises infrastructure and Azure, consider appropriate safeguards such as HTTPS or VPN. When sending encrypted traffic between an Azure virtual network and an on-premises location over the public internet, use Azure VPN Gateway.

The following table lists best practices specific to using Azure VPN Gateway, SSL/TLS, and HTTPS.

| **Best practice**                                                                            | **Solution**                                                                                                                                                                |
| -------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Secure access from multiple workstations located on-premises to an Azure virtual network     | Use site-to-site VPN.                                                                                                                                                       |
| Secure access from an individual workstation located on-premises to an Azure virtual network | Use point-to-site VPN.                                                                                                                                                      |
| Move larger data sets over a dedicated high-speed wide area network (WAN) link               | Use Azure ExpressRoute. If you choose to use ExpressRoute, you can also encrypt the data at the application level by using SSL/TLS or other protocols for added protection. |
| Interact with Azure Storage through the Azure portal                                         | All transactions occur via HTTPS. You can also use Storage REST API over HTTPS to interact with Azure Storage and Azure SQL Database.                                       |

Organizations that fail to protect data in transit are more susceptible to man-in-the-middle attacks, eavesdropping, and session hijacking. These attacks can be the first step in gaining access to confidential data.

Now that we’ve covered the physical aspects of data classification, let’s look at the classification based on discovery and classification.

### Data Discovery

Data discovery and classification provides advanced capabilities built into Azure SQL Database for discovering, classifying, labeling and protecting sensitive data (such as business, personal data, and financial information) in your databases. Discovering and classifying this data can play a pivotal role in your organizational information protection stature. It can serve as infrastructure for:

 -  Helping meet data privacy standards and regulatory compliance requirements.
 -  Addressing various security scenarios such as monitoring, auditing, and alerting on anomalous access to sensitive data.
 -  Controlling access to and hardening the security of databases containing highly sensitive data.

Data discovery and classification is part of the Advanced Data Security offering, which is a unified package for advanced Microsoft SQL Server security capabilities. You access and manage data discovery and classification via the central SQL Advanced Data Security portal.

Data discovery and classification introduces a set of advanced services and SQL capabilities, forming a SQL Information Protection paradigm aimed at protecting the data, not just the database:

 -  **Discovery and recommendations** \- The classification engine scans your database and identifies columns containing potentially sensitive data. It then provides you with an easier way to review and apply the appropriate classification recommendations via the Azure portal.
 -  **Labeling** \- Sensitivity classification labels can be persistently tagged on columns using new classification metadata attributes introduced into the SQL Server Engine. This metadata can then be utilized for advanced sensitivity-based auditing and protection scenarios.
 -  **Query result set sensitivity** \- The sensitivity of the query result set is calculated in real time for auditing purposes.
 -  **Visibility** \- You can view the database classification state in a detailed dashboard in the Azure portal. Additionally, you can download a report (in Microsoft Excel format) that you can use for compliance and auditing purposes, in addition to other needs.

### Steps for discovery, classification, and labeling

Classifications have two metadata attributes:

 -  **Labels** \- These are the main classification attributes used to define the sensitivity level of the data stored in the column.
 -  **Information Types** \- These provide additional granularity into the type of data stored in the column.

SQL data discovery and classification comes with a built-in set of sensitivity labels and information types, and discovery logic. You can now customize this taxonomy and define a set and ranking of classification constructs specifically for your environment.

Definition and customization of your classification taxonomy takes place in one central location for your entire Azure Tenant. That location is in Microsoft Defender for Cloud, as part of your Security Policy. Only a user with administrative rights on the Tenant root management group can perform this task.

As part of Azure Information Protection policy management, you can define custom labels, rank them, and associate them with a selected set of information types. You can also add your own custom information types and configure them with string patterns, which are added to the discovery logic for identifying this type of data in your databases. Learn more about customizing and managing your policy in the Information Protection policy how-to guide.

After you’ve defined the tenant-wide policy, you can continue with classifying individual databases using your customized policy.
