Let's start by understanding the key concepts within Azure HPC Cache. This overview will help you understand how the cache service works.

## What is a storage target?

A storage target is where your data is kept. Often, these are Network Attached Storage (NAS) appliances. There are specific storage targets that the HPC Cache supports like Azure NetApp Files (ANF), physical NetApp appliances, EMC Isilon appliances, or Linux storage servers.

Most high-performance applications use NFSv3 for the file system protocol. HPC Cache uses this efficient protocol to transfer data among the storage target, the cache, and the clients.

![Screenshot of a sample NFS storage target.](../resources/2a-storage-target-example.png)

## Azure HPC Cache definition

Azure HPC Cache is a managed service that accelerates file-based storage for compute-intensive workloads.

Caching data close to compute clients allows those clients to run more efficiently and complete high-performance tasks faster. When compute clients are waiting for storage responses, they aren’t computing. Compute cycles are wasted, and charges continue to be incurred when the data can’t get to the clients fast enough. Rather than waiting for responses from slower storage or from high-latency WAN links, compute clients can quickly access the needed data from the cache.

## How to know if your workload is cacheable

Azure HPC Cache accelerates cacheable workloads. If your HPC workload is cacheable, or one that reuses most of the same data, then a caching service like Azure HPC Cache may be a good fit.

Cacheable workloads have a static set of data that several clients will access at the same time.

For example, if you were running a stock market simulation using historical stock market data, that would be a perfect use for a caching service. The dataset isn't changing and you can have hundreds of compute clients running thousands of scenarios.
