Backing of critical business data can be a challenging task, primarily because of its size and high volume of changes. Effectively, some of data files might be open or they might be in an inconsistent state. To remediate this challenge, you can use VSS.

## What is VSS?

Backup and restore operations require close coordination between the backup applications, the line-of-business applications that manipulate data being backed up, and the storage management hardware and software. Windows Server Backup uses VSS to perform backups. VSS facilitates communication between these components to optimize their collaboration. VSS coordinates the actions that are necessary to create a consistent shadow copy, also known as a snapshot or a point-in-time copy, of the data that's to be backed up.

VSS solutions have the following basic components:

- VSS service. This is part of the Windows operating system, which ensures that the other components can communicate with each other properly and work together.
- VSS requester. This software requests the actual creation of shadow copies or other high-level operations like importing or deleting them. Typically, this is a backup application, such as Windows Server Backup.
- VSS writer. This component guarantees that you have a consistent dataset to back up. This is typically part of a line-of-business application such as Microsoft SQL Server or Microsoft Exchange Server. The Windows operating system includes VSS writers for various Windows components such as the registry.
- VSS provider. This component creates and maintains the shadow copies. This can occur in the software or in the hardware. The Windows operating system includes a VSS provider that uses copy-on-write.

:::image type="content" source="../media/m16-vscs-components.png" alt-text="The primary components of the VSS architecture." border="false":::

> [!IMPORTANT]
> To take advantage of VSS in combination with SMB file shares, both the SMB client and the SMB server must support SMB 3.0 at a minimum.

> [!NOTE]
> VSS supports volume sizes of up to 64 TB.
