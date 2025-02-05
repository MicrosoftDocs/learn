Containers are complete, replicable compute environments where you can run code safely. Kubernetes is the most popular system designed to run many containers and orchestrate them into scalable and versatile systems.

In your global cycling manufacturer, you've been migrating your public-facing web site to run in containers and then using Google Kubernetes Engine (GKE) to orchestrate them. Now, you need to know how to migrate that system to Azure.

In this unit, you compare services that host Kubernetes in Azure and Google Cloud.

:::image type="content" source="../media/kubernetes-overview.png" alt-text="A diagram showing the types of service provided by Microsoft Azure and Google Cloud.":::

## What is Kubernetes?

A popular approach to custom system deployment is to use virtual compute resources called **containers**. A container is much like a Virtual Machine (VM) in that it provides an isolated virtual computer on which a process can run in a consistent and predictable environment. However, because a container shares the OS with the host computer, it's smaller and more flexible than a VM.

Systems are being built that run on multiple containers, each running one instance of a component such as a microservice. Those containers must therefore communicate, share resources, and respond to users. If demand increases, you should respond by increasing the number of instances of relevant containers.

Kubernetes is an open-source container orchestration platform that automates the deployment, scaling, and management of containerized applications. You can use it to manage clusters of containers, and it provides features such as load balancing, service discovery, automated rollouts, storage orchestration, and self-healing capabilities.

Kubernetes can run on-premises or in the cloud. Azure and Google Cloud both provide Kubernetes hosting services:

- **Google Cloud**: Google Kubernetes Engine (GKE)
- **Azure**: Azure Kubernetes Services (AKS)

## Compare Kubernetes in Azure and Google Cloud

Let's compare GKE to AKS and discuss their differences:

| Purpose | AKS | GKE |
|---|---|---|
| Integration and ecosystem | AKS is integrated with Azure DevOps, Azure Monitor, and Microsoft Entra ID. | GKE is integrated with Google Cloud services like BigQuery, Cloud Storage, and Stackdriver for monitoring and logging. |
| Cluster management | Provides a managed control plane but requires more manual intervention than GKE for updates. It also supports node autoscaling, but the implementation differs slightly. | Offers a fully managed control plane with automatic updates and scaling. Features like node autorepair and autoscaling are built in. |
| Networking | AKS relies on Azure Virtual Networks (VNets) with a flat network or Container Network Interface (CNI) architecture. It supports Network Security Groups (NSGs) and Azure Firewall. | GKE uses Google’s global Virtual Private Cloud (VPC) network, which provides high-performance and low-latency connectivity. It supports native VPC and advanced network configurations. |
| Ingress | GKE uses L7 Global Load Balancer | AKS has two options: Application Gateway for Containers which is a L7 regional load balancer or a fully managed NGINX addon|
| Identity and Access Management (IAM) | AKS uses Microsoft Entra ID for authentication and role-based access control within the cluster or classic Kubernetes role-based access control | GKE integrates with Google Cloud IAM for managing permissions and roles within the cluster or Kubernetes role-based access control |
| Monitoring and logging | You can use Azure Monitor and Azure Log Analytics to monitor AKS. Azure provides insights and dashboards tailored to AKS. | Google Cloud includes Stackdriver for logging, monitoring, and alerting, which integrates seamlessly with GKE. |
| Service Level Agreements (SLAs) | The SLA of 99.95% up time applies to the AKS API server. | The SLA of 99.95% up time applies to the GKE control plane. |
| Deployment and configuration | You can use Azure CLI commands to deploy containers to AKS, or declarative files in ARM template or Bicep format. Alternatively, Kubernetes manifests are supported | The gcloud CLI has deployment commands or you can use Terraform files or Kubernetes manifests. |
| Service Mesh | GKE uses Anthos Service Mesh which resides outside of the cluster as a fully managed service | AKS offers Istio as fully managed Kubernetes addon |

## Learn more

- [Deploy an Azure Kubernetes Service (AKS) cluster using Azure portal](/azure/aks/learn/quick-kubernetes-deploy-portal)
- [Deploy an Azure Kubernetes Service cluster](/training/modules/deploy-azure-kubernetes-service-cluster/)
