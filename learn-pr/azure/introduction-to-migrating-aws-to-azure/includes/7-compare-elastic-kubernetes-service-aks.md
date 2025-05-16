Containers are complete, portable compute environments where you can run code safely. Kubernetes is the most popular system designed to run many containers and orchestrate them into scalable and versatile systems.

In your global clothing retailer, you've been migrating your public-facing web site to run in containers and then using Amazon Elastic Kubernetes Service (EKS) to orchestrate them. Now, you need to know how to migrate that system to Azure.

In this unit, you compare services that host Kubernetes in Azure and Amazon Web Services (AWS).

:::image type="content" source="../media/kubernetes-overview.png" alt-text="A diagram showing the types of service provided by Microsoft Azure and Amazon AWS." border="false":::

## What is Kubernetes?

In recent years, many organizations are hosting their systems using virtual compute resources called **containers**. A container is much like a Virtual Machine (VM) in that it provides an isolated virtual computer on which a process can run in a consistent and predictable environment. However, because a container shares the OS with the host computer, it's smaller and more flexible than a VM.

Systems are being built that run on multiple containers, each running one instance of a component such as a microservice. Those containers must therefore communicate, share resources, and respond to users. If demand increases, you should respond by increasing the number of instances of relevant containers.

Kubernetes is an open-source container orchestration platform that automates the deployment, scaling, and management of containerized applications. You can use it to manage clusters of containers, and it provides features such as load balancing, service discovery, automated rollouts, storage orchestration, and self-healing capabilities.

Kubernetes can run on-premises or in the cloud. Azure and AWS both provide Kubernetes hosting services:

- **AWS**: Amazon Elastic Kubernetes Service (EKS)
- **Azure**: Azure Kubernetes Services (AKS)

## Compare Kubernetes in Azure and Amazon

A Kubernetes hosting service, such as AKS or EKS, must provide a consistent environment for hosting containers, so that developers don't have to target their solution a particular service. Therefore, if you're familiar with EKS, you should find the design of AKS similar and comfortable.

However there are some differences. Let's examine them here:

| Purpose | AKS | AWS EKS | Comments |
|---------|---------|---------|---------|
| Service integration | Integrates with Azure services such as [Microsoft Entra ID](/entra/fundamentals/whatis) for identity management, Azure Monitor for monitoring, and [Azure Container Registry (ACR)](/azure/container-registry/container-registry-intro). | Tightly integrated with other AWS services such as IAM (Identity and Access Management), CloudWatch (monitoring), and ECR (Elastic Container Registry). | |
| Cluster Management | Requires manual configuration for setting up and managing the Kubernetes control plane and worker nodes. Management features are more automated, including automated updates and scaling of the control plane and worker nodes. | AWS handles the control plane, but you need to manage the worker nodes. | |
| Networking | Uses [Azure Virtual Networks (VNets)](/azure/virtual-network/virtual-networks-overview), which are tightly integrated with Azure’s networking services. This approach simplifies network management. | Uses AWS Virtual Private Cloud (VPC) for networking, which offers flexibility but might require some more configuration. | |
| Security | Uses Microsoft Entra ID for role-based access control (RBAC).| Relies heavily on AWS IAM for authentication and authorization, which can be complex but powerful. | |
| Logging and Monitoring | Uses [Azure Monitor](/azure/azure-monitor/overview) and [Log Analytics](/azure/azure-monitor/logs/log-analytics-overview), which provides integrated monitoring and logging solutions out of the box. You can also use [Azure Managed Grafana](/azure/managed-grafana/overview) and [Prometheus](/azure/azure-monitor/essentials/prometheus-metrics-overview). | Uses CloudWatch for logging and monitoring, which requires configuration to collect and visualize logs and metrics. | |
| Updates and Upgrades | Offers more automated upgrade processes, including the ability to upgrade the control plane and node pools with minimal downtime. | Typically requires more manual intervention for cluster updates and upgrades, although AWS provides tools to assist with these tasks. | |
| Pricing | The Kubernetes control plane is free and you only pay for the worker nodes. This arrangement can be more cost-effective depending on your usage pattern. | Charges for both the control plane and the worker nodes. The control plane has a fixed cost, and the worker nodes are billed based on EC2 instance usage. | |

## Learn more

- [Deploy an Azure Kubernetes Service (AKS) cluster using Azure portal (Quickstart)](/azure/aks/learn/quick-kubernetes-deploy-portal)
- [Deploy an Azure Kubernetes Service cluster](/training/modules/deploy-azure-kubernetes-service-cluster/)
