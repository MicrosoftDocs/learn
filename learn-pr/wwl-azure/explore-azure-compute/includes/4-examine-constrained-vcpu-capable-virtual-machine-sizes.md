Some database workloads like SQL Server or Oracle require high memory, storage, and I/O bandwidth, but not a high core count. Many database workloads aren't CPU-intensive. Azure offers certain VM sizes where you can constrain the VM vCPU count to reduce the cost of software licensing while maintaining the same memory, storage, and I/O bandwidth.

The vCPU count can be constrained to one-half or one-quarter of the original VM size. These new VM sizes have a suffix that specifies the number of active vCPUs to make them easier for you to identify.

For example, the current VM size **Standard\_GS5** comes with 32 vCPUs, 448-GB RAM, 64 disks (up to 256 TB), and 80,000 IOPs or 2 GB/s of I/O bandwidth. The new VM sizes (**Standard\_GS5-16** and **Standard\_GS5-8**) come with 16 and 8 active vCPUs respectively, while maintaining the rest of the specs of the Standard\_GS5 for memory, storage, and I/O bandwidth.

The licensing fees charged for SQL Server or Oracle are constrained to the new vCPU count, and other products should be charged based on the new vCPU count. With the previous example reduction of vCPU leads to a 50% to 75% increase in the ratio of the VM specs to active (billable) vCPUs. These new VM sizes allow customer workloads to use the same memory, storage, and I/O bandwidth while optimizing their software licensing cost.
