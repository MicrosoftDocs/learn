Some Contoso applications need data to survive pod replacement. Persistent volumes separate the lifetime of that data from the lifetime of an individual pod.

Use only disposable lab data for this exercise. Keep the Arc proxy running in its separate terminal, and run the commands in one management PowerShell session from the directory containing `contoso-aks-kubeconfig`. If you open another terminal, set `$namespace` again to the exact namespace you created; variables aren't shared between processes.

## Understand persistent storage resources

A **PersistentVolume** represents storage available to a cluster. A **PersistentVolumeClaim** (PVC) requests capacity and an access mode. A **StorageClass** describes the provisioner and storage characteristics used for dynamic provisioning.

With static provisioning, an administrator creates a persistent volume, which can exist before a claim requests it. With dynamic provisioning, a storage provisioner creates the volume in response to a claim.

AKS on Azure Local provides a `default` storage class that creates VHDX-backed volumes on Cluster Shared Volumes. Inspect the classes in the target cluster before relying on a particular configuration:

```powershell
kubectl --kubeconfig .\contoso-aks-kubeconfig get storageclass
kubectl --kubeconfig .\contoso-aks-kubeconfig describe storageclass default
```

Review the provisioner, filesystem parameters such as `fsType`, access requirements, binding behavior, and reclaim policy. Confirm that the `default` class supports this Linux sample on your target release before applying it. If its filesystem configuration isn't suitable, stop and resolve that with the platform administrator rather than selecting another class without validation.

The storage class selects a provisioner and provisioning policies; the PVC requests an access mode that the storage driver must support. Disk storage provides single-node read/write attachment. `ReadWriteOnce` means read-write access from a single node. Multiple pods on that node can use the volume; it isn't a single-pod guarantee.

For shared files accessed from different nodes, evaluate the platform's SMB or NFS CSI drivers and their OS-specific requirements. These file drivers use shares provisioned in advance. Requesting `ReadWriteMany` doesn't turn a disk into shared-file storage.

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

Save the claim as `app-data.yaml` in your working directory. Replace `<new-isolated-lab-namespace>` with a new namespace name and create it solely for this exercise. Stop if namespace creation fails, including when that name already exists; don't reuse an unrelated namespace.

```powershell
$namespace = '<new-isolated-lab-namespace>'
kubectl --kubeconfig .\contoso-aks-kubeconfig create namespace $namespace
if ($LASTEXITCODE -ne 0) {
    throw 'Namespace creation failed. Stop before creating sample resources.'
}
kubectl --kubeconfig .\contoso-aks-kubeconfig --namespace $namespace `
    apply -f .\app-data.yaml
if ($LASTEXITCODE -ne 0) {
    throw 'Claim creation failed. Resolve the error before continuing.'
}
kubectl --kubeconfig .\contoso-aks-kubeconfig --namespace $namespace get pvc app-data
if ($LASTEXITCODE -ne 0) {
    throw 'Claim inspection failed. Resolve the error before continuing.'
}
```

Use this namespace for every operation on the sample claim and pod. A class using `WaitForFirstConsumer` can leave the claim `Pending` until a consuming pod is scheduled; that alone isn't a provisioning failure. With immediate provisioning, inspect the claim's events if it doesn't bind. When resuming the exercise in another terminal, reuse the namespace value without repeating namespace creation.

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

Save the pod as `storage-check.yaml`. Apply it, then check both claim binding and pod readiness:

```powershell
kubectl --kubeconfig .\contoso-aks-kubeconfig --namespace $namespace `
    apply -f .\storage-check.yaml
if ($LASTEXITCODE -ne 0) {
    throw 'Pod creation failed. Resolve the error before continuing.'
}
kubectl --kubeconfig .\contoso-aks-kubeconfig --namespace $namespace `
    wait --for=jsonpath='{.status.phase}'=Bound pvc/app-data --timeout=300s
if ($LASTEXITCODE -ne 0) {
    throw "The claim didn't bind. Inspect the claim and pod events before continuing."
}
kubectl --kubeconfig .\contoso-aks-kubeconfig --namespace $namespace `
    wait --for=condition=Ready pod/storage-check --timeout=300s
if ($LASTEXITCODE -ne 0) {
    throw "The pod isn't ready. Inspect its events before continuing."
}
```

Expect a `Bound` claim and a ready pod whose volume references `app-data`. If either check fails, stop and inspect the resources:

```powershell
kubectl --kubeconfig .\contoso-aks-kubeconfig --namespace $namespace describe pvc app-data
kubectl --kubeconfig .\contoso-aks-kubeconfig --namespace $namespace describe pod storage-check
```

A timeout isn't proof of data loss. Investigate capacity, class configuration, scheduling, image pulls, and attach or mount errors rather than repeatedly recreating the claim. Resolve failures and rerun the binding and readiness checks before proceeding.

## Verify persistence across pod replacement

The web server doesn't write its content to `/data` in this example. Write a marker to the mounted volume, delete only the pod, and recreate it using the same claim:

```powershell
kubectl --kubeconfig .\contoso-aks-kubeconfig --namespace $namespace `
    exec storage-check -- sh -c "echo persistence-test > /data/marker.txt"
if ($LASTEXITCODE -ne 0) {
    throw 'The marker write failed. Stop before deleting the pod.'
}
kubectl --kubeconfig .\contoso-aks-kubeconfig --namespace $namespace `
    delete pod storage-check --wait=true --timeout=300s
if ($LASTEXITCODE -ne 0) {
    throw "Pod deletion didn't complete. Resolve the error before recreating it."
}
kubectl --kubeconfig .\contoso-aks-kubeconfig --namespace $namespace `
    apply -f .\storage-check.yaml
