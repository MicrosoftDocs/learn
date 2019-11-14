It's important to ensure data stored at rest is encrypted to prevent data loss if there's a security breach. Most storage, and data services, in Azure provide encryption at rest by default, helping to build the foundations towards regulatory compliance.

Your company has migrated several systems to Azure, and it now wants to protect data stored in these systems. In the move to meeting regulatory and business requirements, this data needs to be encrypted at rest. Your manager has asked you to investigate the encryption at rest capabilities on the Azure platform to ensure this data is secured. Your manager would also like you to advise which services are available for managing encryption keys.

In this unit, you'll explore encryption at rest in Azure, key management with Azure Key Vault, and encryption at rest for key Azure data services.

## What is encryption at rest on Azure

Microsoft Azure provides encryption for Azure Storage, Azure SQL Database, Azure SQL Data Warehouse, Azure Cosmos DB, and Azure Data Lake. Microsoft Azure uses **symmetric** (one secret key to encrypt or decrypt information) encryption to encrypt and decrypt vast quantities of data quickly.

Encryption at rest is no different in a cloud model than it's on-premises, the control, and how to use it, is slightly different. Data encryption at rest refers to any data, or information, on persistent storage. This includes files on magnetic tape, optical media, archived data, or data in backups. In Azure, data is encoded as it's persisted to storage.

## Why you should encrypt data at rest

Data stored, either on physical media, or in the cloud, has to be secured. Encryption at rest provides protection for data stored at rest. Attacks that try to gain access to a company's data will begin with an attempt to gain access to the hardware on which data is stored. Once successful, an attacker will have access to the files on the media. Encryption at rest prevents attackers from accessing the data stored in those files.

Industry, and government, regulations including the General Data Protection Regulation (GDPR), Health Insurance Portability and Accountability Act (HIPAA), Payment Card Industry Data Security Standard (PCI DSS) and Federal Risk and Authorization Management Program (FedRAMP), lay out specific guidelines for data protection and encryption. In most cases encryption at rest is mandatory for compliance with these regulations.

The data currently stored in Azure by your company contains customer details, financial information, and intellectual property. This data is highly confidential, and that's why all the data has to be encrypted with the highest possible level of security. The GDPR, for example, requires your organization, as a data controller, to ensure this data is encrypted as a mandatory requirement for compliance.

## Base components of Azure at rest encryption

Azure supports a couple of different encryption models Client Encryption and Server-side Encryptions**. Each model supports different scenarios that you'll cover later in this unit. At rest encryption in Azure is composed of components that enable secure storage, key management, and access control. Below is an image showing an example of an encryption at rest implementation in Azure using Azure Key Vault.

![Image showing the encryption at rest model in Azure](../media/4-encryption-at-rest.png)

The three key elements to at rest encryption in Azure are:

- Azure Active Directory (AD) for access control and authentication. Azure AD is the basis for assigning permissions in the Azure platform, it is used to assign permissions for who, or what, services have access to encryption keys stored in Azure Key Vault.
- A multiple Key Hierarchy for a complete encryption at rest implementation. At rest encryption of data, stored in Azure, uses a data encryption key with symmetric encryption. However, an asymmetric key, known as the key encryption key, is then used to encrypt the encryption keys providing an additional layer of security.
- Azure Key Vault creates and stores encryption keys. Encryption keys should be stored securely but also be easy to manage.

## Azure Key Vault

In the server-side encryption model encryption keys get stored in Azure Key Vault, if using service-managed or customer-managed keys.

Azure Key Vault is a service in Microsoft Azure to securely store and access secrets in other words, a secret store. A vault is a logical group of secrets. A secret is defined as anything that you want tight control over access to, including passwords, certificates, or API keys. Applications and services in the cloud use cryptographic keys, or secrets, to keep information secure. Azure Key Vault helps to safeguard these keys and secrets. When you use the Azure Key Vault, Microsoft can't see or extract your keys.

Each Azure Key Vault instance has its own unique URI (URL) that hosts the REST API. The REST API is used to gain access to, and manage, stored secrets from the Azure management tools or via client libraries for popular languages.

## Manage keys, secrets, and certificates

Azure Key Vault provides secure storage for users, or applications, to store and consume encryption keys in several forms:

- **Cryptographic keys**: a string of bits to form a key, for example Azure storage keys
- **Secrets**: passwords up to 127 characters long
- **Security** certificates: either self-signed or from a certificate authority. Existing secrets and certificates can be imported into Azure key vault.

