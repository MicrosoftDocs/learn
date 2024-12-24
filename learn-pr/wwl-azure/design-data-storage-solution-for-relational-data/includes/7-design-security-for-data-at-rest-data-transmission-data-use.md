Many organizations use Azure SQL Database for large customer databases that store phone numbers, addresses, orders, and credit card information.
They need a security solution to prevent unauthorized data access to their cloud hosted databases. Classifying stored data by sensitivity and business scenario helps organizations determine the risks associated with their data.

There are three basic tenets of good information security: data discovery, classification, and protection. In this unit, we review different data states and encryption methods to apply these tenets in a strong security solution. 

## Data encryption for structured data

Data exists in three basic states: data at rest, data in motion, and data in process. 

- **Data at rest** is data on a storage device that isn't being moved or used. Data at rest includes archived email messages stored in your Outlook inbox, or files on your laptop that you aren't using.

- **Data in motion** (also called _data in transit_) is data that's being moved from one device to another within a private network or public network like the internet. data in motion can also be data that's being read (used) but not changed. Data in motion includes email messages in transit, browsing internet websites, or using company applications like an organization chart.

- **Data in process** is data that's open and being changed. Data in process includes writing an email message, saving your work files, or ordering from a website.

There are different encryption methods for each of data state. The following table summarizes the methods. 

| Data state | Encryption method | Encryption level |
| --- | --- |
| **Data&nbsp;at&nbsp;rest** | Transparent data encryption (TDE) | Always encrypted. |
| **Data&nbsp;in&nbsp;motion** | Secure Socket Layers and Transport Layer Security (SSL/TLS) | Always encrypted. |
| **Data&nbsp;in&nbsp;process** | Dynamic data masking | Specific data is unencrypted. Remaining data is encrypted. |

Large organizations, governments, and military entities use data classification to manage their data's integrity. The data classification process yields common metadata attributes that enable us to label data as _Public_, _Confidential_, or _Restricted_. After data is classified, you can implement data protection measures for highly classified data.

> [!NOTE]
> You might be familiar with another state called **Defense in depth**. This state is a cybersecurity strategy that employs a layered approach to slow the advance of an attack aimed at acquiring unauthorized access to information. To learn more, watch the video, [Defense in depth security in Azure](/shows/azure-videos/defense-in-depth-security-in-azure).

### Things to know about data at rest and TDE

Data encryption at rest is a mandatory step toward data privacy, compliance, and data sovereignty. Encryption helps mitigate risks related to unauthorized data access. Data at rest needs to be protected from unauthorized or offline access to raw files or backups to an unsecured server. Data at rest needs to be protected by preventing copying of the database and transaction log files to an unsecured server.

Transparent data encryption (TDE) protects Azure SQL Database, Azure SQL Managed Instance, and Azure Synapse Analytics against the threat of malicious offline activity by encrypting data at rest. TDE performs real-time encryption and decryption of the database, associated backups, and transaction log files at rest without requiring changes to the application. TDE is enabled by default to all newly deployed Azure SQL Databases. For Azure SQL Managed Instance, databases created after February 2019 have TDE enabled.

### Things to consider when protecting data at rest

Let's review how TDE is implemented for data at rest. Consider how data at rest can be protected in the security solution for Tailwind Traders.

- TDE performs encryption and decryption of the data at the page level.

- The data is encrypted as the data is written to the data page on disk and decrypted when the data page is read into memory.

- The end result is all data pages on the disk are encrypted.

- Database backups are also encrypted because a backup operation copies the data pages from the database file to the backup device. No decryption is done during the backup operation.

- You can use TDE with databases in an **Always On** Availability Group (AG). The certificate used to encrypt the database must be backed up and restored to the other servers within AGs that host copies of the database.

### Things to know about data in motion and SSL/TLS

Azure SQL Database, Azure SQL Managed Instance, and Azure Synapse Analytics enforce Secure Socket Layers and Transport Layer Security (SSL/TLS) encryption always for all connections. This level of encryption ensures all data is encrypted "in transit" between the client and server. Transport Layer Security (TLS) is used by all drivers that Microsoft supplies or supports for connecting to databases in Azure SQL Database or Azure SQL Managed Instance. In some circumstances, you might want to isolate the entire communication channel between your on-premises and cloud infrastructures by using a VPN.

### Things to consider when protecting data in motion

Consider the following Tailwind Traders scenarios, and possible data in motion security solutions for using VPN Gateway, TLS, and HTTPS.

| Scenario | Possible security solution |
| --- | --- |
| Secure access from multiple workstations located on-premises to an Azure virtual network| Use site-to-site VPN |
| Secure access from an individual workstation located on-premises to an Azure virtual network| Use point-to-site VPN |
| Move large data sets over a dedicated high-speed wide-area network (WAN) link | Use Azure ExpressRoute |
| Interact with Azure Storage through the Azure portal | All transactions are done by using HTTPS. You can also use the Azure Storage REST API over HTTPS to interact with Azure Storage and Azure SQL Database. |

### Things to know about data-in-use and dynamic data masking

Encryption for data-in-use is about protecting data and sensitive information. The encryption methods target usage scenarios and minimum access required.

Consider a scenario where customer assistants access the Tailwind Traders database that has customer phone numbers and email addresses. The assistants require access to only a portion of the sensitive data. They need to verify the user who is calling by checking the last four digits of the customer's phone number. The assistant doesn't need access to the remaining sensitive data. You can encrypt the remaining customer data and not reveal it to the assistants. 

Data-in-use employs a policy-based security feature called _dynamic data masking_. This feature hides the sensitive data in the result set of a query over designated database fields, while the data in the database remains unchanged. Dynamic data masking helps prevent unauthorized access to sensitive data by enabling customers to designate how much of the sensitive data to reveal with minimal consequence on the application layer.

### Things to consider when protecting data-in-use

Consider the following points about working with data-in-use and dynamic data masking. Think about how data-in-use can be protected in the security solution for Tailwind Traders.

- Dynamic data masking automatically discovers potentially sensitive data in Azure SQL Database and Azure SQL Managed Instance. The feature provides actionable recommendations to mask these fields.

- Dynamic data masking works by obfuscating the sensitive data in the result set of a query.

- The data masking policy can be configured in the Azure portal for Azure SQL Database.

- Dynamic data masking can be set up by using PowerShell cmdlets and the Azure REST API.