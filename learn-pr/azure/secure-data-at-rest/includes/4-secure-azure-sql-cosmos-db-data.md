The data that your organization is moving to Azure includes customer details and financial information. This is data that must be kept as secure as possible, remain accessible for day-to-day use with systems and applications, and meet regulatory requirements. You need to understand how Azure SQL Database and Azure Cosmos DB can help you achieve this.

Here, you'll learn about the encryption features in Azure SQL Database and Cosmos DB.

## Secure your SQL database with transparent data encryption (TDE)

SQL databases store your data in a structured format – in data files. These files can be encrypted so that, if either the hard drives that store the data are compromised, or the data files are stolen, the data will be secure. For Azure SQL Database, you can achieve this encryption at rest through transparent data encryption (TDE). Transparent data encryption in Azure SQL Database encrypts not only the data files, but also the transaction log files, and any backups for your databases. This process of encryption is entirely transparent to the applications using the databases. For older SQL Databases, transparent data encryption isn't enabled by default. However, newly provisioned SQL Databases have transparent data encryption enabled by default.

Transparent data encryption ensures that an entire database is encrypted through a defined process. A database encryption key is used to encrypt the database. This key is then secured by a transparent data encryption protector. The protector can be a key you've stored in Azure Key Vault or a certificate managed for you. The database encryption key is decrypted at the moment the database is started. Afterwards, this same database encryption key is used to decrypt the database, and encrypt it again when the time comes.

You can manually enable transparent data encryption for a SQL Database on Azure, through Azure PowerShell, Transact-SQL, or the Azure portal. In the Azure portal, look for transparent data encryption under the settings in your SQL Database, then select **ON** under data encryption.

Below is an example showing how you can enable TDE in the portal:

![Enable TDE](../media/4-enable-tde.png)

## Secure your Cosmos DB with automatic encryption at rest

Cosmos DB databases allow your data to be stored in an unstructured format. Databases for Cosmos DB are physically stored in hard drives – solid state for Cosmos DB. Cosmos DB components, like backups, are stored in HDDs. Your media attachments, the actual databases, or back-ups can all be protected at rest. At the same time, none of this encryption affects the latency and throughput SLAs that Cosmos DB sets out to meet. Your data is automatically encrypted at rest, but is not automatically encrypted when it is generated, and when it is in use.

![Cosmos DB Encryption behind the scenes](../media/4-cosmos-db-encryption.png)

Data in your Cosmos DB is protected using AES-256 encryption. In the background, the Azure Cosmos DB Management Service, with the help of a Secret Store, manages all of your encryption keys and unwraps them when necessary. These keys are used to encrypt and decrypt your data. Microsoft manages the keys for you – the encryption keys are also rotated to keep your data secure.

Encryption at rest is automatically enabled by default, whatever the region. This situation means you can use turnkey global distribution, and confidently replicate your data to any region, knowing that all of your data is automatically encrypted. In fact, you can't disable encryption even if you wanted to. Because encryption is enabled by default, there's nothing to do on your end to configure Cosmos DB  to encrypt all of your data.

The process for how your data is secured is straightforward. The user establishes a secure connection with Cosmos DB and sends data. The data to be stored and persisted in Cosmos DB is securely encrypted, and written to secure storage together with any relevant indexing data. A secured backup is then created routinely.
