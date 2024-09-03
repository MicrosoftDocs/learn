Azure VMware Solution (AVS) is a great way to extend or move VMware workloads to Azure without refactoring or rearchitecting. Though AVS includes vSAN datastores to store your virtual machines (VMs), there are several scenarios where it might make sense to extend the storage footprint of your AVS clusters without adding AVS hosts. Storage solutions such as Azure NetApp Files allow you to provision performant and highly available storage directly to AVS hosts. These solutions allow you to increase datastore capacity or connect directly to AVS guest VMs to provide shared file systems to various workloads.

Azure NetApp Files uses NetApp technology to provide significant data protection and disaster recovery features for your mission-critical workloads in an Azure native storage service. Using Azure VMware Solution with Azure NetApp Files can also scale your on-premises operation to the cloud with an easy-to-use interface and a lower total cost of ownership.

This learning module helps you understand when and how to configure Azure NetApp Files with Azure VMware Solution to optimize scale and performance.

In this guide, we explore:

- Why use Azure NetApp Files with Azure VMware Solution?
- How to follow the prerequisites, adhere to best practices, and select the appropriate performance sizing for deploying Azure NetApp Files with Azure VMware Solution.
- How to attach Azure NetApp Files volumes as datastores to Azure VMware Solution.
- How to protect VMs using Cloud Backup for Virtual Machines.
- How to attach Azure NetApp Files volumes to VMs as guest-mounted file systems.
