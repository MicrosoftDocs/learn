Here you learn about all the parts of AKS Edge Essentials and how it uses Windows IoT Enterprise to deploy a lightweight Kubernetes platform with kernel to cloud support:

* Clusters and nodes
* Networking
* Deployment schema
* Storage
* Interoperability with Windows applications
* Azure Arc for management
* Kernel to cloud support

## Clusters and nodes

When you create an AKS Edge Essentials deployment, AKS Edge Essentials creates a virtual machine for each deployed node. You can define the amount of CPU and memory resources that you'd like to allocate for each of the VMs. This static allocation enables you to control how resources are used and ensures that applications running on the host have the required resources. AKS Edge Essentials manages the lifecycle, configuration, and updates of the VMs.

:::image type="content" source="../media/3-aks-edge-vm-inline.png" alt-text="Diagram showing the VMs in AKS Edge Essentials." lightbox="../media/3-aks-edge-vm-expanded.png":::

### Node types

Deployments can only create one Linux VM and one Windows VM on a given host machine. The Linux VM can act as both the control plane node and as a worker node based on your deployment needs. Running a Windows node is optional and you can create a Windows worker node if you need to deploy Windows containers.

### Cluster deployment options

After you set up your machines, you can deploy AKS Edge Essentials in the following configurations:

* **Single machine cluster:** Runs Kubernetes nodes on a single machine to create a single machine cluster. This deployment uses an internal network switch to enable communication across the nodes. This deployment supports only one Linux node and one Windows node, both running on a single machine.
* **Scalable cluster:** Lets you create a multi-node Kubernetes cluster that can be scaled across multiple machines.

:::image type="content" source="../media/3-aks-edge-deployment-options-inline.png" alt-text="Diagram showing AKS Edge Essentials deployment scenarios." lightbox="../media/3-aks-edge-deployment-options-expanded.png":::

## Networking

