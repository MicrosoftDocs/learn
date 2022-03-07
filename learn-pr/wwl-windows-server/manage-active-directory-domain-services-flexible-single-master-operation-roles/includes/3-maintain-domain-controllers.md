There are operational aspects applicable to every AD DS environment that focus on maintaining business continuity of the authentication services. This includes backup and recovery of domain controllers, and the AD DS objects they host.

## Maintain AD DS domain controller availability

Domain controllers use a multi-master replication process to copy data from one domain controller to another. As a best practice, an AD DS domain should have at least two domain controllers per AD DS site. This makes the AD DS database more available and spreads the authentication load during peak sign-in times.

> [!IMPORTANT]
> For most enterprises, consider two domain controllers per geographical region as the absolute minimum to help ensure high availability and performance.

## Plan for AD DS backup and restore

Maintaining the reliability of the Active Directory data is important. Performing regular backups can play a part in this process but knowing how to restore or recover data after a failure is vital.

### Restoring deleted AD DS objects by using Recycle Bin

Because restoring objects deleted from AD DS by using traditional backup methods involves temporary OS downtime, Windows Server offers the **Active Directory Recycle Bin** feature, which provides a straightforward method to restore deleted objects with no AD DS downtime. After you enable **Active Directory Recycle Bin**, the Deleted Objects container displays in Active Directory Administrative Center. Deleted objects persist in this container until their deleted object lifetime expires. For new AD DS deployments, that lifetime is set to 180 days, but you have the option to change it. You can choose to restore the objects either to their original location or to an alternate location within AD DS.

> [!IMPORTANT]
> You cannot use **Active Directory Recycle Bin** to revert changes to existing objects. In such cases, you must use the traditional methods of backing up and restoring AD DS.

### AD DS backup and restore

To restore AD DS, a backup must explicitly include system state data. *System state* is a collection of critical OS and server role files that include the AD DS database and the registry.

> [!IMPORTANT]
> A full server backup that is used for full server recovery does not support this scenario.

To perform an AD DS restore, you must have full access to the files on the domain controller. This requires restarting the domain controller in DSRM. If you're restarting a domain controller locally, open the advanced startup options and choose the DSRM from the menu.

When you start a domain controller in DSRM, you will sign in as Administrator with the DSRM password. You then can use Windows Server Backup to restore the directory database. After completing the restore process, you must restart the server you are recovering. The domain controller will ensure that its database is consistent with the rest of the domain by pulling from its replication partners the changes to the directory that have occurred since the date of the backup.

#### Nonauthoritative restore

By default, you restore an AD DS backup as of a known good date. Essentially, you roll the domain controller back in time. When AD DS restarts on the domain controller, the domain controller contacts its replication partners and requests all subsequent updates. In other words, the domain controller catches up with the rest of the domain by using standard replication mechanisms.

This type of restore is useful when the directory on a domain controller has been damaged or corrupted, but the problem has not spread to other domain controllers. However, in some scenarios, this approach is not suitable. For example, this will not enable you to recover an object you deleted after the backup took place, if that deletion has replicated to other domain controllers. If you restore a known good version of AD DS and restart the domain controller, the deletion that happened after the backup took place will simply replicate back to the domain controller.

#### Authoritative restore

An authoritative restore allows you to restore a known good copy of AD DS objects, which replaces the current version of these objects in the AD DS database. In an authoritative restore, you start with the same sequence of steps as the nonauthoritative restore. However, before you restart the domain controller, you mark the restored objects that you want to persist as authoritative, so they will replicate from the restored domain controller outbound to its replication partners.
