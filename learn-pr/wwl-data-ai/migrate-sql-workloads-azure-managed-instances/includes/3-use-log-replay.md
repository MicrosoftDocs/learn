Log Replay Service (LRS) is a technology that enables custom migrations of databases from on-premises SQL Servers to SQL Managed Instance in the cloud. It uses log shipping technology and is particularly useful in cases where more control is needed, when there is little tolerance for downtime, or when Azure Data Migration Service cannot be used. 

LRS can be used directly with PowerShell, CLI cmdlets, or API, to manually build and orchestrate database migrations to SQL Managed Instance. Some of the reasons to consider using LRS include include:

- More control over the database migration project
- Little tolerance for downtime on migration cutover
- Inability to install DMS executable in the environment
- Lack of file access to database backups
- Inability to open networking ports from the environment to Azure

