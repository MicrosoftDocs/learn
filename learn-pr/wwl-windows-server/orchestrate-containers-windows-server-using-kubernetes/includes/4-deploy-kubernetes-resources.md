You need to understand how you might apply Kubernetes to the Contoso containerized workloads. The following high-level steps outline the general process of creating a Kubernetes orchestration solution.

## Create a Kubernetes orchestration solution

The process for creating a Kubernetes orchestration solution includes the following general steps:

1. Create a *Kubernetes master*. The Kubernetes master is configured on a host that's running a compatible version of the Linux OS. You can install the *kubeadm* tool on your host and use it to initialize the Kubernetes master/control plane node. The *kubeadm* tool can initialize a Kubernetes cluster quickly, with minimum features and addons, and provide all the tools that are required to administer your cluster nodes. You'll also need to install Docker to allow for container support.

1. Configure a pod networking solution. To enable communication between pods, you need to install a pod network on your cluster. The Kubernetes networking model can be implemented by choosing a network solution plugin or addon that's best suited to your requirements. You can use the *kubectl* CLI tool to install an appropriate network plugin to your control plane node.

    > [!NOTE]
    > The network solution that's typically used to create routable cluster subnets is a Linux-based CNI plugin called *Flannel*. Other possible solutions include configuring a smart top-of-rack (ToR) switch or using Open vSwitch (OvS) or Open Virtual Network (OVN) technology.

1. Join worker nodes. After creating the Kubernetes master and configuring the network solution, you can join Windows Server and Linux-based worker nodes to the cluster. Joining the worker nodes consists of configuring OS-specific binaries and then connecting them to the network solution.

    > [!NOTE]
    > Since the release of Kubernetes version 1.14, Windows-based nodes are supported for both worker nodes and for scheduling Windows containers. Windows-based worker nodes must be on Windows Server 2019 and Windows Server version 1809 or newer.

1. Manage Kubernetes resources. Use the `kubectl` command to deploy and manage the Kubernetes pods that hold the containers for your applications.

> [!TIP]
> Cloud services such as the AKS provide a hosted Kubernetes environment. This addresses the challenges associated with manually configuring Kubernetes clusters.
>
> These kinds of services also simplify the deployment and management of containerized applications in Azure. With AKS, you get the benefits of using Kubernetes without the complexity or operational overhead of running your own custom Kubernetes cluster.