To establish a communication channel between the Windows host OS and the Linux and Windows virtual machines, AKS Edge Essentials uses a Hyper-V networking stack. For more information about Hyper-V networking, see [Hyper-V networking basics](/windows-server/virtualization/hyper-v/plan/plan-hyper-v-networking-in-windows-server#hyper-v-networking-basics).

On a **single machine cluster**, the installer and deployment mechanism handles all the necessary networking configuration and no extra steps or configuration are needed to deploy the cluster. In **scalable cluster** deployments, the nodes running inside the different devices must communicate between each other, therefore, all nodes must be connected to the same network and to achieve this node-to-node communication across devices, AKS Edge Essentials scalable cluster deployments use external virtual switches.

### Single machine cluster

Single machine deployments use an internal virtual switch to manage the networking. This type of deployment must have a Linux node; a Windows node is optional. The following diagram shows a single machine deployment architecture using internal virtual switch:

:::image type="content" source="../media/3-networking-single-machine-inline.png" alt-text="Diagram showing the network architecture using internal virtual switch on a single machine cluster." lightbox="../media/3-networking-single-machine-expanded.png":::

### Scalable cluster

Scalable cluster deployments use external virtual switches to manage the networking. Once deployment is finished, all nodes and the Windows host OS are connected to the external network using the same external virtual switch. The following diagram shows a scalable cluster deployment architecture using external virtual switches:

:::image type="content" source="../media/3-networking-multi-machine-inline.png" alt-text="Diagram showing the network architecture using external virtual switch on a multi-node cluster." lightbox="../media/3-networking-multi-machine-expanded.png":::

## Deployment schema

The AKS Edge Essentials deployment schema provides a flexible and scalable way to deploy and manage containerized applications on edge devices. After you install AKS Edge Essentials, you can find the complete JSON schema file at `C:\Program Files\AksEdge\aksedge-dcschema.json`. The following table describes some of the values you can define in the schema (for a complete list, see [Deployment configuration JSON parameters](/azure/aks/hybrid/aks-edge-deployment-config-json)):

| Attribute | Value type      |  Description |  Default value |   Applicable deployment types   |
| :------------ |:-----------|:------------------|:--------|:------------|
| `SchemaVersion` |String|Specifies the version of the schema/format of the JSON. | `1.9` |Single-machine and full deployment|
| `Version` |`1.0`|Specifies the version of the JSON instance. | `1.0` |Single-machine and full deployment|
| `DeploymentType` |[`SingleMachineCluster` / `ScalableCluster`]| Specifies deployment type. In `ScalableCluster`, you can add more machines to the cluster infrastructure. | `SingleMachineCluster` |Single-machine and full deployment|
| `Arc.ClusterName` |String|Preferred name for the cluster to show in the Azure portal.| `<Machinename>-cluster` |Single-machine and full deployment|
| `Network.NetworkPlugin` |[`calico` / `flannel`]|CNI plugin choice for the Kubernetes network model. For K8s cluster, always use `calico` and for K3s cluster, always use `flannel`.|  `flannel`|Single-machine and full deployment|
| `Machines[].LinuxNode.ControlPlane` | Boolean | Specifies whether you want this new deployment to be a control plane. If `false`, it's a worker node. Only for Linux VMs.| `false` |Single-machine and full deployment|
| `Machines[].LinuxNode.CpuCount` | [`2-x`] | Number of CPU cores reserved for VM/VMs. | `2` |Single-machine and full deployment|
| `Machines[].LinuxNode.MemoryInMB` | [`2048-2x`] | RAM in MBs reserved for VM/VMs. | `2048` |Single-machine and full deployment|
| `Machines[].LinuxNode.DataSizeInGB` | Number | Size of the data partition. For large applications, we recommend increasing this number. Only for Linux VMs. | `10` |Single-machine and full deployment|
| `Machines[].LinuxNode.Ip4Address` | `A.B.C.x` | Specifies the IP address your VM takes. ||Single-machine and full deployment|
| `Machines[].WindowsNode.CpuCount` | [`2-x`] | Number of CPU cores reserved for VM/VMs. | `2` |Single-machine and full deployment|
| `Machines[].WindowsNode.MemoryInMB` | [`2048-2x`] | RAM in MBs reserved for VM/VMs (multiples of 2). | `2048` |Single-machine and full deployment|
| `Machines[].WindowsNode.Ip4Address` | `A.B.C.x` | Specifies the IP address your VM takes. ||Single-machine and full deployment|

## Storage

Applications running in AKS Edge Essentials might need to store and retrieve data. Persistent storage solutions allow you to store application data external from the pod running your application, and allow you to maintain application data, even if the application's pod fails. The [Local Path Provisioner](https://github.com/rancher/local-path-provisioner) provides a way for Kubernetes users to use the local storage in each node by enabling the ability to create persistent volume claims using local storage on the respective node.

It's also possible to decouple storage availability from the node's lifecycle by using external storage providers like NFS. For more information about the NFS plugin, see the [nfs-subdir-external-provisioner](https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner).

## Interoperability with Windows applications

Windows provides a rich app eco system, user experience and robust security, and powers much of the infrastructure for Operational Technology (OT) today from HMIs, robots, PLCs, medical devices etc. Many of the cloud-native workloads are built on Linux, and you're faced with the challenge of having to introduce Linux systems to take advantage of cloud-native solutions. AKS Edge Essentials offers interoperability between native Windows applications and containerized Linux workloads. This interoperability enables you to use a broad set of AI capabilities to innovate quickly and drive your edge innovation forward with the least disruption.

:::image type="content" source="../media/3-aks-edge-windows-interop-inline.png" alt-text="Diagram showing AKS Edge Essentials interoperability with Windows applications." lightbox="../media/3-aks-edge-windows-interop-expanded.png":::

## Azure Arc for management

AKS Edge Essentials clusters can be Arc-enabled and managed as an Azure resource from the Azure portal. Once your AKS Edge Essentials cluster is connected to Azure Arc, it extends the Azure platform to the edge with core services like governance, monitoring, application, ML and data services. It also helps bring DevOps practices anywhere and build iteratively using GitOps and Flux to seamlessly manage application deployments.

## Kernel to cloud support

AKS Edge Essentials is available on multiple Windows editions including Windows 10/11 (IoT Enterprise / Enterprise / Pro) or Windows (Server / Server IoT) 2019/2022. The Linux VM is fully managed and is based on a curated CBL-Mariner image, which is a lightweight image that helps reduce attack surface, ensures better performance, and provides less overhead for patching vulnerabilities. You can manage all your containers and Kubernetes configs across cloud and on-premises with Arc-enabled Kubernetes. This multi-layered approach ensures that the entire software stack is secure and updated so that your business applications can run reliably.

Windows IoT Enterprise focus on OT scenarios and experiences like advanced lockdown features, kiosk and dual operator modes, device image optimization capabilities and a 10-year Long-Term Servicing Channel (LTSC). Windows IoT Enterprise, coupled with the Linux-based and Arc-enabled Kubernetes at the edge with AKS Edge Essentials, gets you the benefit of having a fully supported stack from kernel to cloud.
