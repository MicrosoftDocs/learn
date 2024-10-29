The first step in building a generative AI solution with Azure OpenAI Service  is to provision an Azure OpenAI Service resource in your Azure subscription. You can get started by creating an Azure AI Hub resource in Azure AI Studio. After the hub resource is created, you'll need to create an Azure AI Project. 

## Azure AI Hub resource

The Azure AI hub resource is the top-level Azure resource for Azure AI Studio and provides the working environment for a team to build and manage AI applications. In Azure, resources enable access to Azure services for individuals and teams. Resources also provide a container for billing, security configuration, and monitoring. Follow the steps provided to create an Azure AI Hub resource.

1. Within [Azure AI Studio](https://ai.azure.com/), navigate to **Management** and select **All hubs**.
1. Within hubs, select **+ New hub**.
1. Complete the following fields:
    - Hub name - provide a name for your hub
    - Subscription - select your Azure subscription
    - Resource group - selecting an existing resource group or create a new one
    - Location - East US
    - Connect Azure AI Services or Azure OpenAI - select **Create new AI Services**
    - Connect Azure AI Search - select **Create new AI Search**
1. Select **Next**.
1. After reviewing the Hub details, select **Create**.

## Azure AI project

Projects are hosted by an Azure AI hub resource that provides enterprise-grade security and a collaborative environment. A project is used to organize your work and save state while building customized AI apps. Follow the steps provided to create an Azure AI Project.

1. Within **All hubs**, select your newly created hub.
1. On the hub page, within the **Projects** section, select **+ New project**.
1. In the **Create a project** window, enter a project name.
1. Select **Create a project**.

## Download the project files

Project files are available in the [Measure and Mitigate Workshop](https://github.com/Azure-Samples/RAI-workshops/) folder. Download the repository to access the files required this  module. To download the repository, select **Code** > **Download ZIP**.
