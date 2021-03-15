NFS evolved from the enterprise, designed to handle concurrent file access at growing scale. However, there is an upper bound of performance and scale one can achieve with NFS solutions. There are also classes of workloads that require far greater parallel access of files, including the ability to write to some section of a file by multiple concurrent processes. 

The need to read and write at large scales has grown significantly over the past two decades, and parallel file system solutions are the main choice for accelerating the largest high-performance workloads. Originating in supercomputing centers, parallel file systems are now widely deployed for various scenarios, such as seismic processing and interpretation solutions used by major oil and gas companies, or secondary/tertiary analysis of genomic data.

This unit is a light treatment on parallel file systems; chances are those of you who have been running such workloads are well acquainted with the drivers, need, and architecture of such solutions. There is a gray area between distributed NAS solutions serving NFS and parallel file systems where the use of such technology may better satisfy your requirements.

Once you complete this unit, you will be more familiar with the main parallel file system features.

Note that parallel file systems have historically been a full class of capability that requires in-depth knowledge of application I/O and so this information is here to help build understanding, not expertise.

## Distributed NAS(NFS) vs parallel file systems ##

Both Distributed NAS and parallel file systems are shared file systems; files can be read by multiple clients concurrently, files can be written to, locked, metadata can be modified, etc.

They can both be scaled by adding or upgrading storage hardware technologies, adding "front-end" servers to scale client access, or improving network connectivity.

![A diagram contrasting Network-Attached Storage and Parallel File System architectures](../media/nas-vs-pfs.png)

### Parallel I/O ###

Parallel file systems break up files into discrete blocks or stripes and distribute these files across multiple storage servers. While there are distributed file systems that stripe data, the difference is that parallel file systems then expose stripes directly to clients, via communication with the hosting storage servers themselves. Striping allows for significant parallel I/O over a standard distributed NAS system. NFS clients running with the most common scale-out NAS environments must access a file via a single server. Clients accessing a single server causes issues when the number of *concurrent requests* grow beyond what that server can handle. Further, parallel file systems approach to parallel access and striping makes them a great fit for workloads where the need to is access large files across large numbers of concurrent clients.

Three major parallel file systems are IBM's GPFS (known as Spectrum Scale), Lustre (which is open source with some commercial implementations) and BeeGFS. These systems achieve parallel I/O differently, with GPFS using servers known as Network Storage Devices (NSDs) that connect to a high-performance Storage Area Network (SAN), which means GPFS servers have raw disk I/O as their backing storage. BeeGFS has many of the same architectural components as Lustre, but also has a robust distributed metadata architecture. BeeOND, shorthand for "BeeGFS On Demand" enables on-demand BeeGFS environments that use storage on each client. Such temporary file system environments can be used for burst buffering.

In both cases however, parallel file systems can scale by adding more storage servers, which in turn offer more parallel I/O to clients. It also means that total client count can be significant, ranging into the tens of thousands.


#### Metadata ####

NFS clients interface directly with an NFS server, which provides metadata information and retrieves data on behalf of the clients. The server component must be sized according to the quantity of clients and the anticipated rate of traffic, and can become a bottleneck. NAS vendors can implement some metadata optimizations, but most NFS implementations do not recognize a separate metadata service.

Parallel file systems, by contrast, typically implement strategies to better scale client data access. Lustre, for example, implements a separate metadata server (MDS) and clients retrieve all metadata from that system. Further, Lustre clients are able to directly access the storage server where a given file is located and are able to read/write multiple parallel threads. This approach allows the architecture to scale bandwidth based on the number of deployed storage servers.

### Block size ###

**Block size** was discussed earlier in the context of NFS. Parallel file system block sizes can be much larger than NFS. The default rsize/wsize for NFS clients is usually 64K; Lustre, as one example, has block sizes in the MBs. This larger size has two effects. First, the reading/writing of large files is superior in a parallel file system. On the other hand, parallel file systems offer little advantage when the file sizes are small and the number those files is high.

### Complexity ###

Distributed file system solutions running NFS are easy to set up and run for common use cases. Like any system, they can be tuned for performance, including manipulating client-server block sizes (rsize/wsize) based on workloads. 

Parallel file systems typically operate against complex workloads in scale environments and are more likely to require configuration and tuning to ensure sufficient performance and scale.

## Deployment considerations ##

Today, Azure offers several roll-your-own parallel file system offerings. You can go to the Azure Marketplace to see the options, which include BeeGFS, Lustre (search for Whamcloud). You can also install Lustre on standard Linux Virtual Machines, or you can use of the ARM templates found at our Azure Quickstart site: https://azure.microsoft.com/en-us/resources/templates/?term=lustre
