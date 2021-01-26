Installing and configuring iSCSI Target on Windows Server is a relatively straightfoward process. However, it is important to point out that implementation must also include setting up highly performant and highly available network and storage components.

## Implement iSCSI network and storage components

When implementing iSCSI networking, you should use either a separate, dedicated network or configure Quality of Service (QoS) on your existing network. For highly available storage, you can choose between Fibre Channel storage, SCSI storage array or a Storage Spaces Direct cluster, with the iSCSI Target Server configured as a cluster role.

## Implement iSCSI Target Server

In Windows Server, the iSCSI Target Server is available as a File and Storage Services role service. You can install the role service by using Windows Admin Center, Server Manager, or Windows PowerShell. With Windows PowerShell, you can also automate the process of configuring the iSCSI Target, as in the following example:

```powershell
Install-WindowsFeature FS-iSCSITarget-Server
New-IscsiVirtualDisk E:\iSCSIVirtualHardDisk\1.vhdx –size 1GB
New-IscsiServerTarget SQLTarget –InitiatorIds 'IQN: iqn.1991-05.com.Microsoft:SQL1.Contoso.com'
Add-IscsiVirtualDiskTargetMapping SQLTarget E:\iSCSIVirtualHardDisk\1.vhdx
```

## Implement iSCSI initiator

The iSCSI initiator is available by default on all versions of Windows operating systems. To connect it to an iSCSI target, you need to start the corresponding service and configure it. As with iSCSI Target, you can automate this process by using Windows PowerShell, as in the following example:

```powershell
Start-Service msiscsi
Set-Service msiscsi –StartupType 'Automatic'
New-IscsiTargetPortal –TargetPortalAddress iSCSIServer1
Connect-IscsiTarget –NodeAddress 'iqn.1991-05.com.microsoft:netboot-1-SQLTarget-target'
```

## Demonstration

The following video demonstrates how to implement iSCSI.

The main steps in the process are:

1. Create AD DS environment. Create a single-domain AD DS forest including a domain member server with a data disk and a management server.
1. Install the iSCSI Target role service. Use Windows PowerShell to install the iSCSI Target role service on the domain member server.
1. Initialize the data disk, create a new partition, and format it with ReFS. On the domain member server, use Windows PowerShell to initialize the data disk, create a new partition, and format it with ReFS.
1. Review firewall rules to allow iSCSI-related traffic. On the domain member server, use Windows PowerShell to review firewall rules allowing iSCSI-related traffic.
1. Create an iSCSI virtual disk an assign it to the iSCSI target. On the domain member server, use Server Manager to create an iSCSI virtual disk an assign it to the iSCSI target.
1. Connect to the iSCSI Target from the management server. Use iSCSI Initiator to connect to the newly configured iSCSI Target.
1. Validate the presence of a new volume. Use Server Manager to validate the volume mount on the management server.

 >[!VIDEO https://www.microsoft.com/en-us/videoplayer/embed/RE4MxmO]