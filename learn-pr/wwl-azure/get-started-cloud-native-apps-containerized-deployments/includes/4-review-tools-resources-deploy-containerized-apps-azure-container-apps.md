Real-world solutions often require a significant number of resources to develop and maintain. Before starting a project that implements new tools and technologies, it can be helpful to examine the tools and architecture of an existing solution.

## Examine an Azure Container Apps solution

Azure Container Apps is a fully managed environment that enables you to run microservices and containerized applications on a serverless platform. Technically speaking, it's an app-centric abstraction on top of AKS, with native features such as KEDA and Dapr integrated.

The following example project takes the workload used in Microservices architecture on Azure Kubernetes Service and rehosts it in Azure Container Apps as its application platform.

### Introduction

Fabrikam inc has created a new operations team, and under its organization is a brownfield application called Drone Delivery. This application has been running for a while in Azure Kubernetes Service (AKS). The team recognizes the benefits gained by using containers to run microservices and by having Kubernetes to host them. However, the team has discovered that they aren't making use of advanced AKS features, such as custom service mesh and autoscaling.

The team has detected an opportunity to simplify and be more efficient at the devops level. They're going to evaluate using Azure Container Apps to host the Drone Delivery app. Azure Container Apps could help the team to publish and run containerized microservices at scale, faster than before, and with reduce complexity. Azure Container Apps could also save resources by using scale-to-zero and the built-in autoscaling capability. Azure Container Apps provides these benefits without losing all the container advantages the team loves.

### Migration process and architecture

In this example scenario, the Fabrikam Drone Delivery app that was previously running in Azure Kubernetes Services is run in a newly created Azure Container App environment. This application platform is optimized for running applications that span multiple microservices. This example makes some containers face the internet via an HTTPS ingress, and internally accessible thanks to its built-in DNS-based service discovery capability. Additionally, it manages their secrets in a secure manner and authenticates against Azure Key Vault resources using managed identities.

![Diagram showing the deployment architecture for the Azure Container Apps solution.](../media/microservices-with-container-apps-deployment.png)

The following information describes how the Container Apps features are used in this reference implementation:

- HTTPS ingress is used to expose the Ingestion service to internet.
- Internal service discovery, Delivery, DroneScheduler and Package services must be internally reachable by Workflow service.
- Use user-assigned identities when authenticating into Azure KeyVault from Delivery and DroneScheduler services.
- Securely manage secrets for Package, Ingestion and Workflow services.
- Run containers from any registry, the Fabrikam Drone Delivery uses Azure Container Registry (ACR) to publish its Docker images.
- Use Revisions in Azure Container Apps to safely deploy updates, where appropriate. The Workflow Service app consumes messages, so it needs to be deployed in single revision mode. Single revision mode prevents old versions from inadvertently retrieving and processing a message.
- Use ARM templates to deploy the application, there's no need for another layer of indirection like Helm charts. All the Drone Delivery containers are part of the ARM templates
- Review container logs directly in Log Analytics without configuring any provider from code or Azure service.

The following Azure resources are used throughout this example scenario.

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

### Runtime Architecture

In this scenario, the container images are sourced from Azure Container Registry and deployed to a Container Apps Environment.

The services sharing the same environment benefit from the following capabilities:

- Internal ingress and service discovery.
- A single Log Analytics workspace for runtime logging.
- Secure management of secrets and certificates.

The workflow service container app is running in single revision mode. A container app running in single revision mode has a single revision for zero-many replicas. A replica is composed of the application container and any required sidecar containers. This example isn't making use of sidecar containers, therefore each container app replica represents a single container. Since this example doesn't employ scaling, there's only one replica running for each container app.

The workflow uses a hybrid approach to managing secrets. Managed identities are used in the services where such implementation required no code changes. The Drone Scheduler and Delivery services use user-assigned managed identities to authenticate with Azure Key Vault to access the secrets stored there. The remaining services store secrets via Container Apps service at the application level.

![Diagram showing the runtime architecture for the Azure Container Apps solution.](../media/microservices-with-container-apps-runtime-diagram.png)

## Tools and resources used to deploy containerized apps to Azure Container Apps

It's important to understand the tools and resources required to implement and manage an Azure Container Apps solution. The following sections list your resource requirements.

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
- Azure CLI with `containerapp` extension
- Windows PowerShell
- Self-hosted Windows agent

## Continuous deployment resources

Azure DevOps project configured as follows:

- A repository for your container app
- A Starter pipeline named `Pipeline1`
