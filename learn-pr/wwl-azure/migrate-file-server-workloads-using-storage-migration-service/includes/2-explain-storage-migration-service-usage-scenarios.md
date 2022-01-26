Storage Migration Service migrates data from multiple sources to either an on-premises Windows Server or a virtual machine (VM) in Microsoft Azure. The graphical management interface is integrated as part of Windows Admin Center. The primary use case for Storage Migration Service is to migrate an existing file server to a new file server. If you're migrating storage to Windows Azure, Storage Migration Service can automate the creation of a VM as the destination for the data.

![Diagram that displays Storage Migration Service architecture with source and destination servers on-premises and in the cloud.](../media/storage-migration-service-diagram.png)

> [!NOTE]
> Storage Migration Service can't be used to consolidate multiple file shares into a single destination file share.

A key benefit of Storage Migration Service is that it can assign the identity of the source server to the target server, including the server name and the server IP addresses. This means that clients configured to access a share on the source server can automatically begin using the migrated data on the target servers. You don't need to update drive mappings or file share names in scripts.

Storage Migration Service can also migrate local user accounts. This can be useful if you have local user accounts created for administrative access or applications.

The general process for using Storage Migration Service is:

1. Inventory source servers

1. Transfer data

1. Cut over identities

After cutting over, the source servers are still functional but aren't accessible to users and apps at the original names and IP addresses. The files are still available to the administrators if required, and you can decommission the source servers when you're ready.

