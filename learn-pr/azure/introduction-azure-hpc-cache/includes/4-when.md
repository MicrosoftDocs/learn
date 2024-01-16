This unit addresses when to use Azure HPC Cache, to help you evaluate whether HPC Cache is appropriate to accelerate storage for an HPC workload.

Here, we discuss what workflow elements are best for HPC Cache.

## When to use HPC Cache

Ideal workloads for HPC Cache are read-heavy workloads, which means 90 percent or more NFS read operations. Similarly, 10 percent or less of the storage operations are NFS write operations.

Workloads should also involve dozens or hundreds of clients. The more clients you have reading from the same dataset, the greater the benefit of caching.

Clients should be as close to the cache as possible. For example, HPC Cache is in Azure, so using HPC clients in Azure minimizes latency between the cache and the clients.

Datasets should include megabyte- or ideally gigagbyte-sized files. The working set should be at least 1 terabyte (TB) in size.

## Decision criteria

Use HPC Cache when you plan on using thousands of compute cores to run read-heavy workloads against a single, static dataset using NFS.

HPC Cache wouldn't be the best fit if:

- The dataset is constantly changing.
- Only a few clients are accessing data on a non-NAS server.
- A large set of the storage calls is made up of write requests.
- The file system isn't NFS.

The following table lists criteria for using HPC Cache.

| **Criteria** | **Analysis** |
| --- | --- |
| **Storage** | Data should be stored on NAS like NetApp, EMC Isilon, or Linux storage servers. |
| **Protocol** | Storage should use NFSv3 as its file system protocol. |
| **Read/Write** | Workloads need to be read-heavy. At least 90 percent of NFS operations need to be read. |
| **Clients** | Hundreds or thousands of compute clients should be in Azure requesting the same data. |
| **Data** | The size of the workload should be at least 1 TB. |

## Apply the criteria

Read-heavy NFS workloads on NAS are ideal for HPC Cache. There are times when the fit might not be perfect, but HPC Cache is still a good solution. Let's look at a few scenarios to determine whether HPC Cache should be used.

### Should financial institutions use HPC Cache to run simulations?

Financial simulations are a great fit for HPC Cache. The dataset of historic stock market data is unchanging. Hundreds of clients use the same data to run several simulations. The file sizes are gigabytes in size and the total working set is over 1 TB.

### Should users use HPC Cache for home directories?

Using home directories isn't a good fit for HPC Cache. The dataset is only a few gigabytes in size. Only a single client accesses the data. The data is often changing. Data is stored in an SMB file system.

### Should Engineering Design Automation use HPC Cache to accelerate a tools repository?

Accelerating Engineering Design Automation (EDA) tools repositories is a good fit for HPC Cache. Several clients use the tools repo while designing and architecting. The repo is large and is accessed via NFS.
