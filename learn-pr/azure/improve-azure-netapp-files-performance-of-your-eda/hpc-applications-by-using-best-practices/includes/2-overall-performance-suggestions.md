# Goal

We'll introduce overall performance suggestions regarding reference architecture, client VMs, and network running your EDA applications on Azure NetApp Files.

## Reference Architecture

The reference architectures below illustrate how you can use Azure NetApp Files for EDA workloads in both cloud-bursting (hybrid) and fully-on-Azure architectures.

![Diagram of the reference architecture to illustrate how you can use Azure NetApp Files for EDA workloads.](../media/referencearchitecture.png)

## Client VMs and NFS utility versions

It's always the best practice to run the latest OS patch version available, and updating the NFS utilities to their latest releases to get the newest bug fixes and feature functionality, to optimal performance and system stability.

## Accelerate Networking and VNET

It's always the best practice to enable Accelerated Networking on Azure Virtual Machines, if supported, to provide 30+ Gb/s in networking throughput.

Client VMs and Azure NetApp Files to be in the same VNET when possible, to reduce network latency in between.
