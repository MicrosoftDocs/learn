As Contoso prepares for the VM migrations, certain scenarios might require sharing of a single VHD between multiple VMs. This typically occurs when you incorporate high availability by using VMs that you configure to support failover clustering. Hyper-V in Windows Server 2019 supports two methods for sharing a VHD between multiple VMs: shared VHDs and VHD Sets.

## Shared VHDs

Windows Server operating systems support the ability to create a VHD in the .vhdx format and connect the file to the SCSI controllers of multiple VMs. These *shared VHDs* must be stored on Cluster Shared Volumes (CSVs) or a file server with Server Message Block (SMB) version 3.0 file-based storage. Sharing a virtual hard disk file (.vhdx) provides the shared storage that's necessary for a Hyper-V guest failover cluster and as such you can deploy a Hyper-V guest failover cluster that's no longer bound to your storage topology.

Typical usages scenarios might include:

- SQL Server database files.
- File server services running within a VM.
- Database files that reside on shared disks.

> [!NOTE]
> The shared virtual hard disk must use the .vhdx file format for the data drive, however the OS disk for a VM can use either the .vhd or the .vhdx file format.

Using a shared VHD with guest failover clustering does pose some limitations, such as:

- The .vhdx disk format doesn't support resizing of the file while the cluster is running. You must shut down the cluster to resize the disk.
- Shared VHDs do not support Hyper-V Replica to replicate the VM failover cluster.
- Backing up the VMs from the host machine isn't supported.

To address these limitations, Windows Server 2016 and later provides the ability to create VHD Sets.

## VHD Sets

A *VHD Set* provides a newer alternative for sharing virtual disk files with multiple VMs. Consider the following factors involved when using a VHD Set:

- Requires Windows Server 2016, Windows 10, or newer.
- Uses the .vhds file format for the shared disk and a .vhdx file as a checkpoint file.
- Supports both fixed-size and dynamically expanding disk types.
- Supports dynamic resizing, which means you can resize an online VHD and avoid having to restart.
- Supports backup at the host level.
- Supports Hyper-V Replica.

> [!TIP]
> You can convert from a shared VHD to a VHD Set by using the `Convert-VHD` Windows PowerShell cmdlet.
