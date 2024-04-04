## Overview:

Azure CycleCloud aims to simplify the management of large scale, dynamic HPC environments. As compute sizes increase, and customer workloads become more scalable, it’s essential to ensure that all the VMs deployed for the cluster are available for jobs. 

Node Health checks (NHCs) checks ensure network interfaces, InfiniBand connectivity, and GPUs are functioning properly. It avoids the delays associated with job prologues and custom scheduler integration. This proactive approach prevents users from encountering failures later on.

NHCs are conducted as nodes join the cluster and the process also includes checks during overprovisioning. This verification occurs before the nodes are registered with the scheduler. 

> [!NOTE]
> Starting from CycleCloud v8.5, NHCs can be configured from the CycleCloud Slurm cluster web portal under the _Advanced Settings_ tab. Running NHC will add startup time to healthy nodes which can take up to 10 minutes. For more information on how to enable the NHC, see [Node Health Checks](/azure/cyclecloud/how-to/healthcheck).

Azure CycleCloud supports the new H-series VMs out of the box and N-series, but for the best experience and performance, follow the guidelines and best practices. For more information about CycleCloud supported VMs, see [GPU optimized virtual machine sizes](/azure/virtual-machines/sizes-gpu) and [HPC optimized virtual machine sizes](/azure/virtual-machines/sizes-hpc).

### Minimum requirements for Node Health Checks

| **Requirement** | **Details** |
| :------------------- | :-------------------  | 
| **Operating System** | Ubuntu 20.04, 22.04 <br> AlmaLinux >= 8.6 |
| **CUDA (for GPU SKUs)** | Version >= 12 |
| **AMD Clang Compiler (for Non-GPU SKUs)** | Version >= 4.0.0 |
| **Mellanox OFED Drivers (For IB Related SKUs)** | Required for InfiniBand support |
| **HPC-X MPI (Default in Azure AI/HPC Marketplace Image)** | Version >= v2.11 <br> Automatically installed in the Azure AI/HPC marketplace image |
| **NCCL-Tests** | Clone and build in `/opt/` OR modify environment variable paths in <br> `azure_nccl_allreduce.nhc` and <br> `azure_nccl_allreduce_ib_loopback.nhc` <br> NCCL-Tests are preinstalled in the Azure AI/HPC marketplace image. | 

> [!NOTE]
> Other distributions may work but are not supported.

### Health checks

Many of the hardware checks are part of the default NHC project. If you would like to learn more, check out the [Node Health Checks project](https://github.com/mej/nhc).

The following are Azure custom checks added to the existing NHC suite of tests:

| **Check** | **Component Tested** | **nd96asr_v4 expected** | **nd96amsr_a100_v4 expected** | **nd96isr_h100_v5 expected** | **hx176rs expected** | **hb176rs_v4 expected** |
|:---|:---|:---|:---|:---|:---|:---|
| **check_gpu_count** | GPU count | 8 | 8 | 8 | NA | NA |
| **check_nvlink_status** | NVlink | no inactive links | no inactive links | no inactive links | NA | NA |
| **check_gpu_xid** | GPU XID errors | not present | not present | not present | NA | NA |
| **check_nvsmi_healthmon** | Nvidia-smi GPU health check | pass | pass | pass | NA | NA |
| **check_gpu_bandwidth** | GPU DtH/HtD bandwidth | 23 GB/s | 23 GB/s | 52 GB/s | NA | NA |
| **check_gpu_ecc** | GPU Memory Errors (ECC) | 20 GB | 20 GB | 20 GB | NA | NA |
| **check_gpu_clock_throttling** | GPU Throttle codes assertion | not present | not present | not present | NA | NA |
| **check_nccl_allreduce** | GPU NVLink bandwidth | 228 GB/s | 228 GB/s | 460 GB/s | NA | NA |
| **check_ib_bw_gdr** | IB device (GDR) bandwidth | 180 GB/s | 180 GB/s | 380 GB/s | NA | NA |
| **check_ib_bw_non_gdr** | IB device (non GDR) bandwidth | NA | NA | NA | 390 GB/s | 390 GB/s |
| **check_nccl_allreduce_ib_loopback** | GPU/GPU Direct RDMA(GDR) + IB device bandwidth | 18 GB/s | 18 GB/s | NA | NA | NA |
| **check_hw_topology** | IB/GPU device topology/PCIE mapping | pass | pass | pass | NA | NA |
| **check_ib_link_flapping** | IB link flap occurrence | not present | not present | not present | not present | not present |
| **check_cpu_stream** | CPU compute/memory bandwidth | NA | NA | NA | 665 GB/s | 665 GB/s |

Table doesn't list all the supported SKUs. The scripts for all tests can be found in the [custom test directory](https://github.com/Azure/azurehpc-health-checks/blob/main/customTests).

### Other references

- [LBNL Node Health Checks](https://github.com/mej/nhc).
- [Azure HPC Images](https://github.com/Azure/azhpc-images).
