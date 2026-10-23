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

For example, Contoso can reserve a set of Windows nodes for a dedicated application with a custom taint. This example requires an existing Windows node. If the cluster only has its default Linux pool, complete the Windows node-pool preparation and creation in the Windows workload unit before you try this example.

Replace `windows-node-name` with the intended node name:

```powershell
kubectl --kubeconfig .\contoso-aks-kubeconfig taint nodes windows-node-name `
    dedicated=windows-apps:NoSchedule
```

`NoSchedule` prevents new pods without a matching toleration from being scheduled onto that node. It doesn't evict pods that are already running.

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

The selector requires Windows nodes. The toleration permits the pod to use nodes with the custom taint. If the workload must use only a particular pool, add a selector for an appropriate pool label as well. Inspect existing node labels and taints before changing them.

> [!IMPORTANT]
> Taints affect which workloads can schedule on a node. Test changes with the system and application workloads that use the pool. Don't indiscriminately taint all Linux nodes that host the Arc agents.

## Investigate pending pods

With the Arc proxy running, inspect node labels, pod placement, and scheduling events:

```powershell
kubectl --kubeconfig .\contoso-aks-kubeconfig get nodes --show-labels
kubectl --kubeconfig .\contoso-aks-kubeconfig get pods -o wide
kubectl --kubeconfig .\contoso-aks-kubeconfig describe pod 'pod-name'
```

Replace `pod-name` before running the last command. Compare the pod's selector, tolerations, resource requests, and storage requirements with the available nodes. A node selector alone doesn't create a missing Windows pool or provide additional resources.

See [AKS on Azure Local mixed-OS deployments](/azure/aks-hybrid-edge/local/hyperconverged/cluster-architecture#mixed-os-deployments) and [Kubernetes taints and tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/).
