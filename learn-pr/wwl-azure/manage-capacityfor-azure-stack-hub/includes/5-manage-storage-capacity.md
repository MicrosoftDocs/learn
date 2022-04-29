This unit helps Azure Stack Hub cloud operators monitor and manage the storage capacity of their Azure Stack Hub deployment. The Azure Stack Hub storage infrastructure allocates a subset of the total storage capacity of the Azure Stack Hub deployment as storage services. Storage services store a tenant's data in shares on volumes that correspond to the nodes of the deployment.

As a cloud operator, you have a limited amount of storage to work with. The amount of storage is defined by the solution you implement. The solution is provided by your OEM vendor when you use a multinode solution, or it's provided by the hardware on which you install the Azure Stack Development Kit (ASDK).

Azure Stack Hub only supports the expansion of storage capacity by adding other scale unit nodes.

It's important to monitor the available storage to ensure that efficient operations are maintained. When the remaining-free capacity of a volume becomes limited, plan to manage the available space to prevent the shares from running out of capacity.

Your options for managing capacity include:

 -  Reclaiming capacity.
 -  Migrating storage objects.

When an object store volume is 100% utilized, the storage service no longer functions for that volume. To get assistance in restoring operations for the volume, contact Microsoft support.

## Volumes and shares, containers, and disks

The *storage service* partitions the available storage into separate, equal volumes that are allocated to hold tenant data.

Object store volumes hold tenant data. Tenant data includes page blobs, block blobs, append blobs, tables, queues, databases, and related metadata stores. The number of object store volumes is equal to the number of nodes in the Azure Stack Hub deployment:

 -  On a four-node deployment, there are four object store volumes. On a multinode deployment, the number of volumes isn't reduced if a node is removed or malfunctioning.
 -  If you use the ASDK, there's a single volume with a single share.

The object store volumes are for the exclusive use of storage services. You must not directly modify, add, or remove any files on the volumes. Only storage services should work on the files stored in these volumes.

Because the storage objects (blobs, and so on) are individually contained within a single volume, the maximum size of each object can't exceed the size of a volume. The maximum size of new objects depends on the capacity that remains in a volume as unused space when that new object is created.

When an object store volume is low on free space and actions to reclaim space aren't successful or available, Azure Stack Hub cloud operators can migrate storage objects from one volume to another.

## Containers

Tenant users create containers that are then used to store blob data. Although users decide in which container to place blobs, the storage service uses an algorithm to determine on which volume to put the container. The algorithm typically chooses the volume with the most available space.

After a blob is placed in a container, the blob can grow to use more space. As you add new blobs and existing blobs grow, the available space in the volume that holds the container shrinks.

Containers aren't limited to a single volume. When the combined blob data in a container grows to use 80% or more of the available space, the container enters *overflow* mode. When in overflow mode, any new blobs that are created in that container are allocated to a different volume that has sufficient space. Over time, a container in overflow mode can have blobs that are distributed across multiple volumes.

When 80% (and then 90%) of the available space in a volume is used, the system raises alerts in the Azure Stack Hub administrator portal. Cloud operators should review available storage capacity and plan to rebalance the content. The storage service stops working when a disk is 100% used and no additional alerts are raised.

## Disks

Azure Stack Hub supports the use of managed disks and unmanaged disks in virtual machines, as both an operating system (OS) and a data disk.

**Managed disks** simplify disk management for Azure IaaS virtual machines by managing the storage accounts associated with the virtual machine disks. You only have to specify the size of disk you need, and Azure Stack Hub creates and manages the disk for you.

It is recommended that you use Managed Disks for virtual machine for easier management and capacity balance. You don't have to prepare a storage account and containers before using Managed Disks. When creating multiple managed disks, the disks are distributed into multiple volumes, which helps to balance the capacity of volumes.

**Unmanaged disks** are VHD files that are stored as page blobs in Azure storage accounts. The page blobs created by tenants are referred to as virtual machine disks and are stored in containers in the storage accounts. We recommend you use Unmanaged Disks only for virtual machines that need to compatible with third-party tools only support Azure-Unmanaged Disks.

The guidance to tenants is to place each disk into a separate container to improve performance of the virtual machine.

 -  Each container that holds a disk, or page blob, from a virtual machine is considered an attached container to the virtual machine that owns the disk.
 -  A container that doesn't hold any disks from a virtual machine is considered a free container.

The options to free up space on an attached container are limited.

Cloud operators don't directly operate unmanaged disks, which are attached to virtual machines that tenants might add to a container. However, when you plan to manage space on storage shares, it can be useful to understand how unmanaged disks relate to containers and shares.

## Monitor volumes

Use PowerShell or the administrator portal to monitor volumes so you can understand when free space is limited. When you use the portal, you receive alerts about volumes that are low on space.

As a cloud operator, you can monitor the storage capacity of a volume using the PowerShell `Get-AzsVolume` cmdlet. The cmdlet returns the total and free space in gigabyte (GB) on each of the volumes.

:::image type="content" source="../media/add-additional-scale-unit-nodes-image-1-f50ebede.png" alt-text="Image showing total and free space.":::


 -  **Total capacity**: The total space in GB that's available on the share. This space is used for data and metadata that's maintained by the storage services.
 -  **Remaining capacity**: The amount of space in GB that's free to store the tenant data and associated metadata.

### As a cloud operator, you can use the administrator portal to view the storage capacity of all volumes.<br>

1.  Sign in to the Azure Stack Hub administrator portal (`https://adminportal.local.azurestack.external`).
2.  Select **All services &gt; Storage &gt; Volumes** to open the volume list where you can view the usage information.:::image type="content" source="../media/add-additional-scale-unit-nodes-image-2-4687c941.png" alt-text="Image showing storage volumes from the Stack Hub administrator portal.":::
    

 -  **Total**: The total space available on the volume. This space is used for data and metadata that's maintained by the storage services.
 -  **Used**: The amount of data that's used by the all the extents from the files that store the tenant data and associated metadata.

## Manage available space

When it's necessary to free space on a volume, use the least invasive methods first. For example, try to reclaim space before you choose to migrate a managed disk.

### Reclaim capacity.

You can reclaim the capacity that's used by tenant accounts that have been deleted. This capacity is automatically reclaimed when the data retention period is reached, or you can act to reclaim it immediately.
