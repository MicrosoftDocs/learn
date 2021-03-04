It is important to consider encryption both for data at rest, and data in transit. This unit describes encryption for data at rest.

## Encryption at rest

It is important to understand exactly what encryption at rest entails. Encryption at rest does not encrypt data at the table or column level. Anyone with the appropriate permissions can read the data, copy the data and even share the data. Encryption at rest provides protection against someone restoring a backup to an unsecured server or making a copy of all the database and transaction log files and attaching them to another unsecured server. 

## Transparent data encryption

Microsoft SQL Server’s Transparent Data Encryption (TDE) encrypts all the data within a target database at the page level. The data is encrypted as the data is written to the data page on disk and decrypted when the data page is read into memory. The end result is that all data pages on disk are encrypted. A database file is not readable by someone who is not authorized. Database backups will also be encrypted, because a backup operation just copies the data pages from the database file to the backup device. No decryption is done during the backup operation.

With Azure SQL Database, enabling TDE is simple. Databases that are created in Azure SQL Database after May 2017 have TDE enabled automatically. Databases that were created before May 2017 will have TDE disabled by default and TDE will need to be manually enabled on these databases. When using Azure SQL Managed Instance, databases that were created after February 2019 have TDE enabled. Databases created before February 2019 will have TDE disabled. Enabling TDE within an Azure SQL Database database is simply a matter of editing the database within the Azure portal. From the “Transparent Data Encryption” pane, select to enable data encryption.

:::image type="content" source="../media/module-33-security-final-04.png" alt-text="Transparent Data Encryption Settings for an Azure SQL Database":::


By default, databases within Azure SQL Database are encrypted using a Microsoft provided certificate. Microsoft Azure does provide a Bring Your Own Key option, which allows you to use a certificate that was created by your company and uploaded to Azure. If your company removes the certificate from Azure, then the database connections will be closed, and there will be no access to the database.

Enabling TDE within a Microsoft SQL Server Database is an easy process as only a few T-SQL commands are required. This process involves setting a master key within the master database using the CREATE MASTER KEY ENCRYPTION command. After that, a certificate is created in the master database, which will be used for the encryption using the CREATE CERTIFICATE command. A database encryption key is then created within the database, which allows you to enable TDE with the CREATE DATABASE ENCRYPTION KEY command. Once the encryption key is created, it needs to be enabled using the ALTER DATABASE command. The entire set of commands is shown below.

```sql
USE master;

GO

CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Pa55.w.rd';

GO

CREATE CERTIFICATE MyServerCert

 WITH SUBJECT = 'TDEDemo_Certificate';

GO


USE TDE_Demo;

GO


CREATE DATABASE ENCRYPTION KEY

 WITH ALGORITHM = AES_256 ENCRYPTION BY SERVER CERTIFICATE MyServerCert;

GO


ALTER DATABASE TDE_Demo SET ENCRYPTION ON;

GO
```

Once TDE is enabled, it will take some time in order to encrypt the database as each database page must be read, encrypted and written back to disk. The larger the database the longer this operation will take. This process is a background process and is run at a low priority in order to not overload the IO or the CPU of the system.

Once the certificate that will be used by TDE has been created, it must be manually backed up and stored in a safe place. SQL Server integrates with Enterprise Key Managers (EKMs) in order to manage encryption keys. An example of an EKM is Azure Key Vault. Managing the certificate is important, because if the certificate is lost and the database needs to be restored from a backup, the restore will fail, as the database cannot be read. To use TDE with databases in an Always On Availability Group, the certificate used to encrypt the database must be backed up and restored to the other servers within the Availability Group that will be hosting copies of the database.

## Encryption at rest for MySQL and PostgreSQL

Azure SQL Database for MySQL and Azure SQL Database for PostgreSQL do not have a TDE like process. However, the Azure environment in which they are run supports a disk encryption method. This process encrypts the databases that are stored on the disk, so that if the disk hosting the database was compromised the data on it would be unreadable. This service offers a Bring Your Own Key service, much like TDE within Azure SQL Database does. This service allows you to upload your own certificate and have this certificate be used for the encryption.

## Azure disk encryption

In addition to these SQL Server security features, Azure VMs include an additional layer of security, Azure Disk Encryption—a feature that helps protect and safeguard data and meet organization and compliance commitments. If you are using TDE, your data is protected by multiple layers of encryption. Azure Disk Encryption and encryption of the SQL Server database files and backup.
