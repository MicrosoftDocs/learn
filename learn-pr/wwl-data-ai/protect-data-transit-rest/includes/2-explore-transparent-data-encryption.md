
Microsoft SQL Server’s Transparent Data Encryption (TDE) encrypts all the data within a target database at the page level. The data is encrypted as the data is written to the data page on disk and decrypted when the data page is read into memory. The end result is that all data pages on disk are encrypted.

TDE does not encrypt data at the table or column level. Anyone with the appropriate permissions can read the data, copy the data and even share the data. Encryption at rest provides protection against someone restoring a backup to an unsecured server or making a copy of all the database and transaction log files and attaching them to another unsecured server. No decryption is done during the backup operation.

TDE protects data at rest, and follows several laws, regulations, and guidelines established in various industries. With this capability, software developers can encrypt data using the AES and 3DES encryption algorithms without having to change existing applications.

The following image shows how TDE encryption works.

:::image type="content" source="../media/module-33-security-final-05_1.png" alt-text="Transparent Data Encryption architecture":::

With Azure SQL Database, enabling TDE is simple. Databases that are created in Azure SQL Database after May 2017 have TDE enabled automatically. Databases that were created before May 2017 will have TDE disabled by default and TDE will need to be manually enabled on these databases. When using Azure SQL Managed Instance, databases that were created after February 2019 have TDE enabled. Databases created before February 2019 will have TDE disabled.

Enabling TDE within an Azure SQL Database database is simply a matter of editing the database within the Azure portal. From the **Transparent data encryption** pane, select to enable data encryption.

:::image type="content" source="../media/module-33-security-final-04.png" alt-text="Transparent Data Encryption Settings for an Azure SQL Database":::

By default, databases within Azure SQL Database are encrypted using a Microsoft provided certificate. Microsoft Azure does provide a Bring Your Own Key option, which allows you to use a certificate that was created by your company and uploaded to Azure. If your company removes the certificate from Azure, then the database connections will be closed, and there will be no access to the database.

Enabling TDE within a Microsoft SQL Server Database is an easy process as only a few T-SQL commands are required. This process involves the following steps:

1. Set a master key within the master database using the `CREATE MASTER KEY ENCRYPTION` command.
1. Create a certificate in the master database, which will be used for the encryption using the `CREATE CERTIFICATE` command.
1. Create a database encryption key within the database, which allows you to enable TDE with the `CREATE DATABASE ENCRYPTION KEY` command.
1. Once the encryption key is created, it needs to be enabled using the `ALTER DATABASE` command.

The entire set of commands is shown below.

```sql
USE master;
GO

CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Pa55.w.rd';
GO

CREATE CERTIFICATE MyServerCert
    WITH SUBJECT = 'TDEDemo_Certificate';
GO

USE [TDE_Demo];
GO

CREATE DATABASE ENCRYPTION KEY
    WITH ALGORITHM = AES_256 ENCRYPTION BY SERVER CERTIFICATE MyServerCert;
GO

ALTER DATABASE TDE_Demo SET ENCRYPTION ON;
GO
```

Once TDE is enabled, it will take some time in order to encrypt the database as each database page must be read, encrypted and written back to disk. The larger the database the longer this operation will take. This process is a background process and is run at a low priority in order to not overload the IO or the CPU of the system.

Once the certificate that will be used by TDE has been created, it must be manually backed up and stored in a safe place. SQL Server integrates with Enterprise Key Managers (EKMs) in order to manage encryption keys. An example of an EKM is Azure Key Vault. 

Managing the certificate is important, because if the certificate is lost and the database needs to be restored from a backup, the restore will fail, as the database cannot be read. 

 > [!NOTE]
 >To use TDE with databases in an Always On Availability Group, the certificate used to encrypt the database must be backed up and restored to the other servers within the Availability Group that will be hosting copies of the database.

### Azure disk encryption

In addition to these SQL Server security features, Azure VMs include an additional layer of security, Azure Disk Encryption—a feature that helps protect and safeguard data and meet organization and compliance commitments. If you are using TDE, your data is protected by multiple layers of encryption with Azure Disk Encryption.
