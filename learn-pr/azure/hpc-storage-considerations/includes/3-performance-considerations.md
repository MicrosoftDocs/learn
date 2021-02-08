If you have run HPC workloads, chances are that you have run into the terms **operations**, **block size**, **IOPS**, **throughput**, and **latency**. You've probably considered these factors when choosing storage.

By the end of this section you should have a working understanding of these five performance factors and how they impact your HPC workloads.

## Operations

**Operations** refers to any activity between the host/machine and the file system or disk.

For example, you are probably familiar with these operations that involve an operating system and its local disk:

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

These are listed to provide context for what exactly an operation does.

NFS represents the network-level interaction between a file client and server. You'll notice that some of these operations look similar to the local operations. However, because NFS is a network API, these network operations may involve multiple local operations.

- create (file or link)
- mkdir
- readdir or readdirplus
- getattr
- setattr
- lookup (search for a filehandle in directory)
- link/symlink/readlink
- read
- rename
- remove
- rmdir
- write

### How do operations affect HPC storage?

It is helpful to appreciate how operations impact your storage system. For example, if your HPC workload creates a large number of small files in nested directory structures, your workload will require a significantly greater number of operations than it would for a workload that reads a few large sequential files.

We will discuss these access patterns in the next unit. For now, note that a `create` involves multiple operations, and so the more file creates your workload does, the greater the impact on performance.

## Block size

**Block size** refers to the smallest data size a file system can read or write (in bytes) as one operation.

For our purposes, block size also refers to the payload size of a NFS data chunk (read/write) that can be transmitted between NFS clients and servers.

NFS servers and clients negotiate the block size, accepting the largest size both can support. Default settings can range from 4 KB to 64 KB, and the current maximum configurable value is 1 MB. Individual data packets can have payloads no larger than the set value.

Block size can be explicitly configured on clients. Check the full `mount` statement on your HPC cluster machines to determine what the value is. If the sizes are not explicitly set the default sizes will be set.

The two arguments used to configure NFS block size are `rsize` (reading size) and `wsize` (writing size)

If you have configured a small block size (or your choice of file systems has a small maximum block size), but your workload consists of large files, performance will suffer due to the additional chunking of those large files (to fit the block size).

## IOPS

**IOPS** stands for "Input/output operations per second". The number of IOPS in your storage environment depends on the following attributes:

- The type of storage media - for example, hard disk drives (HDD) versus solid-state drives(SSD)
- Latency, usually introduced via network connectivity
- The block size used by the file system
- The amount of concurrent access available to the file system

A storage solution has a single IOPS number. As an example, if you are using an Azure Managed Disk that states it supports 5000 IOPS, that means that you can have up to 5000 operations per second total. However, IOPS measures the *total* maximum for all read or write operations against that disk, including system overhead reads and writes. 

IOPS are a guide to the possible maximum number of operations that your disk or NAS environment can support.

The measurements are typically broken down between **Random** and **Sequential** read and write operations.

- Random operations refer to the reading or writing of data at different, random points of a disk or file - for example, editing a specific range of bytes somewhere in a file.
- Sequential operations reflect contiguous access of file, reading it from the start of the file.

## Throughput

**Throughput** refers to the total possible transfer rate the file system can handle, measured in bytes per second.

To do a basic calculation of throughput, multiply the system's IOPS x block size.

For example, if you have a disk that supports 3000 IOPS and your block size is 4K, your total possible throughput is 12 MB/s.

This calculation provides a basic understanding of your file system's general performance possibilities. Actual throughput might be quite different, however. Throughput is affected by a variety of factors, including things like network overhead if doing high rates of small file creates or deletes (as one example).

## Latency

**Latency** refers to the measured amount of time it takes to complete an operation. The higher the latency, the higher the likelihood of slower workload runs. 

There can be multiple sources of latency within a single architecture, each contributing to an overall latency impact.

File system latency can occur under the following conditions:

- Slow network connection between client and server
- Congestion on the network, or at the file server, due to a large number of concurrent requests
- Natural latency because of distance between clients and servers (for instance, across a WAN)
- Slow disk subsystem access on the file server itself

Latency is not always consistent or clearly documented. You will need to run tests to determine latency between your HPC cluster machines and the storage endpoint. 

Latency is also a cumulative issue. Network performance might be the one contributor, but there also might be other factors, like a misconfigured machine operating system, or inefficiencies in the workload code itself. Each of these factors will impact overall latency.

Latency is the most important factor when assessing your file system's actual performance. Higher latencies translate into fewer IOPS. Fewer IOPS can translate into lower throughput.

## Test and calculate baseline values

When choosing the exact performance configuration for HPC workloads, the workload itself has a large influence. 

Azure file system offerings will present expected IOPS and throughput values. If you choose to build your own NAS solution, you would use the metrics documented for each virtual machine SKU as well as the metrics provided for the managed disks you would be using.

You can use a local datacenter HPC configuration as a starting point for performance expectations, but keep in mind that cloud solutions allow for creating multiple environments that run workloads, and so you might have more per-workload flexibility when building in Azure. By contrast your local environment was built based on a specific capacity that is not easily (dynamically) expanded.

You will want to use basic tools such as `ping`, `fio`, `iozone`, and `iometer` to determine some of your Azure file system's baseline numbers.

## Application profiling

You may have a very I/O intensive workload that requires significant IOPs and throughput to run efficiently. On the other hand your workload may launch, read libraries and source data into memory, and proceed with minimal storage I/O. Perhaps the first workload above writes out intermediate data that must be read by other HPC machines. Each of these dynamics contribute to how you will approach your storage solution. In the case where the workload reads a small amount of binaries and source initially, you will want to ensure that the machines are able to read that data as quickly as possible, thus focusing on reducing read latency. On the other hand, if your workload is writing intermediate, or scratch, information to disks, you'll likely ensure that each HPC machine can quickly access either local disks or a fast shared NAS solution for those writes (depending on which machines may need to read those intermediate writes).

You will likely want to invest in profiling your applications for their use of storage I/O. Profiling will increase in importance as your HPC cluster grows in size and number of workloads.

Profiling involves the use of tools running on your HPC machines and your storage environment that report on the amount, type and size of operations running against your storage environment.

Profiling a workload can be difficult due to the sheer amount of data that may be generated. Running tools such as `iostat` and `sar` can create a lot of output over time; the results need to be analyzed and may require additional parsing of the results, generating histograms, etc.

If you are using a NAS solution you will need to gather stats from the vendor's interface during your profiling runs and correlate that information with the HPC machine data to verify I/O patterns.

There are third party profiling tools available, some specifically offered by HPC application vendors, to help with I/O analysis.