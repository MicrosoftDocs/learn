There are different scenarios where applications in an Azure Kubernetes Service cluster might need to store and retrieve data. Consider the following examples:

- Your application workload uses local, fast data storage on a node that's not needed after the pods are deleted.
- Your application workload requires storage that persists on more regular data volumes within the Azure platform.
- Multiple pods share the same data volumes, or reattach data volumes if the pod is rescheduled on a different node.
- You need to inject sensitive data or application configuration information into pods.

The following illustration highlights storage options for applications in an AKS cluster.

:::image type="content" source="../media/kubernetes-storage-b14b0f2d.png" alt-text="Illustration that shows storage options for applications in an Azure Kubernetes Services cluster." border="false":::

Let's examine four core concepts about providing storage for your applications in AKS: storage volumes, persistent volumes, storage classes, and volume claims.

### Things to know about storage volumes

Applications often need to store and retrieve data. Because Kubernetes typically treats individual pods as ephemeral, disposable resources, different approaches are available for applications to use and persist data as necessary. Storage volumes represent a way to store, retrieve, and persist data across pods and through the application lifecycle.

- Traditional storage volumes that store and retrieve data are created as Kubernetes resources backed by Azure Storage.

- You can manually create storage volumes to be assigned to pods directly, or have Kubernetes automatically create them.

- Storage volumes can use Azure Disks or Azure Files:

   - Use **Azure Disks** to create a Kubernetes *DataDisk* resource. Disks can use Azure Premium storage, backed by high-performance SSDs, or Azure Standard storage, backed by regular HDDs. For most production and development workloads, use Premium storage. Azure Disks are mounted with *ReadWriteOnce* permissions, so they're available to a single node only. For storage volumes that can be accessed by multiple nodes simultaneously, use Azure Files.
 
   - Use **Azure Files** to mount an SMB 3.0 share backed by an Azure storage account to pods. Azure Files let you share data across multiple nodes and pods. Files can use Azure Standard storage backed by regular HDDs, or Azure Premium storage, backed by high-performance SSDs.

### Things to know about persistent volumes

Volumes are defined and created as part of the pod lifecycle and exist only until the pod is deleted. Pods often expect their storage to remain if a pod is rescheduled on a different host during a maintenance event, especially in `StatefulSets` configurations. A persistent volume (`PersistentVolume`) is a storage resource that's created and managed by the Kubernetes API that can exist beyond the lifetime of an individual pod.

- You can use Azure Disks or Azure Files to provide a persistent volume. The choice of whether to use Azure Disks or Azure Files is often determined by the need for concurrent access to the data or the performance tier.

- A persistent volume can be statically created by a cluster administrator, or dynamically created by the Kubernetes API server.

- If a pod is scheduled, and requests Storage that's not currently available, Kubernetes can create the underlying Azure Disks or Azure Files storage. Kubernetes also attaches the storage volume to the pod.

- Dynamic provisioning uses a `StorageClass` type to identify what kind of Azure Storage needs to be created.

### Things to know about storage classes

To define different tiers of storage, such as Premium and Standard, you can configure a `StorageClass` type. The `StorageClass` type also defines the `reclaimPolicy` actions for the storage. The `reclaimPolicy` definition controls the behavior of the underlying Azure Storage resource when the pod is deleted and the persistent volume might no longer be required. The underlying Storage resource can be deleted, or retained for use with a future pod.

In Azure Kubernetes Service, four initial `StorageClasses` types are created for a cluster by using in-tree storage plugins:

| StorageClass type | Description | reclaimPolicy action |
| --- | --- | --- |
| `default` | Use Azure StandardSSD storage to create an Azure managed disk. | Ensures the underlying Azure disk is deleted when the persistent volume that used the disk is deleted. |
| `managed-premium` | Use Azure Premium storage to create an Azure managed disk. | Ensures the underlying Azure disk is deleted when the persistent volume that used the disk is deleted. |
| `azurefile` | Use Azure Standard storage to create an Azures Files file share. | Ensures the underlying Azure Files file share is deleted when the persistent volume that used the file share is deleted. |
| `azurefile-premium` | Use Azure Premium storage to create an Azures Files file share. | Ensures the underlying Azure Files file share is deleted when the persistent volume that used the file share is deleted. |

If no `StorageClass` type is specified for a persistent volume, the `default` type is used.

> [!Important]
> Take care when requesting persistent volumes, and ensure your volumes use the storage you require.
> You can create a `StorageClass` type to satisfy subsequent requirements by using the Azure CLI `kubectl` tool.

### Things to know about persistent volume claims

A persistent volume claim (`PersistentVolumeClaim`) requests either Azure Disks or Azure Files storage of a particular `StorageClass`, access mode, and size. 

- The Kubernetes API server can dynamically provision the underlying storage resource in Azure, if there's no existing resource to fulfill the claim based on the defined `StorageClass` type.

- The pod definition includes the volume mount after the volume has been connected to the pod.

- A persistent volume is *bound* to a persistent volume claim after an available Storage resource is assigned to the pod that requests the volume.

- There's a 1:1 mapping of persistent volumes to claims.