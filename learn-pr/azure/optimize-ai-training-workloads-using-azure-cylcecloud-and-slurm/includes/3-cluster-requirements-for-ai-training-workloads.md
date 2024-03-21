Running AI training workloads require significant computing and storage requirements as well as making sure the environment can support the intense workloads. 

## Requirements for running AI Training Workloads

| **Requirement** | **Details** |
|---|---|
| **Distributed Training** | |
| **Marketplace Images** | Pre-installed with: |
| **Premium SSDs for OS Disks** | |
| **Accelerated Networking** | |
| **User Home Directories** | |
| **Optional Requirements** | **Container Support** |

- Requires a multi-node environment with a minimum of 4 GPUs. 
- Each node can accommodate a maximum of 8 GPUs. 
- Distribute processing power across multiple GPUs. 
- Large models necessitate substantial memory.
- InfiniBand drivers 
- GPU drivers 
- NCCL libraries/tests 
- MPI libraries
- Utilizes premium SSDs with a larger capacity (60 GB) for OS disks.
  - Faster data access and reduced latency: Premium SSDs enhance read and write speeds, minimizing latency.
  - Shorter training times and faster model convergence: High-speed performance accelerates training iterations.
  - Improved scalability and parallelism: Efficiently handle increased data volumes and parallel processing.
  - Enhanced support for generative AI and large language models: Premium SSDs meet intensive storage requirements.
- Enabled for improved network performance.
- Mounted on either:
  - Azure NetApp Files – single node file storage solution 
  - AMLFS – multi node file storage (high bandwidth, and IOPS workloads)
- Automatic node recovery after reboot. 
- Utilizes local NVMe SSDs.
- Enables GPU persistence mode and GPU app clock frequencies. 
- Local NVMe SSD capacity: 7 TB.
- **Pyxis+enroot integration for GPU container support with the SLURM scheduler.**