Azure Kubernetes Service (AKS) hybrid deployment options ("AKS hybrid") is an on-premises implementation of the Azure Kubernetes Service orchestrator. The orchestrator automates  running containerized applications at scale while allowing you to operate consistent cloud native applications anywhere. on-premises infrastructure and integrate them with Azure services.

Depending on your hardware class, compute availability and your Kubernetes adoption process, the following AKS hybrid deployment options are available:

- AKS on Windows Server
- AKS on Azure Stack HCI (Hyper-converged infrastructure)
- AKS cluster provisioning from Azure (PREVIEW)
- AKS Edge Essentials

## Storage in AKS hybrid

Because AKS hybrid is an implementation of AKS, most of the storage concepts are the same. An **AKS hybrid cluster** contains a control plane managed by AKS that provides the core Kubernetes services and orchestration, while you manage the nodes that contain pods with your application workloads. The following diagram shows the architecture of an AKS hybrid cluster that is using the AKS hybrid deployment option AKS on Azure Stack HCI:

:::image type="content" source="../media/aks-hybrid.jpg" alt-text="Diagram showing the architecture of an AKS hybrid cluster that is using the AKS hybrid deployment option AKS on Azure Stack HCI." border="false":::

As in AKS, traditional volumes are Kubernetes resources backed by Azure Storage. You can manually create data volumes to be assigned to pods directly or have Kubernetes automatically create them. To associate these volumes with Azure Storage, AKS hybrid uses the Container Storage Interface (CSI). AKS Hybrid supports Windows containers and persistent storage with the same CSI drivers as AKS.

When creating persistent storage, AKS hybrid uses the same Kubernetes concepts as AKS, with some variations. Persistent volumes are statically or dynamically created. If you create them dynamically, you define their type and life cycle with a storage class, and they're bound to the persistent volume (PV) with a persistent volume claim (PVC).

Where AKS hybrid storage differs from AKS, is its support for using your on-premises storage as persistent storage.

## Persistent volumes

A persistent volume is a storage resource created and managed by the Kubernetes API that can exist beyond the lifetime of an individual pod. For example, when using the AKS hybrid deployment option AKS on Azure Stack HCI, you can use AKS Disk volumes backed by VHDX (virtual hard disk file type) that are mounted as `ReadWriteOnce` and are accessible to a single node at a time. Or you can use AKS Files volumes backed by SMB (Server Message Block) or NFS (Network File System) file shares. These are mounted as `ReadWriteMany` and are available to multiple nodes concurrently.

A cluster administrator can statically create a persistent volume, or dynamically create it can be created by the Kubernetes API server. If a pod is scheduled and requests storage that isn't currently available, then Kubernetes can create the underlying VHDX file and then attach it to the pod. Dynamic provisioning uses a `StorageClass` to identify what type of storage needs to be created.

## Storage classes

A storage class defines the storage tier, location, and `reclaimPolicy` of the underlying storage resource.

In AKS hybrid, the default storage class is automatically created and uses CSV to create VHDX-backed volumes. The reclaim policy ensures that the underlying VHDX is deleted when the persistent volume that used it's deleted. The storage class also configures the persistent volumes to be expandable, so you just need to edit the persistent volume claim with the new size.

If you don’t specify a`StorageClass` for a persistent volume, the default `StorageClass` is used. When requesting persistent volumes, make sure they use the appropriate storage you need. You can create a StorageClass for more needs.

## Persistent volume claims

A `PersistentVolumeClaim` requests either` ReadWriteOnce` or `ReadWriteMany` storage of a particular `StorageClass` and size. The Kubernetes API server can dynamically provision the underlying storage resource in AKS hybrid if There's no existing resource to fulfill the claim based on the defined `StorageClass`. The pod definition includes the volume mount once the volume has been connected to the pod.

A `PersistentVolume` is bound to a `PersistentVolumeClaim` once an available storage resource has been assigned to the pod requesting it. There's a 1:1 mapping of persistent volumes to claims.

## Using local disks for persistent storage

One of the benefits of using AKS Hybrid is that you can use local disks as persistent storage for Windows containers. Local disks are physical disks that are attached to your on-premises nodes. Local disks offer high performance and low latency for your containerized applications.

To use local disks with Windows containers on AKS hybrid, you need to use the local-volume-provisioner plugin. This plugin automatically discovers and creates persistent volumes (PVs) for local disks on your nodes. Then, you need to create persistent volume claims (PVCs) that match the PVs based on node affinity and storage class. Finally, you need to mount the PVCs to your pods or containers using volume definitions.
