The first step in this workshop is to create a hub-based project in Microsoft Foundry (classic). The local Azure AI Evaluation SDK and simulator workflows used throughout the notebooks currently apply to Foundry (classic) hub-based projects rather than new Foundry projects. After the project is ready, deploy a chat model that the AI-assisted quality evaluators can use as their judge model.

## Create a hub-based project in Microsoft Foundry (classic)

> [!NOTE]
> If the portal shows the **New Foundry** toggle, turn it **off** so the UI matches the **Foundry (classic)** experience used by this workshop and by the related local SDK articles.

> [!NOTE]
> AI-assisted safety evaluators and `GroundednessProEvaluator` are available only in supported regions. For the current list, see [Rate limits, region support, and enterprise features for evaluation](/azure/foundry/concepts/evaluation-regions-limits-virtual-network).

> [!IMPORTANT]
> Use **East US 2** for this workshop if you want one region that supports all the evaluation features covered in the exercises.

1. Sign in to [Microsoft Foundry](https://ai.azure.com/?cid=learnDocs).
1. Create a new project and choose **AI hub resource** when you're asked what type of project to create.
1. Enter a project name.
1. Select an existing hub in **East US 2**, or create a new hub and set its **Location** to **East US 2**.
1. Finish creating the project and wait for the hub and project resources to be provisioned.

For the full hub-based project workflow, see [Create a hub project for Microsoft Foundry (classic)](/azure/foundry-classic/how-to/hub-create-projects).

## Deploy a chat model for the quality evaluators

The exercises that use `GroundednessEvaluator`, `RelevanceEvaluator`, `CoherenceEvaluator`, `FluencyEvaluator`, or `SimilarityEvaluator` need a deployed chat model in `model_config`. The safety evaluators and `GroundednessProEvaluator` use Microsoft's hosted Foundry Evaluation service instead and don't need a deployment.

1. In your hub or project, open **Deployments** or **Models + endpoints**, depending on your classic portal layout.
1. Select **+ Deploy model** > **Deploy base model**.
1. Choose a chat-capable model that is available in your region and supported by your quota, such as `gpt-4o` or `gpt-4o-mini`.
1. Give the deployment a name that you'll reuse in the workshop `.env` file (for example, `gpt-4o`). Note the deployment name, the Azure OpenAI endpoint, and the API version—you set these as `AZURE_OPENAI_DEPLOYMENT`, `AZURE_OPENAI_ENDPOINT`, and `AZURE_OPENAI_API_VERSION` later.
1. Keep the default tokens-per-minute (TPM) allocation, or adjust it only if your subscription quota requires a smaller value.
1. Wait for the deployment status to show **Succeeded**.

For more information, see [Create and deploy an Azure OpenAI in Microsoft Foundry Models resource (classic)](/azure/foundry-classic/openai/how-to/create-resource#deploy-a-model) and [Manage Azure OpenAI in Microsoft Foundry Models quota (classic)](/azure/foundry-classic/openai/how-to/quota#assign-quota).

## Access workshop code

A development container environment is available with all dependencies required to complete every exercise in this project. You can run the development container in GitHub Codespaces or locally using Visual Studio Code.

###### [Develop in browser](#tab/github-codespaces)

GitHub Codespaces runs a development container managed by GitHub with Visual Studio Code for the Web as the browser-based user interface. For the most straightforward development environment, use GitHub Codespaces so that you have the correct developer tools and dependencies preinstalled to complete this training module.

> [!IMPORTANT]
> Personal GitHub accounts include 120 core-hours and 15 GB of storage of free Codespaces usage each month, which is the equivalent of 60 hours of clock time on the default 2-core machine. For current limits, see [About billing for GitHub Codespaces](https://docs.github.com/billing/concepts/product-billing/github-codespaces).

1. Create a new GitHub Codespace using the `https://codespaces.new/Azure-Samples/RAI-workshops?quickstart=1` template.

    :::image type="content" border="true" source="https://github.com/codespaces/badge.svg" alt-text="Open in GitHub Codespaces" link="https://codespaces.new/Azure-Samples/RAI-workshops?quickstart=1":::

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

The notebooks install any missing Python packages and prompt you to populate the workshop `.env` file with your project and deployment values.

---
