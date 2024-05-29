A substantial allocation of resources is required to develop and maintain real-world solutions. Before embarking on a project that involves new tools and technologies, it is essential to evaluate existing solutions and architectures.

## Examine an Azure Container Apps solution

The following sections examine a reference scenario for Azure Container Apps. The team begins with a workload structured in a microservices architecture and hosted on Azure Kubernetes Service. After an internal assessment, the team decides to migrate the solution to Azure Container Apps.

### Reference scenario

You work for Fabrikam Inc. as part of a new operations team. The team is responsible for a brownfield application called Drone Delivery that has been running on Azure Kubernetes Service. Although AKS offers valuable features for microservices and Kubernetes hosting, an analysis has detected underutilization, especially with advanced AKS features like custom service mesh and autoscaling.

The team identifies an opportunity to simplify their implementation and enhance DevOps efficiency. They plan to evaluate using Azure Container Apps to host the Drone Delivery app. The migration to Container Apps aims to expedite the publication and scaling of containerized microservices, reduce complexity, and save resources. Container Apps retains the container advantages provided by the AKS solution.

### Solution architecture

Your operations team completes the planned migration. The Drone Delivery app that was running in Azure Kubernetes Services is now run in a newly created Azure Container Apps environment. This environment is optimized for running apps that span multiple microservices. Notable features include:

- Containers accessible via HTTPS ingress for external connections.
- Internal accessibility through DNS-based service discovery.
- Secure secrets management.
- Azure Key Vault resource authentication via managed identities.

![Diagram showing the deployment architecture for the Azure Container Apps solution.](../media/microservices-with-container-apps-deployment.png)

### Container Apps features

This reference implementation uses Container Apps features in the following ways:

- **HTTPS Ingress**: Used to expose the Ingestion service to the internet.
- **Internal Service Discovery**: Ensures internal services (Delivery, DroneScheduler, and Package) can be reached by the Workflow service.
- **Managed Identities**: User-assigned managed identities authenticate with Azure KeyVault from Delivery and DroneScheduler services.
- **Secrets Management**: Secure management of secrets for Package, Ingestion, and Workflow services.
- **Container Registry**: Fabrikam Drone Delivery leverages Azure Container Registry (ACR) for publishing Docker images.
- **Revisions**: Azure Container Apps' revision feature is used for safe updates. The Workflow Service, operating as a message consumer, deploys in single revision mode.
- **Azure Resource Manager Templates**: The application is deployed using Azure Resource Manager templates, simplifying deployment.
- **Log Analytics**: Container logs are reviewed in Log Analytics without the need for additional configuration.

## Azure resources

The following Azure resources are integral to this scenario:

| Resource | Purpose |
| --- | --- |
| An Azure Container App Environment | This resource is the managed Container App environment where Container Apps are deployed. |
| Five Azure Container Apps | These Azure resources represent the five Fabrikam microservices in the Azure Container App environment. |
| An Azure Container Registry | This resource is the private container registry where all Fabrikam workload images are uploaded. After they're uploaded, images are pulled by the different Azure Container Apps. |
| An Azure Log Analytics Workspace | This resource is where all the Container Apps logs are sent, along with Azure Diagnostics on all services. |
| An Azure Application Insights instance | All services are sending trace information to a shared Azure Application Insights instance. |
| Two Azure Cosmos DB instances | Delivery and Package services have dependencies on Azure Cosmos DB. |
| An Azure Redis Cache instance | Delivery service uses Azure Redis cache to keep track of inflight deliveries. |
| An Azure Service Bus | Ingestion and Workflow services communicate using Azure Service Bus queues. |
| Five Azure User Managed Identities | These resources provide `Read` and `List secrets` permissions over Azure Key Vault to the microservices. |
| Five Azure Key Vault instances | Secrets are saved into Azure Key Vault instances. Currently only two out of five instances are being used as part of this reference implementation. |

### Runtime architecture

In this scenario, the container images are sourced from Azure Container Registry and deployed to a Container Apps Environment. Since the app services share the same environment, they benefit from the following capabilities:

- Internal ingress and service discovery.
- A single Log Analytics workspace for runtime logging.
- Secure management of secrets and certificates.

The workflow service container app is running in single revision mode. A container app running in single revision mode has a single revision for zero-many replicas. A replica is composed of the application container and any required sidecar containers. This example isn't making use of sidecar containers, therefore each container app replica represents a single container. Since this example doesn't employ scaling, there's only one replica running for each container app.

The workflow uses a hybrid approach to managing secrets. Managed identities are used in the services where such implementation required no code changes. The Drone Scheduler and Delivery services use user-assigned managed identities to authenticate with Azure Key Vault to access the secrets stored there. The remaining services store secrets via Container Apps service at the application level.

![Diagram showing the runtime architecture for the Azure Container Apps solution.](../media/microservices-with-container-apps-runtime-diagram.png)

## Tools and resources for an Azure Container Apps solution

The following sections list the resource requirements for an Azure Container Apps solution.

### Accounts and subscriptions

- Azure subscription.
- GitHub account.

### Azure resources

An Azure Resource Group that contains the following resources:

- Container registry (premium) instance with a deployed image.
- Container App.
- Container Apps Environment.
- Virtual network.
- Private endpoint.
- Network interface.
- Private DNS zone.
- Managed Identity.
- Service Bus Namespace.
- Log Analytics workspace.
- Storage account.

### Host environment resources

A host environment configured with the following tools:

- Docker desktop.
- Visual Studio Code with Docker and Azure App Service extensions.
- Azure CLI with `containerapp` extension.
- Windows PowerShell.
- Self-hosted Windows agent.

## Continuous deployment resources

Azure DevOps project configured as follows:

- A project named `Project1`.
- A repository for your container app.
- A Starter pipeline named `Pipeline1`.
