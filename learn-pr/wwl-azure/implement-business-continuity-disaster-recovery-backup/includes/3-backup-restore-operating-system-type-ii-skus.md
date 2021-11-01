The OS backup scripts use the ReaR software, which is pre-installed in the server. The Relax-and-Recover (ReaR) packages are pre-installed in the Type II SKUs of HANA Large Instances, and no action is needed from you. You can directly start using the ReaR for the operating system backup. However, in the circumstances where you need to install the packages on your own, you can follow the listed steps to install and configure the ReaR tool.

To install the ReaR backup packages, use the following commands:

 -  For SLES operating system, use the following command:
    
    ```bash
    #zypper install [rear rpm package]
    
    ```
 -  For RHEL operating system, use the following command:
    
    ```bash
    #yum install rear –y
    
    ```

To configure the ReaR tool, you need to update parameters OUTPUT\_URL and BACKUP\_URL in the file /etc/rear/local.conf.

```bash
OUTPUT=ISO

ISO_MKISOFS_BIN=/usr/bin/ebiso

BACKUP=NETFS

OUTPUT_URL="nfs://nfsip/nfspath/"

BACKUP_URL="nfs://nfsip/nfspath/"

BACKUP_OPTIONS="nfsvers=4,nolock"

NETFS_KEEP_OLD_BACKUP_COPY=

EXCLUDE_VG=( vgHANA-data-HC2 vgHANA-data-HC3 vgHANA-log-HC2 vgHANA-log-HC3 vgHANA-shared-HC2 vgHANA-shared-HC3 )

BACKUP_PROG_EXCLUDE=("${BACKUP_PROG_EXCLUDE[@]}" '/media' '/var/tmp/*' '/var/crash' '/h

```

After the provisioning is complete by the Microsoft Service Management team, by default, the server is configured with two scheduled backups of the operating system. You can check the schedule of the backup job by using the following command:

```bash
#crontab –l

```

You can change the backup schedule anytime using the following command:

```bash
#crontab -e

```

## Take a manual backup

The operating system file system backup is scheduled using a cron job already. However, you can perform the operating system file level backup manually as well. To perform a manual backup, run the following command:

```bash
#rear -v mkbackup

```

## Restore a backup

You can restore a full backup or an individual file from the backup. To restore, use the following command:

```bash
#tar -xvf [backup file] [file to restore (optional)]

```

After the restore, the file is recovered in the current working directory.

The following command shows the restore of a file /etc/fstabfrom the backup file backup.tar.gz

```bash
#tar -xvf /osbackups/hostname/backup.tar.gz etc/fstab

```

You need to copy the file to the desired location after it is restored from the backup.