if ($LASTEXITCODE -ne 0) {
    throw 'Pod recreation failed. Resolve the error before continuing.'
}
kubectl --kubeconfig .\contoso-aks-kubeconfig --namespace $namespace `
    wait --for=condition=Ready pod/storage-check --timeout=300s
if ($LASTEXITCODE -ne 0) {
    throw "The replacement pod isn't ready. Inspect its events before reading data."
}
$marker = kubectl --kubeconfig .\contoso-aks-kubeconfig --namespace $namespace `
    exec storage-check -- cat /data/marker.txt
if ($LASTEXITCODE -ne 0 -or $marker -ne 'persistence-test') {
    throw "The marker couldn't be verified. Stop and investigate the volume and mount."
}
$marker
```

The output should be `persistence-test`. This disposable-file test checks persistence across replacement of the sample pod. It doesn't test backup recovery, storage failure, the application's real write path, or application consistency. The bare Pod is a teaching aid that you recreate manually here; use an appropriate controller for a production workload.

## Protect data throughout its lifecycle

A persistent volume can outlive the pod that uses it, but persistent storage isn't a backup. Before an application holds production data, establish and test a recovery plan:

1. Agree on acceptable data loss and recovery time.
1. Identify the application data and Kubernetes configuration needed for recovery.
1. Choose an application-consistent capture method, coordinating writes or using application-native backup procedures as required. Store backups outside the original storage's failure domain with appropriate access protection.
1. Restore into isolated test resources. Verify an application-level result, such as a known record or file, and measure recovery time.
1. Repeat the test after relevant application or platform changes.

Confirm backup-tool support for the exact Azure Local deployment, Kubernetes version, and CSI driver. Don't assume cloud-AKS backup features or node-VM backups protect these application volumes. The Azure Local recovery options identify partner tools; their applicability and recovery procedure still need to be established for your configuration.

## Clean up disposable lab storage

Cleanup is optional. Before deleting anything, inspect the PV associated with the bound claim. Reuse `$namespace` from this exercise. If you're in a new terminal, set that value again and retrieve `$pvName` with this block rather than assuming either variable is available.

```powershell
$claimPhase = kubectl --kubeconfig .\contoso-aks-kubeconfig --namespace $namespace `
    get pvc app-data -o jsonpath='{.status.phase}'
if ($LASTEXITCODE -ne 0 -or $claimPhase -ne 'Bound') {
    throw "The claim lookup failed or the claim isn't Bound. Inspect its events."
}
$pvName = kubectl --kubeconfig .\contoso-aks-kubeconfig --namespace $namespace `
    get pvc app-data -o jsonpath='{.spec.volumeName}'
if ($LASTEXITCODE -ne 0 -or [string]::IsNullOrWhiteSpace($pvName)) {
    throw 'The claim lookup failed or no PV was returned. Stop before cleanup.'
}
kubectl --kubeconfig .\contoso-aks-kubeconfig get pv $pvName
if ($LASTEXITCODE -ne 0) {
    throw 'PV lookup failed. Stop before cleanup.'
}
kubectl --kubeconfig .\contoso-aks-kubeconfig describe pv $pvName
if ($LASTEXITCODE -ne 0) {
    throw 'PV inspection failed. Stop before cleanup.'
}
```

Confirm that `$pvName` identifies the claim's volume. Read that PV's reclaim policy rather than assuming the storage class's current policy describes every previously provisioned volume.

> [!WARNING]
> Delete the sample claim only when its data is disposable or an appropriate restore has been verified. With the `Delete` policy and a supporting provisioner, claim deletion releases the PV for deletion along with its backing storage. The documented default disk storage on this platform deletes the backing VHDX. Persistence doesn't protect against this deletion.

For the isolated sample only, delete the pod before deleting its claim:

```powershell
kubectl --kubeconfig .\contoso-aks-kubeconfig --namespace $namespace `
    delete pod storage-check --wait=true --timeout=300s
if ($LASTEXITCODE -ne 0) {
    throw "Pod deletion didn't complete. Stop before deleting the claim."
}
kubectl --kubeconfig .\contoso-aks-kubeconfig --namespace $namespace `
    delete pvc app-data --wait=true --timeout=300s
if ($LASTEXITCODE -ne 0) {
    throw "Claim deletion didn't complete. Inspect its status before continuing."
}
kubectl --kubeconfig .\contoso-aks-kubeconfig get pv $pvName
```

Deletion is asynchronous, and an in-use claim is protected until no pod uses it. With `Delete`, the final query should eventually return `NotFound` after the PV and backing VHDX are deleted. With `Retain`, expect a `Released` volume requiring deliberate administrator recovery or cleanup; it isn't automatically handed to another claim. Inspect status and events if deletion remains incomplete. Any query failure other than the expected `NotFound` is a reason to stop, not evidence that deletion succeeded.

Don't remove protection finalizers or delete backing files to hurry cleanup. Only if this exercise created the isolated namespace and no other resources in it are needed, remove the namespace:

```powershell
kubectl --kubeconfig .\contoso-aks-kubeconfig delete namespace $namespace
if ($LASTEXITCODE -ne 0) {
    throw 'Namespace deletion failed. Inspect its status instead of forcing deletion.'
}
```

For the platform's storage model, CSI drivers, and recovery guidance, see the Summary unit's **More info** section.
