## Robocopy

Robocopy is a command-line tool that comes with Windows and copies data between SMB shares and local drives. Use it for smaller amounts of data.

> [!NOTE]
> Robocopy is an unmanaged tool. Ensure that you implement proper error handling and that you discover and recover from any transfer errors.

Learn more: [Robocopy](/windows-server/administration/windows-commands/robocopy)

## Rsync and fpsync

You can use Rsync or fpsync to replicate or migrate data to Azure.

> [!NOTE]
> These tools are unmanaged. Ensure that you implement proper error handling and that you discover and recover from any transfer errors.

> [!NOTE]
> Microsoft doesn't support or maintain these tools. Use these tools at your own discretion.

## Independent software vendor (ISV) offerings

### Storage Migration Program

If tools like Azure Storage Mover don't work for you, the Azure Storage Migration Program pays select ISV software license costs to simplify storage migrations. Data must be new to Azure (not already stored there) to qualify.

Learn more:

- [Azure Storage Migration Program details](/azure/storage/solution-integration/validated-partners/data-management/azure-file-migration-program-solutions?source=recommendations)
- [Azure Storage migration tools comparison](/azure/storage/solution-integration/validated-partners/data-management/migration-tools-comparison)

### Rclone

You can use Rclone to replicate or migrate data to Azure. Rclone offers an open source version at [https://rclone.org/](https://rclone.org/). A hardened, commercially supported version is available at [https://rclone.com/](https://rclone.com/).

> [!NOTE]
> These tools are unmanaged. Ensure that you implement proper error handling and that you discover and recover from any transfer errors.

### MoveBot.io

Microsoft evaluated MoveBot.io for migrating data from on-premises SharePoint and SFTP servers to Azure Blob Storage. For more information, see [Movebot – Data Migration Tool](https://movebot.io/).

### NetApp Data Migrator

NetApp Data Migrator migrates data from various systems to NetApp-compatible systems, including Azure NetApp Files.

Learn more: [NetApp Data Migrator](/azure/storage/solution-integration/validated-partners/data-management/netapp-data-migrator-guide)

## Azure Data Box

Azure Data Box lets you copy data to the device and ship it physically. Azure then imports the data into your storage account. Data Box supports high-capacity transfers with multiple connectivity options.

Azure Data Box Disk is a solid-state drive (SSD) that you connect via Serial ATA (SATA) or USB to a PC. When Azure receives the disk, it imports the data into your storage account. Two variants are available:

- One uses BitLocker encryption for Windows.
- The second uses self-encryption for Linux or where an encryption performance impact isn't acceptable.

> [!NOTE]
> Availability differs per region.

> [!NOTE]
> You must organize the data in a specific structure so Azure can import it correctly.

Learn more:

- [Azure Data Box overview](/azure/databox/data-box-overview?pivots=dbx-ng)
- [Azure Data Box Disk overview](/azure/databox/data-box-disk-overview)

## Import/Export

Use the Azure Import/Export service to send data to and receive data from Azure using your own SATA SSDs. Azure requires encryption for this service.

Learn more: [Using Azure Import/Export to transfer data to and from Azure Storage](/azure/import-export/storage-import-export-service)

## Tapes

Microsoft is working with TapeArk to help you migrate tape data to Azure. Tapes are often an obstacle to decommissioning a data center. The TapeArk integration aims to resolve that obstacle. Also, data stored on tapes for cost savings is valuable for AI workloads. With this service, you can bring the data back online and use it.
