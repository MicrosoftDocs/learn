Target IOPS, throughput and latency numbers are the important values, but you must also determine how your HPC workloads will interact with the file system to optimize performance. The next step is to quantify the traffic scale and mix your file system will need to support.

## Traffic mix considerations

**Traffic mix** refers to the makeup of the HPC workload traffic, in terms of:

- Ratio of read traffic to write traffic (for example, 100% read, 50% read/write, 100% write)
- Random vs sequential read/write
- Checkpoints and snapshots
- Concurrency
- File quantity and size

In the rest of this unit, we'll see how this mix of traffic types impacts your storage choices.

### Read traffic vs write traffic vs create/delete

IOPS are consumed equally whether the operation is read or write. However, the file system you choose may apply high-availability to incoming write traffic, which translates into a slower, but resilient, write throughput. 

Performance may be impacted if your HPC workload does a large number of metadata-heavy operations, such as creating files, renaming directory structures, or deleting files. A create may consume several ops (checking to see if the file exists, create the file handle, update the directory entry, and so on).

Your HPC workload may be largely focused on transforming data, and so the amount of write traffic may be significant. In this case, you will want to optimize your write performance as the priority.

### Random vs sequential traffic

Application access drives the type of reading and writing traffic patterns your workload may require.

HPC workloads may be highly parallel, with many machines requesting the same data from a shared file system. Or they may be unique and serialized, with unique and random data access patterns. Sequential traffic performance will be greater than random traffic. An example of sequential traffic might be the loading of a binary library or a large image or video file by one or more machines. An example of random traffic might include requests for different byte ranges of a single or multiple files, versus reading the entire file itself.

### Checkpoints and snapshots

Workloads may often be **checkpointed**--the state of the application and its data are copied to durable storage and then the workload continues. Checkpointing is used to resume long-running workloads without requiring a complete job restart. Checkpointing may also be used with **snapshots**, which are read-only copies of your file system taken at a point-in-time. Checkpoints can be thought of as application-specific or application-dependent, while snapshots are relevant to the file system level.

Both checkpoints and snapshots consume IOPS and storage, and so will impact the overall performance of the file system depending on their frequency and the amount of data involved.

## Concurrency

The number of concurrent clients and threads is another factor when selecting the right file system. Many HPC workloads require significant concurrency during the job startup and results phases, possibly into the hundreds or thousands of threads. For example, a job may initialize across 100 16-core machines, each core operating one or two concurrent threads, and so the thread concurrency in this case may be anywhere from 1600 to 3200 threads. These threads may all be reading binaries (libraries, toolchains, etc.) that are required to proceed. The underlying storage system must be able to provide fast responses to these read requests in order to minimize the job run time.

The same job could stop requiring any concurrent access, or require bursty access of more file data, or write out intermediate results that must then be read by other threads in the job.

## File count and size

The number and average size of the files must also be considered when selecting file storage. A workload that consumes 2TB of data will have different performance characteristics if that 2TB consists of 100 20GB files versus 10000 200MB files. Especially if those 10,000 files are nested in deep directory structures.

The recommendation is to identify the most likely **working set** of data. Working set refers to the potential maximum file count and file size you would require. Try to identify the maximum and the average working set definitions and use those maximums to guide your planning.

It isn't always easy to define working set, especially for an environment as opposed to a single HPC workload. For example, one day you may need to create a small simulation against a static set of data, and the next day scale up to do a much larger analysis with intermediate outputs and checkpointing.