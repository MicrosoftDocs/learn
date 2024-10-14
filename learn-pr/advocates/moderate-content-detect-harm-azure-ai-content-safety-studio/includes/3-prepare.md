The first step in moderating content by using Azure AI Content Safety is to provision an Azure OpenAI Service resource in your Azure subscription. You can get started by creating an Azure AI Studio hub resource in Azure AI Studio.

In Azure, resources enable access to Azure services for individuals and teams. Resources also provide a container for billing, security configuration, and monitoring.

A hub is the top-level Azure resource for Azure AI Studio. It provides the working environment for a team to build and manage AI applications.

## Create an Azure AI Studio hub resource

> [!IMPORTANT]
> This exercise uses the East US region because that region supports all features included in this module. If you select a different region, you might not be able to complete the exercises. To learn more, see [Region availability](/azure/ai-services/content-safety/overview#region-availability).

1. In [Azure AI Studio](https://ai.azure.com/), under **Management**, select **All resources**.
1. Select **+ New hub**.
1. Complete the following fields:
    - **Hub name**: Provide a name for your hub.
    - **Subscription**: Select your Azure subscription.
    - **Resource group**: Select an existing resource group or create a new one.
    - **Location**: Select **East US**.
    - **Connect Azure AI Services or Azure OpenAI**: Select **Create new AI Services**, enter a name, and then select **Create**.
    - **Connect Azure AI Search**: Select **Skip connecting**.
1. Select **Next**.
1. After reviewing the hub details, select **Create**.

## Go to Content Safety

You access the Content Safety capabilities within Azure AI Studio.

1. In [Azure AI Studio](https://ai.azure.com/), under **Get started**, select **AI Services**.
1. On the **Integrate with generative AI page**, select **Content Safety**.
1. On the **Content Safety** page, you can view the features that you'll use in the exercises of this module.

:::image type="content" source="../media/content-safety-capabilities.png" alt-text="Screenshot of the Content Safety page of Azure AI Studio. It shows the built-in features of moderate text content, groundedness detection, protected material detection, and prompt shields." lightbox="../media/content-safety-capabilities.png":::

## Download the project files

Project files are available in the [data](https://github.com/Azure-Samples/RAI-workshops/tree/main/data) folder. Download the repository to access the files required for the upcoming exercises for text moderation and image moderation. To download the repository, select **Code** > **Download ZIP**.

> [!NOTE]
> Don't unzip the **bulk-image-moderation-dataset.zip** file in the **data** folder. The .zip format is required for the image moderation exercise.

> [!WARNING]
> The **Image Moderation** folder contains graphic images that depict scenes of harm. These image files have **blood** in the name and are used for the image moderation exercises. You don't need to view the images to complete the exercise. The image moderation feature includes a **Blur image** toggle that hides the view of uploaded images by default.
