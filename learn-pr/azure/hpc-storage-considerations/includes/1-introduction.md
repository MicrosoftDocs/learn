Azure has several file-system offerings to meet your high-performance computing (HPC) workload needs.

Suppose you have a computationally intensive compute job that you want to run in Azure. Assume the job is a simulation that runs on an HPC cluster. The simulation code expects a local path (like /mnt/data/simdata). The data is common for each HPC cluster node. You want to replicate the run just as you would in your datacenter, with your own HPC cluster. You want to enable jobs like this to run at any time, at any scale, and maybe run multiple jobs simultaneously.

You need an HPC storage solution that can provide fast scale-out access to your files.

After you finish this module, you'll understand the major considerations for choosing an HPC storage solution and will be able to create a requirements spreadsheet based on these considerations.

## Learning objectives

In this module, you will:

- Document the desired file-access architecture for your HPC use case.
- Consider the implications of your architecture requirements.
- Compare several file-access architectures.

## Prerequisites  

- Understand file systems
- Understand shared file systems
- Understand file-system permissions, authentication methods, and operations
- Understand high-performance computing, how HPC jobs run, and how HPC interacts with storage
