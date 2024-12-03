Azure Kubernetes Service (AKS) manages your hosted Kubernetes environment and makes it simple to deploy and manage containerized applications in Azure. An AKS environment has features like automated updates, self-healing, and quick scaling. You manage the agent nodes in the cluster and pay only for the virtual machines that run your nodes.

Here are some of the many benefits of using AKS for your Windows container networking:

- AKS implements the Docker image file format. You can use any development environment to create a workload, package the workload as a container, and deploy the container as a Kubernetes pod.
- AKS works with common development and management tools such as Helm, Draft, Kubernetes extension for Visual Studio Code, and Visual Studio Kubernetes Tools.
- AKS supports integration with Azure DevOps Projects to simplify setting up a DevOps pipeline for your application.

## AKS and Windows containers

On a single host or development environment, the standard container management runtime is focused on managing individual containers. Sometimes you need to scale your configuration and create multiple containers that work together. Scaling multiple containers is more challenging in terms of container management. You need to address load balancing, security, network connectivity, and deployment. To help make this process easier, it's common to use a container management platform such as Kubernetes.

AKS is a container orchestration platform that makes it simple to develop, deploy, and manage containerized applications. You can use AKS to manage your hosted Kubernetes environment in Azure. AKS streamlines the installation process and takes care of most of the underlying cluster management tasks. AKS is part of Azure and can be integrated with other Azure services to extend your product or exchange data with other services.

> [!IMPORTANT]
> To deploy Windows Server containers on AKS, your configuration must satisfy the following requirements:
>
> - Use the Azure CNI network plugin for your Kubernetes cluster.
> - Use Windows Server 2019 or later for your Windows nodes. Earlier versions of Windows Server don’t support overlay networks, which are required by Azure CNI.
> - Use Kubernetes version 1.14 or later. Earlier versions of Kubernetes don’t support Windows nodes or pods.

## AKS and networking

In AKS, you can deploy a Windows container cluster that uses Azure Container Networking Interface (Azure CNI) networking. In this model, pods receive full virtual network connectivity: pod to pod and pod to virtual machine, in the same or in a peered virtual network. Pods are accessible through their private IP address on connected networks.

Azure CNI supports Windows node pools. Clusters can be deployed in existing or new virtual networks. On-premises access is supported by using VPN or Azure Express Route. You can expose Kubernetes services by using a load balancer service, Azure App Gateway, or through an ingress controller.

## Traffic control with network policies

The best practice for Windows containers with AKS is to use network policies to allow or deny traffic to your pods. By default, all traffic is allowed between pods within a cluster. For improved security, you can define rules to limit pod communication.

**Network policy** is a Kubernetes feature available in AKS that lets you control the traffic flow between pods. You allow or deny traffic to the pod based on settings such as assigned labels, namespace, or traffic port. Network policies are a cloud-native way to control the flow of traffic for pods. As pods are dynamically created in an AKS cluster, required network policies can be automatically applied.

## AKS considerations

AKS supports a virtual network configuration, where you need pod to pod network communication or access to on-premises networks from your Windows cluster. A Windows AKS cluster can be deployed into an existing virtual network with ease.

Here are some features of AKS to consider when planning for Windows container networking:

| Feature | Consideration | Solution |
|-|-|-|
| **Docker image support** | Use Docker images for your containers | AKS supports the Docker file image format by default. |
| **Virtual network support** | Support pod to pod network communication, access on-premises networks from your AKS cluster | An AKS cluster can be deployed into an existing virtual network with ease. |
| **Ingress with HTTP application routing support** | Make your deployed applications publicly available | The HTTP application routing add-on makes it easy to access AKS cluster deployed applications. |
| **Automatic cluster node and pod scaling** | Scale up or down, scale resources in a large containerization environment | AKS supports easy scaling for your clusters and provides two auto-cluster scaling options for large environments.<br>- The **horizontal pod autoscaler** watches the resource demand of pods and increases pods to meet demand.<br>- The **cluster autoscaler** component watches for pods that can't be scheduled because of node constraints. It automatically scales cluster nodes to deploy scheduled pods. |
| **Integrated logging and monitoring** | Monitor containers, pods, and clusters | AKS includes Azure Monitor for containers to provide performance visibility of the cluster. With a custom Kubernetes installation, use Azure Monitor, or install and configure Azure Log Analytics or Azure Application Insights. |
| **High availability** | Ensure high availability and fault tolerance | AKS helps you achieve high availability and fault tolerance for your Windows clusters by distributing your nodes across availability zones and regions. |
| **Security integration** | Protect your Windows clusters and applications | AKS integrates with Microsoft Entra ID (formerly *Azure Active Directory*), Azure Key Vault, Azure Policy, and Azure Security Center. |