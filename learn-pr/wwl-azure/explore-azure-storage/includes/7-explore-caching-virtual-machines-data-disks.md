When you mount disks to VMs, you can choose whether the I/O traffic between the VM and those disks located in Azure storage is cached. Standard and premium storage use two different technologies for this type of cache.

## Standard storage

The possible cache types are:

- None
- Read
- Read/Write

## Premium storage

The following caching options exist:

- None
- Read
- Read/Write
- None + Write Accelerator (applicable only to Azure M-Series VMs)
- Read + Write Accelerator (applicable only to Azure M-Series VMs)
