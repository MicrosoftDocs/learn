Azure Stack Hub factors two considerations when placing virtual machines (VMs).

 -  Is there enough memory on the host for the virtual machine type?
 -  Are the virtual machines a part of an availability set or are they virtual machine scale sets?

To achieve high availability of a multi-virtual machine production workload in Azure Stack Hub, virtual machines (VMs) are placed in an availability set that spreads them across multiple fault domains. Azure Stack Hub supports having an availability set with a maximum of three fault domains to be consistent with Azure. virtual machines placed in an availability set will be physically isolated from each other by spreading them as evenly as possible over multiple fault domains (Azure Stack Hub nodes). If there's a hardware failure, virtual machines from the failed fault domain will be restarted in other fault domains.

In this module, you will learn how to manage compute and storage capacity for Azure Stack Hub.

This module aligns with the exam AZ-600: Configuring and Operating a Hybrid Cloud with Microsoft Azure Stack Hub.

## Learning objectives

After completing this module, you'll be able to:

 -  Manage compute capacity for Azure Stack Hub.
 -  Manage partitioned GPUs in Azure Stack Hub.
 -  Add nodes in Azure Stack Hub.
 -  Manage storage capacity for Azure Stack Hub.
 -  Add IP pools in Azure Stack Hub.

## Skills measured

 -  Manage capacity.

## Prerequisites

 -  Conceptual knowledge of Azure compute solutions.
 -  Working experience with virtual machines, containers, and app service.
 -  Working experience with database solutions.
