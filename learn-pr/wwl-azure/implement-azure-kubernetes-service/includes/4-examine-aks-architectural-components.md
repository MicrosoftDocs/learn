A Kubernetes cluster is divided into two components:

 -  Cluster master nodes provide the core Kubernetes services and orchestration of application workloads.
 -  Nodes that run your application workloads.

:::image type="content" source="../media/aks-components-5fbc204a.png" alt-text="Graphic representing an Azure managed cluster master, which is in a box. A second box within contains a scheduler, controller, API server, and storage. A separate customer managed node box has boxes within containing container runtime, container, kubelet and kube proxy. Kubelet container and the Node box have arrows pointing to scheduler in the Cluster master box.":::


## Cluster master

When creating an AKS cluster, a cluster master is automatically created and configured.

This cluster master is provided as a managed Azure resource abstracted from the user.

There's no cost for the cluster master, only the nodes part of the AKS cluster.

The cluster master includes the following core Kubernetes components:

 -  kube-apiserver. The API server is how the underlying Kubernetes APIs are exposed. This component interacts with management tools such as kubectl or the Kubernetes dashboard.
 -  etcd. To maintain the state of your Kubernetes cluster and configuration, the highly available etcd is a key-value store within Kubernetes.
 -  kube-scheduler. The Scheduler determines what nodes can run the workload and starts when creating or scaling applications.
 -  kube-controller-manager. The Controller Manager oversees several smaller controllers that do actions such as replicating pods and managing node operations.

## Nodes and node pools

To run your applications and supporting services, you need a Kubernetes node.

An *AKS cluster*, which is an Azure virtual machine (VM) that runs the Kubernetes node components and container runtime, contains one or more nodes:

 -  The *kubelet* is the Kubernetes agent that processes the orchestration requests from the cluster master and schedules the requested containers.
 -  The kube-proxy handles virtual networking on each node. The proxy routes network traffic and manage IP addressing for services and pods.
 -  The *container runtime* is the component that allows containerized applications to run and interact with more resources such as the virtual network and storage.
    
     -  In AKS, Docker is used as the container runtime by default. For Linux and Windows Server 2019 node pools, containerd is used for node pools using specific Kubernetes versions.

Nodes of the same configuration are grouped into *node pools*. A Kubernetes cluster contains one or more node pools.

The initial number of nodes and size is defined when creating an AKS cluster, making a default node pool.

This default node pool in AKS contains the underlying VMs that run your agent nodes.

## Pods

Kubernetes uses pods to run an instance of your application. A pod represents a single instance of your application.

Pods typically have a 1:1 mapping with a container, although there are advanced scenarios where a pod might contain multiple containers.

These multi-container pods are scheduled together on the same node and allow containers to share related resources.

When you create a pod, you can define resource limits to request a certain amount of CPU or memory resources.

The Kubernetes Scheduler attempts to schedule the pods to run on a node with available resources to meet the request.

You can also specify maximum resource limits that prevent a given pod from consuming too much compute resource from the underlying node.

> [!NOTE]
> A best practice is to include resource limits for all pods to help the Kubernetes Scheduler understand what resources are needed and permitted.

A pod is a logical resource, but the container (or containers) is where the application workloads. Pods are typically ephemeral, disposable resources.

Therefore, individually scheduled pods miss some of the high availability and redundancy features Kubernetes provides.

Instead, pods are deployed and managed by Kubernetes controllers, such as the Deployment controller.
