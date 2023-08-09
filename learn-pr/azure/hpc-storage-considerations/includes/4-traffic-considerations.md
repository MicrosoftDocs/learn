Target IOPS, throughput, and latency numbers are the important values. But to optimize performance, you also need to determine how your HPC workloads interact with the file system. The next step is to quantify the traffic scale and mix that your file system needs to support.

## Traffic mix considerations

*Traffic mix* refers to the makeup of the HPC workload traffic, in terms of:

- Ratio of read traffic to write traffic. (For example, 100% read, 50% read and 50% write, 100% write.)
- Random versus sequential read/write.
- Checkpoints and snapshots.
- Concurrency.
- File quantity and size.

In the rest of this unit, we look at how this mix of traffic types affects your storage choices.

### Read traffic vs. write traffic vs. create/delete

Read and write operations consume IOPS equally. But the file system you choose might apply high availability to incoming write traffic, which translates into a slower but resilient write throughput.

Performance might be affected if your HPC workload does a large number of metadata-heavy operations. Such as, creating files, renaming directory structures, or deleting files. Creating a file might consume several operations. (Check to see if the file exists, create the file handle, update the directory entry, and so on.)

Your HPC workload might be largely focused on data transformation, so the amount of write traffic might be significant. In that case, you want to prioritize optimization of your write performance.

### Random vs. sequential traffic

Application access drives the type of reading and writing traffic patterns your workload might require.

HPC workloads might be highly parallel, with many computers requesting the same data from a shared file system. Or they might be unique and serialized, with unique and random data access patterns. Sequential traffic performance is greater than random traffic. An example of sequential traffic would be the loading of a binary library or a large image or video file by one or more computers. An example of random traffic would include requests for different byte ranges of a single file or multiple files, as opposed to reading an entire file.

### Checkpoints and snapshots

Workloads are often *checkpointed*. In checkpointing, the state of the application and its data are copied to durable storage, and then the workload continues. Checkpointing is used to resume long-running workloads without the need for a complete job restart. Checkpointing can also be used with *snapshots*. Snapshots are read-only copies of your file system that are taken at a point in time. Checkpoints can be thought of as application-specific or application-dependent, but snapshots are relevant at the file-system level.

Both checkpoints and snapshots consume IOPS and storage. So they affect the overall performance of the file system, depending on their frequency and the amount of data involved.

## Concurrency

The number of concurrent clients and threads is another factor to consider when you select your file system. Many HPC workloads require significant concurrency during the job startup and results phases, possibly into the hundreds or thousands of threads. For example, a job might initialize across one hundred 16-core machines, each core operating one or two concurrent threads. The thread concurrency in that case could be anywhere from 1,600 to 3,200 threads. These threads might all be reading binaries (libraries, toolchains, and so on) that are required before the job can continue. To minimize the job run time, the underlying storage system needs to be able to provide fast responses to these read requests.

The same job could stop requiring any concurrent access. Or, it could require bursty access of more file data, or write out intermediate results for other threads in the job to read.

## File count and size

When you select file storage, you also need to consider the number and average size of the files. A workload that consumes 2 TB of data has different performance characteristics if that 2 TB consists of one hundred 20-GB files as opposed to 10 thousand 200-MB files. Especially if the 10 thousand files are nested in deep directory structures.

We recommend that you identify the most likely *working set* of data. A working set is the potential maximum file count and file size that you require. Try to identify the maximum and average working set definitions, and use those maximums to guide your planning.

It isn't always easy to define a working set, especially for an environment as opposed to a single HPC workload. For example, one day you might need to create a small simulation against a static set of data. The next day you might need to scale up to do a larger analysis with intermediate outputs and checkpointing.