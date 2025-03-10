The first step in moderating content by using Azure AI Content Safety is to provision an Azure OpenAI Service resource in your Azure subscription. You can get started by creating a project resource in [Azure AI Foundry](https://ai.azure.com).

Projects are hosted by an Azure AI hub resource that provides enterprise-grade security and a collaborative environment. A project is used to organize your work and save state while building customized AI apps.

The Azure AI hub resource is the top-level Azure resource for Azure AI Foundry and provides the working environment for a team to build and manage AI applications. 

In Azure, resources enable access to Azure services for individuals and teams. Resources also provide a container for billing, security configuration, and monitoring.

## Create an Azure AI Foundry project resource

> [!IMPORTANT]
> This exercise uses the East US region because that region supports all features that this module includes. If you select a different region, you might not be able to complete the exercises. To learn more, see [Region availability](/azure/ai-services/content-safety/overview#region-availability).

1. In [Azure AI Foundry](https://ai.azure.com/), select **+Create project**.
1. For **Project name**, provide a name for your project.
1. Select **Customize** and modify the following fields as needed:
    - **Hub name**: Select an existing hub or provide a name for a new one.
    - **Subscription**: Select your Azure subscription.
    - **Resource group**: Select an existing resource group or create a new one.
    - **Location**: Select **East US**.
    - **Connect Azure AI Services or Azure OpenAI**: Either select an existing service, use the default name provided for a new service, or select **Create new AI Services** to provide your own name for the service.
    - **Connect Azure AI Search**: Select **Skip connecting**.
1. Select **Next**.
1. Review the hub details, and then select **Create**.

## Go to Content Safety

You access the Content Safety capabilities within Azure AI Foundry.

1. Within your project in [Azure AI Foundry](https://ai.azure.com/), select **AI Services**.
1. In the **Infuse your solutions with AI capabilities** section, select **Content Safety**.
1. On the **Content Safety** page, you can view the features that you'll use in the exercises of this module.

## Download the project files

Project files are available in the [data](https://github.com/Azure-Samples/RAI-workshops/tree/main/data) folder. Download the repository to access the required files for the upcoming exercises about text moderation and image moderation. To download the repository, select **Code** > **Download ZIP**.

> [!NOTE]
> Don't unzip the **bulk-image-moderation-dataset.zip** file in the **data** folder. The .zip format is required for the image moderation exercise.

> [!WARNING]
> The **Image Moderation** folder contains graphic images that depict scenes of harm. These image files have **blood** in the name and are used for the image moderation exercise. You don't need to view the images to complete the exercise. The image moderation feature includes a **Blur image** toggle that hides the view of uploaded images by default.
