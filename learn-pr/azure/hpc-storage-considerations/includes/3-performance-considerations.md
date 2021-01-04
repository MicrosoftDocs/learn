The performance requirements for HPC workloads may vary widely depending on a number of variables. The following section highlights the main aspects of file system performance that you must consider when determining your architecture.

## Factors contributing to File System Performance

### Operations

**Operations** refers to any activity between the host/machine and the file system or disk. OS-level operations include the following list:

- File create
- File delete
- File open
- close
- read
- write
- append
- get attribute
- set attribute
- rename

When using the NFS protocol, there are several key API calls that translate into multiple operations

- create (file or link)
- mkdir
- readdir / readdirplus
- getattr
- setattr
- lookup (search for file handle in directory)
- link / symlink /readlink
- read
- rename
- remove
- rmdir
- write

### Block Size

**Block Size** refers to the smallest size of a read or write, in bytes, of a file system. For our purposes, block size also refers to the payload size of a NFS data chunk (read/write) that can be transmitted between NFS clients and servers.

NFS servers and clients negotiate the block size, accepting the largest size both can support. Default settings can range from 4KB to 64KB, with the current maximum configurable value being 1MB. This would translate into individual packets with payloads no greater than the set value.

Block size may be explicitly configured on clients. Check the full `mount` statement on your HPC cluster machines to determine what the value is.

The two arguments used to configure NFS block size are `rsize` and `wsize`, configuring block sizes for reading and writing data respectively.

### IOPS

**IOPS** stands for "Input/Output operations per second", and is a key value when evaluating storage solutions. The number of IOPS will vary depending on the following attributes:

- the type of storage media (Hard Disk Drives (HDD) vs Solid-State Drives(SSD))
- latency, usually introduced via network connectivity
- the block size used by the file system
- the amount of concurrent access to the file system (there is one set of IOPS for all clients)

### Throughput

**Throughput** refers to the total possible transfer rate the file system can handle, measured in bytes per second. The basic calculation for throughput is to multiply IOPS x Block Size. So for example if you have a disk that supports 3000 IOPS and your block size is 4K, your total possible throughput is 12MB/s. This provides a basic understanding of the general performance possibility, but can be affected by a variety of factors, including high rates of small file creates/deletes (as one example).

### Latency

**Latency** refers to the measured amount of time it takes to complete an operation. The higher the latency, the higher the likelihood of slower job runs. There can be multiple sources of latency within a single architecture, each contributing to an overall latency effect.

File system latency may occur under the following conditions:

- Slow network connection between client and server
- Congestion on the network, or at the file server, due to a large number of concurrent requests
- Natural latency due to distance between clients and servers, for instance across a Wide-Area Network
- Slow disk subsystem access on the file server itself

Latency is not always consistent or clearly documented. You will need to run tests to determine latency between your HPC cluster machines and the storage endpoint. Latency is also a cumulative issue, where the network performance may be the sole contributor, but there may also be misconfiguration of the machine operating system, or inefficiencies in the actual workload code itself. Each of these will impact overall latency.

Latency is the most important factor when assessing your file system's actual performance. Higher latencies translate into fewer IOPS. Fewer IOPS may translate into lower throughput.

## Baseline Values

Choosing the precise performance configuration for HPC workloads is highly conditional on the workloads themselves.

Azure file system offerings will present IOPS and throughput values you can expect. If you choose to build your own NAS solution, you would use the metrics documented for each virtual machine SKU as well as the metrics provided for the managed disks you would be using.

You can use your local datacenter HPC configuration as a starting point for performance expectations, but keep in mind that cloud solutions may be more on-demand, and thus you may have more per-workload flexibility when building in Azure.

You will want to use basic tools such as `ping`, `fio`, `iozone` and `iometer` to determine some of your Azure file system's baseline numbers.
