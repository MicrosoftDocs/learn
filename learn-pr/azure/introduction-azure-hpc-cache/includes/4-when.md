This unit addresses when to use Azure HPC Cache. Evaluate whether Azure HPC Cache is appropriate to accelerate storage for an HPC workload.

Here, we'll discuss what workflow elements are best for Azure HPC Cache.

## When to use Azure HPC Cache

Ideal workloads are read-heavy workloads meaning that 90% or more NFS read operations. Similarly, 10% or less of the storage operations are NFS write operations.

Workloads should also involve dozens or hundreds of clients. The more clients you have reading from the same data set, the greater the benefit of caching.

Clients should be as close to the cache as possible. For example, Azure HPC Cache is in Azure so using HPC clients in Azure minimizes latency between the cache and the clients.

Data sets should include megabyte- or ideally gigagbyte-sized files. The working set should be at least 1 terabyte (1 TB) in size.

## Decision criteria

Use Azure HPC Cache when using thousands of compute cores to run read-heavy workloads against a single, static data set using NFS.

Azure HPC Cache would not be the best fit where the data set is constantly changing, there are only a few clients accessing data on a non-NAS server, a large set of the storage calls are write requests, and the file system isn't NFS.

| **Criteria** | **Analysis** |
| --- | --- |
| **Storage** | Data should be stored on NAS like NetApp, EMC Isilon, or Linux storage servers. |
| **Protocol** | Storage should use NFSv3 as its file system protocol. |
| **Read/Write** | Workloads need to be read-heavy. At least 90% of NFS operations need to be read. |
| **Clients** | Hundreds or thousands of compute clients should be in Azure requesting the same data. |
| **Data** | The size of the workload should be at least 1TB. |

## Apply the criteria

Read-heavy NFS workloads on NAS are ideal for Azure HPC Cache. There are times where there may not be a perfect fit but Azure HPC Cache is still a good solution. Let's look at a few scenarios to determine whether Azure HPC Cache should be used.

### Should financial institutions use Azure HPC Cache to run simulations?

Financial simulations are a great fit for Azure HPC Cache. The data set of historic stock market data is unchanging. Hundreds of clients use the same data to run several simulations. The file sizes are gigabytes in size and the total working set is over 1 TB.

### Should end users use Azure HPC Cache for home directories?

Home directories is not a good fit for Azure HPC Cache. The data set is only a few gigabytes in size. Only a single client is accessing the data. The data is often changing. Data is stored in an SMB file system.

### Should Engineering Design Automation (EDA) use Azure HPC Cache to accelerate a tools repository?

Accelerating EDA tools repositories is a good fit for Azure HPC Cache. Several clients use the tools repo while designing and architecting. The repo is large and is accessed via NFS.
