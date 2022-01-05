The directory database stores Active Directory information. Logically, the database consists of several partitions. Physically, the AD DS database is a collection of files on the domain controllers' local file system.

## What is the AD DS database?

The AD DS database is stored as a file named Ntds.dit. When you install and configure AD DS, you can specify the location of the file.

> [!TIP]
> The default location is `%SystemRoot%\NTDS`. 

Within the Ntds.dit file are all the partitions that the domain controller hosts. In the NTDS folder are other files that support the AD DS database. The Edb*.log files are the transaction logs for AD DS. When a change occurs in the directory:

1. It is first written to the log file.

1. The change is committed to the directory as a transaction.

1. If the transaction fails, AD DS rolls back the changes.

The following table describes the different file-level components of the AD DS database.

| File| Description|
| :--- | :--- |
| Ntds.dit| Main AD DS database file. Contains Active Directory partitions and objects.|
| Edb*.log| Transaction logs. Under normal operations, new transactions in the transaction log overwrite old transactions. However, if many transactions occur within a short period, AD DS creates additional transaction log files. Therefore, if you look in the NTDS folder of a particularly busy domain controller, you might see several Edb*.log files.|
| Edb.chk| Database checkpoint file. The Edb.chk file acts like a bookmark in the log files. Edb.chk marks the location before which transactions have been successfully committed to the database, and after which transactions remain to be committed.|
| Edbres00001.jrs, Edbres00002.jrs| Reserve transaction log files. If a disk drive runs out of space, AD DS cannot write to the logs. So, AD DS maintains two extra log files, Edbres00001.jrs and Edbres00002.jrs. When a disk runs out of space for normal transaction logs, AD DS recruits the space used by these two files to write the transactions that are in a queue currently. After that, it safely shuts down Active Directory services, and dismounts the database.|

## Manage the AD DS database with NtdsUtil

NtdsUtil.exe is a command-line executable file that you can use to perform database maintenance, including:

- Creating snapshots

- Relocating database files

- Offline defragmentation

- Perform domain-controller metadata cleanup

- Resetting the password used to sign in to the Directory Services Restore Mode (DSRM).

> [!NOTE]
> You configure this password initially during the configuration of a domain controller.

> [!TIP]
> If you forget the password, you can use the `NtdsUtil.exe set dsrm` command to reset it.

## What is restartable AD DS?

In most scenarios that require Active Directory management, you should restart the domain controller in DSRM. Windows Server enables administrators to stop and start AD DS just like any other service—without restarting a domain controller—to perform some management tasks quickly. This feature is called restartable AD DS. Restartable AD DS reduces the required time to perform certain operations. For example, you can stop AD DS so that you can apply updates to a domain controller.

You can use the following methods to restart AD DS:

- Services console

- Command prompt

- Windows PowerShell

> [!TIP]
> Other services running on the server that do not depend on AD DS to function, such as Dynamic Host Configuration Protocol (DHCP), remain available to respond to client requests while AD DS is stopped. 

Restartable AD DS requires minor changes to the existing Microsoft Management Console (MMC) snap-ins. By using the snap-in, an administrator can stop and restart AD DS more easily, as they would any other service that is running locally on the server. Although stopping AD DS is similar to signing in in DSRM, restartable AD DS provides a unique state, known as AD DS Stopped.

### What are the domain controller states?

The three possible states for a domain controller that is running Windows Server are as follows:

- AD DS Started. In this state, AD DS is started. The domain controller can perform AD DS–related tasks normally.****

- AD DS Stopped. In this state, AD DS is stopped. The domain controller has some characteristics of both a domain controller in DSRM and a domain-joined member server. ****

- DSRM. In this state, the AD DS database (Ntds.dit) on the local domain controller is offline. Another domain controller can be contacted for sign-in, if one is available. If no other domain controller can be contacted, you can do one of the following, by default:

  - Sign in to the domain controller locally in DSRM by using the DSRM password.

  - Restart the domain controller to sign in with a domain account.

As with a member server, the domain controller in the Stopped state is still joined to the domain. Because the domain controller is still joined to the domain, Group Policy and other settings still apply to the computer. However, a domain controller should not remain in the AD DS Stopped state for an extended period because in this state, it cannot service sign-in requests or replicate with other domain controllers.

## Manage AD DS snapshots

An AD DS snapshot is the exact capture of a historical state of the directory service at a certain time. You can use tools to explore the contents of a snapshot to examine the state of the directory service at the time the snapshot was made. For example, you can use the snapshot to browse the contents of the AD DS database as it was during the time of backup. You can use several tools to work with and manage snapshots:

- Use NtdsUtil.exe to create and mount snapshots of AD DS.

- Use the Ldifde command-line tool to connect to a mounted snapshot, and export objects from AD DS.

## Restore Active Directory data

When a domain controller or its directory experiences corruption, damage, or failure, you have several options to restore the system. To perform a restore of AD DS, you must have full access to the files on the domain controller. This requires restarting the domain controller in DSRM.

When you start a domain controller in DSRM, you sign in as Administrator with the DSRM password. You then can use Windows Server Backup to restore the directory database.

After completing the restoration, you must restart the server. The domain controller ensures that its database is consistent with the rest of the domain. The domain controller does this by pulling from its replication partners the changes to the directory that have occurred since the date of the backup.

### Perform nonauthoritative restore

In a normal restoration, you restore a backup of AD DS as of a known good date. Essentially, you roll the domain controller back in time. When AD DS restarts on the domain controller, the domain controller contacts its replication partners and requests all subsequent updates. In other words, the domain controller catches up with the rest of the domain by using standard replication mechanisms.

Normal restoration is useful when the directory on a domain controller has been damaged or corrupted, but the problem has not spread to other domain controllers. However, for certain situations a normal restoration is not sufficient. For example, normal restoration will not work where damage has replicated, such as when you delete one or more objects, and that deletion has replicated. If you restore a known good version of AD DS and restart the domain controller, the deletion—which happened after the backup—simply replicates back to the domain controller.

### Perform authoritative restore

An authoritative restore is necessary when you have restored a known good copy of AD DS and it contains objects that must override existing objects in the AD DS database. In an authoritative restore, you restore the known good version of AD DS just as you do in a normal restore. However, before you restart the domain controller, you mark the accidentally deleted or previously corrupted objects that you wish to retain as authoritative, so that they will replicate from the restored domain controller to its replication partners. When you mark objects as authoritative, Windows increments the version number of all object attributes to be so high that the version is virtually guaranteed to be higher than the version number on all other domain controllers.

When the restored domain controller restarts, it replicates from its replication partners all the changes made to the directory. It also notifies its partners that it has changes, and the version numbers of the changes ensure that partners take the changes and replicate them throughout the directory service.

> [!TIP]
> In forests with Active Directory Recycle Bin enabled, you can use Active Directory Recycle Bin as a simpler alternative to an authoritative restore.

To perform an authoritative restore, complete the following procedure:

1. Restart the domain controller in DSRM.

1. Sign in with the Administrator account and the DSRM password.

1. Restore the directory with Windows Server Backup. Before restarting the domain controller, you must first mark as authoritative the objects that you wish to persist after restart—that is, the deleted objects that you are trying to restore. To mark an object as authoritative, at the command prompt, run the following commands:

    - NtdsUtil.exe

    - authoritative restore

    - restore object \<object DN\>

1. Restart the domain controller.

> [!TIP]
> A DN looks something like this: CN=User name,OU=IT,DC=Contoso,DC=com.

