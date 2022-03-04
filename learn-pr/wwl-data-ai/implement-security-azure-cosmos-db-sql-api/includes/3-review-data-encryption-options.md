Azure Cosmos DB stores its primary databases on Solid-State Driver (SSDs).  Media attachments and backups are stored in Azure Blob storage, which is usually placed on HHDs. All Azure Cosmos DB regions have encryption turned on for all user data. Azure Cosmos DB now uses *encryption at rest* for all its databases, backups, and media. *Encryption at rest* refers to encryption of data on nonvolatile storage devices like HHDs and SSDs. Additionally, when Azure Cosmos DB data is in transit, or over the network, that data is also encrypted.  Encryption at rest and in transit means that Azure Cosmos DB is using end-to-end encryption. There's no extra cost for end-to-end encryption.

All this encryption is automatic, so you don't have to enable any setting to use it, which means that encryption is *on* by default. Azure Cosmos DB uses EAS-256 encryption on all regions where the account is running at. Azure Cosmos DB data is encrypted and decrypted on the fly with service-managed keys without affecting performance or availability. These service-managed keys are managed by Microsoft, but you have to option to use your own customer-managed keys. Microsoft has a set of internal guidelines for encryption key rotation, which Cosmos DB follows.

## Azure Cosmos DB at rest encryption implementation

Azure Cosmos DB encryption at rest uses security technologies like secure key storage systems, encrypted networks, and cryptographic APIs. The storage of encrypted data and the management of the keys is done separately. Systems that decrypt and process data have to communicate with systems that manage keys as indicated in the diagram below. 

:::image type="content" source="../media/3-encryption-keys.png" alt-text="Diagram that shows the systems that decrypt and process data have to communicate with systems that manage keys.":::

