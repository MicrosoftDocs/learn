Kubernetes is a rapidly evolving platform that manages container-based applications and their associated networking and storage components. Kubernetes focuses on the application workloads, not the underlying infrastructure components. Kubernetes provides a declarative approach to deployments, backed by a robust set of APIs for management operations.

You can build and run modern, portable, microservices-based applications, using Kubernetes to orchestrate and manage the availability of the application components. Kubernetes supports both stateless and stateful applications as teams progress through the adoption of microservices-based applications.

As an open platform, Kubernetes allows you to build your applications with your preferred programming language, OS, libraries, or messaging bus. Existing continuous integration and continuous delivery (CI/CD) tools can integrate with Kubernetes to schedule and deploy releases.

AKS provides a managed Kubernetes service that reduces the complexity of deployment and core management tasks, like upgrade coordination. The Azure platform manages the AKS control plane, and you only pay for the AKS nodes that run your applications.

:::image type="content" source="../media/kubernetes-architecture-components-fb87cc85.png" alt-text="Diagram showing how the basic components and resources for Azure Kubernetes.":::


The basic components for Azure Kubernetes Service are:

 -  **Azure Kubernetes Service** (AKS). AKS is a managed Kubernetes cluster hosted in the Azure cloud. Azure manages the Kubernetes API service, and you only need to manage the agent nodes.
 -  **Virtual network**. By default, AKS creates a virtual network into which agent nodes are connected. You can create the virtual network first for more advanced scenarios, which lets you control things like subnet configuration, on-premises connectivity, and IP addressing.
 -  **Ingress**. An ingress server exposes HTTP(S) routes to services inside the cluster.
 -  **Azure Load Balancer**. Once the AKS cluster is created, the cluster is ready to use the load balancer. Then, once the NGINX service is deployed, the load balancer is configured with a new public IP that will front your ingress controller. This way, the load balancer routes internet traffic to the ingress.
 -  **External data stores**. Microservices are typically stateless and write state to external data stores, such as Azure SQL Database or Azure Cosmos DB.
 -  **Azure Active Directory**. AKS uses an Azure Active Directory (Azure AD) identity to create and manage other Azure resources such as Azure load balancers. Azure AD is also recommended for user authentication in client applications.
 -  **Azure Container Registry**. Use Container Registry to store private Docker images, which are deployed to the cluster. AKS can authenticate with Container Registry using its Azure AD identity. AKS doesn't require Azure Container Registry. You can use other container registries, such as Docker Hub.
 -  **Azure Monitor**. Azure Monitor collects and stores metrics and logs, application telemetry, and platform metrics for the Azure services. Use this data to monitor the application, set up alerts, dashboards, and perform root cause analysis of failures. Azure Monitor integrates with AKS to collect metrics from controllers, nodes, and containers.
