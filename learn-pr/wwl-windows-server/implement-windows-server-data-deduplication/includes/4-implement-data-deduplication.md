When you've identified volumes suitable for Data Deduplication, you can proceed with its implementation.

## Implement Data Deduplication

After completing your planning, use the following steps to deploy Data Deduplication to a server in your environment:

1. Install Data Deduplication Windows Server role service by using Windows Admin Center, Server Manager, or the **Add-WindowsFeature** Windows PowerShell cmdlet with the **-Name FS-Data-Deduplication** parameter.
1. Enable Data Deduplication by using Windows Admin Center, Server Manager, or the ```Enable-DedupVolume``` Windows PowerShell cmdlet with the ```–Volume *VolumeLetter* –UsageType *StorageType*``` parameters. The ```StorageType``` placeholder represents the primary type of workload for the volume. The supported values include:

- Hyper-V. A volume hosting Hyper-V storage.
- Backup. A volume hosting virtualized backup servers.
- Default. A general-purpose volume.

## Configure Data Deduplication

The default deduplication settings are usually sufficient for most environments. However, you might need to alter the default settings in the following scenarios:

- Incoming data is static or expected to be read-only, and you want to process files on the volume sooner.
- You have directories that you don't want to deduplicate. Add a directory to the exclusion list.
- You have file types that you don't want to deduplicate. Add a file type to the exclusion list.
- The server has different off-peak hours than the default setting, and you want to change the Garbage Collection and Scrubbing schedules.

> [!NOTE]
> You can use the Windows PowerShell cmdlet ```Set-DedupVolume``` to customize deduplication settings.
