In this module, you have learned about cloud-native applications and their benefits. Cloud-native applications are built from the ground up and optimized for cloud scale and performance. They are based on microservices architectures, use managed services, and take advantage of continuous delivery. Cloud-native systems make extensive use of Platform as a Service (PaaS) compute infrastructure and managed services, treating the underlying infrastructure as disposable. The Azure cloud platform supports highly elastic infrastructure with automatic scaling, self-healing, and monitoring capabilities. Cloud-native applications offer advantages such as resilience, elasticity, observability, automation, portability, security, and cost-effectiveness.

You have also examined different deployment options for cloud-native applications on Azure. Azure Container Apps enables you to build serverless microservices and jobs based on containers. It is optimized for running general-purpose containers and supports Kubernetes-style apps and microservices. Azure App Service provides fully managed hosting for web applications, making it an ideal option for web apps. Azure Container Instances provide a lower-level "building block" option compared to Container Apps, allowing you to run isolated containers on demand. Azure Kubernetes Service offers a fully managed Kubernetes option in Azure, providing direct access to the Kubernetes API. Azure Functions is a serverless Functions-as-a-Service solution optimized for event-driven applications. Azure Spring Apps is a fully managed service for Spring developers, while Azure Red Hat OpenShift provides an integrated product and support experience for running Kubernetes-powered OpenShift.

Lastly, you reviewed an Azure Container Apps solution architecture and resources. The example project involved migrating a brownfield application called Drone Delivery from Azure Kubernetes Service to Azure Container Apps. The solution architecture included HTTPS ingress, internal service discovery, user-assigned identities for authentication, secure management of secrets, and deployment using Azure Resource Manager templates. The runtime architecture featured container images sourced from Azure Container Registry and deployed to a Container Apps Environment. The workflow service ran in single revision mode, and managed identities were used for authentication in some services. The solution required various Azure resources such as Container Apps, Container Registry, Log Analytics Workspace, Azure Cosmos DB instances, Azure Redis Cache, Azure Service Bus, User Managed Identities, and Azure Key Vault instances.

Detailed resources:

- Cloud-Native Applications | Microsoft Azure [https://azure.microsoft.com/solutions/cloud-native-apps/](https://azure.microsoft.com/solutions/cloud-native-apps/)

- Introduction to cloud-native applications - .NET | Microsoft Learn [/dotnet/architecture/cloud-native/introduction](/dotnet/architecture/cloud-native/introduction)

- Comparing Container Apps with other Azure container options | Microsoft Learn [/azure/container-apps/compare-options](/azure/container-apps/compare-options)

- Azure Containers—Services and Management | Microsoft Azure [https://azure.microsoft.com/products/category/containers/](https://azure.microsoft.com/products/category/containers/)

- Deploy microservices with Azure Container Apps - [/azure/architecture/example-scenario/serverless/microservices-with-container-apps](/azure/architecture/example-scenario/serverless/microservices-with-container-apps)

- Azure Container Apps example scenario - [https://github.com/mspnp/container-apps-fabrikam-dronedelivery#expected-results](https://github.com/mspnp/container-apps-fabrikam-dronedelivery#expected-results)
