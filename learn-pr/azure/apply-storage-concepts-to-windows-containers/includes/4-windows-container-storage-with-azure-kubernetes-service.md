In the previous unit, we learned how Kubernetes manages and orchestrates your container-based applications and their associated storage components. We also learned about the Kubernetes cluster architecture that consists of a control plane for core services, and nodes for application resources. 

Azure Kubernetes Service (AKS) simplifies the deploying of a managed Kubernetes cluster in Azure by offloading the operational overhead to Azure. As a hosted Kubernetes service, Azure handles critical tasks, like health monitoring and maintenance.  

When you create an **AKS cluster**, a control plane is automatically created and configured. This control plane is provided at no cost as a managed Azure resource abstracted from the user. You only pay for and manage the nodes attached to the AKS cluster.

The following diagram shows how the control plane that provides the core Kubernetes services and orchestration of application workloads is managed by AKS, while you manage the nodes that contain the application workloads.

:::image type="content" source="../media/storage-container-control-plane.jpg" alt-text="Diagram showing how the control plane that provides the core Kubernetes services and orchestration of application workloads is managed by AKS." border="false":::

## AKS cluster

When you deploy an AKS cluster, you specify the number and size of the nodes, and AKS deploys and configures the Kubernetes control plane and nodes.

The following diagram shows the architecture of an AKS cluster.

:::image type="content" source="../media/aks-cluster.jpg" alt-text="Diagram showing the architecture of an AKS cluster." border="false":::

AKS nodes run on Azure virtual machines (VMs). By default, Azure automatically replicates the operating system disk (OS disk) for a VM (Virtual Machine) to Azure storage to avoid data loss when the VM is relocated to another host. However, as we learned previously, containers aren't designed to have local state persisted. So, this behavior offers limited value while providing drawbacks such as slower node provisioning and higher read/write latency.  

AKS, by contrast, uses *ephemeral OS disks*. These disks are stored only on the host machine, just like a temporary disk. With this configuration, you get lower read/write latency, together with faster node scaling and cluster upgrades.

## Volume storage in AKS

In AKS, traditional volumes are created as Kubernetes resources backed by Azure Storage. You can manually create data volumes to be assigned to pods directly or have Kubernetes automatically create them. To associate these volumes with Azure Storage, AKS makes use of the **CSI (Container Storage Interface)**.

CSI is a standard for exposing arbitrary block and file storage systems to containerized workloads on Kubernetes.  

By adopting and using CSI, Azure Kubernetes Service (AKS) can write, deploy, and iterate plug-ins to expose new or improve existing storage systems in Kubernetes without having to touch the core Kubernetes code and wait for its release cycles.

The CSI storage driver support on AKS allows you to natively use:

- **Azure Disks** can be used to create a Kubernetes DataDisk resource. Disks can use Azure Premium Storage, backed by high-performance SSDs, or Azure Standard Storage, backed by regular HDDs (Hard Disk Drives) or Standard SSDs. For most production and development workloads, use Premium Storage. Azure Disks are mounted as *ReadWriteOnce* and are only available to one node in AKS. For storage volumes that can be accessed by multiple nodes simultaneously, use Azure Files.
- Azure Files can be used to mount an SMB (Server Message Block) 3.0/3.1 share backed by an Azure storage account to pods. With Azure Files, you can share data across multiple nodes and pods. Azure Files can use Azure Standard storage backed by regular HDDs or Azure Premium storage backed by high-performance SSDs.
- Azure Blob storage can be used to mount Blob storage (or object storage) as a file system into a container or pod. Using Blob storage enables your cluster to support applications that work with large unstructured datasets like log file data, images or documents, HPC, and others. Additionally, if you ingest data into Azure Data Lake storage, you can directly mount and use it in AKS without configuring another interim file system.

Starting with Kubernetes version 1.21, AKS only uses CSI drivers by default and CSI migration is enabled. While existing in-tree persistent volumes continue to function, starting with version 1.26, AKS will no longer support volumes created using in-tree driver and storage provisioned for files and disk.

## Persistent volumes

A persistent volume (PV) is a storage resource created and managed by the Kubernetes API that can exist beyond the lifetime of an individual pod. In AKS, you can use Azure Disk or Azure Files to provide the `PersistentVolume`. Your choice of Disks or Files for the volume is often determined by the need for concurrent access to the data or the level of performance required.

A cluster administrator can statically create a `PersistentVolume`, or the volume is created dynamically by the Kubernetes API server. If a pod is scheduled and requests currently unavailable storage, Kubernetes can create the underlying Azure Disk or File storage and attach it to the pod. Dynamic provisioning uses a `StorageClass` to identify what type of Azure storage needs to be created.

## Storage classes in AKS

To define different tiers of storage, such as Premium and Standard, you can create a StorageClass. The StorageClass also defines the *reclaimPolicy*. When you delete the persistent volume, the *reclaimPolicy* controls the behavior of the underlying Azure storage resource. The underlying storage resource can either be deleted or kept for use with a future pod.

For clusters using CSI drivers, AKS has created the following extra `StorageClasses`:

| Permission | Reason |
|-|-|
| managed-csi  | Uses Azure StandardSSD locally redundant storage (LRS) to create a Managed Disk. The reclaim policy ensures that the underlying Azure Disk is deleted when the persistent volume that it uses is deleted. The storage class also configures the persistent volumes to be expandable, you just need to edit the persistent volume claim with the new size. |
| managed-csi-premium  | Uses Azure Premium locally redundant storage (LRS) to create a Managed Disk. The reclaim policy again ensures that the underlying Azure Disk is deleted when the persistent volume that used it is deleted. Similarly, this storage class allows persistent volumes to be expanded. |
| azurefile-csi | Uses Azure Standard storage to create an Azure file share. The reclaim policy ensures that the underlying Azure file share is deleted when the persistent volume that used it is deleted. |
| azurefile-csi-premium | Uses Azure Premium storage to create an Azure file share. The reclaim policy ensures that the underlying Azure file share is deleted when the persistent volume that used it is deleted. |
| azureblob-nfs-premium | Uses Azure Premium storage to create an Azure Blob storage container and connects using the NFS (Network File System) v3 protocol. The reclaim policy ensures that the underlying Azure Blob storage container is deleted when the persistent volume that used it is deleted. |
| azureblob-fuse-premium | Uses Azure Premium storage to create an Azure Blob storage container and connect using BlobFuse. The reclaim policy ensures that the underlying Azure Blob storage container is deleted when the persistent volume that used it is deleted. |

Unless you specify a StorageClass for a persistent volume, the default StorageClass is used. You should ensure that volumes use the appropriate storage you need when requesting persistent volumes. The default class will be the same as `managed-csi`.

## Persistent volume claims

A `PersistentVolumeClaim` requests storage of a particular `StorageClass`, access mode, and size. The Kubernetes API server can dynamically provision the underlying Azure storage resource if no existing resource can fulfill the claim based on the defined `StorageClass`.

The pod definition includes the volume mount once the volume has been connected to the pod.

The following diagram shows how a PVC works within an AKS cluster:

:::image type="content" source="../media/pvc-in-aks-cluster.jpg" alt-text="Diagram showing how a PVC works within an AKS cluster." border="false":::
