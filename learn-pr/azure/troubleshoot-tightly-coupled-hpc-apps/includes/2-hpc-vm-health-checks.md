Azure provides several automated tests to help identify unhealthy VMs. By using these automated tests, Azure helps you remove unhealthy VMs from the fleet when they are discovered, and before customers have a chacen to access them. However, sometimes these automated tests do not catch every unhealthy VM.

> [!NOTE]
> The automated healthchecks in Azure are continually updated and improved.

Some HPC applications, especially tightly coupled HPC applications, are sensitive to unhealthy VMs, which can cause an HPC application to have a run time failure or run slower than expected. The chances that you may encounter an unhealthy VM increase as the scale of your tightly coupled HPC application increases.

As a precaution, you should run your own health checks, especially when you're executing tightly coupled HPC applications at scale. Running your own health checks increase the probability that you'll continue to run your HPC application optimally at scale.

## HPC VM Health Checks

We recommend that your VM health checks should verify that the following compontents are working and performing as expected: InfiniBand network, Memory, Storage, and CPU cores.

### InfiniBand health checks

In most scenarios, measuring point-to-point InfiniBand latency and bandwidth via a ping pong test (sending and receiving a message) is sufficient to verify the health of the InfiniBand network.

The **Intel IMP-MPI1 Ping Pong** test is a great option, because it's pre-built and available on the **CentOS-HPC 7.7+** image in the Azure Marketplace. There is a version included in the Intel MPI environment, and also a version in the HPCX MPI environment, though you'll typically get the best latency and bandwidth performance using the HPCX version. Scripts to run Intel IMP-MPI1 PingPong tests are available in the [IMB-MPI benchmarks project](https://github.com/Azure/azurehpc/tree/master/apps/imb-mpi).

The following table illustrates the measured expected InfiniBand network latency and bandwidth measured using HPCX Intel IMB-IMP1 PingPong benchmark on HPC VMs. Values that are outside of the following ranges would be considered unhealthy.

| VM SKU | Expected Network Latency | Expected Network Bandwidth |
|---|---|---|
| HB120_v2 | &lt; 2 &mu;s | &gt; 23.0 GB/s |
| HC44 | &lt; 2 &mu;s | &gt; 11.5 GB/s |
| HB60 | &lt; 2 &mu;s | &gt; 11.5 GB/s |

Other tools and benchmarks to consider would be **osu-micro-benchmarks** and **Mellanox Clusterkit**, which is also pre-installed in the CentOS-HPC 7.7+ marketplace image, in the HPCX environment. Some example clusterkit scripts are available in the [Azure health-check scripts project](https://github.com/Azure/azurehpc/tree/master/apps/health_checks).

### Memory health checks

A good way to verify that a VM's memory is healthy is to measure the memory bandwidth, and the **Intel Memory Latency Checker (MLC)** is an ideal tool to benchmark the memory bandwidth. Other options would be to build and run the stream benchmark, or use **Clusterkit**, which can also measure memory bandwidth. Some example scripts can be found in the [Azure health-check scripts project](https://github.com/Azure/azurehpc/tree/master/apps/health_checks).

The following table shows the expected measured memory bandwidth on each of the HPC VMs running Intel MLC. Memory bandwidths that are outside these ranges would be considered unhealthy.

| VM SKU | Expected Memory Bandwidth |
|---|---|
| HB120_v2 | &gt; 300 GB/s |
| HC44 | &gt; 200 GB/s |
| HB60 | &gt; 250 GB/s |

### Storage health checks

It is important to understand what storage solution you're using and its expected I/O performance, and then verify the expected I/O performance by running an I/O benchmark. There are several I/O benchmark tools to choose from:

- [IOR](https://github.com/hpc/ior)
- [FIO](https://github.com/axboe/fio)
- [IOzone](http://iozone.org/)
- [vdbench](https://www.oracle.com/downloads/server-storage/vdbench-downloads.html)

To measure your storage health, you would create the maximum I/O throughput to generate an IOPS benchmark, then compare your measured I/O benchmark results with the expected I/O performance for your storage solution. Some example IOR scripts can be found in the [IOR and mdtest project](https://github.com/Azure/azurehpc/tree/master/apps/ior), and some example FIO scripts can be found in the [FIO project](https://github.com/Azure/azurehpc/tree/master/apps/fio).

### CPU core health

A great way to verify that your CPU cores are healthy and performing as expected is to measure the maximum Floating-point Operation Per Second (FLOPS), and then compare your measured results with the theoretical expected FLOPS.

The **High Performance Linpack (HPL)** is an ideal way to measure maximum FLOPS. A side benefit of running HPL is that it can also help to identify some bad memory DIMMS and overall health of the HPC cluster, because it also performs some limited tightly coupled communication testing. The HPL is often used in HPC data centers to burn-in a new HPC system. Some example HPL scripts can be found in the [linpack project](https://github.com/Azure/azurehpc/tree/master/apps/linpack).
