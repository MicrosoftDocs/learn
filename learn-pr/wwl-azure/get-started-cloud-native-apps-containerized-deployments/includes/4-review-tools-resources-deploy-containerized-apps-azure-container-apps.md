Real-world solutions often require a significant number of resources to develop and maintain. Before starting a project that implements new tools and technologies, it can be helpful to examine the tools and architecture of an existing solution.

## Examine an Azure Container Apps solution

Azure Container Apps is a fully managed environment that enables you to run microservices and containerized applications on a serverless platform. Technically speaking, it's an app-centric abstraction on top of AKS, with native features such as KEDA and Dapr integrated.

The following example project takes the workload used in Microservices architecture on Azure Kubernetes Service and rehosts it in Azure Container Apps as its application platform.

### Introduction

Fabrikam inc has created a new operations team, and under its organization is a brownfield application called Drone Delivery. This application been running for a while in Azure Kubernetes Service (AKS), and while they are obtaining the benefits of containers to run microservices and Kubernetes to host them, it has been discovered that they are not making use of any of the advance features of AKS like custom service mesh or autoscaling among others.

The team has detected an opportunity to simplify and be more efficient at the devops level, and this is why they are now looking into Azure Container Apps to evaluate hosting Fabrikam Drone Delivery. This will allow them to publish and run containarized microservices at scale, faster than before, reducing the complexity, saving resources by using scale-to-zero, built-in autoscaling capability, and without losing all the container advantages they love.

### Migration process and architecture

In this example scenario, the Fabrikam Drone Delivery app that was previously running in Azure Kubernetes Services will be run in a newly created Azure Container App environment. This application platform is optimized for running applications that span multiple microservices. This example makes some containers internet-facing via an HTTPS ingress, and internally accessible thanks to its built-in DNS-based service discovery capability. Additionally, it manages their secrets in a secure manner and authenticates against Azure Key Vault resources using managed identities.

![Diagram showing the deployment architecture for the Azure Container Apps solution.](../media/microservices-with-container-apps-deployment.png)

The following information describes how the Container Apps features are used in this reference implementation:

- HTTPS ingress, this allows to expose the Ingestion service to internet.
- Internal service discovery, Delivery, DroneScheduler and Package services must be internally reachable by Workflow service.
- Use user-assigned identities when authenticating into Azure KeyVault from Delivery and DroneScheduler services.
- Securely manage secrets for Package, Ingestion and Workflow services.
- Run containers from any registry, the Fabrikam Drone Delivery uses Azure Container Registry (ACR) to publish its Docker images.
- Use Revisions in Azure Container Apps to safely deploy updates, where appropriate. Workflow Service is a message consumer app, so it needs to be deployed in single revision mode, otherwise an old versions could still process a message if it happens to be the one that retrieves it first.
- Use ARM templates to deploy the application, there is no need for another layer of indirection like Helm charts. All the Drone Delivery containers are part of the ARM templates
- Logs, review container logs directly in Log Analytics without configuring any provider from code or Azure service.

The following Azure resources are used throughout this example scenario.

| Resource | Purpose |
| --- | --- |
| An Azure Container App Environment | This is the managed Container App environment where Container Apps are deployed |
| Five Azure Container Apps | These are the Azure resources that represents the five Fabrikam microservices in the Azure Container App environment |
| An Azure Container Registry | This is the private container registry where all Fabrikam workload images are uploaded and later pulled from the different Azure Container Apps |
| An Azure Log Analytics Workspace | This is where all the Container Apps logs are sent, along with Azure Diagnostics on all services |
| An Azure Application Insights instance | All services are sending trace information to a shared Azure Application Insights instance |
| Two Azure Cosmos DB instances | Delivery and Package services have dependencies on Azure Cosmos DB |
| An Azure Redis Cache instance | Delivery service uses Azure Redis cache to keep track of inflight deliveries |
| An Azure Service Bus | Ingestion and Workflow services communicate using Azure Service Bus queues |
| Five Azure User Managed Identities | These are going to give Read and List secrets permissions over Azure Key Vault to the microservices. |
| Five Azure Key Vault instances | Secrets are saved into Azure Key Vault instances. Currently only two out of five instances are being used as part of this reference implementation |

### Runtime Architecture

In this scenario, the container images are sourced from Azure Container Registry and deployed to a Container Apps Environment.

The services sharing the same environment benefit from:

- Internal ingress and service discovery.
- A single Log Analytics workspace for runtime logging.
- Secure management of secrets and certificates.

The workflow service container app is running in single revision mode. A container app running in single revision mode will have a single revision that is backed by zero-many replicas. A replica is composed of the application container and any required sidecar containers. This example isn't making use of sidecar containers, therefore each container app replica represents a single container. Since this example doesn't employ scaling, there will be only one replica running for each container app.

The workflow uses a hybrid approach to managing secrets. Managed identities are used in the services where such implementation required no code changes. The Drone Scheduler and Delivery services use user-assigned managed identities to authenticate with Azure Key Vault to access the secrets stored there. The remaining services store secrets via Container Apps service at the application level.

![Diagram showing the runtime architecture for the Azure Container Apps solution.](../media/microservices-with-container-apps-runtime-diagram.png)

## Tools and resources used to deploy containerized apps to Azure Container Apps

It's important to understand the tools an resources required to implement and manage a Azure Container Apps solution. The following sections list your resource requirements.

### Accounts and subscriptions

- Azure subscription
- GitHub account

### Azure resources

An Azure Resource Group (RG1) in Central US location that contains the following resources:

- Container registry (premium)
- Container App
- Container Apps Environment
- Virtual network
- Private endpoint
- Network interface
- Private DNS zone
- Managed Identity
- Service Bus Namespace
- Log Analytics workspace
- Storage account

### Host environment resources

A host environment configured with the following tools:

- Docker desktop
- Visual Studio Code with Docker and Azure App Service extensions
- Azure CLI with containerapp extension
- Windows PowerShell
- Self-hosted Windows agent

## Continuous deployment resources

Azure DevOps project configured as follows:

- A repository for your container app
- A Starter pipeline named Pipeline1
