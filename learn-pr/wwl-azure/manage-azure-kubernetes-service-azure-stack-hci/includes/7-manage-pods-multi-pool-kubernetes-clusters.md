Contoso's Linux and Windows applications need different worker nodes. Node pools group nodes with a common configuration, while Kubernetes scheduling rules determine which nodes can host each pod.

## Select the required operating system

Use the `kubernetes.io/os` node label to restrict a pod to nodes that run its required operating system. The values are lowercase: `linux` and `windows`.

The following Deployment runs a Linux web container. The node selector belongs in the pod template, not at the top level of the Deployment:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: linux-web
spec:
  replicas: 2
  selector:
    matchLabels:
      app: linux-web
  template:
    metadata:
      labels:
        app: linux-web
    spec:
      nodeSelector:
        kubernetes.io/os: linux
      containers:
      - name: web
        image: nginx:stable
        ports:
        - containerPort: 80
```

This selector prevents the Linux container from being scheduled onto a Windows node. It doesn't guarantee capacity: pods remain pending if no eligible node meets their requirements. For production, use approved images pinned to an appropriate version or digest, and define resource requests and limits for the workload.

## Combine selectors with taints and tolerations

A **taint** is configured on a node. A **toleration** is configured on a pod and permits it to tolerate a matching taint. A toleration doesn't force a pod onto the tainted node, and it doesn't prevent scheduling onto other eligible nodes.

In AKS on Azure Local, configure taints on the managed node pool rather than on one existing node. Contoso can use the `dedicated=windows-apps:NoSchedule` taint on its Windows pool to prevent new pods without a matching toleration from scheduling there.

If `winpool` already exists, use the update procedure here. If the cluster only has its default Linux pool, skip this pool-change procedure for now. The later Windows workload unit prepares and creates `winpool` with this taint. You don't need to create the pool early or run an update just to add the same taint again.

For an existing pool, inspect its current configuration in your management PowerShell session. Replace the placeholders with the resource group and cluster name used earlier. Set these variables again if you open another terminal; PowerShell variables aren't shared between processes.

```powershell
$resourceGroup = '<resource-group-containing-your-cluster>'
$clusterName = '<aks-cluster-name>'

az aksarc nodepool show --resource-group $resourceGroup `
    --cluster-name $clusterName --name winpool
if ($LASTEXITCODE -ne 0) {
    throw 'Pool lookup failed. Resolve the error before changing taints.'
}
```

Review the pool's taint list before updating it. The following update is for a lab pool that has no other taints.

> [!IMPORTANT]
> Updating `--node-taints` replaces the pool's entire existing taint list. If the pool already has taints, include every existing taint in the comma-separated value along with the new taint. Check that required workloads and agents tolerate the resulting taints. Don't apply this Windows-workload taint to the Linux pool that hosts the Arc agents.

```powershell
az aksarc nodepool update --resource-group $resourceGroup `
    --cluster-name $clusterName --name winpool `
    --node-taints "dedicated=windows-apps:NoSchedule"
if ($LASTEXITCODE -ne 0) {
    throw 'Pool update failed. Resolve the error before continuing.'
}
```

Verify the pool configuration and its nodes. Keep the Arc proxy running in its separate terminal, and run `kubectl` from the directory containing `contoso-aks-kubeconfig`. Replace `<node-from-winpool>` with a node belonging to this pool, using the node labels to identify it.

```powershell
az aksarc nodepool show --resource-group $resourceGroup `
    --cluster-name $clusterName --name winpool
kubectl --kubeconfig .\contoso-aks-kubeconfig get nodes `
    -l kubernetes.io/os=windows --show-labels
kubectl --kubeconfig .\contoso-aks-kubeconfig describe node '<node-from-winpool>'
```

The pool's nodes should show `dedicated=windows-apps:NoSchedule`. This effect prevents new scheduling without a matching toleration; it doesn't evict pods that are already running. Stop and investigate if the pool update isn't reflected on its nodes.

Add the matching toleration and an OS selector to the application's pod specification:

```yaml
nodeSelector:
  kubernetes.io/os: windows
tolerations:
- key: dedicated
  operator: Equal
  value: windows-apps
  effect: NoSchedule
```

The selector requires Windows nodes. The toleration permits the pod to use nodes with the custom taint, but doesn't require that taint to exist or force placement on that pool. If the workload must use only a particular pool, add a selector for an appropriate pool label as well. Inspect existing node labels and taints before changing them, and test changes with the system and application workloads that use the pool.

## Investigate pending pods

With the Arc proxy running, inspect node labels, pod placement, and scheduling events:

```powershell
kubectl --kubeconfig .\contoso-aks-kubeconfig get nodes --show-labels
kubectl --kubeconfig .\contoso-aks-kubeconfig get pods -o wide
kubectl --kubeconfig .\contoso-aks-kubeconfig describe pod 'pod-name'
```

Replace `pod-name` before running the last command. Compare the pod's selector, tolerations, resource requests, and storage requirements with the available nodes. A node selector alone doesn't create a missing Windows pool or provide additional resources.

See **AKS on Azure Local node-pool taints**, **Mixed-OS deployments**, and **Kubernetes taints and tolerations** in the Summary unit's **More info** section.
