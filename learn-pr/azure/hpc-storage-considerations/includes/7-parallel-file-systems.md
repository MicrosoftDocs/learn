NFS evolved from the enterprise, designed to handle concurrent file access at growing scale. However, there is an upper bound of performance and scale one can achieve with NFS solutions. There are also classes of workloads that require far greater parallel access of files, including the ability to write to the section of a file at the same time. 

The need to read and write at very large scales has grown significantly over the past two decades, and parallel file systems such as GPFS and Lustre represent the main PFS solutions used to accelerate high-performance workloads. Originating in supercomputing centers, parallel file systems are now widely used for a variety of scenarios, such as seismic processing and interpretation solutions used by major oil and gas companies, or secondary/tertiary analysis of genomic data.

This unit is a light treatment on parallel file systems; chances are those of you who have been running such workloads are well acquainted with the drivers, need and architecture of such solutions. There is a gray area between distributed NAS solutions serving NFS and parallel file systems where the use of such technology may better satisfy your requirements.

Once you complete this module you will be more familiar with the main parallel file system features.

Please note that parallel file systems have historically been a full class of capability that requires in-depth knowledge of application I/O and so this information is simply here to help build understanding, not expertise.

## Distributed NAS(NFS) vs Parallel File Systems ##

Both Distributed NAS and Parallel File Systems are shared file systems; files can be read by multiple clients concurrently, files can be written to, locked, metadata can be modified, etc.

They can both be scaled by adding or upgrading storage hardware technologies, adding "front-end" servers to scale client access, or improving network connectivity.

### Parallel I/O ###

One key difference is that Parallel File Systems break files up into discrete blocks or stripes and distributes them across multiple storage nodes. While there are distributed file systems that stripe data, the difference is that Parallel File Systems expose storage server access directly to clients. This allows for significant parallel I/O over a standard distributed NAS system. NFS clients running with the most common scale-out NAS environments must access a file via a single server. This causes issues when the number of *concurrent requests* grow beyond what that server can handle.

Two major parallel file systems are IBM's GPFS (known as Spectrum Scale) and Lustre (which is open source with some commercial implementations). These systems achieve parallel I/O differently, with GPFS leveraging servers known as Network Storage Devices (NSDs) that connect to a high-performance Storage Area Network (SAN), which means GPFS servers have raw disk I/O as their backing storage.

#### Metadata ####

NFS clients interface directly with an NFS server, which provides metadata information and retrieves data on behalf of the clients. The server component must be sized according to the quantity of clients and the anticipated rate of traffic, and can become a bottleneck. 

Parallel file systems, by contrast, typically implement strategies to better scale client data access. Lustre, for example, implements a separate metadata server (MDS) and clients retrieve all metadata from that system. Further, Lustre clients are then able to directly access the storage server where a given file is located, able to read/write multiple parallel threads. This approach allows the architecture to scale bandwidth based on the number of deployed storage servers. By contrast, GPFS stores metadata along with data and each client has direct access to this via the NSDs.








Parallel file systems also offer the ability to concurrently read and write to the same byte range of a file.

By facilitating parallel access at scale, parallel file systems are the main option for workloads requiring high levels of parallelism.

The throughput typically associated with parallel file systems often ranges into the hundreds of Gigabytes per second.







    profiling tool
    MPI
    significantly higher bandwidth
    parallel writing to same file
    larger blocksizes stripe size in lustre
    MPI workloads



deployment considerations

