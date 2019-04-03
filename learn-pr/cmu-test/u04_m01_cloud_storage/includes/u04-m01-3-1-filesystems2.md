<!-- Original file: C:\Users\Mark\Desktop\CMU-source\v_5_3\content\_u04_cloud_storage\_u04_m01_cloud_storage\x-oli-workbook_page\_u04_m01_3_1_filesystems2.xml -->

##  Abstractions in Storage

On a fundamental level, data are stored in <!-- some -->binary encoding on some medium (such as the ones described in the previous page magnetic or solid state media). The challenge is to systematically organize the data in systems<!-- ways --> that are accessible to users and applications. These systems of organization provide abstractions to users and applications <!-- either -->in the form of files on a file system, or as entities in a database.

![Figure 4.6: Various layers of abstraction of data ](../media/layers_abstraction_data-01.png)

_Figure 4.6: Various layers of abstraction of data_


It is important to note that applications can interact with any layer of the abstractions, including the block-level (which is rare for any non-system program). Block devices offer the highest performance but have the least metadata, making it very difficult to write programs using this layer. Many applications interact with a file system, and for applications that require more metadata, database systems may offer a better and more efficient abstraction to manage data.

##  Block Devices

In the previous pages you learned about different types of data and storage devices. Although there will always be data residing in various cache memories to improve performance, eventually it has to be stored on a **persistent** (sometimes called **nonvolatile**) medium such as Magnetic Disks or SSDs. Since these devices typically have a non-trivial architecture and layout, the interface presented to the operating system is a generic **block device**.

A **block** is simply a collection of bytes that is grouped together. The **block size** indicates how many bytes are in that block, such as 512 bytes, 64kiB, or 1MiB. Block sizes are usually represented as a power of 2. A single block is the smallest unit that can be addressed, so all of the bytes in a block must be read or written at the same time. This is similar to how a CPU accesses memory in **words** (either 32 bits or 64 bits) at a time; if you want to modify a single byte of data either in registers or main memory during a CPU instruction, you have to _read_ 8 bytes (in case of a 64-bit CPU), _modify_ 1, and then _write_ the new word (1 new byte + 7 original bytes) back to memory. This process is amplified with blocks, so an application that modifies a single byte requires reading, say, 512 bytes, modifying 1 byte, and then writing back 512 bytes. This is a rare case, since applications typically read a number of contiguous blocks at a time and may be cached somewhere along the memory hierarchy.

A **block device** provides an OS access to blocks through an interface. In practice, block devices can be physical or virtual, and can be local or remote. A taxonomy of block devices along with examples are presented below:

|Local|Remote|
|--|--|--|
|Physical|Internal: HDD, SSD, optical, tape drives. External: direct-attached storage (DAS), removable drives (USB, Firewire, eSATA) |SAN (with one-to-one mapping)|
|Virtual|Software block devices: virtual drives (VHD, VDI, VMDK, CDROM, etc.), RAMDisk |SAN (with thin provisioning, de-duplication). DRBD, block device services: Amazon EBS|


<!-- <em>Physical vs. virtual:</em> -->Physical storage devices correspond to a one-to-one mapping of physical storage blocks to the blocks exposed to the OS. Virtual devices abstract the details of a physical block device from the OS and instead present a virtualized block device to the OS. 

<!-- <em>Local vs. remote:</em> --> **Local storage** refers to block devices that are directly connected to a computer. These can be either internal devices (connected via SCSI or ATA interfaces) or external devices (connected via USB, Firewire, eSATA, etc.). **Remote storage** is storage that is not directly attached to a computer, but is accessed through a network (using protocols such as Fibre Channel (FC) or iSCSI).

Physical block devices that are local to a computer include the common examples of hard disk drives, optical drives, and tape drives that are directly connected either through an internal interface or an external interface. The best example of a physical block device that is connected externally to a computer is a SAN with one-to-one mapping between the blocks allocated on the SAN to the blocks accessed by the OS.

Virtual block devices that are local to a computer include any block device that is represented as a file. Examples include virtual machine disk images such as Virtual Machine Disk (VMDK, VMware’s virtual disk format), Virtual Disk Image (VDI, VirtualBox’s disk format), and Virtual Hard Disk (VHD). 

Remotely accessed virtual block devices include SANs, which export block devices that do not have a one-to-one correspondence with physically allocated blocks. For example, SANs can **thinly provision** a block device of 1TB to a server, but the actual disk space used on the SAN is the exact amount of storage used by the server at the moment. When an OS writes additional data to the block device, the block allocations within the SAN increase. SANs also have features such as de-duplication, which identifies identical blocks and stores only a single copy. 

##  File Systems


One basic abstraction of storage is the concept of **files** and **file systems**. A file, in the context of storage, can be thought of as a block of information that is made available to computer programs. A file system is an abstraction to users and applications that includes the associated data structures to store, retrieve, and update a set of files. A file system typically manages access to its data and **metadata** (metadata is additional information and parameters that describe the files). File systems have a myriad of responsibilities, ranging from space management, naming, metadata management, and access control to<!-- as well as --> maintaining the reliability and integrity of the files stored in the <!-- file -->system.


File systems can be categorized into many types. Figure 4.7 illustrates the hierarchical taxonomy of file systems as defined by the Storage Networking Industry Association (SNIA).

![Figure 4.7: File system taxonomy](../media/fs_taxonomy.png)

_Figure 4.7: File system taxonomy_


Based on their architecture and implementation, file systems can be broadly defined as<!-- into three categories -->

- Local file systems: These are file systems that are designed to be operated on a one or more disks, granting access to a single instance of an operating system to storage devices. Examples include FAT, ext, HFS, ReiserFS etc.
- Shared file systems: These are special purpose file systems that allow multiple disks to be pooled into a group of available block devices to be shared among multiple machines over a network. Examples include IBM's GPFS and SanFS.
- Network file systems: Network file systems are higher-level storage services offered to applications (as opposed to plain block devices in Local and Shared file systems). Examples include CIFS, NFS, among others. We will explore, in detail, a special class of network file systems called Distributed File Systems in this module.

##  Databases

Another layer of abstraction in storage systems is Databases. Databases are typically run on top of file systems, but there are instances where databases are run directly on top of block devices in order to improve performance, but these are rare. As we will see in detail in this module, databases are designed to store and retrieve information for applications. Databases have higher visibility into the data, sometimes allowing for complicated queries and operations on the data. 

### References

1. _Thomas Rivera (2012). The Evolution of File Systems SNIA Tutorial_