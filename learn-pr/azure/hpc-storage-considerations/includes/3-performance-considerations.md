If you've run HPC workloads, chances are that you've seen the terms *operations*, *block size*, *IOPS*, *throughput*, and *latency*. You have probably considered these factors when choosing storage.

By the end of this section, you should have a working understanding of these five performance factors and how they affect your HPC workloads.

## Operations

The term *Operations* refers to any activity between the host/machine and the file system or disk.

For example, you're probably familiar with these operations that involve an operating system and its local disk:

- Create (a file)
- Delete
- Open
- Close
- Read
- Write
- Append
- Get attribute
- Set attribute
- Rename

NFS represents the network-level interaction between a file client and server. Notice that some of these operations look similar to the local operations. But because NFS is a network API, these network operations might involve multiple local operations.

- `create` (file or link)
- `mkdir`
- `readdir` or `readdirplus`
- `getattr`
- `setattr`
- `lookup` (search for a filehandle in a directory)
- `link`/`symlink`/`readlink`
- `read`
- `rename`
- `remove`
- `rmdir`
- `write`

### How do operations affect HPC storage?

It's helpful to understand how operations affect your storage system. For example, assume your HPC workload creates a large number of small files in nested directory structures. In this scenario, your workload would require a higher number of operations than it would for a workload that reads a few large sequential files.

We'll discuss these access patterns in the next unit. A `create` involves multiple operations, so the more files your workload creates, the greater the effect on performance.

## Block size

*Block size* refers to the smallest data size (in bytes) that a file system can read or write as one operation.

For our purposes, block size also refers to the payload size of an NFS data chunk (read/write) that can be transmitted between NFS clients and servers.

NFS servers and clients negotiate the block size and accept the largest possible size they mutually support. Default settings can range from 4 KB to 64 KB. The current maximum configurable value is 1 MB. Individual data packets can have payloads no larger than the set value.

You can explicitly configure block size on clients. Check the full `mount` statement on your HPC cluster machines to determine the value. The default sizes are set. You don't explicitly configure the values in the `mount` statement.

The two arguments used to configure NFS block size are `rsize` (reading size) and `wsize` (writing size).

If you configure a small block size. Or your choice of file systems has a small maximum block size and your workload consists of large files. Performance suffers because of the extra chunking of the large files.

## IOPS

The term *IOPS*, stands for *input/output operations per second*. The number of IOPS in your storage environment depends on these attributes:

- The type of storage media. For example, hard disk drives (HDD) versus solid-state drives (SSD).
- Latency introduced by network connectivity.
- The block size used by the file system.
- The amount of concurrent access available to the file system.

A storage solution has a single IOPS number. For example, if you're using an Azure managed disk that supports 5,000 IOPS, you can have up to 5,000 operations per second. But the IOPS number is a measure of the *total* maximum for all read or write operations against the disk, including system overhead reads and writes.

Your IOPS value is a guide to the possible maximum number of operations that your disk or NAS environment can support.

The measurements are typically broken down between *random* and *sequential* read and write operations.

- A random operation is the reading or writing of data at different, random points of a disk or file. For example, editing a specific range of bytes somewhere in a file.
- A sequential operation is the contiguous access of file, reading it from the start of the file.

## Throughput

*Throughput* refers to the total possible transfer rate the file system can handle, measured in bytes per second.

To do a basic calculation of throughput, multiply the system's IOPS by the block size.

For example, if you have a disk that supports 3,000 IOPS and your block size is 4K, your total possible throughput is 12 MBps.

This calculation provides a basic understanding of your file system's general performance possibilities. But actual throughput might be different. Other factors affect throughput, including things like network overhead if you're creating or deleting a large number of small files.

## Latency

*Latency* refers to the amount of time it takes to complete an operation. The higher the latency, the higher the likelihood of slower workload runs. 

There can be multiple sources of latency within a single architecture, each contributing to an overall latency effect.

File-system latency can occur under these conditions:

- Slow network connection between the client and the server.
- Congestion on the network, or at the file server, caused by a large number of concurrent requests.
- Natural latency because of the distance between clients and servers (for example, across a WAN).
- Slow disk subsystem access on the file server itself.

Latency isn't always consistent or clearly documented. You need to run tests to determine latency between your HPC cluster machines and the storage endpoint.

Latency is also a cumulative problem. Network performance might be one contributor, but there might be other factors, like a misconfigured machine operating system or inefficiencies in the workload code itself. Each of these factors affects overall latency.

Latency is the most important factor when you assess your file system's actual performance. Higher latencies translate into fewer IOPS. Fewer IOPS can translate into lower throughput.

## Test and calculate baseline values

When you choose the exact performance configuration for HPC workloads, the workload itself has a significant influence. 

Azure file-system offerings present expected IOPS and throughput values. If you choose to build your own NAS solution, use the metrics documented for each virtual machine and managed disk SKU.

You can use a local datacenter HPC configuration as a starting point for performance expectations. Keep in mind that cloud solutions allow you to create multiple environments that run workloads. So you might have more per-workload flexibility in Azure. In contrast, your local environment was built based on a specific capacity that's not easily (dynamically) expanded.

You can use basic tools like `ping`, `fio`, `iozone`, and `iometer` to determine your Azure file system's baseline numbers.

## Application profiling

You might have an I/O-intensive workload that requires significant IOPS and throughput to run efficiently. Or your workload might launch, read libraries and source data into memory, and continue with minimal storage I/O. Maybe the first workload in the previous list writes out intermediate data that other HPC machines must read. Each of these dynamics contributes to how you approach your storage solution. To ensure the machines can read that data as quickly as possible, focus on reducing read latency. But if your workload is writing intermediate, or scratch, information to disks, you want to ensure that each HPC machine can quickly access either local disks or a fast-shared NAS solution for those writes. Depending on which machines might need to read those intermediate writes.

You probably want to invest in profiling your applications for their use of storage I/O. Profiling becomes more important as your HPC cluster grows in size and number of workloads.

Profiling involves the use of tools running on your HPC machines and your storage environment. These tools report on the amount, type, and size of operations that run against your storage environment.

Profiling a workload can be difficult because of the amount of data that might be generated. Tools like `iostat` and `sar` can create significant output over time. You might need to analyze the results, and you might need to parse the results further, generating histograms.

If you're using a NAS solution, you need to gather statistics from the vendor's interface during your profiling runs. Then, correlate that information with the HPC machine data to verify I/O patterns.

Third-party profiling tools are available to help with I/O analysis, some offered by HPC application vendors.