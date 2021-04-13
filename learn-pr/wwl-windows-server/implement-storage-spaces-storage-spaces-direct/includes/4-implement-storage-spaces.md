As part of the implementation of Storage Spaces, you need to provision an appropriate amount and type of storage. You also need to choose the optimal logical sector sizes, drive allocation algorithm, and provisioning scheme.

## Disk sector size

The assignment of the logical sector size takes place when you create a storage pool. If you use only 512 and/or 512e drives, then the pool defaults to 512e. A *512 drive* uses 512-byte sectors. A *512e drive* is a hard disk with 4,096-byte sectors that emulates 512-byte sectors. If the list contains at least one 4-kilobyte (KB) drive, then the pool sector size is 4 KB by default. Optionally, you can explicitly specify the sector size of a pool and enforce it for all of its spaces. Your choices include 512 or 512e for a 512e storage pool, and 512, 512e, or 4 KB for a 4-KB pool.

## Drive allocation

You can configure how a pool allocates drives. Options include:

- Automatic. This is the default allocation when you add any drive to a pool. Storage Spaces can automatically select available capacity on data-store drives for both storage-space creation and JIT allocation.
- Manual. You can specify **Manual** as the usage type for drives that you add to a pool. A storage space won't use a manual drive automatically unless you select it when you create that storage space. This property makes it possible for administrators to specify that only certain Storage Spaces can use particular types of drives.
- Hot spare. Drives that you add as hot spares to a pool aren't available when creating a storage space. Instead, their purpose is to automatically replace failed drives.

## Provisioning schemes

You can provision a virtual disk by using one of two provisioning schemes:

- Fixed provisioning. With fixed provisioning, Storage Spaces allocates all storage capacity you designate at the time that you create the storage space.
- Thin provisioning. With thin provisioning, Storage Spaces allocates storage on as-needed basis, as dataset grows, up to the limit you designate.

## Demonstration

The following video demonstrates how to implement Storage Spaces by using Server Manager.

The main steps in the process are:

1. Create AD DS environment. Create a single-domain AD DS forest with a domain member configured as a file server with four data disks.
1. Create a storage pool. Use Server Manager to create a storage pool.
1. Create a mirrored virtual disk hosting a single volume by using Server Manager. Use Server Manager to create a mirrored virtual disk hosting a single volume.
1. Examine disk properties in Windows Admin Center. Use Windows Admin Center to examine the properties of the provisioned virtual disk and its volume.

 >[!VIDEO https://www.microsoft.com/en-us/videoplayer/embed/RE4MAkL]