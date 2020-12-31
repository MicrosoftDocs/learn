Knowing your target IOPS, throughput and latency numbers is the important first step, but you must also determine how your hpc jobs will interact with the file system to optimize performance. The next step is to quantify the traffic scale and mix your file system will need to support.

## Traffic mix considerations

**Traffic mix** refers to the makeup of the HPC job traffic, in terms of:

- Ratio of read traffic to write traffic (e.g., 100% read, 50% read/write, 100% write)
- Random vs sequential read/write
- File quantity and size
- Concurrent client access

### Read traffic vs write traffic vs create/delete

IOPS are consumed equally whether the operation is read or write. However, the file system you choose may apply high-availability to incoming write traffic, which translates into a slower write throughput. The media your solution is using (HDD vs SSD) may also have write performance penalties to consider. 

Further, if your HPC workload does a large number of metadata-heavy operations, such as creating files, renaming directory structures or deleting files. A create may consume 2 or more ops.