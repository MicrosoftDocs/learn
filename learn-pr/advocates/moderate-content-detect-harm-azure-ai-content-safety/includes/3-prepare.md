The first step in moderating content with Azure AI Content Safety is to create a Content Safety resource and retrieve the **Subscription Key** and **Endpoint**. The endpoint and key are used to call APIs.

## Create Content Safety resource

The Content Safety Resource is an Azure AI service. This service consists of machine-learning-assisted moderation APIs which detect material that's potentially offensive, risky, or otherwise undesirable, to assure the content in the community is safe. Follow these steps to create a Content Safety Resource:

:::image type="content" source="../media/create-content-safety-resource.png" alt-text="A screenshot of the Create Content Safety screen. Displayed on the screen are fields for subscription, resource group, region, name, and pricing tier.":::

1. Navigate to [aka.ms/acs-create](https://aka.ms/acs-create).
1. Complete the following fields:
   - **Subscription**: Select your Azure subscription that has access to Azure OpenAI Service.
   - **Resource group**: Select or create a Resource group.
   - **Region**: East US or West Europe.
   - **Name**: Provide a name for your resource.
   - **Pricing tier**: **Free F0** or **Standard S0**.
1. Select **Review + create**.
1. Select **Create**.

## Get Content Safety Resource Key and Endpoint

:::image type="content" source="../media/content-safety-keys-endpoint.png" alt-text="A screenshot of the keys and endpoint for a Content Safety resource. There are 2 keys available in addition to the region and endpoint.":::

1. After the resource is created, select **Go to resource**.
1. In the **Content Safety Resource**, navigate to **Resource Management**.
1. Select **Keys and Endpoint**.
1. Copy the values for **KEY 1** and **Endpoint** and store them in a text editor; you'll need them in the next section.

## Access workshop code

A development container environment is available with all dependencies required to complete every exercise in this project. You can run the development container in GitHub Codespaces or locally using Visual Studio Code.

###### [Develop in browser](#tab/github-codespaces)

GitHub Codespaces runs a development container managed by GitHub with Visual Studio Code for the Web as the browser-based user interface. For the most straightforward development environment, use GitHub Codespaces so that you have the correct developer tools and dependencies preinstalled to complete this training module.

> [!IMPORTANT]
> All GitHub accounts can use Codespaces for up to 60 hours free each month with two core instances.

1. Create a new GitHub Codespace using the `https://codespaces.new/Azure-Samples/RAI-workshops?quickstart=1` template.

    :::image type="content" border="true" source="https://github.com/codespaces/badge.svg" alt-text="Open in GitHub Codespaces" link="https://codespaces.new/Azure-Samples/RAI-workshops?quickstart=1?azure-portal=true":::

1. On the **Create codespace** page, review the codespace configuration settings, then select **Create new codespace**.

1. Wait for the codespace to start. This startup process can take a few minutes.

The remaining exercises in this project take place in the context of this development container.

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

The remaining exercises in this project take place in the context of this development container.

---

## Assign environment variables

Once you have the development container open, you can create environment variables for your Content Safety resource key and endpoint.

1. In the files, select `.env` file.
1. Assign your **Subscription Key** to `CONTENT_SAFETY_KEY`.
1. Assign your **Endpoint** to `CONTENT_SAFETY_ENDPOINT`.

> [!NOTE]
> For demo purposes, we'll be using an `.env` file to store your subscription key. However, it's best practice to use token-based authentication. You can use the `DefaultAzureCredential` class the AzureSDK provides, which automatically detects and uses the appropriate authentication method based on your environment.

## Open the Jupyter notebook

1. In the repository files, navigate to the **Azure AI Content Safety Workshop** folder and open the **azure-ai-content-safety-module.ipynb** notebook.
1. If the kernel isn't selected, select **Select Kernel** at the upper-right of the notebook.
1. Select **Python Environments** in the kernel drop-down menu.
1. Choose the **Python 3.11** environment.
