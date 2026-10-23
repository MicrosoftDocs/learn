Some Contoso applications need data to survive pod replacement. Persistent volumes separate the lifetime of that data from the lifetime of an individual pod.

## Understand persistent storage resources

A **PersistentVolume** represents storage available to a cluster. A **PersistentVolumeClaim** (PVC) requests capacity and an access mode. A **StorageClass** describes the provisioner and storage characteristics used for dynamic provisioning.

With static provisioning, an administrator creates a persistent volume, which can exist before a claim requests it. With dynamic provisioning, a storage provisioner creates the volume in response to a claim.

AKS on Azure Local provides a `default` storage class that creates VHDX-backed volumes on Cluster Shared Volumes. Inspect the classes in the target cluster before relying on a particular configuration:

```powershell
kubectl --kubeconfig .\contoso-aks-kubeconfig get storageclass
kubectl --kubeconfig .\contoso-aks-kubeconfig describe storageclass default
```

Review the provisioner, access requirements, binding behavior, and reclaim policy. `ReadWriteOnce` means read-write access from a single node. Multiple pods on that node can use the volume. Shared access across nodes requires an appropriate storage backend and configuration.

## Request and mount persistent storage

The following claim requests a 10-GiB volume from the `default` storage class:

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: app-data
spec:
  accessModes:
  - ReadWriteOnce
  storageClassName: default
  resources:
    requests:
      storage: 10Gi
```

Save the claim as `app-data.yaml` in your working directory and create it in the same namespace as the application:

```powershell
kubectl --kubeconfig .\contoso-aks-kubeconfig apply -f .\app-data.yaml
kubectl --kubeconfig .\contoso-aks-kubeconfig get pvc app-data
```

The pod references the claim under `volumes` and mounts that volume in a container. This Linux example uses a separate `/data` path:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: storage-check
spec:
  nodeSelector:
    kubernetes.io/os: linux
  containers:
  - name: web
    image: nginx:stable
    volumeMounts:
    - name: data
      mountPath: /data
  volumes:
  - name: data
    persistentVolumeClaim:
      claimName: app-data
```

Save the pod as `storage-check.yaml` and apply it:

```powershell
kubectl --kubeconfig .\contoso-aks-kubeconfig apply -f .\storage-check.yaml
kubectl --kubeconfig .\contoso-aks-kubeconfig describe pod storage-check
```

The example mounts storage. It doesn't configure the web application to write its content to `/data`. Test persistence with the application's actual write path and workload behavior.

If the claim remains pending, inspect its events and the consuming pod. Depending on the storage class's binding mode, provisioning can wait for a pod to be scheduled. Investigate capacity, class configuration, and attachment errors rather than repeatedly recreating the claim.

## Protect data throughout its lifecycle

A persistent volume can outlive the pod that uses it. Deleting a claim can cause its backing storage to be deleted when the associated reclaim policy is `Delete`.

Verify the policy and recovery plan before cleanup. Persistent storage isn't a backup: test restore procedures and document how application-consistent data is protected during maintenance.

See [Storage options for applications in AKS on Azure Local](/azure/aks-hybrid-edge/local/hyperconverged/concepts-storage) for the platform's persistent storage model.
