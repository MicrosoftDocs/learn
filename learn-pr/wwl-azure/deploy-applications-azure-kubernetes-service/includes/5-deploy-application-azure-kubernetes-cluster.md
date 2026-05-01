So far, you've been provisioning individual pods to illustrate security- and storage-related Azure Kubernetes Service (AKS) concepts. However, for stateless workloads, the recommended approach is to manage pods by using Kubernetes Deployments. Stateful workloads can use StatefulSets when they require stable identities or persistent storage. In this unit, we examine the differences between pods and Deployments and describe the benefits associated with Deployments.

### Explore Kubernetes pods

Kubernetes uses *pods* to run individual instances of containerized applications. A pod is a logical Kubernetes resource, but application workloads run within a container. There's typically a 1:1 mapping between a pod and a container, although there are scenarios in which a pod may contain multiple, closely integrated containers. All containers that are part of the same pod run on the same node and share networking and storage resources.

When you author a pod, you specify *resource requests* and *limits* on each container. The Kubernetes Scheduler places the pod on a node with sufficient unallocated CPU and memory based on the pod's effective request, which is the sum of its regular container requests, or the highest individual init container request if that's greater, plus any pod overhead. Limits cap the resources a container can consume at runtime: CPU usage is throttled to the limit, while memory limits are enforced reactively, and a container or one of its processes that exceeds the limit can be terminated by the kernel out-of-memory killer when the node is under memory pressure. Setting requests and limits prevents a pod from starving the node or other workloads.

Because pods are ephemeral and disposable by default, deploying them as individual resources considerably limits their resiliency and is typically not suitable for production environments. To realize the high availability and redundancy benefits offered by the AKS platform, you should deploy and manage pods by using Kubernetes *controllers*, such as the Deployment Controller.

### Explore Kubernetes Deployments

A *Deployment* manages a set of pods through ReplicaSets, working to maintain a desired state defined by a pod template. At steady state the replicas share that template, but during rolling updates a Deployment can manage multiple ReplicaSets with different templates, so old and new pods coexist briefly. A Deployment defines the number of pod *replicas* to create, manages ReplicaSets, and lets each ReplicaSet maintain the requested number of pod replicas. If a pod or node fails, the controller creates replacement pods, and the Kubernetes Scheduler places them on healthy nodes with available resources.

You can update Deployments to change the pod template, including the configuration of pods, their container image, or attached storage. During a rolling update, the Deployment Controller:

- Creates a new ReplicaSet that uses the updated pod template.
- Gradually scales down the old ReplicaSet while scaling up the new ReplicaSet, in line with the Deployment's `maxSurge` and `maxUnavailable` settings.
- Continues the process until the new ReplicaSet has fully replaced the old one.

By default, Deployments use 25% `maxUnavailable` and 25% `maxSurge`. Kubernetes rounds percentage values during a rollout (`maxUnavailable` down and `maxSurge` up), so the 75% available and 125% surge figures are a rule of thumb that depends on the replica count; with four replicas, the controller keeps at least three pods available and allows up to five non-terminating pods. Pods that are terminating can continue to exist and use resources until their grace periods expire, so observed pod counts or resource use can briefly exceed `replicas + maxSurge`.

In addition, if your application requires a minimum number of available instances, you can use *Pod Disruption Budgets* to define how many replicas of a replicated application can be unavailable during voluntary disruptions, such as node drains or AKS node upgrades. Pod Disruption Budgets don't control Deployment rolling updates; use `maxSurge` and `maxUnavailable` for rollout behavior, although pods unavailable during a rollout count against the budget.

Stateful workloads that require stable network identities, ordered deployment or scaling, or stable persistent storage should use *StatefulSets* instead of Deployments.

Most stateless applications in AKS should be managed by Deployments rather than as individually scheduled pods. Kubernetes can monitor Deployment health and status to ensure that the required number of replicas run within the cluster. When scheduled individually, pods don't have a controller to create a replacement if the pod is deleted or the node fails. The kubelet might restart containers on the same node according to the pod's restart policy, but Kubernetes doesn't recreate the pod elsewhere. In addition, Deployments support controlled rollouts and rollbacks.

To help define the Deployment, you use a manifest file in YAML format. You reference the manifest file when running the `kubectl create` or `kubectl apply` commands. For more information, see [AKS cluster and workload concepts](https://learn.microsoft.com/azure/aks/concepts-clusters-workloads).

### Deploy AKS workloads with Helm

Rather than authoring and managing YAML manifests directly, you might want to consider using Helm. Helm is an open-source package manager for Kubernetes. It automates management of containerized applications by installing reusable packages referred to as Helm *charts* that contain Kubernetes resource definitions, templated manifests, and default configuration values. Each chart installation creates a *release* that Helm can track, upgrade, or roll back. You can store Helm charts either locally or in a remote repository, such as an Azure Container Registry.

### Namespaces

Kubernetes resources, such as pods and Deployments, are logically grouped into *namespaces*, which helps with organizing them in the manner that reflects their intended use. Namespaces scope resource names and can be used with RBAC, resource quotas, and network policies, but they aren't a hard security boundary by themselves.

When you create an AKS cluster, the following namespaces are created by default:

- **default**: serves as the default namespace for resources that weren't allocated to another namespace during their creation. When you interact with the Kubernetes API (for example, when running `kubectl get pods`), the default namespace is used when none is specified.
- **kube-node-lease**: enables nodes to communicate their availability to the control plane.
- **kube-public**: isn't typically used, but you can use it so that resources are readable across the entire cluster by any client.
- **kube-system**: hosts core resources, including `CoreDNS`, `konnectivity-agent`, and `metrics-server`, and — when the cluster networking mode uses it — `kube-proxy`. AKS clusters that use Azure CNI powered by Cilium don't run `kube-proxy`. When using AKS, you don't deploy your own applications into this namespace.

> [!NOTE]
> `kube-root-ca.crt` is a ConfigMap that Kubernetes creates in namespaces so pods can verify internal Kubernetes API endpoints; it isn't a namespace. AKS add-ons can create additional namespaces. The Azure Policy add-on runs the `azure-policy` pods in `kube-system` and the Gatekeeper pods in `gatekeeper-system`. The Istio-based service mesh add-on uses `aks-istio-system` for control plane components and, when ingress gateways are enabled, `aks-istio-ingress` for the ingress gateway. Don't deploy application workloads into AKS-managed namespaces unless the documentation for that feature instructs you to.
