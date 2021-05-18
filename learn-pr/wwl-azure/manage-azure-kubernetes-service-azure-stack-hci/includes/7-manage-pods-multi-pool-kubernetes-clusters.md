Contoso developers are working on transforming internally developed Windows and Linux applications into Docker-based images deployable using Helm charts. In your planning for implementing Kubernetes clusters on Azure Stack HCI, you need to ensure support for both operating system platforms.

## What are node pools in Kubernetes clusters on Azure Stack HCI

AKS on Azure Stack HCI supports multiple node pools in the same Kubernetes cluster. Each pool consists of identically configured VMs, according to the settings you specify when provisioning that pool. 

By grouping nodes into separate pools, you can target pod deployments to the suitable set of VMs. For example, you might have containerized workloads that are supported only by the Windows operating system or require specialized hardware, such as graphics processor units. 

## Control deployment of pods into node pools in Kubernetes clusters on Azure Stack HCI

By default, Kubernetes schedules provisioning of containerized workloads on any available worker nodes in a manner that optimizes resource utilization. To alter this behavior, you can apply constraints on the choice of nodes based on custom criteria that you specify. These constraints include node selectors and taints and tolerations. 

### Node selectors

Node Selector is a setting within the YAML-based definition of a pod or a deployment that identifies the target nodes onto which the corresponding pod can be scheduled. If your intention is to designate target nodes based on their operating system, you can rely on the built-in labels automatically assigned to nodes by Kubernetes. Depending on the intended operating system, the node selector will take the form `kubernetes.io/os = Windows` or `kubernetes.io/os = Linux`. For example, the following YAML-based pod manifest designates Linux nodes as deployment targets:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
  labels:
    env: test
spec:
  containers:
  - name: nginx
    image: nginx
  nodeSelector:
    kubernetes.io/os = Linux
```

### Taints and tolerations

Taints and tolerations provide an alternative approach to controlling pod placement. With this approach, taints are part of the node configuration and tolerations are part of pod specifications. By tainting a node, you effectively prevent it from hosting any pod without the corresponding taint-specific toleration.

For example, in AKS on Azure Stack HCI, if you wanted to allow for a pod to be scheduled on a Windows node, you should add the following toleration to its definition: 

```yaml
tolerations:
- key: node.kubernetes.io/os
  operator: Equal
  value: Windows
  effect: NoSchedule
```

In addition, you would need to add the taint `node.kubernetes.io/os=Windows:NoSchedule` to each of the Windows nodes that you want to make available exclusively for deployment of pods with the corresponding toleration. To accomplish this, you could use the kubectl command line utility, and then, after you connect to the target cluster, run the following command for each of the nodes in scope (where the `<node_name>` placeholder designates the name of the target node):

```kubectl
kubectl taint node <node_name> node.kubernetes.io/os=Windows:NoSchedule
```

> [!NOTE]
> Node selectors enforce placements of pods on a specific set of nodes. Tolerations allow pods to run on a designated set of tainted nodes, but does not prevent their placement on nodes without taints.