The first step in building a generative AI solution with Azure OpenAI Service  is to provision an Azure OpenAI Service resource in your Azure subscription. You can get started by creating an Azure AI Hub resource in [Azure AI Foundry](https:/ai.azure.com). After the hub resource is created, you'll need to create an Azure AI Project. 

Projects are hosted by an Azure AI hub resource that provides enterprise-grade security and a collaborative environment. A project is used to organize your work and save state while building customized AI apps.

The Azure AI hub resource is the top-level Azure resource for Azure AI Foundry and provides the working environment for a team to build and manage AI applications.

In Azure, resources enable access to Azure services for individuals and teams. Resources also provide a container for billing, security configuration, and monitoring.

## Create an Azure AI Foundry project resource

> [!IMPORTANT]
> This exercise uses the East US 2 region because that region supports all features that this module includes. If you select a different region, you might not be able to complete the exercises. To learn more, see [Region availability](/azure/ai-services/content-safety/overview#region-availability).

1. In [Azure AI Foundry](https://ai.azure.com/), select **+Create project**.
1. For **Project name**, provide a name for your project.
1. Select **Customize** and modify the following fields as needed:
    - **Hub name**: Select an existing hub or provide a name for a new one.
    - **Subscription**: Select your Azure subscription.
    - **Resource group**: Select an existing resource group or create a new one.
    - **Location**: Select **East US 2**.
    - **Connect Azure AI Services or Azure OpenAI**: Either select an existing service, use the default name provided for a new service, or select **Create new AI Services** to provide your own name for the service.
    - **Connect Azure AI Search**: Select **Create new AI Search**. Provide a name for the resource and select **Next**.
1. Select **Next**.
1. Review the hub details, and then select **Create**.

## Download the project files

Project files are available in the [Measure and Mitigate Workshop](https://github.com/Azure-Samples/RAI-workshops/) folder. Download the repository to access the files required this  module. To download the repository, select **Code** > **Download ZIP**.
