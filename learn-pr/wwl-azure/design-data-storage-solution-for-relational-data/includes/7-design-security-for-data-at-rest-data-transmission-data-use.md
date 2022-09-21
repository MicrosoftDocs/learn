You've been hired as a Senior Database Administrator to help ensure the security of the Azure SQL Database environment. Your company is an online sporting goods retailer that stores customer data like phone numbers, addresses, and credit cards in Azure SQL Database hosted on the cloud. What solution would you implement to prevent unauthorized data access by someone that is working to support this cloud hosted database?

Classifying stored data by sensitivity and business impact helps organizations determine the risks associated with the data. In this unit, we will learn the different data states and encryption modes in detail.

The three basic tenets of good information protection are:

- Data discovery

- Classification

- Protection

Large organizations, governments, and military entities have been using data classification to manage their data's integrity. The result of data classification is metadata that enables us to label the data as:

- Public

- Confidential

- Restricted

After the data is classified, you can implement data protection measures for highly-classified data. In this section, we explore data encryption for structured data.

Data exists in one of three basic states - data-at-rest, data-in-motion, data-in-process.  This table shows different data states with possible encryption methods. 

| Data state | Encryption method |
| --- | --- |
| **Data-at-rest** | TDE, Always Encrypted |
| **Data-in-motion** | SSL/TLS, Always Encrypted |
| **Data-in-process** | Dynamic data masking |


 

> [!NOTE]
> Defense in depth is a strategy that employs a layered approach to slow the advance of an attack aimed at acquiring unauthorized access to information.

## Protect data-at-rest

Data encryption at rest is a mandatory step toward data privacy, compliance, and data sovereignty. Encryption helps mitigate risks related to unauthorized data access. Data-at-rest needs to be protected from unauthorized or offline access to raw files or backups to an unsecured server or making a copy of all the database and transaction log files to another unsecured server.

**Transparent data encryption (TDE)**

TDE protects Azure SQL Database, Azure SQL Managed Instance, and Azure Synapse Analytics against the threat of malicious offline activity by encrypting data at rest. It performs real-time encryption and decryption of the database, associated backups, and transaction log files at rest without requiring changes to the application. TDE is enabled by default to all newly deployed Azure SQL Databases. With Azure SQL Managed Instance, databases created after February 2019 have TDE enabled.

- TDE performs encryption and decryption of the data at the page level.

- The data is encrypted as the data is written to the data page on disk and decrypted when the data page is read into memory.

- The end result is that all data pages on disk are encrypted.

- Database backups will also be encrypted because a backup operation just copies the data pages from the database file to the backup device. No decryption is done during the backup operation.

- TDE encrypts the storage of an entire database by using a symmetric key called the Database Encryption Key (DEK).

- Service-managed TDE - where the DEK is protected by a built-in server certificate.

- Customer-managed TDE - the TDE Protector that encrypts the DEK is supplied by customer and stored in a customer-owned and managed in their key management system

> [!NOTE]
> To use TDE with databases in an Always On Availability Group, the certificate used to encrypt the database must be backed up and restored to the other servers within the Availability Group that will be hosting copies of the database.



## Protect data-in-transit

SQL Database, SQL Managed Instance, and Azure Synapse Analytics enforce encryption (SSL-Secure Sockets Layer/TLS - Transport Layer Security) at all times for all connections. This ensures all data is encrypted "in transit" between the client and server. **Transport Layer Security** (TLS) is used by all drivers that Microsoft supplies or supports for connecting to databases in Azure SQL Database or Azure SQL Managed Instance. In some circumstances, you might want to isolate the entire communication channel between your on-premises and cloud infrastructures by using a VPN.

The next table has different scenarios and solutions for VPN Gateway, TLS and HTTPS.

| Scenario | Solution |
| --- | --- |
| Secure access from multiple workstations located on-premises to an Azure virtual network| Use site-to-site VPN |
| Secure access from an individual workstation located on-premises to an Azure virtual network| Use point-to-site VPN |
| Move large data sets over a dedicated high-speed wide-area network (WAN) link| Use Azure ExpressRoute |
| Interact with Azure Storage through the Azure portal| All transactions occur via HTTPS. You can also use Storage REST API over HTTPS to interact with Azure Storage and Azure SQL Database. |


## Protect data-in-use

Consider the scenario where you have customer service representatives accessing the database containing customer Phone Number and email address. You want to still enable them to verify the users calling in so except the last four digits of the customer's phone number, the rest needs to be encrypted and not revealed to the service representative. How would you implement a solution for this case?

**Dynamic Data Masking**

Dynamic data masking is a policy-based security feature that hides the sensitive data in the result set of a query over designated database fields, while the data in the database is not changed. It helps prevent unauthorized access to sensitive data by enabling customers to designate how much of the sensitive data to reveal with minimal impact on the application layer.

- Dynamic data masking automatically discovers potentially sensitive data in Azure SQL Database and SQL Managed Instance and provides actionable recommendations to mask these fields.

- It works by obfuscating the sensitive data in the result set of a query

- Data masking policy can be set up in Azure portal only for Azure SQL Database

- Dynamic data masking can be set up using PowerShell cmdlets and REST API
