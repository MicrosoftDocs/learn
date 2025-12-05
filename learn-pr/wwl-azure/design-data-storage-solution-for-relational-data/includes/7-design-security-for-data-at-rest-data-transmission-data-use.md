Many organizations use Azure SQL Database for large customer databases that store phone numbers, addresses, orders, and credit card information.
They need a security solution to prevent unauthorized data access to their cloud hosted databases. Classifying stored data by sensitivity and business scenario helps organizations determine the risks associated with their data.

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=863a59d5-05cd-49e4-af44-9820b8ba82cd]

There are three basic tenets of good information security: data discovery, classification, and protection. In this unit, we review different data states and encryption methods to apply these tenets in a strong security solution. 

## Data encryption for structured data

Data exists in three basic states: data at rest, data in motion, and data in process. 

- **Data at rest** is data on a storage device that isn't being moved or used. Data at rest includes archived email messages stored in your Outlook inbox, or files on your laptop that you aren't using. Data encryption at rest is a mandatory step toward data privacy, compliance, and data sovereignty. 

- **Data in motion** (also called _data in transit_) is data that's being moved from one device to another within a private network or public network like the internet. Data in motion can also be data that's being read (used) but not changed. Data in motion includes email messages in transit, browsing internet websites, or using company applications like an organization chart.

- **Data in process** is data that's open and being changed. Data in process includes writing an email message, saving your work files, or ordering from a website.

There are different encryption methods for each of data state. The following table summarizes the methods. 

| Data state | Encryption method | Encryption level |
| --- | --- |
| **Data&nbsp;at&nbsp;rest** | Transparent data encryption (TDE) | Always encrypted. |
| **Data&nbsp;in&nbsp;motion** | Secure Socket Layers and Transport Layer Security (SSL/TLS) | Always encrypted. |
| **Data&nbsp;in&nbsp;process** | Dynamic data masking | Specific data is unencrypted. Remaining data is encrypted. |

### Things to know about data encryption

- Transparent data encryption (TDE) protects Azure SQL Database, Azure SQL Managed Instance, and Azure Synapse Analytics against the threat of malicious offline activity by encrypting data at rest. TDE performs real-time encryption and decryption of the database, associated backups, and transaction log files at rest without requiring changes to the application. TDE is enabled by default to all newly deployed Azure SQL Databases. 

- Azure SQL Database, Azure SQL Managed Instance, and Azure Synapse Analytics enforce Secure Socket Layers and Transport Layer Security (SSL/TLS) encryption always for all connections. This level of encryption ensures all data is encrypted "in transit" between the client and server. Transport Layer Security (TLS) is used by all drivers that Microsoft supplies or supports for connecting to databases in Azure SQL Database or Azure SQL Managed Instance. 

- Data-in-use employs a policy-based security feature called _dynamic data masking_. This feature hides the sensitive data in the result set of a query over designated database fields, while the data in the database remains unchanged. Dynamic data masking helps prevent unauthorized access to sensitive data by enabling customers to designate how much of the sensitive data to reveal with minimal consequence on the application layer.

   :::image type="content" source="../media/dynamic-data-masking.png" alt-text="Diagram shows how parts of a data block are masked." border="false":::

> [!TIP]
> Expand your learning with the [Plan and implement security for Azure SQL Database and Azure SQL Managed Instance](/training/modules/security-azure-sql-database-azure-sql-managed-instance/) learning module. 