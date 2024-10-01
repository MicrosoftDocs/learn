By calculating performance baselines for your server environment, you can interpret real-time monitoring information more accurately. A baseline for a server's performance indicates what performance-monitoring statistics indicate during normal use. You can establish a baseline by monitoring performance statistics over a specific period.

> [!TIP]
> When an issue or symptom occurs in real-time, you can compare baseline statistics to real-time statistics and then identify anomalies.
## Perform trends analysis

You should consider the value of performance data carefully to ensure that it reflects your server environment. Additionally, you should gather performance data that you can use to plan for business or technological growth, and then create upgrade plans. For example, following a trend analysis, you might be able to reduce the number of servers that are in operation.

By analyzing performance trends, you can predict when existing capacity is likely to be exhausted. Review historical analysis along with your business requirements, and then use this data to determine when more capacity is required. Consider that in typical scenarios, peaks in activity are likely to occur from time to time. These peaks could make a capacity increase necessary to meet the demands being imposed on your infrastructure.

> [!TIP]
> Some peaks are associated with one-time activities, such as extremely large orders. Other peaks occur on a regular basis, such as monthly payroll processing. 
## Consider capacity planning

Planning for future server capacity is a best practice for all organizations. Planning for business changes often requires more server capacity to meet targets. If you can align your IT strategy with your business strategy, you can better support business objectives.

> [!TIP]
> Consider virtualizing your environment to reduce the number of physical servers that you require. You can consolidate servers by implementing the Hyper-V role in a Windows Server environment.
Capacity planning focuses on assessing:

- Server workload

- The number of users that a server can support

- The ways to scale systems to support more workload and users in the future

New server applications and services affect the performance of an IT infrastructure. These services could receive dedicated hardware, although they often use the same local area network (LAN) and wide area network (WAN) infrastructure. Planning for future capacity should include all hardware components and how new servers, services, and applications affect the existing infrastructure. You should consider how your servers can scale up and out to support an increased workload.

> [!IMPORTANT]
> Factors such as power, cooling, and rack space are often overlooked during initial planning for capacity expansion.
Tasks such as upgrading to a newer version of Windows Server might affect the performance of your servers and network. An update can sometimes cause problems with applications that might be incompatible with Windows Server. Careful performance monitoring before and after applying updates can help identify and rectify these problems.

An expanding business can require an infrastructure to support a growing number of users. You should consider your organization's current and anticipated business requirements when purchasing hardware. This helps you to meet future business requirements by increasing the number of servers or by adding capacity to existing hardware when needed.

Additional capacity requirements can include:

- Adding more servers

- Adding hardware

- Reducing application loads

- Reducing the number of users that connect to a server

## Understand bottlenecks

A performance bottleneck occurs when a computer is unable to service requests for a specific resource. The resource might be a key component such as a disk, memory, processor, or network. Alternatively, the shortage of a component within an application package might cause the bottleneck. By regularly using performance-monitoring tools and comparing the results to your baseline and historical data, you can often identify performance bottlenecks before they affect users.

After identifying a bottleneck, you must decide how to remove it. Your options for removing a bottleneck include:

- Adding resources to the computer.

- Reducing workload on the computer.

A computer that suffers from a severe resource shortage might stop processing user requests.

> [!TIP]
> This requires immediate attention. 
However, if your computer experiences a bottleneck but still works within acceptable limits, you might decide to defer any changes until you resolve the situation or have an opportunity to take corrective action.

## Analyze key hardware components

The four key hardware components are processor, disk, memory, and network. By understanding how your operating system uses these components and how they interact with one another, you'll better understand how to optimize server performance.

### Processor

Processor speed is an important factor in determining your server's overall computing capacity. Processor speed can be defined as the number of operations that can be performed in a measured period. For example, a billion processor cycles per second is one gigahertz (GHz). Servers with multiple processors and processors with multiple cores generally perform processor-intensive tasks with greater efficiency and speed than a single processor or single-core processor computers. Processor architecture is also important.

### Disk

Server hard disks store programs and data. Consequently, the throughput of hard disks affects the speed of a workstation or server, especially when the workstation or server is performing disk-intensive tasks. Some older hard disks have moving parts, and it takes time to position the read/write heads over the appropriate disk sector to retrieve the requested information.

> [!TIP]
> Using SSDs eliminates the problems associated with read/write head positioning. 
Furthermore, disk controller performance and configuration also affect overall disk performance. By selecting faster disks and using disk arrays such as Redundant Array of Independent Disks (RAID) to optimize access times, you can alleviate the potential for a disk subsystem to create a performance bottleneck.

You should also remember that the data on a disk moves into memory before it's used. If there is a surplus of memory, the Windows Server operating system creates a file cache for items that were recently written to or read from the disks. Installing more memory in a server can often improve disk subsystem performance because:

- Accessing the cache is faster than moving the information into memory.

- Having a surplus of memory reduces the need for memory paging.

> [!TIP]
> You can also improve disk performance by implementing SSDs or tiered storage.
### Memory

Programs and data load from a disk into memory before a program manipulates the data. In servers that run multiple programs or where datasets are extremely large, increasing the amount of installed memory can help improve server performance.

Windows Server uses a memory model in which it doesn't reject memory requests by applications that exceed the computer's total available memory. Rather, it performs paging for these requests. During paging, Windows Server moves data and programs in memory that are currently not in use by the processors to the paging file, which is an area on the hard disk. This frees up physical memory to satisfy the excess requests. However, if a hard disk is comparatively slow, it has a negative effect on workstation performance. You reduce the need for paging by adding more memory.

### Network

The network is a critical part for performance monitoring because many network applications depend on the performance of network communications. Poor network performance can cause slow or unresponsive applications and server functionality. Therefore, network capacity planning is very important. While planning network capacity, you must consider bandwidth capacity and the capacity of any network devices, such as router and switch capacity. In many cases, optimizing the configuration of network devices such as switches or routers improves the performance of a network and network applications.

