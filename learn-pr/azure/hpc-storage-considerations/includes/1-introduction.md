Azure has several file system offerings to satisfy your High Performance Computing workload needs.

Suppose you have a monte carlo simulation job you wish to run in Azure. The simulation in this example runs on a HPC cluster. The simulation code expects a local path (such as /mnt/data/simdata). The data is common for each HPC cluster node. You wish to replicate the run just as you would in your datacenter, with your own HPC Cluster. You wish to enable jobs such as this to run at any time, at any scale, and perhaps multiple jobs at one time.

You need a storage solution that can provide fast, scale-out access to your files. The solution you choose will be driven by a variety of considerations.

Here, you will gain an understanding of those considerations and their implications in Azure.

## Learning objectives

In this module, you will:

- Document the desired file access architecture for your HPC use case.
- Consider the implications of your architecture requirements.
- Compare several file access options.

## Prerequisites  

- Understanding of file systems
- Understanding of shared file systems
- File system permissions and authentication methods
- Understanding of High Performance Computing (HPC), how HPC jobs run, and how HPC interacts with storages
