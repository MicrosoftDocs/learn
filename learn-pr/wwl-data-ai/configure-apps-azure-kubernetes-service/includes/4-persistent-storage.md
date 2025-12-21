# Attach persistent storage to an app

AI services sometimes need durable storage for embeddings, cached artifacts, or conversation state. Container filesystems are ephemeral by default. Data is lost when a Pod restarts or moves to a different node. PersistentVolume (PV) and PersistentVolumeClaim (PVC) provide storage that survives Pod restarts and rescheduling. You declare a PVC to request storage with specific capacity and access modes. Kubernetes binds the claim to a PersistentVolume that meets your requirements. Azure provides multiple storage options for AKS including CSI drivers that integrate Azure storage services and Azure Container Storage for container-optimized performance.

This unit focuses on using CSI drivers with standard Kubernetes storage patterns. CSI drivers provision Azure Disk or Azure Files resources through pre-configured StorageClasses.

> [!NOTE]
> The examples in this unit use CSI driver-based storage classes.

## Choose a persistent volume option

AKS supports two approaches for persistent storage. [Container Storage Interface (CSI) drivers](/azure/aks/csi-storage-drivers) integrate Azure storage services with Kubernetes using standard storage classes. CSI drivers provision [Azure Disk](/azure/aks/azure-disk-csi) for single-node block storage, [Azure Files](/azure/aks/azure-files-csi) for shared file access across multiple Pods, and [Azure Blob](/azure/aks/azure-blob-csi) for large unstructured datasets. This approach works well for general-purpose scenarios and provides compatibility with existing Azure storage features.

[Azure Container Storage](/azure/storage/container-storage/container-storage-introduction) provides a fully managed, container-native storage platform optimized for stateful workloads. The service uses network block storage protocols like NVMe-oF for fast volume attach and detach operations. Azure Container Storage reduces pod failover times and simplifies management through Kubernetes-native kubectl commands. Choose this option when you need optimized performance for I/O intensive applications or rapid scaling of stateful workloads.

## Define a PersistentVolumeClaim

A PersistentVolumeClaim is a request for storage. You specify how much capacity you need and what access modes you require. The `storageClassName` field tells Kubernetes which StorageClass to use. The StorageClass controls the backing storage type and provisioning behavior. Common access modes include `ReadWriteOnce` for single-node access and `ReadWriteMany` for shared access across multiple nodes. Right-size your capacity request to avoid waste. Plan for growth so you don't need to resize volumes frequently.

AKS provides built-in StorageClasses for CSI drivers with different performance tiers and sharing capabilities. The following table shows the default CSI driver storage classes and their characteristics. Choose the storage type based on whether you need single-Pod or multi-Pod access and the performance tier your workload requires.

| Storage class | Backing storage | Access mode | Performance | Use case |
| --- | --- | --- | --- | --- |
| `managed-csi` (default) | Azure Disk | ReadWriteOnce | Standard HDD/SSD | Single Pod access, cost-efficient storage for databases and stateful apps |
| `managed-csi-premium` | Azure Disk Premium | ReadWriteOnce | Premium SSD | Single Pod access, low latency and high throughput for I/O intensive workloads |
| `azurefile-csi` | Azure Files | ReadWriteMany | Standard HDD/SSD | Shared access across multiple Pods, configuration files, logs, content management |
| `azurefile-csi-premium` | Azure Files Premium | ReadWriteMany | Premium SSD | Shared access with high performance, collaborative workloads requiring low latency |

Azure Disk storage classes use `ReadWriteOnce` mode because the disk attaches to a single node. Only Pods on that node can access the volume. Azure Files storage classes use `ReadWriteMany` mode because the SMB file share mounts across multiple nodes simultaneously. Multiple Pods across different nodes can read and write to the same volume. Choose disk-based storage for single-Pod stateful applications like databases. Choose file-based storage when multiple Pods need concurrent access to shared data. PVC manifests are typically stored in a file named *pvc.yaml*.

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: data-pvc
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
  storageClassName: default
```

## Mount the PVC in a Deployment

After you create a PVC, you mount it in your Deployment. Add a volume entry in the Pod spec that references the claim by name. Then add a `volumeMount` entry in the container spec. The `mountPath` specifies where the volume appears in the container filesystem. Your application reads and writes files under that path. Data written to the mount path persists even when the Pod restarts. Before you deploy, confirm that your container has the correct permissions to read and write to the mount path. Check the ownership and permissions settings if you encounter access errors at runtime.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-api
spec:
  replicas: 2
  selector:
    matchLabels:
      app: web-api
  template:
    metadata:
      labels:
        app: web-api
    spec:
      volumes:
      - name: data-volume
        persistentVolumeClaim:
          claimName: data-pvc
      containers:
      - name: api
        image: myregistry.azurecr.io/web-api:v1
        volumeMounts:
        - name: data-volume
          mountPath: /app/data
```

## Verify persistence

Apply your PVC and Deployment manifests. Use `kubectl describe pvc` to check that the claim is bound to a volume. Use `kubectl get pods` to confirm your Pods are running. To test persistence, write a file to the mount path inside a Pod. Delete the Pod and wait for Kubernetes to create a replacement. Check that the file still exists in the new Pod to confirms that data survives Pod restarts. Before you move to production, run small load tests to verify that I/O performance meets your expectations. These manifests are typically stored in files named *pvc.yaml* (PVC) and *deployment.yaml* (Deployment).

```bash
kubectl apply -f pvc.yaml
kubectl apply -f deployment.yaml
kubectl describe pvc data-pvc
kubectl describe pod -l app=web-api
```

## Additional resources

- [Storage options for applications in AKS](/azure/aks/concepts-storage) - Compare storage types and access modes
- [Use managed identity for Azure Files](/azure/aks/azure-files-csi#use-managed-identity-to-access-azure-files-storage-preview) - Configure identity-based access for Azure Files
- [Statically provision volumes with Azure Disk](/azure/aks/azure-csi-disk-storage-provision#statically-provision-a-volume) - Configure permissions for external storage accounts and resource groups