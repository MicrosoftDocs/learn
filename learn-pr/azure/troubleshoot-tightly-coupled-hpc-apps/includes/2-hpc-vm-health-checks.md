Azure provides several automated tests to help identify unhealthy virtual machines (VMs). By using these automated tests, Azure helps you remove unhealthy VMs from the fleet when they're discovered, and before customers have a chance to access them. However, sometimes these automated tests don't catch every unhealthy VM.

> [!NOTE]
> The automated health checks in Azure are continually updated and improved.

Some HPC applications, especially tightly coupled HPC applications, are sensitive to unhealthy VMs. This sensitivity can cause an HPC application to have a runtime failure or run more slowly than expected. The chances that you might encounter an unhealthy VM increase as the scale of your tightly coupled HPC application increases.

As a precaution, you should run your own health checks, especially when you're running tightly coupled HPC applications at scale. Running your own health checks increase the probability that you'll continue to run your HPC applications optimally at scale.

## HPC VM health checks

We recommend that your VM health checks should verify that the following components are working and performing as expected: InfiniBand network, memory, storage, and CPU cores.

### InfiniBand health checks

In most scenarios, measuring point-to-point InfiniBand latency and bandwidth via a ping-pong test (sending and receiving a message) is enough to verify the health of the InfiniBand network.

The *Intel IMP-MPI1 PingPong* test is a useful option, because it's prebuilt and available on the *CentOS-HPC 7.7+* image in Azure Marketplace. There's a version included in the Intel MPI environment and a version in the HPCX MPI environment, though you'll typically get the best latency and bandwidth performance by using the HPCX version. Scripts to run Intel IMP-MPI1 PingPong tests are available in the [IMB-MPI benchmarks project](https://github.com/Azure/azurehpc/tree/master/apps/imb-mpi).

The following table illustrates the expected InfiniBand network latency and bandwidth measured through a HPCX Intel IMB-IMP1 PingPong benchmark on HPC VMs. Values that are outside the following ranges would be considered unhealthy.

| VM SKU | Expected network latency | Expected network bandwidth |
|---|---|---|
| HB120_v2 | &lt; 2 &mu;s | &gt; 23.0 GB/s |
| HC44 | &lt; 2 &mu;s | &gt; 11.5 GB/s |
| HB60 | &lt; 2 &mu;s | &gt; 11.5 GB/s |

Other tools and benchmarks to consider are *osu-micro-benchmarks* and *Mellanox ClusterKit*. The latter is also preinstalled in the CentOS-HPC 7.7+ Azure Marketplace image, in the HPCX environment. Example ClusterKit scripts are available in the [Azure health-check scripts project](https://github.com/Azure/azurehpc/tree/master/apps/health_checks).

### Memory health checks

A good way to verify that a VM's memory is healthy is to measure the memory bandwidth, and *Intel Memory Latency Checker (MLC)* is a useful tool for benchmarking the memory bandwidth. Other options are to build and run the stream benchmark or use ClusterKit, which can also measure memory bandwidth. You can find example scripts in the [Azure health-check scripts project](https://github.com/Azure/azurehpc/tree/master/apps/health_checks).

The following table shows the expected measured memory bandwidth on each of the HPC VMs running Intel MLC. Memory bandwidths that are outside these ranges would be considered unhealthy.

| VM SKU | Expected memory bandwidth |
|---|---|
| HB120_v2 | &gt; 300 GB/s |
| HC44 | &gt; 200 GB/s |
| HB60 | &gt; 250 GB/s |

### Storage health checks

It's important to understand what storage solution you're using and its expected I/O performance, and then verify the expected I/O performance by running an I/O benchmark. You can choose from several I/O benchmark tools:

- [IOR](https://github.com/hpc/ior)
- [FIO](https://github.com/axboe/fio)
- [IOzone](http://iozone.org/)
- [vdbench](https://www.oracle.com/downloads/server-storage/vdbench-downloads.html)

To measure your storage health, you would create the maximum I/O throughput to generate an IOPS benchmark. Then you would compare your measured I/O benchmark results with the expected I/O performance for your storage solution. 

You can find example IOR scripts in the [IOR and mdtest project](https://github.com/Azure/azurehpc/tree/master/apps/ior). You can find example FIO scripts in the [FIO project](https://github.com/Azure/azurehpc/tree/master/apps/fio).

### CPU core health

A great way to verify that your CPU cores are healthy and performing as expected is to measure the maximum floating-point operations per second (FLOPS), and then compare your measured results with the theoretical expected FLOPS.

You can use *High Performance Linpack (HPL)* to measure maximum FLOPS. A side benefit of running HPL is that it can also help to identify some bad memory DIMMS and overall health of the HPC cluster, because it also performs some limited tightly coupled communication testing. 

HPL is often used in HPC datacenters to burn in a new HPC system. You can find example HPL scripts in the [linpack project](https://github.com/Azure/azurehpc/tree/master/apps/linpack).
