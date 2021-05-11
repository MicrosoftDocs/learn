Now that you understand how to create and use Azure shared disks, you can migrate your cluster solution from on-premises or build highly available applications that run in the cloud environment.

## Benefits using Azure shared disks

The benefits of shared disks include:

- **Simplified lift and shift.** You can move your existing clustered or distributed solutions to Azure without changes to your architecture.
- **High availability**. Leveraging HA configurations provides better control on application uptime for planned and unplanned failovers. If there's a failure in one VM, the other VMs can maintain full access to the disk.
- **Familiar tools**. You can use familiar tools for creating clustered solutions. The tools include Windows Server Failover Cluster Manager, and Linux Clustering with SBD.
- **Support for SCSI Persistent Reservations**. After mounting the shared disk to your cluster's VMs, establish quorum and read/write to the disk by using SCSI PR which is an industry standard specification.
- **Support for Azure Backup**. Azure Backup natively supports managed disks, including shared disks. It supports backup and restore of both OS and data disks, including shared disks. This support is available regardless of whether they're currently attached to a running Azure VM.

## Limitations of Azure shared disks

Azure shared disk is a new Azure feature that currently has some limitations, including:

- Shared managed disks don't natively offer a fully managed file system that's accessible by using a server message block (SMB) or a NFS. You must use a cluster manager such as Windows Server Failover Cluster (WSFC) or Pacemaker that manages cluster-node communication and write locking.
- Azure shared disks support only certain disk types. Currently, only some Premium SSD sizes and Ultra Disk sizes are supported for shared-disk scenarios.
- You can only use basic disks with some Windows Server Failover Cluster versions.
- Azure Site Recovery support isn't yet available for shared disks.
- When using Availability Sets and Virtual Machine Scale sets, Azure doesn't enforce the storage fault domain alignment with VMs on the shared data disk.
- A disk's **maxShares** value defines how many VMs can share the disk simultaneously. For Ultra disks, the **maxShares** value is 5. For Premium SSDs, it depends on the disk size. The **maxShares** value can vary from 2 to 10.
