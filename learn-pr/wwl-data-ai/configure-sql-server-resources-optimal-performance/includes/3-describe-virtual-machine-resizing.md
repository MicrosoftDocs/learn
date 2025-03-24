There are many size options for Azure Virtual Machines. For SQL Server workloads the main characteristics to look for are the amount of memory available, and the number of input and output operations (IOPs) the virtual machine can perform. 

## Using constrained cores 
 
Typically, SQL Server licenses are based on the number of cores, and Azure allocates a fixed ratio of CPU cores to memory. However, some workloads may require large amounts of memory without needing the default number of allocated CPUs. In such cases, using Azure's constrained cores can be beneficial.

With constrained cores, you can reduce the cost of software licensing while still getting the full amount of memory, storage, and I/O bandwidth. This is good for database workloads that aren't CPU-intensive and can benefit from high memory, storage, and I/O bandwidth, while using a constrained vCPU count.

## Using general purpose virtual machines 

Most SQL Server production workloads run on the general purpose or memory-optimized families of Azure Virtual Machines. Larger workloads requiring more memory and/or CPU resources land in memory-optimized virtual machines, but many production applications can run comfortably on general purpose virtual machines. 

## Resizing virtual machines 

Azure supports resizing your virtual machine. This operation does require a restart; however, restarting a virtual machine is typically a fast process. In some cases, depending on what virtual machine type you're switching to and from, you may need to deallocate your virtual machine and then resize. This operation does extend the duration of the outage but shouldn't take more than a few minutes.
