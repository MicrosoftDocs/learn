


*Cloud tiering* is an optional feature of Microsoft Azure File Sync that helps ensure that on-premises file servers always have enough free space. It can also help ensure that frequently accessed files are cached locally on a file server while all other files are tiered to an Azure file share. When a file is tiered, the File Sync file system filter replaces the file locally with a pointer called *reparse point*, which represents a URL to the file on an Azure file share. When a user requests a tiered file, File Sync seamlessly recalls the file data from Azure Files without the user needing to know that the file date is stored on an Azure file share.

## Configure cloud tiering

You can configure cloud tiering for every server endpoint. If cloud tiering is disabled, which is the default setting, all file data syncs from a cloud endpoint to a server endpoint. After enabling cloud tiering, you can configure two policies as described in the following table.

|Policy|Description|
|------------------------------------------------------------|------------------------------------------------------------|
|**Always preserve the specified percentage of free space on the volume**| For this policy, also called the *volume free space policy*, you specify the percentage of free space that must always be available on the volume on which a server endpoint is located. For example, if volume size is 100 gigabytes (GB) and volume free space is set to 20 percent, up to 80 percent of disk space can be used by files that are most often used. Files that are used less often and would exceed the 20 percent free space threshold get tiered to the cloud endpoint. When a user connects to a server endpoint, all files—including those that are tiered to an Azure file share—are displayed and the user can access them seamlessly.|
|**Only cache files that were accessed or modified within the specified number of days**| This policy, also called the *date policy*, specifies that only the most recently accessed files cache locally. You define the number of days, and if a file isn't read or written to for that many days, it's automatically tiered.|

The volume free space policy always has precedence over the date policy. For example, if the date policy specifies that the files that were accessed in the last seven days should be kept locally and the volume free space policy defines that 20 percent of the volume should be free, the files that were accessed in the last seven days are also tiered if they exceed 80 percent of the volume's free disk space.

If more than one server endpoint is on the same volume (each server endpoint is in a different sync group), the effective free space threshold for the volume is the largest specified free space for the volume across any server endpoint on that volume. For example, if the first server endpoint has a volume free space policy of 20 percent and a second server endpoint has a volume free space policy of 30 percent, the volume will always have at least 30 percent free space.

> [!NOTE]
> Cloud tiering isn't supported on a Windows system volume.

## How cloud tiering works

For cloud tiering, the File Sync system filter builds a map of your namespace on each server endpoint. It monitors access attempts (read and write operations) over time, and then based on both the frequency and recency of access, assigns a heat score to every file. A frequently accessed file that was recently opened is considered hot, whereas a file that's accessed rarely and wasn't opened for a long time is considered cool. When the file volume on a server exceeds the volume's free space threshold, File Sync tiers the coolest files to Azure Files until the free space percentage is met.

With cloud tiering, files can be cached locally or tiered to an Azure file share. Some file formats, such as multimedia files or compressed zip files, can also be in a third state, which is *partially tiered*. In a partially tiered file, only part of the file caches locally. This occurs when you open a tiered file and the file format supports partial read, which means that you can use the file without downloading it completely. For example, you can start referring to a multimedia file, and while you go through it, only the needed parts of the media file cache locally.

### Recognize tiered files

Tiered files are seamlessly accessible, and you can use them in the same way as files that cache locally on a file server. You can recognize a tiered file in several ways, including:

- Tiered files don't use local disk space because they're stored on an Azure file share. Regardless of their actual size, the size on the disk is 0 bytes. In File Explorer, you can observe the file properties, including how much space it takes on the disk. For partially tiered files, the size on the disk is larger than 0 bytes but less than the actual file size.
- Attributes, namely **Offline**, **Reparse point**, and **Recall on data access** are set on tiered files. In File Explorer, you can observe the file properties on the Details tab of the file or by adding the Attributes column.
- Tiered files have reparse pointers set. A *reparse pointer* is a special pointer for the File Sync file system filter. To check whether a file has a reparse point, you can run the following command:

```powershell
fsutil reparsepoint query <file-name>
```

If the file has a reparse point, the output includes "Reparse Tag Value: 0x8000001e".

### Tier or recall files manually

When cloud tiering is enabled, files are automatically tiered based on the volume free space policy and date policy. You can manually force a file to be tiered; for example, if you just saved a large file that you don't intend to use again for a long time and you don't want to wait for the policy to tier the file. You can trigger tiering by running the `Invoke-StorageSyncCloudTiering` cmdlet.

If a file is already tiered and you want to recall it, the easiest way to cache it locally is to open the file, such as by double-clicking or selecting it in File Explorer. You can also run the `Invoke-StorageSyncFileRecall` cmdlet, which can be especially useful if you want to recall multiple files at once.

> [!NOTE]
> The **Previous Versions** feature (snapshots) is compatible with cloud tiering; you can use it to restore previous versions of cloud-tiered files. If a file has the **Recall on data access** attribute set, the antivirus software will scan only the file metadata, but it won't recall the file.
