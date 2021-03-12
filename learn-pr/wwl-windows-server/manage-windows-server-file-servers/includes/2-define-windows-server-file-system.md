Before you can store data on a volume, you must first format the volume. To do so, you must select the file system that the volume should use. Several file systems are available, each with its own advantages and disadvantages.

## What is a file system?

A file system provides a range of features that implement storage and retrieval of files on storage devices. It allows you to organize files in a hierarchical structure and controls their format and naming convention. File systems support a wide range of storage devices, including hard disks and removable media.

All file systems available on Windows operating system consist of the following storage components:

- Files. A file is a logical grouping of related data.
- Directories. A directory is a hierarchical collection of directories and files.
- Volumes. A volume is a collection of directories and files.

## What are the distinguishing features of Windows Server file system types?

The Windows Server file system types include:

- File allocation table (FAT), FAT32, and extended file allocation table (exFAT).
- The NT File System (NTFS).
- Resilient File System (ReFS).

### FAT, FAT32, and exFAT

The FAT file system is the simplest file system available in the Windows operating systems support. It keeps track of file system objects by using a volume-level table. FAT maintains two copies of the table for resiliency. Both tables and the root directory must reside at a fixed location on the formatted disk.

Because of the size limitation of the file allocation table, you cannot use FAT to create volumes larger than 4 gigabytes (GB). To accommodate larger disks, Microsoft developed FAT32, which supports partitions of up to 64 GB.

exFAT is the file system designed for flash drives, with support for volume sizes larger than those available with FAT32. It works with media devices, such as modern flat panel TVs, media centers, and portable media players.

Neither FAT nor FAT32 provide file system-level security. You should not create FAT or FAT32-volumes on disks attached to the servers running any of the Windows Server operating systems. However, you might consider using FAT, FAT32, or exFAT to format external media such as USB flash drives.

> [!TIP]
> Starting with Windows Server 2016, FAT and FAT32 support encryption through the Encrypting File System (EFS).

### NTFS

Traditionally, NTFS has been the most common choice of the file system for the Windows Server operating systems. NTFS offer numerous improvements over FAT, which leverage advanced data structures to improve performance, reliability, and disk space utilization. NTFS also provides built-in security, with such access control capabilities as access control lists (ACLs), auditing, file-system journaling, and encryption. NTFS also supports file system compression and encryption, although they are mutually exclusive so you cannot apply both to the same file or folder.

> [!NOTE]
> NTFS is required when implementing volumes on servers hosting several Windows Server roles and features such as Active Directory Domain Services (AD DS), VSS, and the Distributed File System (DFS).

### ReFS

Microsoft introduced ReFS in Windows Server 2012 to enhance the capabilities of NTFS. One of primary strengths of ReFS, as indicated by its name, is its enhanced resiliency to data corruption through a more accurate detection mechanism and the ability to remediate integrity issues online. ReFS also offers support for larger sizes of individual files and volumes, including their deduplication.

In most cases, ReFS is the optimal file system choice for data volumes in Windows Server 2019. However, you should keep in mind that ReFS doesn't offer full feature parity with NTFS. For example, ReFS doesn't support file-level compression and encryption. It's also not suitable for boot volumes and removable media.

## What are sectors and allocation units?

A sector is the minimum amount of data that can be read or written to a hard drive. Traditionally, sector size has been fixed at 512 bytes. Modern drives support larger sizes, such as 1 KB, 2 KB, or 4 KB. Formatting a volume with a file system combines sectors into logical clusters, also referred to as allocation units. For example, if the sectors of a hard drive are 512 bytes, a 4 KB cluster has eight sectors, and a 64 KB cluster has 128 sectors. If you initiate the formatting process, you have the option of designating the preferred cluster size. Alternatively, you can rely on defaults, which determine the cluster size based on the size of the volume.

Cluster size represents the smallest amount of disk space that can be used to hold a file, based on the format defined by the file system. When file size doesn't match the individual or multiple cluster sizes, this results in some degree of disk space usage inefficiencies. However, choosing a smaller cluster size could negatively impact performance, because reading from or writing to a file might require an increased number of disk operations. Besides choosing the optimal cluster size, you should ensure that the cluster boundaries align with the underlying sectors.

To improve performance, try to match the allocation unit size as closely as possible to the typical file or record size written to or read from the disk. For example, if you have a database that writes 8,192-byte records, the optimum allocation unit size would be 8 KB. This setting would allow the operating system to write a complete record in a single allocation unit on the volume. By using a 4 KB allocation unit size, the operating system would have to split the record across two allocation units and manage updates to the underlying metadata. By using an appropriately sized allocation unit, you can reduce the workload on the server's disk subsystem.
