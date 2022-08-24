## Authentication for your Azure Arc-enabled SQL Managed Instance

Authentication is the process of proving the user is who they claim to be. Azure Arc-enabled SQL Managed Instance (MI) supports two types of authentication:

- SQL Authentication
- Active Directory (AD) Authentication

To enable and use AD authentication for Arc-enabled SQL MI, Arc-enabled data services leverages a Kubernetes-native [Custom Resource Definition](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) called an Active Directory Connector. This provides Arc-enabled SQL MI running on the same data controller the ability to perform AD authentication.

With Arc-enabled SQL MI, you must use [keytab](https://docs.microsoft.com/sql/linux/sql-server-linux-ad-auth-understanding?view=sql-server-ver16#what-is-a-keytab-file) files. Keytab files are cryptographic files containing service principal names (SPNs), account names, and hostnames. Arc-enabled SQL MI uses a keytab file to authenticate itself with AD Domains.

There are two types of AD integration modes available:

- Customer-managed keytab (CMK)
- System-managed keytab (SMK)

Review [comparing both AD integration modes](https://docs.microsoft.com/azure/azure-arc/data/active-directory-introduction#compare-ad-integration-modes) to understand which keytab is right for your requirements.

To use AD authentication with your Arc-enabled SQL MI, follow these steps:

1. Deploy data controller
2. Deploy the appropriate keytab AD connector for your requirements:
    - Deploy [CMK AD Connector](https://docs.microsoft.com/azure/azure-arc/data/deploy-customer-managed-keytab-active-directory-connector)
    - Deploy [SMK AD Connector](https://docs.microsoft.com/azure/azure-arc/data/deploy-system-managed-keytab-active-directory-connector)

For either mode, you need a specific AD account, keytab AD connector, and Kubernetes secret for each Arc-enabled SQL MI.

## Encryption for your Arc-enabled SQL Managed Instance

Arc-enabled SQL MI has Transparent Data Encryption (TDE) enabled by default for newly created databases. TDE adds a layer of security to help protect data at rest from unauthorized or offline access to raw files or backups. TDE encrypts the entire database using an AES encryption algorithm, which doesn't require application developers to make any changes to existing applications. Currently, there is no support for restoring an already encrypted database to an Arc-enabled SQL MI.

Key management for TDE is crucial to ensure that your database is secure and you can recover the database when required. There are two types of key management, which we cover below:

- Service-managed keys
- Customer-managed keys

See [Transparent Data Encryption](https://docs.microsoft.com/azure/azure-sql/database/transparent-data-encryption-tde-overview?view=azuresql&tabs=azure-portal) for further information.

<!--
#### Service-managed keys

Using service-managed keys is the traditional approach to managing the keys required for the encryption of the database. The data in the database is encrypted using a symmetric data encryption key (DEK) which is stored in the database being encrypted. This DEK is then further encrypted by a SQL Server Certificate stored in the Master database. A Backup of the SQL Server Certificate is stored in a secure location and used to configure the keys onto another server in cases where you need to restore the database or rebuild a server and perform database restores of a TDE-encrypted database.

#### Customer-managed keys

To ensure the safety and recoverability of the keys, ensuring the ability to restore a database onto a new server requires the SQL Server certificate to be backed up. This backup is stored in a secure location. Another alternative is Hardware Security Modules (HSM) devices to store the encryption keys away from the encrypted data. See [Extensible Key Management](https://docs.microsoft.com/en-us/sql/relational-databases/security/encryption/enable-tde-on-sql-server-using-ekm?view=sql-server-ver16) for further information.
-->

## Container level privileges

The deployment, running, and management of the containers being used for Arc-enabled data service deployments work on least privileged access. All is achieved with non-root level access and with least privileged access.
