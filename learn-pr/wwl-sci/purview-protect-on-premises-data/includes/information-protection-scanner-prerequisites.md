Before deploying the Microsoft Purview Information Protection scanner, it's important to prepare the right infrastructure. The scanner works with your existing environment. It connects to Microsoft Purview, scans on-premises locations like file shares and SharePoint Server, and stores configuration data in SQL Server. 

:::image type="content" source="../media/scanner-architecture.png" alt-text="Diagram showing scanner cluster communication with Microsoft Purview, file shares, SharePoint Server, and SQL Server." lightbox="../media/scanner-architecture.png":::

The scanner connects to Microsoft Purview to retrieve label and DLP policies, scans local file shares and SharePoint Server content over SMB, and stores configuration data in SQL Server.

## Configure a supported scanner server

The scanner runs as a service on a 64-bit Windows Server machine. To ensure consistent performance during scans, the server should meet the following minimum requirements:

- **CPU**: At least 4 cores
- **RAM**: At least 8 GB
- **Disk space**: Minimum of 10 GB free, used to store temporary files created during scanning

The amount of required disk space increases based on the number of processor cores and the size of the files being scanned, since the scanner creates multiple temporary files during processing.

The supported operating systems for production use include:

- Windows Server 2016
- Windows Server 2019
- Windows Server 2022
- Windows Server 2025

While you can test the scanner on any operating system [supported by the information protection client](/purview/information-protection-client?azure-portal=true#requirements-for-deploying-the-information-protection-client), this configuration isn't supported for production use. Server Core and Nano Server aren't supported in any scenario.

If your data includes NFS shares, make sure the server has the NFS feature enabled.

## Set up SQL Server for scanner configuration

The scanner stores its configuration data in a SQL Server database. You can use either a local or remote SQL Server instance, but it's recommended to keep the scanner database isolated from other applications.

Make sure your SQL Server setup meets these requirements:

- **SQL Server version**: SQL Server 2016 or later
- **Collation**: Must be case-insensitive
- **Sysadmin access**: Required to install the scanner and automatically create the database
- **Alternative setup**: If Sysadmin rights aren't allowed, the database and permissions can be configured manually with an [alternative configuration](/purview/deploy-scanner-prereqs?azure-portal=true#deploying-the-scanner-with-alternative-configurations)
- **Performance at scale**: For environments with more than 10 scanners, use a SQL Server machine with at least 8 CPU cores and 16-GB RAM

## Grant the correct permissions to the scanner service account

The scanner runs under a service account that needs specific permissions to function correctly. This account should be an Active Directory account synced to Microsoft Entra ID and needs to meet the requirements listed below. If your environment restricts Microsoft Entra ID sync or certain rights, alternative configurations are available.

| Requirement | Purpose and details |
|-----|-----|
| Sign-in locally (temporary) | Required to install and configure the scanner, but not to run scans. You can remove this right after verifying the scanner is working. Alternative configuration options are available if this right can't be granted. |
| Sign-in as a service | Required throughout installation, configuration, and normal operation. This right is automatically assigned during installation. |
| Permissions for file shares | The service account requires Read, Write, and Modify permissions to scan and label content. |
| Permissions for SharePoint | Grant Full Control to scan, classify, and protect SharePoint content. For discovery mode only, Read access is sufficient. |
| Labeling encrypted content | Make the service account an Azure Information Protection super user to label or remove protection from encrypted files. This also ensures access to content under onboarding controls. |
| Site-level SharePoint scanning | To scan sites and subsites under a specific URL, assign Site Collection Auditor rights at the SharePoint farm level. |
| Information Protection license | The service account must be licensed to classify, label, or protect files. See Microsoft 365 security and compliance licensing for details. |

## Install required software and enable connectivity

Install the full Microsoft Purview Information Protection client on the scanner server, not just the PowerShell module. You'll also need the Microsoft Office IFilter to support file types like .zip, and the scanner server needs access to the following endpoints over HTTPS unless configured for offline use:

- *.aadrm.com
- *.azurerms.com
- *.informationprotection.azure.com
- *.protection.outlook.com
- informationprotection.hosting.portal.azure.net
- *.aria.microsoft.com

If internet connectivity isn't allowed, you can export and import label policies and scan configurations to run the scanner in offline mode.

## Verify label and policy readiness

At least one sensitivity label needs to be configured in Microsoft Purview. This label must be available to the scanner service account, and you'll specify that account during scanner setup using PowerShell.

If your labels don't include auto-labeling conditions, you can still use the scanner by enabling one of the following options in your scan job:

- Discover all sensitive information types
- Treat recommended labeling as automatic
- Apply a default label to all scanned files

## Meet SharePoint scanning requirements

To scan SharePoint Server content, ensure you're running a supported version: SharePoint 2013, 2016, or 2019. The scanner accesses the last published version of a document and respects content approval and versioning settings.

In large farms, you might need to raise the SharePoint list view threshold. For environments with long file paths, increase the maxUrlLength setting in your SharePoint web.config file to avoid time-outs.

## Support for long file paths

If your file paths exceed 260 characters, the scanner needs to run on a server that supports long path settings. Windows Server 2016 and later versions can be configured to bypass this limit using Group Policy or registry settings.
