The first step in moderating content by using Azure AI Content Safety within Azure AI Studio is to provision an Azure OpenAI Service resource in your Azure subscription. You can get started by creating an Azure AI Hub resource in Azure AI Studio.

The Azure AI Hub resource is the top-level Azure resource for Azure AI Studio and provides the working environment for a team to build and manage AI applications. In Azure, resources enable access to Azure services for individuals and teams. Resources also provide a container for billing, security configuration, and monitoring. Follow the steps provided to create an Azure AI Hub resource.

## Create an Azure AI Hub resource

> [!IMPORTANT]
> All features included in this module are supported in East US region. If you select a different region, you might not be ablt to complete the exercises. To learn more, visit [Region availability](/azure/ai-services/content-safety/overview).

1. In [Azure AI Studio](https://ai.azure.com/), go to **Management** and select **All hubs**.
1. Within hubs, select **+ New hub**.
1. Complete the following fields:
    - **Hub name**: Provide a name for your hub.
    - **Subscription**: Select your Azure subscription.
    - **Resource group**: Select an existing resource group or create a new one.
    - **Location**: Select **East US**.
    - **Connect Azure AI Services or Azure OpenAI**: Select **Create new AI Services**.
    - **Connect Azure AI Search**: Skip connecting.
1. Select **Next**.
1. After reviewing the hub details, select **Create**.

## Navigate to Content Safety

:::image type="content" source="../media/content-safety-capabilities.png" alt-text="Screenshot of the content safety page of the Azure AI Studio. A list of built-in features displays including moderate text content, groundedness detection, protected material detection, and prompt shields." lightbox="../media/content-safety-capabilities.png":::

The **Content Safety** capabilities are available within the **AI Services** section of the **Azure AI Studio**. In the **Content Safety** section, you're able to try out the features within the exercises of this module.

1. Within [Azure AI Studio](https://ai.azure.com/), navigate to **Get started** and select **AI Services**.
1. On the **Integrate with generative AI page**, select **Content Safety**.

## Download the project files

Project files are available in the [data](https://github.com/Azure-Samples/RAI-workshops/) folder. Download the repository to access the files required for the **Text Moderation** and **Image Moderation** exercises. To download the repository, select **Code** > **Download ZIP**.

> [!NOTE]
> Within the `data` folder is a `bulk-image-moderation-dataset.zip` file. Do not unzip the `bulk-image-moderation-dataset.zip` file as this format is required for the **Image Moderation** exercise.

> [!WARNING]
> There are graphic images provided in the **Image Moderation** folder depicting scenes of harm. These image file names have **blood** appended and are used for the **Image moderation** exercises. You are not required to view the images to complete the exercises. There is a **Blur image** toggle within the **Image moderation** feature which hides the view of uploaded images by default.
