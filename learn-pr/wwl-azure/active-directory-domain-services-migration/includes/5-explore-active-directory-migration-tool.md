To move objects between Active Directory Domain Services (AD DS) forests and domains, Microsoft provides the Active Directory Migration Tool (ADMT). You can use this tool when consolidating domains within a forest or when migrating to a new AD DS forest. This tool hasn't been updated recently, but it still works with Windows Server 2022.

- ADMT can perform the following functions:

- Migrate user accounts

- Migrate service accounts

- Migrate groups

- Migrate computer accounts

- Translate security for local profiles

If you're defining a new naming structure for users or groups, you can implement that as part of the migration process. Use an include file, which identifies the desired source objects and the destination names. Computer accounts can't be renamed during migration.

When you migrate user objects, all attributes are migrated by default. You can filter some attributes out in the migration process if the attributes value is no longer valid. For example, attributes that retired applications configured could be filtered. If there are application-specific attributes, you'll need to research the best approach for migrating them.

## ADMT installation

ADMT installs on a member server with Desktop Experience in the target AD DS forest. Before installing ADMT, you must install Microsoft SQL Server to hold migration information. You can use SQL Server Express for ADMT, but you should monitor the size of the database to ensure that it doesn't reach its maximum limit and stop functioning.

If you're using password synchronization, you must install Password Export Server (PES) on a domain controller in the source. PES is responsible for exporting user password hashes from the source to the target. If you don't use PES, migrated user accounts are configured with a new password stored in a text file. Without password synchronization, you need a process to distribute new passwords to users.

## Migration accounts

Migration accounts are user accounts in the source; they target forests with enough permissions to perform migration tasks. Accounts that are members of Domain Admins in the source and target forests will work, but you can create accounts with only the necessary permissions delegated for specific tasks such as migrating users or computers. The migration account in the target forest must be a local administrator on the member server where ADMT is installed.

## Security translation

Translating security in local profiles on client computers allows a migrated user to retain access to the same profile on the local computer as the source user. For users, this means that their profiles stays intact with all their app configurations.

> [!NOTE]
> ADMT was developed to work with Windows 7 and earlier. It hasn't been updated to work with Window 8 or Windows 10. This means that profile translation might not work properly, depending on the configuration of computers and apps in your organization. For detailed information about using ADMT, obtain [Active Directory Migration Tool (ADMT) Guide: Migrating and Restructuring Active Directory Domains](https://www.microsoft.com/download/details.aspx?id=19188) from the Microsoft Download Center.

