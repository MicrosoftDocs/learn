NFS evolved from the enterprise, designed to handle concurrent file access at growing scale. However, there is an upper bound of performance and scale one can achieve with NFS solutions. There are also classes of workloads that require far greater parallel access of files, including the ability to write to the section of a file at the same time. 

The need to read and write at very large scales has grown significantly over the past two decades, and parallel file system solutions are the main choice for accelerating high-performance workloads. Originating in supercomputing centers, parallel file systems are now widely used for a variety of scenarios, such as seismic processing and interpretation solutions used by major oil and gas companies, or secondary/tertiary analysis of genomic data.

This unit is a light treatment on parallel file systems; chances are those of you who have been running such workloads are well acquainted with the drivers, need and architecture of such solutions. There is a gray area between distributed NAS solutions serving NFS and parallel file systems where the use of such technology may better satisfy your requirements.

Once you complete this unit you will be more familiar with the main parallel file system features.

Please note that parallel file systems have historically been a full class of capability that requires in-depth knowledge of application I/O and so this information is simply here to help build understanding, not expertise.

## Distributed NAS(NFS) vs Parallel File Systems ##

Both Distributed NAS and parallel file systems are shared file systems; files can be read by multiple clients concurrently, files can be written to, locked, metadata can be modified, etc.

They can both be scaled by adding or upgrading storage hardware technologies, adding "front-end" servers to scale client access, or improving network connectivity.

### Parallel I/O ###

Parallel file systems break files up into discrete blocks or stripes and distributes them across multiple storage servers. While there are distributed file systems that stripe data, the difference is that parallel file systems then expose stripe access directly to clients, via communication with the hosting storage servers themselves. This allows for significant parallel I/O over a standard distributed NAS system. NFS clients running with the most common scale-out NAS environments must access a file via a single server. This causes issues when the number of *concurrent requests* grow beyond what that server can handle. Further, parallel file systems approach to parallel access and striping makes them a great fit for workloads where the need to is access very large files across large numbers of concurrent clients.

Two major parallel file systems are IBM's GPFS (known as Spectrum Scale) and Lustre (which is open source with some commercial implementations). These systems achieve parallel I/O differently, with GPFS leveraging servers known as Network Storage Devices (NSDs) that connect to a high-performance Storage Area Network (SAN), which means GPFS servers have raw disk I/O as their backing storage.

In both cases however, parallel file systems can scale by adding more storage servers, which in turn offer more parallel I/O to clients. It also means that total client count can be significant, ranging into the tens of thousands.

#### Metadata ####

NFS clients interface directly with an NFS server, which provides metadata information and retrieves data on behalf of the clients. The server component must be sized according to the quantity of clients and the anticipated rate of traffic, and can become a bottleneck. NAS vendors can implement some metadata optimizations, but most NFS implementations do not recognize a separate metadata service.

Parallel file systems, by contrast, typically implement strategies to better scale client data access. Lustre, for example, implements a separate metadata server (MDS) and clients retrieve all metadata from that system. Further, Lustre clients are then able to directly access the storage server where a given file is located, able to read/write multiple parallel threads. This approach allows the architecture to scale bandwidth based on the number of deployed storage servers. By contrast, GPFS stores metadata along with data and each client has direct access to this via the NSDs.

### Block Size ###

** Block Size ** was discussed earlier in the context of NFS. Parallel file system block sizes can be much larger than NFS. The default rsize/wsize for NFS clients is usually 64K; Lustre, as one example, has block sizes in the MBs. This larger size has two effects. First, the reading/writing of large files is superior in a parallel file system. On the other hand, parallel file systems offer very little advantage when the file sizes are very small and the number those files is significantly high.

### Complexity ###

Distributed file system solutions running NFS are easy to set up and run for common use cases. Like any system, they can be tuned for performance, including manipulating client-server block sizes (rsize/wsize) based on workloads. 

Parallel file systems typically operate against complex workloads in scale environments and are more likely to require configuration and tuning to ensure sufficient performance and scale.

## Deployment Considerations ##

Today, Azure offers several roll-your-own parallel file system offerings. You can go to the Azure Marketplace to see the options, which include BeeGFS, Lustre (search for Whamcloud). You can also install Lustre on standard Linux Virtual Machines, or you can use of the ARM templates found at our Azure Quickstart site: https://azure.microsoft.com/en-us/resources/templates/?term=lustre
