NFS evolved from the enterprise, designed to handle concurrent file access at growing scale. However, there is an upper bound of performance and scale one can achieve with NFS solutions. There are also classes of workloads that require far greater parallel access of files, including the ability to write to the section of a file at the same time. 

The need to read and write at very large scales has grown significantly over the past two decades, and parallel file systems such as GPFS and Lustre represent the main PFS solutions used to accelerate high-performance workloads. Originating in supercomputing centers, parallel file systems are now widely used for a variety of scenarios, such as seismic processing and interpretation solutions used by major oil and gas companies, or secondary/tertiary analysis of genomic data.

This unit is a light treatment on parallel file systems; chances are those of you who have been running such workloads are well acquainted with the drivers, need and architecture of such solutions. There is a gray area between distributed NAS solutions serving NFS and parallel file systems where the use of such technology may better satisfy your requirements.

Once you complete this module you will be more familiar with the main parallel file system drivers.

Please note that parallel file systems have historically been a full class of capability that requires in-depth knowledge of application I/O and so this information is simply to help build understanding, not expertise.

## Distributed NAS(NFS) vs Parallel File Systems ##

Both Distributed NAS and Parallel File Systems are shared file systems; files can be read by multiple clients concurrently, files can be written to, locked, metadata can be modified, etc.

They can both be scaled by adding or upgrading storage hardware technologies, adding "front-end" or improving network connectivity.

One key difference is that Parallel File Systems break files up into discrete blocks or stripes and distributes across multiple storage nodes. While there are NAS technologies that stripe data, the difference is that Parallel File Systems expose access to those stripes directly to clients. This allows for significant parallel I/O over a standard distributed NAS system.

Parallel file systems also offer the ability to concurrently read and write to the same byte range of a file. 

By facilitating parallel access at scale, parallel file systems are the main option for workloads requiring high levels of parallelism.

The throughput typically associated with parallel file systems often ranges into the hundreds of Gigabytes per second. 


    profiling tool
    MPI
    data is accessed across multiple storage devices
    significantly higher bandwidth
    parallel writing to same file
    larger blocksizes stripe size in lustre
    MPI workloads
    Sub-filing


deployment considerations

