The first step to running evaluations with the Azure AI Evaluation SDK is to provision an Azure OpenAI Service resource in your Azure subscription. You can get started by creating an Azure AI Hub resource in Azure AI Studio. After the hub resource is created, you'll need to create an Azure AI Project. Afterwards, you deploy a model to be used for running evaluations.

## Azure AI Hub resource

The Azure AI hub resource is the top-level Azure resource for Azure AI Studio and provides the working environment for a team to build and manage AI applications. In Azure, resources enable access to Azure services for individuals and teams. Resources also provide a container for billing, security configuration, and monitoring. Follow the steps provided to create an Azure AI Hub resource.

> [!NOTE]
> Currently AI-assisted risk and safety metrics are only available in the following regions: East US 2, France Central, UK South, Sweden Central. Groundedness measurement leveraging Azure AI Content Safety Groundedness Detection is only supported in the following regions: East US 2 and Sweden Central. Protected Material measurement is only supported in East US 2.

1. Within [Azure AI Studio](https://ai.azure.com/), navigate to **Management** and select **All hubs**.
1. Within hubs, select **+ New hub**.
1. Complete the following fields:
    - Hub name - provide a name for your hub
    - Subscription - select your Azure subscription
    - Resource group - selecting an existing resource group or create a new one
    - Location - East US 2
    - Connect Azure AI Services or Azure OpenAI - select **Create new AI Services**
    - Connect Azure AI Search - select **Create new AI Search**
1. Select **Next**.
1. After reviewing the Hub details, select **Create**.

## Azure AI project

Projects are hosted in an Azure AI hub resource that provides enterprise-grade security and a collaborative environment. A project is used to organize your work and save state while building customized AI apps. Follow the steps provided to create an Azure AI Project.

1. Within **All hubs**, select your newly created hub.
1. On the hub page, within the **Projects** section, select **+ New project**.
1. In the **Create a project** window, enter a project name.
1. Select **Create a project**.

## Deploy a model

1. Within Azure AI Studio, navigate to the **Model Catalog**.
1. Apply the following filters:
    - Collections > Azure OpenAI
    - Inference tasks > Chat completion
    - Select the **gpt-4o** model to view its model card.
1. On the model card, select **Deploy**.
1. For Deployment name, enter: *gpt-4*.
1. For Azure OpenAI resource, select your Azure OpenAI resource.
1. Select **Deploy**.

## Access workshop code

A development container environment is available with all dependencies required to complete every exercise in this project. You can run the development container in GitHub Codespaces or locally using Visual Studio Code.

###### [Develop in browser](#tab/github-codespaces)

GitHub Codespaces runs a development container managed by GitHub with Visual Studio Code for the Web as the browser-based user interface. For the most straightforward development environment, use GitHub Codespaces so that you have the correct developer tools and dependencies preinstalled to complete this training module.

> [!IMPORTANT]
> All GitHub accounts can use Codespaces for up to 60 hours free each month with two core instances.

1. Create a new GitHub Codespace using the `https://codespaces.new/Azure-Samples/RAI-workshops?quickstart=1` template.

    :::image type="content" border="true" source="https://github.com/codespaces/badge.svg" alt-text="Open in GitHub Codespaces" link="https://codespaces.new/Azure-Samples/aacs-workshops?quickstart=1?azure-portal=true":::

1. On the **Create codespace** page, review the codespace configuration settings, then select **Create new codespace**.

1. Wait for the codespace to start. This startup process can take a few minutes.

The remaining exercises in this project take place in the context of this development container. Project files are available in the [Evaluation and Data Generation Workshop](https://github.com/Azure-Samples/RAI-workshops/) folder.

###### [Develop locally](#tab/visual-studio-code)

The Dev Containers extension for Visual Studio Code requires Docker to be installed on your local machine. The extension hosts the development container locally using the Docker host with the correct developer tools and dependencies preinstalled to complete this training module.

1. Start Docker on your computer.
1. Open **Visual Studio Code** in an empty folder.
1. Use the **Command Palette** (**CTRL + SHIFT/COMMAND + P**) and enter **Git Clone**.
1. Enter the repository URL `https://github.com/azure-samples/RAI-workshops`.
1. Select a folder to store the cloned repository.
1. Open the repository.
1. Use the **Command Palette** or the automatic prompt to **Reopen in Container**.
1. At the top-right of the notebook, for **Select Kernel** select **Python 3.11.9**.

The remaining exercises in this project take place in the context of this development container. Project files are available in the [Evaluation and Data Generation Workshop](https://github.com/Azure-Samples/RAI-workshops/) folder.

---