Running AI training workloads require significant computing and storage requirements to ensure that the environment can support intense workloads. 

## Requirements for running AI training workloads

| **Requirement** | **Details** |
|---|---|
| **Distributed Training** |- Requires a multi-node environment with a minimum of 4 GPUs. <br> - Each node can accommodate a maximum of 8 GPUs.  <br> - Distribute processing power across multiple GPUs. <br> - Large models necessitate substantial memory. |
| **Marketplace Images** | Pre-installed with: <br> - InfiniBand drivers. <br> - GPU drivers.  <br> - NCCL libraries/tests. <br> - MPI libraries.|
| **Premium SSDs for OS Disks** | Utilizes premium SSDs with a larger capacity (60 GB) for OS disks: <br> - Faster data access and reduced latency: Premium SSDs enhance read and write speeds, minimizing latency. <br>  - Shorter training times and faster model convergence: High-speed performance accelerates training iterations. <br>  - Improved scalability and parallelism: Efficiently handle increased data volumes and parallel processing. <br>  - Enhanced support for generative AI and large language models: Premium SSDs meet intensive storage requirements. |
| **Accelerated Networking** |- Enabled for improved network performance. |
| **User Home Directories** |  Mounted on either: <br> - Azure NetApp Files – single node file storage solution. <br>  - AMLFS – multi node file storage (high bandwidth, and IOPS workloads).|
| **Optional Requirements** | - Automatic node recovery after reboot. <br> - Utilizes local NVMe SSDs. <br> - Enables GPU persistence mode and GPU app clock frequencies. <br> - Local NVMe SSD capacity of 7 TB. <br> **Container Support** <br> - The integration of Pyxis and Enroot is designed to facilitate GPU container support in conjunction with the SLURM scheduler.|
