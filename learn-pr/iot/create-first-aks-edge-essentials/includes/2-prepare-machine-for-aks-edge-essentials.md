To maintain a small resource footprint with the most focused possible experience, AKS Edge Essentials is designed for running predefined AKS configurations in production.

In the industrial factory scenario, we will use AKS Edge Essentials to automate and run containerized applications, on multiple specialized devices.

Here, you will learn how to prepare your machine and define the amount of CPU and memory resources needed, to ensure that applications running on the host have the required resources.

## Hardware requirements

| Specs | Local cluster | Arc-connected cluster and GitOps|
| ---------- | --------- |--------- |
| Host OS | Windows 10/11 (IoT Enterprise / Enterprise / Pro) or Windows (Server / Server IoT) 2019/2022||
| Total physical memory | 4 GB with at least 2.5 GB free | 8 GB with at least 4.5 GB free  |
| CPU | 2 vCPUs, clock speed at least 1.8 GHz |4 vCPUs, clock speed at least 1.8 GHz|
| Disk space | At least 14 GB free |At least 14 GB free |

For developer and training use cases, you can run AKS Edge Essentials in an Azure Virtual Machine (VM). You can create a Windows VM with either Windows 10/11 IoT Enterprise/Enterprise/Pro or (Server / Server IoT) 2019/2022, on a VM image that supports nested virtualization.

In our example scenario, we will use a Windows 11 Enterprise [Dsv5-series](/azure/virtual-machines/dv5-dsv5-series) Azure VM.

## Clusters and nodes

AKS Edge Essentials is intended for static, pre-defined configurations and doesn't enable dynamic VM creation/deletion or cluster lifecycle management. Each machine in an AKS Edge Essentials cluster can only have one Linux and/or Windows VM. The Linux VM acts as the control node and worker node for Linux workloads in the Kubernetes cluster. Each machine with AKS Edge Essentials has a VM with restricted RAM, storage, and physical CPU cores according to a static allocation assigned at install time. This static allocation enables you to control how resources are used and ensures that applications running on the host have the required resources. AKS Edge Essentials manages the lifecycle, configuration, and updates of the VMs.

After you set up your machines, you can deploy AKS Edge Essentials in the following configurations:

* **Single machine cluster:** Runs Kubernetes nodes on a single machine to create a single machine cluster. This deployment uses an internal network switch to enable communication across the nodes. This deployment supports only one Linux node and one Windows node, both running on a single machine.
* **Scalable cluster:** Lets you create a multi-node Kubernetes cluster that can be scaled across multiple machines. AKS Edge Essentials doesn't offer dynamic creation of virtual machines. If a node VM goes down, you have to recreate it. That said, if you have a scalable cluster with multiple control plane nodes and worker nodes, if a VM goes down, Kubernetes moves workloads to an active node.

:::image type="content" source="../media/2-aks-edge-deployment-options-inline.png" alt-text="Diagram showing AKS Edge Essentials deployment scenarios." lightbox="../media/2-aks-edge-deployment-options-expanded.png":::

In our example scenario, we will use a single machine K3S cluster with one Linux node and one Windows node.

## Deployment schema for a single machine K3S cluster with one Linux node and one Windows node

The AKS Edge Essentials deployment schema provides a flexible and scalable way to deploy and manage containerized applications on edge devices. The following table describes some of the values used to deploy AKS Edge Essentials in our example scenario:

| Attribute | Value type      |  Description |  Value |
| :------------ |:-----------|:------------------|:--------|
| `DeploymentType` |[`SingleMachineCluster` / `ScalableCluster`]| Specifies deployment type. In `ScalableCluster`, you can add more machines to the cluster infrastructure. | `SingleMachineCluster` |
| `Machines[].LinuxNode.CpuCount` | [`2-x`] | Number of CPU cores reserved for VM/VMs. | `2` |
| `Machines[].LinuxNode.MemoryInMB` | [`2048-2x`] | RAM in MBs reserved for VM/VMs. | `2048` |
| `Machines[].LinuxNode.DataSizeInGB` | Number | Size of the data partition. For large applications, we recommend increasing this number. Only for Linux VMs. | `20` |
| `Machines[].WindowsNode.CpuCount` | [`2-x`] | Number of CPU cores reserved for VM/VMs. | `2` |
| `Machines[].WindowsNode.MemoryInMB` | [`2048-2x`] | RAM in MBs reserved for VM/VMs (multiples of 2). | `2048` |