Secrets are stored in their own individual vaults, these vaults are effectively Azure resources that have their own security policies and configuration. Use the Azure portal to add and manage secrets within a vault. For certain services, Azure Key Vault will automatically manage secrets including rotating keys.

## Encryption at rest for Azure Services

Azure provides encryption at rest for most storage services including blob, table, file, and disk. Not all services have encryption at rest enabled by default. For some services, the encryption capabilities available have several flavors and support **Server-side encryption** or **Client encryption** models. Azure storage services encryption at rest has three main features:

- **Storage service encryption**: Providing encryption capabilities for Azure storage.
- **Azure Disk Encryption**: Encryption of OS and data disks used by Azure Virtual Machines (VM). Windows VMs use BitLocker, and Linux use DM-Crypt.
- **Client-Side Encryption**: Programmatic encryption of data in client applications.
- **Azure Databases**: Data is encrypted and decrypted automatically.

## Storage Service Encryption

Storage service encryption (SSE) is the encryption of Azure Storage. The storage service (Blob Storage, Queue Storage, Table Storage, and File Storage) has encryption at rest enabled by default, it can't be disabled. Storage service encryption supports both the service-managed keys (Microsoft) or customer-managed key scenarios. **Storage service encryption does not impact performance**

Azure Storage services are encrypted using 256-bit AES encryption. Data is encrypted automatically upon being received by the storage account, when data is read from Azure storage it's then decrypted before being returned. This solution allows you to secure and encrypt data without having to write any code.

## Client-side encryption

Client-side encryption is done outside the Azure resource provider or Azure by a service or calling application directly. Your organization keeps complete control of the encryption keys. Data is encrypted before being received by Azure meaning Microsoft don't have access to the encryption keys using this model, as such, Azure services can't decrypt the data. This results in reduced cloud functionality and the responsibility for encryption key storage lies with the organization.

![Screenshot showing client encryption model](../media/4-client-encryption.png)

## Server-side Encryption

Server-side encryption is completed by Azure services and is enabled by default for most services. Dependent on the scenario either Microsoft will manage the encryption keys for you or your organization can manage or control the encryption keys. The server-side encryption model supports key management by either Microsoft or by your organization. The encryption keys can be managed using either service-managed keys, customer-managed keys, or service-managed keys in customer-controlled hardware:

- **Service-managed**: Microsoft manages the encryption keys. Azure resource providers encrypt and decrypt data.
- **Customer-managed**: Your organization manages encryption keys in Azure Key Vault. Azure resource providers encrypt and decrypt data. Shared model with keys in Azure Key Vault.
- **Service-managed in customer-controlled hardware**: Your organization controls encryption keys on its own hardware. Azure resource providers encrypt and decrypt data. Host your own key model.

![Screenshot showing server encryption model](../media/4-server-encryption.png)

If your organization requires, or regulations dictate, data must be encrypted when stored at rest, then the server-side model is the recommended choice allowing the most flexibility for key management. Use the host your key model for situations where the keys must be hosted on hardware controlled by your organization.

## Azure Databases

Azure provides several database engines, from Azure SQL Databases to the document-based Cosmos DB. Starting with the Azure SQL Database, which is a general-purpose relational database service available in Azure. Azure SQL database supports server-side encryption via the Transparent Data Encryption (TDE) feature and client-side encryption via the Always Encrypted feature. Azure SQL Database supports both the Microsoft-managed and customer-managed key models. TDE is enabled by default for all newly created Azure SQL Databases and is available at both the database and server levels.

**Transparent Data Encryption**
TDE encrypts SQL Server, Azure SQL Database, and Azure SQL Data Warehouse data files in real time. TDE encrypts the entire database using AES-256 symmetric encryption keys known as the database encryption key (DEK). This gets stored in the database boot record. TDE protects both data and log files. File encryption is completed at the page level.

**Column-level encryption**
Azure SQL Database allows you to apply symmetric encryption to specific columns of data using T-SQL (Transact-SQL). This enables the encryption on specific columns using different encryption keys.

**Azure SQL Data Warehouse**
A cloud-based enterprise relational Data Warehouse service available in Azure using Massively Parallel Processing (MPP). The TDE implementation in Azure SQL Data Warehouse is based upon the same SQL Server TDE technology as Azure SQL Database. TDE isn't enabled by default on Azure SQL Data Warehouse.

**Azure Cosmos DB**
A cloud-based hyper-scale, globally distributed multi-model database. Data stored in Azure Cosmos DB non-volatile storage (solid-state drives) gets encrypted by default, however there's no facility to turn encryption on or off. All keys are managed by Microsoft and rotated as dictated by Microsoft's internal policies and guidelines.