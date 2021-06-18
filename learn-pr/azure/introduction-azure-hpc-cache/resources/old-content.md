
## Azure HPC Cache

Azure HPC Cache is a managed service that accelerates file-based storage for compute-intensive workloads.
Caching data close to compute clients allows those clients to run more efficiently and complete high-performance tasks faster.

Rather than waiting for responses from either slower storage or across high-latency WAN links, compute clients can quickly access the needed data.

When compute clients are waiting for storage responses, they aren’t computing. Compute cycles are wasted, and charges continue to be incurred when the data can’t get to the clients fast enough.

## How Azure HPC Cache works

Instead of Azure compute clients accessing slower storage directly, clients access Azure HPC Cache for faster access to data.
Azure HPC Cache reads from customer storage and stores frequently-accessed data and stores it in memory and high-speed disks.

![Diagram showing clients connecting to the cache which is then connected to data center storage via Express Route.](../resources/2-what-is-hpc-cache-01.png)

Azure HPC Cache can be configured to access network-attached storage (NAS) in a customer’s data center.
When clients need to access data, they request it from Azure HPC Cache which reads it from the NAS.
When multiple clients read the same data, the cache supplies it faster than NAS.

## When to use Azure HPC Cache

Azure HPC Cache works best for hundreds or thousands of compute clients needing to read terabytes of the same data from file-based NFS workloads that reside on NAS filers like NetApp or EMC Isilon.

A few ideal use cases include:

- Media and entertainment rendering videos
- Financial services running financial simulations
- Life sciences comparing genomic (DNA) sequences

In each of these cases, customers are using thousands of compute cores to run workloads against a single, static data set using NFS.

Azure HPC Cache would not be the best fit in an environment where the data set is constantly changing, there are only a few clients accessing the data, clients are accessing completely different data sets, over 20% of the storage calls are write requests, the data resides on storage other than POSIX storage like NetApp or EMC Isilon, or when SMB is the primary storage protocol.
