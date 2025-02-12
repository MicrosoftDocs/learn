Containers are complete, replicable compute environments where you can run code safely. Kubernetes is designed to run many containers and orchestrate them into scalable and versatile systems.

In your role at the global cycling retailer, you've been migrating your public-facing website to run in containers and then using Google Kubernetes Engine (GKE) to orchestrate them. Now, you need to know how to migrate that system to Azure.

In this unit, you compare services that host Kubernetes in Azure and Google Cloud.

:::image type="content" source="../media/kubernetes-overview.png" alt-text="Diagram that shows the types of services provided by Microsoft Azure and Google Cloud, with Kubernetes highlighted." border="false":::

## What is Kubernetes?

A popular approach to custom system deployment is to use virtual compute resources called *containers*. A container is much like a virtual machine (VM) in that it provides an isolated virtual computer on which a process can run in a consistent and predictable environment. But because a container shares the operating system with the host computer, it's smaller and more flexible than a VM.

Some systems run on multiple containers. Each container runs one instance of a component such as a microservice. Those containers must communicate, share resources, and respond to users. If demand increases, the organization should respond by increasing the number of instances of relevant containers.

Kubernetes is an open-source container orchestration platform that automates the deployment, scaling, and management of containerized applications. You can use it to manage clusters of containers. It provides features such as load balancing, service discovery, automated rollouts, storage orchestration, and self-healing capabilities.

Kubernetes can run on-premises or in the cloud. Azure and Google Cloud both provide Kubernetes hosting services:

- **Azure**: Azure Kubernetes Services (AKS)
- **Google Cloud**: Google Kubernetes Engine (GKE)

## Compare Kubernetes in Azure and Google Cloud

Let's compare GKE to AKS and discuss their differences:

| Purpose | AKS | GKE |
|---|---|---|
| Integration and ecosystem | AKS is integrated with Azure DevOps, Azure Monitor, and Microsoft Entra ID. | GKE is integrated with Google Cloud services like BigQuery and Cloud Storage for monitoring and logging. |
| Cluster management | AKS provides a managed control plane but requires more manual intervention than GKE for updates. It also supports node autoscaling, but the implementation differs slightly. | GKE offers a fully managed control plane with automatic updates and scaling. Features like node autorepair and autoscaling are built in. |
| Networking | AKS relies on Azure virtual networks with a flat network or Container Network Interface (CNI) architecture. It supports network security groups and Azure Firewall. | GKE uses Google's global Virtual Private Cloud (VPC) network, which provides high-performance and low-latency connectivity. It supports native VPC and advanced network configurations. |
| Ingress | AKS has two options: Application Gateway for Containers, which is an L7 regional load balancer; or a fully managed NGINX add-on. | GKE uses an L7 global load balancer.|
| Identity and access management (IAM) | AKS uses Microsoft Entra ID for authentication and role-based access control within the cluster, or classic Kubernetes role-based access control. | GKE integrates with Google Cloud IAM for managing permissions and roles within the cluster or Kubernetes role-based access control. |
| Monitoring and logging | You can use Azure Monitor and Log Analytics to monitor AKS. Azure provides insights and dashboards tailored to AKS. | For logging, monitoring, and alerting, Google Cloud includes Cloud Monitoring and Cloud Logging. They integrate seamlessly with GKE. |
| Service-level agreements (SLAs) | The SLA for uptime applies to the AKS API server. | The SLA for uptime applies to the GKE control plane. |
| Deployment and configuration | You can use Azure CLI commands to deploy containers to AKS, or declarative files in Azure Resource Manager template or Bicep format. Alternatively, Kubernetes manifests are supported. | The Google Cloud CLI has deployment commands, or you can use Terraform files or Kubernetes manifests. |
| Service mesh | GKE uses Cloud Service Mesh, which resides outside the cluster as a fully managed service. | AKS offers Istio as fully managed Kubernetes add-on. |

## Learn more

- [Deploy an Azure Kubernetes Service cluster by using the Azure portal](/azure/aks/learn/quick-kubernetes-deploy-portal)
- [Deploy an Azure Kubernetes Service cluster](/training/modules/deploy-azure-kubernetes-service-cluster/)
