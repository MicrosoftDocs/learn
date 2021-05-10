We'll introduce overall performance suggestions regarding reference architecture, client VMs, and network running your EDA applications on Azure NetApp Files.

## Gain a high-level understanding of your EDA workload by reviewing a reference architecture

Different EDA tools and chips simulation process may have different reference architecture. The reference architecture below illustrates a generic case how you can use Azure NetApp Files for EDA workloads in both cloud-bursting (hybrid) and fully-on-Azure scenarios.

![Diagram of the reference architecture to illustrate how you can use Azure NetApp Files for EDA workloads.](../media/2-overall-performance-suggestions-01.png)

## Suggestions on VNET, Accelerated Networking, and client update

Reside your client VMs and Azure NetApp Files to be in the same region and same VNET when possible, so to reduce network latency in between.

Enable Accelerated Networking on your client VMs if supported, to provide 30+ Gb/s in networking throughput. Accelerated Networking will not only lower the latency from client VMs to Azure NetApp Files, but also boost overall performance especially on Distributed Multi-Scenario Analysis (DMSA) type of simulation.

It's always the best practice to run the latest OS patch version available, and updating the NFS utilities to their latest releases to get the newest bug fixes and feature functionality, to optimal performance and system stability.

For example:

```bash
sudo yum update
sudo yum update nfs-utils
```
