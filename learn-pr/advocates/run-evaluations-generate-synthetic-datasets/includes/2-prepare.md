The first step to running evaluations with the Azure AI Evaluation SDK is to provision an Azure OpenAI Service resource in your Azure subscription. You can get started by creating an Azure AI Hub resource in Azure AI Foundry. After the hub resource is created, you'll need to create an Azure AI Project. Afterwards, you deploy a model to be used for running evaluations.

Projects are hosted by an Azure AI hub resource that provides enterprise-grade security and a collaborative environment. A project is used to organize your work and save state while building customized AI apps.

The Azure AI hub resource is the top-level Azure resource for Azure AI Foundry and provides the working environment for a team to build and manage AI applications.

In Azure, resources enable access to Azure services for individuals and teams. Resources also provide a container for billing, security configuration, and monitoring.

## Create an Azure AI Foundry project resource

> [!NOTE]
> Currently AI-assisted risk and safety metrics are only available in the following regions: East US 2, France Central, UK South, Sweden Central. Groundedness measurement leveraging Azure AI Content Safety Groundedness Detection is only supported in the following regions: East US 2 and Sweden Central. Protected Material measurement is only supported in East US 2.

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

## Deploy a model

1. Within Azure AI Foundry, navigate to the **Model Catalog**.
1. In the search bar, enter: **gpt-4o**.
1. Select the **gpt-4o** model.
1. On the model card, select **Deploy**.
1. For Deployment name, enter: *gpt-4o*.
1. In the **Deployment details** section, select **Customize**.
1. Set the **Tokens per Minute Rate Limit** slider to 100K.
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
1. Open **Visual Studio Code**.
1. Use the **Command Palette** (**CTRL + SHIFT/COMMAND + P**) and enter **Git Clone**.
1. Enter the repository URL `https://github.com/azure-samples/RAI-workshops`.
1. Select a folder to store the cloned repository.
1. Open the repository.
1. Use the **Command Palette** or the automatic prompt to **Reopen in Container**.

The remaining exercises in this project take place in the context of this development container. Project files are available in the [Evaluation and Data Generation Workshop](https://github.com/Azure-Samples/RAI-workshops/) folder.

---