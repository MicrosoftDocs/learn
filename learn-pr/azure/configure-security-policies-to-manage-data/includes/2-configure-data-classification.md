Digital data always exists in one of three states: at **rest**, in **process**, or in **transit**.

All three states require unique technical solutions for data classification, but the applied principles of data classification should be the same for each. Data that is classified as **confidential** needs to stay confidential in each state.

Data can also be either **structured** or **unstructured**. Typical classification processes for structured data found in databases and spreadsheets are less complex and time-consuming to manage than those for unstructured data such as documents, source code, and email. Generally, organizations have more unstructured data than structured data.

Regardless of the type of data, organizations need to manage data sensitivity. When properly implemented, data classification helps ensure that sensitive or confidential data assets are managed with greater oversight than data assets that are considered public distribution.

### Protect data at rest

Data encryption at rest is a mandatory step toward data privacy, compliance, and data sovereignty.

| Best practice| Solution |
|--------------|----------|
| Apply disk encryption to help safeguard your data.| Use [Microsoft Azure Disk Encryption](/azure/security/azure-security-disk-encryption-overview), which enables IT administrators to encrypt both Windows infrastructure as a service (IaaS) and Linux IaaS virtual machine (VM) disks. Disk encryption combines the industry-standard BitLocker feature and the Linux DM-Crypt feature to provide volume encryption for the operating system (OS) and the data disks. ‎Azure Storage and Azure SQL Database encrypt data at rest by default, and many services offer encryption as an option. You can use Azure Key Vault to maintain control of keys that access and encrypt your data. See [Azure Data Encryption at rest](/azure/security/azure-security-encryption-atrest) to learn more. |
| Use encryption to help mitigate risks related to unauthorized data access.| Encrypt your drives before you write sensitive data to them. |

Organizations that don’t enforce data encryption risk higher exposure to data-integrity issues. For example, unauthorized users or malicious hackers might steal data in compromised accounts, or gain unauthorized access to data coded in Clear Format. To comply with industry regulations, companies also must prove that they're diligent and using correct security controls to enhance their data security.

### Protect data in transit

Protecting data in transit should be an essential part of your data-protection strategy. Because data moves back and forth from many locations, we generally recommend that you always use SSL/TLS protocols to exchange data across different locations. In some circumstances, you might want to isolate the entire communication channel between your on-premises and cloud infrastructures by using a VPN.

For data moving between your on-premises infrastructure and Azure, consider appropriate safeguards, such as HTTPS or VPN. When sending encrypted traffic between an Azure virtual network and an on-premises location over the public internet, use Azure VPN Gateway.

The following table lists best practices specific to using Azure VPN Gateway, SSL/TLS, and HTTPS.

| Best practice| Solution |
|--------------|----------|
| Secure access from multiple workstations located on-premises to an Azure virtual network. | Use site-to-site VPN. |
| Secure access from an individual workstation located on-premises to an Azure virtual network. | Use point-to-site VPN. |
| Move large data sets over a dedicated high-speed wide-area network (WAN) link. | Use Azure ExpressRoute. If you choose to use ExpressRoute, you can also encrypt the data at the application level by using SSL/TLS or other protocols for added protection. |
| Interact with Azure Storage through the Azure portal. | All transactions occur via HTTPS. You can also use Storage REST API over HTTPS to interact with Azure Storage and Azure SQL Database. |

Organizations that fail to protect data in transit are more susceptible to man-in-the-middle attacks, eavesdropping, and session hijacking. These attacks can be the first step in gaining access to confidential data.

## Data discovery

Data discovery and classification (currently in preview) provides advanced capabilities built into Azure SQL Database for discovering, classifying, labeling and protecting sensitive data (such as business, personal data (customer content), and financial information) in your databases. Finding and classifying this data can play a pivotal role in your organizational information protection stature. It can serve as infrastructure for:

* Helping meet data privacy standards and regulatory compliance requirements.
* Addressing various security scenarios such as monitoring, auditing, and alerting on anomalous access to sensitive data.
* Controlling access to and hardening the security of databases containing highly sensitive data.

Data discovery and classification is part of the [Microsoft Defender for SQL](/azure/azure-sql/database/azure-defender-for-sql) offering, which is a unified package for advanced Microsoft SQL Server security capabilities. You access and manage data discovery and classification via the Azure SQL Database pane in the Azure portal.

Data discovery and classification introduces a set of advanced services and SQL capabilities, forming a SQL Information Protection paradigm aimed at protecting the data, not just the database:

* **Discovery and recommendations**: The classification engine scans your database and identifies columns containing potentially sensitive data. It then provides you with a more natural way to review and apply the appropriate classification recommendations via the Azure portal.
* **Labeling**: Sensitivity classification labels can be persistently tagged on columns using new classification metadata attributes introduced into the SQL Server Engine. You can then use this metadata for advanced sensitivity-based auditing and protection scenarios.
* **Query result set sensitivity**: The sensitivity of the query result set is calculated in real time for auditing purposes.
* **Visibility**: You can view the database classification state in a detailed dashboard in the Azure portal. Additionally, you can download a report (in Microsoft Excel format) that you can use for compliance and auditing purposes, in addition to other needs.

### Steps for discovery, classification, and labeling

Classifications have two metadata attributes:

* **Labels**:  These are the main classification attributes used to define the sensitivity level of the data stored in the column.
* **Information Types**: These provide additional granularity into the type of data stored in the column.

SQL data discovery and classification comes with a built-in set of sensitivity labels and information types and discovery logic. You can now customize this taxonomy and define a set and ranking of classification constructs specifically for your environment.

Customization of your classification taxonomy takes place in one central location for your entire Azure tenant: **Microsoft Defender for Cloud**. Only a user with administrative rights on the Azure tenant root management group can perform this task.

As part of Azure Information Protection policy management, you can define custom labels, rank them, and associate them with a selected set of information types. You can also add your own custom information types and configure them with string patterns, which are added to the discovery logic for identifying this type of data in your databases. Learn more about customizing and managing your policy with the links in the Summary of this module.

After you define the tenant-wide policy, you can continue with classifying individual databases using your customized policy. Let's examine this in more detail with Azure SQL DB.
