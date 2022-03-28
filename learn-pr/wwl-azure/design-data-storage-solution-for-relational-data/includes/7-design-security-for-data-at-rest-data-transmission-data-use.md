You've been hired as a Senior Database Administrator help ensure the security of the Azure SQL database environment. Your company is an online sporting goods retailer that stores customer data like phone numbers, addresses, and credit cards in Azure SQL database hosted on the cloud. What solution would you implement to prevent unauthorized data access by someone that is working to support this cloud hosted database?

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

| **DATA STATE**| **ENCRYPTION METHOD** |
| - | - |
| Data-at-rest| TDE, Always Encrypted |
| Data-in-motion| SSL/TSL, Always Encrypted |
| Data-in-process| Dynamic data masking |


 

> [!NOTE]
> Defense in depth is a strategy that employs a layered approach to slow the advance of an attack aimed at acquiring unauthorized access to information.

## Protect data-at-rest

Data encryption at rest is a mandatory step toward data privacy, compliance, and data sovereignty. Encryption helps mitigate risks related to unauthorized data access. Data-at-rest needs to be protected from unauthorized or offline access to raw files or backups to an unsecured server or making a copy of all the database and transaction log files to another unsecured server.

**Transparent data encryption**

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

**Azure's Azure Key Vault service for TDE**

[Azure Key Vault](/azure/key-vault/general/overview) is a tool for storing and accessing sensitive data like passwords, certificates or keys. It is a centralized storage solution for application secrets and also helps monitor how and when the keys/certificates are being accessed. Azure Key vault easily integrates with other Azure services. Key Vault data has its own RBAC policies, separate from the Azure subscription so users need explicit access to be granted.

In the scenario discussed at the beginning of the unit, you are implementing a solution to protect data-at- rest from unauthorized data access by someone that is working to support this cloud hosted database. **Customer-managed TDE -**  Bring Your Own Key implementation of TDE is a good solution for the above scenario. The TDE Protector that encrypts the Database Encryption Key (DEK) is a customer-managed asymmetric key, which is stored in a customer-owned and managed Azure Key Vault (Azure's cloud-based external key management system) and never leaves the key vault.

> [!IMPORTANT]
> You can read more here [Azure SQL TDE with customer-managed key](/azure/azure-sql/database/transparent-data-encryption-byok-overview)

## Protect data-in-transit

SQL Database, SQL Managed Instance, and Azure Synapse Analytics enforce encryption (SSL-Secure Sockets Layer/TLS - Transport Layer Security) at all times for all connections. This ensures all data is encrypted "in transit" between the client and server. **Transport Layer Security** (TLS) is used by all drivers that Microsoft supplies or supports for connecting to databases in Azure SQL Database or Azure SQL Managed Instance. In some circumstances, you might want to isolate the entire communication channel between your on-premises and cloud infrastructures by using a VPN.

The next table has different scenarios and solutions for VPN Gateway, TLS and HTTPS.

| **SCENARIO**| **SOLUTION** |
| - | - |
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

- Data masking policy can be set up in Azure portal only for Azure SQL DB

- Dynamic data masking can be set up using PowerShell cmdlets and REST API

In the image below, the last three digits of phone number column and rest of the characters are masked.

:::image type="content" source="../media/dynamic-data-masking.png" alt-text=" In the image,  the last three digits of phone number column and rest of the characters are masked.":::

 
Data masking rules consist of the column to apply the mask to and how the data should be masked. Use the standard mask or specify your own custom masking logic.  
‎The following table shows the column that needs to be masked and the logic:

| **SCENARIO**| **SOLUTION** |
| - | - |
| Default| Displays the default value for that data type instead |
| Credit card| XXXX-XXXX-XXXX-1234 |
| Email| aXX @XXXX.com |
| Random Number| Generated random number between selected boundaries |
| Custom Text| Adds padding string between exposed prefix and exposed suffix characters |

> [!NOTE]
> Note that Dynamic Data Masking is a presentation layer feature, and unmasked data can always be viewed by administrators.

Consider a scenario where a database is queried and accessed by users of all authorization levels. A user that doesn't have administrator privileges queries a table that has some sensitive customer data such as phone number, email etc. along with purchase, and product information.  
‎How will you implement a solution that suppresses the sensitive information while allowing the user to view the other fields?

Dynamic data masking for data-in-use - You can set up a dynamic data masking policy using default masking logic for email, credit cards etc.. Or you can specify custom text or random number for the field in question. You can allow other users to view the non-masked versions by adding them to the SQL users, excluded from the masking list.

**Always Encrypted feature for data-at-rest and data-in-transit**

**Always Encrypted** is a feature designed to protect sensitive data stored in specific database columns from access (for example, credit card numbers, national identification numbers, etc.). This includes database administrators or other privileged users who are authorized to access the database to perform management tasks. The data is always encrypted, which means the encrypted data is decrypted only for processing by client applications with access to the encryption key. This key can be stored either in the Windows Certificate Store or in Azure Key Vault.

**How Always Encrypted works**

Step by step process for Always Encrypted is explained below:

- Always Encrypted uses two types of keys: column encryption keys and column master keys.

- A column encryption key is used to encrypt data in an encrypted column. A column master key is a key-protecting key that encrypts one or more column encryption keys.

- The Database Engine only stores encrypted values of column encryption keys and the information about the location of column master keys, which are stored in external trusted key stores, such as Azure Key Vault, Windows Certificate Store

- To access data stored in an encrypted column in plaintext, an application must use an Always Encrypted enabled client driver. Encryption and decryption occurs via the client driver.

- The driver transparently collaborates with the Database Engine to obtain the encrypted value of the column encryption key for the column as well as the location of its corresponding column master key.

- The driver contacts the key store, containing the column master key, in order to decrypt the encrypted column encryption key value, and then it uses the plaintext column encryption key to encrypt the parameter.

- The driver substitutes the plaintext values of the parameters targeting encrypted columns with their encrypted values, and it sends the query to the server for processing.

- The server computes the result set, and for any encrypted columns included in the result set, the driver attaches the encryption metadata for the column, and then the driver decrypts the results and returns plaintext values to the application.

> [!TIP]
> Read about Always Encrypted [best practices](/azure/azure-sql/database/security-best-practice)

> [!IMPORTANT]
> Always Encrypted does not work with Dynamic Data Masking. It is not possible to encrypt and mask the same column. You need to prioritize protecting data in use vs. masking the data for your app users via Dynamic Data Masking.

Consider this scenario - A customer has an on-premises client application at their business location. As part of their cloud migration of their database, they are evaluating Azure SQL database. They plan to outsource the database maintenance to third parties. They worry that the sensitive data shouldn't be accessed by the third party vendors or the cloud administrators. What will you suggest?

**Always Encrypted for data-at-rest and data-in-transit** - Always Encrypted ensures the separation of duties between database administrators and application administrators. By storing the Always Encrypted keys in a trusted key store hosted on-premises, they can ensure Microsoft cloud administrators have no access to sensitive data. Always Encrypted enables customers to confidently store sensitive data outside of their direct control.