To optimize container orchestration environments, your organization needs to be able to control platform-level capabilities, including not only compute but also storage. Choosing the most suitable storage solution for Azure Kubernetes Service (AKS) workloads must account for many factors, including performance, availability, recoverability, security, and cost.

AKS supports both stateless and stateful workloads. Stateful workloads typically require a storage solution for storing and retrieving data. To accommodate this requirement, you can apply a range of native Azure services, including managed databases, disks, and file and blob storage. Each of these options offers different SKUs, sizes, and performance characteristics. Selecting the right option requires careful consideration.

### Select the right storage service

When choosing the optimal storage for AKS containerized workloads, review [AKS storage concepts](https://learn.microsoft.com/azure/aks/concepts-storage) and choose from the following options:

- **Application-level access to structured or semi-structured data**. For structured or semi-structured data, use a platform managed database, such as Azure SQL, Azure Database for MySQL, Azure Database for PostgreSQL, and Azure Cosmos DB.
- **File-level access to data**. For shared application data that requires high performance, use Azure NetApp Files or Azure Files SSD provisioned v2 shares (`PremiumV2_LRS` or `PremiumV2_ZRS`). The earlier `Premium_LRS` and `Premium_ZRS` SSD shares are still supported, but provisioned v2 is recommended for new deployments. For shared data that requires moderate performance, use Azure Files HDD pay-as-you-go or HDD provisioned v2 shares.
- **Block-level access to data (self-managed)**. For applications requiring consistently low latency, high IOPS, and high throughput, use Azure Premium SSD, Azure Premium SSD v2, or Azure Ultra Disk Storage. These options provide flexibility when you want to manage storage characteristics yourself.
- **Object-level access to data**. For large unstructured data, interact with Azure Blob Storage directly, or mount Blob Storage by using the Azure Blob CSI driver with NFS v3.0 or BlobFuse.
- **Block-level access to data (fully managed)**. For a fully managed, cloud-based volume management and orchestration solution, consider [Azure Container Storage](https://learn.microsoft.com/azure/storage/container-storage/container-storage-introduction). It integrates with Kubernetes, allowing dynamic and automatic provisioning of persistent volumes. Azure Container Storage 2.0.x supports local NVMe disks; 2.1.x and later add support for Azure Elastic SAN. Use Azure Container Storage 2.1.x or later for local NVMe or Azure Elastic SAN, and a supported 1.x release for Azure Disks, because the 2.x line doesn't support Azure Disks.

### Plan for pod volumes

AKS typically treats individual pods as ephemeral, disposable resources. Kubernetes volumes let pods store and share data while containers are running. Some volume types, such as `emptyDir`, are ephemeral and exist only for the lifetime of a pod. For data that must persist beyond the lifetime of a pod or across pod rescheduling, use PersistentVolume (PV) resources accessed through PersistentVolumeClaim (PVC)-backed volumes. When selecting the underlying storage for AKS persistent volumes, your choices include Azure Disks, Azure Files, Azure NetApp Files, Azure Blobs, and, through Azure Container Storage, local NVMe disks and Azure Elastic SAN. Local NVMe storage provides the highest performance but is node-local and ephemeral, with no built-in data durability. Pods that consume it through a PersistentVolumeClaim must opt in by setting the `localdisk.csi.acstor.io/accept-ephemeral-storage: "true"` annotation, and the data is lost if the node is deleted or the pod is rescheduled to another node. Use local NVMe only for workloads that can tolerate data loss or that provide their own replication.

AKS volume types include:

- `emptyDir` is used as temporary space for pods. All containers within a pod can access the data on the volume. Data written to this volume type persists only for the lifespan of the pod. Once you delete the pod, the volume is deleted. This volume typically uses the underlying local node disk storage, though it's possible to host it in the node's memory.
- `secret` is used to inject sensitive data, such as passwords, into pods.
- `configMap` is used to inject key-value pair properties into pods, frequently referencing application configuration settings.
- `persistentVolumeClaim` is used to mount storage requested by a PersistentVolumeClaim. The claim binds to a PersistentVolume, which has a lifecycle independent of any individual pod.

### Implement AKS persistent volumes

You can use Azure Disk, Azure Files, Azure Blob Storage, Azure NetApp Files, or Azure Container Storage resources to implement PersistentVolume resources in AKS clusters. Azure Blob Storage uses the Azure Blob CSI driver, and Azure NetApp Files dynamic provisioning uses NetApp Trident. The choice is typically based on the desired performance characteristics and whether the workload requires shared or exclusive access to the underlying storage.

To ensure the availability of persistent volumes, you can precreate PersistentVolume resources. Alternatively, you can rely on Kubernetes to create them dynamically. If a pod awaiting scheduling requires storage that is unavailable, Kubernetes can dynamically provision a supported underlying storage resource, such as an Azure Disk, Azure Files share, Azure Blob container, or Azure Container Storage volume, through the relevant CSI driver and StorageClass. Dynamic provisioning relies on the *StorageClass* specification to determine the type of Azure storage to create.

#### Create StorageClasses

The StorageClass is a Kubernetes construct that defines storage characteristics. In AKS, these characteristics map to specific Azure Storage resources.

The StorageClass also defines the *reclaimPolicy*. When a PersistentVolumeClaim that uses the StorageClass is deleted, the reclaimPolicy controls whether the dynamically provisioned underlying Azure storage resource is deleted or, with `Retain`, kept for manual recovery and reclamation. Retained storage isn't automatically reusable until it's manually reclaimed. Starting with Kubernetes version 1.21, AKS uses Container Storage Interface (CSI) drivers by default and enables CSI migration for supported in-tree Azure Disk and Azure Files volume types. In Kubernetes version 1.26 and later, the in-tree Azure Disk and Azure Files volume types are deprecated and unsupported for new use. Existing in-tree persistent volumes and StorageClasses can continue to function through CSI migration, but workloads should migrate to CSI drivers. AKS includes built-in CSI-based disk and file StorageClasses, such as `managed-csi`, `managed-csi-premium`, `azurefile-csi`, and `azurefile-csi-premium`. When you enable the Azure Blob CSI driver, it provides built-in `azureblob-nfs-premium` and `azureblob-fuse-premium` StorageClasses. Starting with Kubernetes version 1.29, built-in disk StorageClasses in multi-zone AKS clusters use zone-redundant storage (ZRS).

#### Configure PersistentVolumeClaims

A PersistentVolumeClaim is a request for a particular `StorageClass`, access mode, and size. The access mode requests how the volume can be mounted — `ReadWriteOnce`, `ReadOnlyMany`, `ReadWriteMany`, or `ReadWriteOncePod` — and must be supported by the bound PersistentVolume. As mentioned earlier, Kubernetes can dynamically provision the underlying Azure storage resource if no existing resource can fulfill the claim based on the defined StorageClass.

When a matching PersistentVolume is found or dynamically provisioned, Kubernetes *binds* the PersistentVolume to the PersistentVolumeClaim. The pod then mounts the PersistentVolumeClaim as a volume.

The following YAML manifest describes a PersistentVolumeClaim that uses the custom *managed-premium-retain* StorageClass and requests an Azure Disk *5Gi* in size. The *managed-premium-retain* StorageClass is created later in the module; modern AKS built-in StorageClasses are CSI-based and use names such as *managed-csi* and *managed-csi-premium*:

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: azure-managed-disk
spec:
  accessModes:
  - ReadWriteOnce
  storageClassName: managed-premium-retain
  resources:
    requests:
      storage: 5Gi
```

When you create a pod definition, you also specify:

- the PersistentVolumeClaim to request the desired storage.
- the *volumeMount* for your applications to read and write data.

The following YAML manifest illustrates how the PersistentVolumeClaim defined earlier is used to mount a volume on the */mnt/azure* directory:

```yaml
kind: Pod
apiVersion: v1
metadata:
  name: nginx
spec:
  containers:
    - name: myfrontend
      image: mcr.microsoft.com/azurelinux/base/nginx:1.28
      volumeMounts:
      - mountPath: "/mnt/azure"
        name: volume
  volumes:
    - name: volume
      persistentVolumeClaim:
        claimName: azure-managed-disk
```
