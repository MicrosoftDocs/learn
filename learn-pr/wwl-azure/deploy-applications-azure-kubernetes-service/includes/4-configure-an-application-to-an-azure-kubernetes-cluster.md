
To optimize container orchestration environments, your organization needs to be able to control platform-level capabilities, including not only compute but also storage. Choosing the most suitable storage solution must account for many factors, including performance, availability, recoverability, security, and cost.

AKS supports both stateless and stateful workloads. Stateful workloads typically require a storage solution for storing and retrieving data. To accommodate this requirement, you can apply a range of native Azure services, including managed databases, disks, and file and blob storage. Each of these options offers different SKUs, sizes, and performance characteristics. Selecting the right option requires careful consideration.

### Select the right storage service

When choosing the optimal storage for AKS containerized workloads, you can choose from the following options:

 -  **Application-level access to structured or semi-structured data**. For structured or semi-structured data, use a platform managed database, such as Azure SQL, Azure Database by MySQL, Azure Database for PostgreSQL, and Cosmos DB.
 -  **File-level access to data**. For shared application data that requires high performance, use either Azure NetApp Files or the *premium* tier of Azure Files. For shared data that requires moderate performance, use the *standard* tier of Azure Files.
 -  **Block-level access to data**. Use disks for storage for applications that require consistently low latency, high I/O operations per second (IOPS), and high throughput. For the best performance, consider using Azure Premium SSD, Azure Premium SSD v2, or Azure Ultra Disk Storage. Alternatively, apply Azure Blob storage by using BlobFuse virtual file system, or read from and write to blob storage directly.

### Plan for pod volumes

AKS typically treats individual pods as ephemeral, disposable resources. To implement a persistent storage for pods, you can create volumes. A *volume* offers a mechanism to store, retrieve, and persist data across pods and throughout the application lifecycle. When selecting the underlying storage for AKS volumes, your choices include Azure Disks, Azure Files, Azure NetApp Files, and Azure Blobs.

AKS volume types include:

 -  emptyDir is used as temporary space for pods. All containers within a pod can access the data on the volume. Data written to this volume type persists only for the lifespan of the pod. Once you delete the pod, the volume is deleted. This volume typically uses the underlying local node disk storage, though it's possible to host it in the node's memory.
 -  secret is used to inject into pods sensitive data, such as passwords.
 -  configMap is used to inject into pods key-value pair properties, frequently referencing application configuration settings.
 -  PersistentVolume (PV) is a block or file storage resource created and managed by the Kubernetes API that has the ability to persist beyond the lifetime of a pod.

### Implement AKS persistent volumes

You can use either Azure Disk or Azure Files resources to implement `PersistentVolumes` in AKS clusters. The choice between them is typically based on the desired performance characteristics and the ability to provide either shared or exclusive access to the underlying storage.

:::image type="content" source="../media/azure-kubernetes-storage-flow-30832364.png" alt-text="Diagram showing how either Azure Disk or Azure Files resources are used to implement Persistent Volumes for a clusters.":::
<br>

To ensure the availability of persistent volumes, you can precreate PersistentVolume resources. Alternatively, you can rely on the Kubernetes API server to create them dynamically. A pod awaiting deployment ,may require storage that is unavailable, AKS can automatically provision an underlying Azure Disk or File resource and attach it to the pod. Dynamic provisioning relies on the *StorageClass* specification to determine the type of Azure storage to create.

#### Create storage classes

The StorageClass is a Kubernetes construct that defines storage characteristics. In AKS, these characteristics map to specific Azure Storage resources.

The StorageClass also defines the *reclaimPolicy*. When you delete the persistent volume, the reclaimPolicy controls the behavior of the underlying Azure storage resource. That resource can either be deleted or retained for future use. AKS includes several default storage classes, representing a mix of Azure Disks and Azure Files with Standard and Premium performance tiers.

#### Configure persistent volume claims

A PersistentVolumeClaim is a request for a particular `StorageClass`, access mode (which determines whether volume access should be shared or exclusive), and size. As mentioned earlier, the Kubernetes API server can dynamically provision the underlying Azure storage resource if no existing resource can fulfill the claim based on the defined StorageClass.

:::image type="content" source="../media/azure-kubernetes-persistent-storage-92f42a3f.png" alt-text="Diagram showing how a persistent volume claim is requested for a storage class.":::


Once an available storage resource has been assigned to the pod requesting storage, PersistentVolume is *bound* to a PersistentVolumeClaim.

The following YAML manifest describes a persistent volume claim that uses the *managed-premium* StorageClass and requests a Disk *5Gi* in size:

<!--- raw content start --->
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
<!--- raw content end --->

When you create a pod definition, you also specify:

 -  the persistent volume claim to request the desired storage.
 -  the *volumeMount* for your applications to read and write data.

The following YAML manifest illustrates how that persistent volume claim defined earlier is used to mount a volume on the */mnt/azure* directory:

<!--- raw content start --->
kind: Pod
apiVersion: v1
metadata:
  name: nginx
spec:
  containers:
    - name: myfrontend
      image: mcr.microsoft.com/oss/nginx/nginx:1.15.5-alpine
      volumeMounts:
      - mountPath: "/mnt/azure"
        name: volume
  volumes:
    - name: volume
      persistentVolumeClaim:
        claimName: azure-managed-disk
<!--- raw content end --->
