Data deduplication is a continuous process, which might occasionally require additional oversight, including maintenance and monitoring tasks. It is also important to consider data deduplication in the context of on standard server maintenance tasks, such as backups and restores.

## Running Data Deduplication jobs on demand

You can run Data Deduplication jobs on demand or automatically, according to the default or a custom schedule. These jobs include:

|Job type|To trigger job execution, run (where the *VolumeLetter* parameter represents the target volume)|
|-|--|
|Optimization|```Start-DedupJob –Volume *VolumeLetter* –Type Optimization```|
|Data Scrubbing|```Start-DedupJob –Volume *VolumeLetter* –Type Scrubbing```|
|Garbage Collection|```Start-DedupJob –Volume *VolumeLetter* –Type GarbageCollection```|
|Unoptimization|```Start-DedupJob –Volume *VolumeLetter* –Type Unoptimization```|

> [!IMPORTANT]
> Because Garbage Collection is a processing-intensive operation, you should consider waiting until after the deletion load reaches a threshold to run this job on demand, or you should schedule the job for after hours.

## Configure Data Deduplication schedules

When you enable Data Deduplication on a server, three schedules are enabled by default: optimization is scheduled to run every hour, and Garbage Collection and Scrubbing are scheduled to run once a week. You can access the schedules by using this Windows PowerShell cmdlet ``Get-DedupSchedule``.

These scheduled jobs run on all the volumes on the server. However, if you want to run a job only on a particular volume, you must create a new job. You can create, modify, or delete job schedules from Server Manager or by using the Windows PowerShell cmdlets: ```New-DedupSchedule```, ```Set-DedupSchedule```, or ```Remove-DedupSchedule```.

> [!NOTE]
> Data Deduplication jobs support weekly job schedules at most. If you need to create a schedule for a monthly job or for any other custom period, you'll need to use Windows Task Scheduler. However, you won't be able to use the ```Get-DedupSchedule``` cmdlet to access these custom job schedules that you create in Windows Task Scheduler.

## Backup and restore considerations with Data Deduplication

One of the benefits of using Data Deduplication is that backup and restore operations are faster. This is because you have reduced the used space on a volume, meaning there is less data to back up. Effectively, when you perform an optimized backup, your backup is smaller. This is because the total size of the optimized files, non-optimized files, and data deduplication chunk store files are much smaller than the logical size of the volume.

Restore operations can also benefit from Data Deduplication. Any file-level, full-volume restore operations can benefit because they're essentially a reverse of the backup procedure, and less data means quicker operations. Block-level restore from an optimized backup is automatically an optimized restore because the restore process occurs under Data Deduplication, which works at the file level.

With deduplication in Windows Server, you can back up and restore individual files and full volumes. You can also perform optimized file-level backup and restore using Volume Shadow Copy Service (VSS) writer.

> [!NOTE]
> Many block-based backup systems should work with Data Deduplication, maintaining the optimization on the backup media. File-based backup operations that don't use deduplication usually copy the files in their original format.

> [!TIP]
> As with any product from a third-party vendor, you should verify whether the backup solution supports Data Deduplication in Windows Server.

## Demonstration

The following video demonstrates how to:

- Implement Data Deduplication.
- Review the status of Data Deduplication, including Data Deduplication jobs.

The main steps in the process are:

1. Create AD DS environment. Create a single-domain AD DS forest with a domain member server with a data disk.
1. Install the Data Deduplication role service. Use Server Manager to install the Data Deduplication role service on the domain member server.
1. Enable Data Deduplication on the target volume. Use Server Manager to enable Data Deduplication on the target volume.
1. Copy files to the data volume. Run a batch file to extract files to the volume with Data Deduplication enabled.
1. Review Data Deduplication status. Use Windows PowerShell to review status of Data Deduplication jobs.

 >[!VIDEO https://www.microsoft.com/videoplayer/embed/RE4MFIg]