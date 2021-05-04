The 3D models used in your engineering organization require many calculations to render and use memory resources intensively. You find that standard virtual machines (VMs) render these models relatively slowly. These delays affect the productivity of your engineers, and you'd like to avoid them.

For high-intensity tasks with specialized requirements, you might need to use specialized VMs. Here, you'll learn about VM tiers in Azure that support specialized, high-performance tasks.

## H-series VMs

As the solution architect for the engineering organization, you've already seen how Azure Batch orchestrates hundreds and thousands of nodes working together in parallel. The emphasis is on the sheer number of VMs that can be orchestrated in parallel. This process means that work is achieved in a fraction of the time. Sometimes, though, you need especially powerful VMs with exceptional CPU, memory, and networking capabilities. In these cases, use Azure VM HPC Instances. HPC Instances is a series of Azure VMs expressly designed for challenging HPC scenarios.

Azure *H-series* VMs are a family of the most powerful and fastest CPU-based VMs on Azure. These VMs are optimized for applications that require high CPU frequencies or large amounts of memory per core. The basic H-series is well suited to genomic research, seismic and reservoir simulation, financial risk modeling, and molecular modeling.

The VMs feature the Intel Xeon E5-2667 v3 Haswell 3.2 GHz CPU with DDR4 memory. Configurations range from 8 cores and 56 GB at the lower end (the H8 SKU) to 16 cores and 224 GB at the higher end (the H16m SKU).

You can use all of these HPC instances with Azure Batch. When you set up a Batch pool, you can specify that H-series VMs should be used.

### HB-series VMs

*HB-series* VMs specifically target applications requiring extreme memory bandwidth, particularly fluid dynamics, explicit finite element analysis, and weather modeling. HB VMs have 60 AMD EPYC 7551 processor cores, with 4 GB of RAM per CPU core and 240 GB of memory overall. HB-series VMs provide more than 260 GB/sec of memory bandwidth. This bandwidth is 33 percent faster than x86 alternatives and 2.5 times faster than is standard for most current HPC customers.

### HC-series VMs

*HC-series* VMs are optimized for applications driven by dense computation, such as implicit finite element analysis, reservoir simulation, and computational chemistry. HC VMs have 44 Intel Xeon Platinum 8168 processor cores, with 8 GB of RAM per CPU core and 352 GB of memory overall. This CPU has 22 cores and 44 threads (when hyper-threading (HT) is enabled). HC-series VMs support Intel software tools such as the Intel Math Kernel Library, and feature an all-cores clock speed greater than 3 GHz for most workloads.

## Remote Direct Memory Access

The H16r and H16mr SKUs of the H-series, and both the HB- and HC-series VMs, use a second, low-latency, high-throughput network interface. It's called Remote Direct Memory Access (RDMA). RDMA enables direct memory access between systems without the involvement of the operating system. On Azure, network connections over an InfiniBand network enable this high-speed access.

Message Passing Interface (MPI) is a protocol for communication between computers as they run complex HPC tasks in parallel. To use it, your developers must use an implementation of the protocol, which is usually a library of routines in a .dll. RDMA can give a significant boost to the performance of MPI applications.

Ask your developers if they're using MPI. If the answer is yes, you should ensure that the VM tier and size you select supports the protocol. Otherwise, your nodes won't communicate at the highest possible speed.

## InfiniBand interconnects

InfiniBand is a data interconnect hardware standard for HPC. It's often used to accelerate communications between components, both within a single server and between servers. It has been designed to support the highest speeds and the lowest latency for messages between CPUs, and between processors and storage components.

Both HC- and HB-series VMs use a router offering 100 GB/sec Mellanox EDR InfiniBand interconnect in a non-blocking tree configuration to boost hardware performance.

## N-series VMs

Some HPC tasks are both compute-intensive and graphics-intensive. Suppose, for example, you're modeling the behavior of a wing in a wind tunnel, and you want to show a live visualization to help engineers understand that behavior. For these applications, consider using N-service VMs, which include single or multiple NVIDIA GPUs. 

### NC-series VMs

*NC-series* VMs use the NVIDIA Tesla K80 GPU card and Intel Xeon E5-2690 v3 processors. This series is the lowest cost of the N-series tiers, but VMs in this tier are capable of graphics-intensive applications. They also support NVIDIA's CUDA platform, so that you can use the GPUs to run compute instructions.

### ND-series VMs

*ND-series* VMs are optimized for AI and deep learning workloads. They use the NVIDIA Tesla P40 GPU card and Intel Xeon E5-2690 v4 processors. They are fast at running single-precision floating point operations, which are used by AI frameworks including Microsoft Cognitive Toolkit, TensorFlow, and Caffe.
