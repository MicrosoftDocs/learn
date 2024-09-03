The first step in moderating content with Azure AI Content Safety within the Content Safety Studio is to create an Azure AI Hub resource. After the hub resource is created, you need to create both an Azure AI Project and Content Safety resource.

## Azure AI Hub Resource

The Azure AI hub resource is the top-level Azure resource for Azure AI Studio and provides a working environment for a team to build and manage AI applications. In Azure, resources enable access to Azure services for individuals and teams. Resources also provide a container for billing, security configuration, and monitoring. Use the following steps to create an Azure AI Hub resource.

1. Within [Azure AI Studio](https://ai.azure.com/), in the menu under **Management** select **All hubs**. Then select **+ New hub**.
1. Complete the following fields:
   - **Hub name** – provide a name for your hub.
   - **Subscription** – select your Azure subscription that has access to Azure OpenAI Service.
   - **Resource group** – select an existing resource group or create a new one.
   - **Location** – For this example, select *East US*.
   - **Connect Azure AI Services or Azure OpenAI** – select your AI Service.
   - **Connect Azure AI Search** – Skip connecting.
1. Select **Next**.
1. After reviewing the Hub details, select **Create**.

## Azure AI Project

Projects are hosted in an Azure AI hub resource that provides enterprise-grade security and a collaborative environment. A project is used to organize your work and save state while building customized AI apps. Use the following steps to create an Azure AI Project.

1. Within [Azure AI Studio](https://ai.azure.com/), navigate to **Home** and select **+ New project**.
1. Complete the following fields:
   - **Project name** – provide a name for your project.
   - **Hub** – select the Hub that was previously created.
1. Select **Create a project**.

## Content Safety Resource

The Content Safety Resource is an Azure AI service. This service consists of machine learning assisted moderation APIs that detect material that is potentially offensive, risky, or otherwise undesirable, to assure the contents in community is safe. Use the following steps to create a Content Safety Resource.

1. Within [Content Safety Studio](https://contentsafety.cognitive.azure.com/), select the **Settings** icon in the top navigation menu.
1. In the **All resources** section, select **+ Create a new resource**.
1. Complete the following fields:
   - **Subscription** – select your Azure subscription that has access to Azure OpenAI Service.
   - **Resource group** – select the Resource Group that was previously created.
   - **Region** – For this example, select *East US*.
   - **Name** – provide a name for your resource.
   - **Pricing tier** – Select *Free* or *Standard S0*.
1. Select **Review + create**.
1. Select **Create**.

## Download the project files

Project files are available in the [data](https://github.com/Azure-Samples/aacs-workshops/) folder. Download the repository to access the files required for the **Text Moderation** and **Image Moderation** exercises. To download the repository, select **Code** > **Download ZIP**.

> [!NOTE]
> Within the `data` folder is a `bulk-image-moderation-dataset.zip` file. Do not unzip the `bulk-image-moderation-dataset.zip` file as this format is required for the **Image Moderation** exercise.