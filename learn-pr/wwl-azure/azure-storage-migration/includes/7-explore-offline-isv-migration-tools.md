## RoboCopy

RoboCopy is a program that comes with Windows and copies data between SMB shares and local drives. Use it for smaller amounts of data.

> [!NOTE]
> RoboCopy is an unmanaged tool. That means you need to ensure that proper error handling is implemented and any errors during transfer are discovered and recovered.

Learn more: [Robocopy](/windows-server/administration/windows-commands/robocopy)

## Rsync and fpsync

Many customers use Rsync and fpsync to replicate or migrate their data to Azure.

> [!NOTE]
> These tools are unmanaged. That means you need to ensure that proper error handling is implemented and any errors during transfer are discovered and recovered.

> [!NOTE]
> These tools are not supported or maintained by Microsoft. You are solely responsible for their use.

## ISV offerings

### Storage Migration Program

If tools like Azure Storage Mover don't work for you, the Azure Storage Migration Program pays select ISVs' software license cost to facilitate easier storage migrations. Data must be net-new to Azure to qualify.

Learn more: [Azure Storage Migration Program details](/azure/storage/solution-integration/validated-partners/data-management/azure-file-migration-program-solutions?source=recommendations)
For a comparison of tools, see [Azure Storage migration tools comparison](/azure/storage/solution-integration/validated-partners/data-management/migration-tools-comparison)

### Rclone

Many customers use Rclone to replicate or migrate data to Azure. Rclone offers an open source version at [https://rclone.org/](https://rclone.org/). A hardened, commercially supported version is also available at [https://rclone.com/](https://rclone.com/).
> [!NOTE]
> These tools are unmanaged. That means you need to ensure that proper error handling is implemented and any errors during transfer are discovered and recovered.

### MoveBot.io

Microsoft evaluated MoveBot.io for migrating data from on-premises SharePoint and SFTP servers to Azure Blob Storage. MoveBot.io offers more capabilities beyond what Microsoft evaluated. For more information, see [Movebot – Data Migration Tool](https://movebot.io/).

### NetApp Data Migrator

NetApp published NetApp Data Migrator to migrate data from various systems to NetApp compatible systems like Azure NetApp Files.
Learn more: [NetApp Data Migrator](azure/storage/solution-integration/validated-partners/data-management/netapp-data-migrator-guide)

## Azure Data Box

Azure Data Box allows you to copy your data to it, ship it physically, and have the data automatically hydrated into your storage account. Data Box has recently been updated with more capacity, faster speeds, and more connectivity options.

Azure Data Box Disk is a SATA SSD that can be connected via SATA or USB to a PC, and upon receipt at Azure, data is hydrated into the storage account. Two variants are available: one is encrypted with BitLocker for use with Windows, and the second is self-encrypted for use with Linux or where an encryption performance impact isn't acceptable.
> [!NOTE]
> Availability differs per region.

> [!NOTE]
> Data must be put into a specific structure so it can be hydrated properly.

Learn more:
- [Azure Data Box overview](/azure/databox/data-box-overview?pivots=dbx-ng)
- [Azure Data Box Disk overview](/azure/databox/data-box-disk-overview)

## Import/Export

Use the Azure Import/Export service to send data to and receive data from Azure using your own SATA SSDs. However, encryption is mandatory for security reasons.
Learn more: [Using Azure Import/Export to transfer data to and from Azure Storage](/azure/import-export/storage-import-export-service)

## Tapes

Microsoft is working with TapeArk to allow customers to migrate data on tapes to Azure. Tapes are often an obstacle to decommissioning a data center. This service aims to resolve that issue. Additionally, much of the data that was stored on tapes for cost reasons is an invaluable asset for AI. With this service, data can be brought back online and used.
