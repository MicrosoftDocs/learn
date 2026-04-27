The exercises in this module use the Content Safety **Try it out** experience in Azure AI Foundry. To complete them, create a hub-based project in the Foundry classic portal and connect it to an Azure AI resource that provides Content Safety.

Hub-based projects help you organize connections, uploaded data, and saved settings while you build and test AI applications. The hub centralizes shared governance, connections, and project settings across related projects.

> [!NOTE]
> These exercises use the **Foundry classic** portal flow for hub-based projects. If you see a **New Foundry** toggle in the portal, turn it **off** before you start. For background, see [Types of projects in Microsoft Foundry (classic)](/azure/foundry-classic/what-is-foundry#types-of-projects) and [Create a hub project for Microsoft Foundry (classic)](/azure/foundry-classic/how-to/hub-create-projects).

## Create a hub-based project in Azure AI Foundry

> [!IMPORTANT]
> Use the **East US** region for this module. East US currently supports every Azure AI Content Safety feature used in these exercises, including groundedness detection and multimodal analysis. Some other regions support only a subset of these features. If you select a region that doesn't support a feature, the matching panel won't appear in **Try it out**. For the current support matrix, see [Region availability](/azure/ai-services/content-safety/overview#region-availability).

1. In [Azure AI Foundry](https://ai.azure.com/), sign in. If the **New Foundry** toggle appears, turn it **off**.
1. Create the project:
    - If you're not already in a project, select **Create new**.
    - If you're already in a project, select the project breadcrumb and then select **Create new resource**.
1. Select **AI hub resource**, and then select **Next**.
1. For **Project name**, enter a name for your project.
1. Review the hub that the portal selects for you. If you need a different hub, choose an existing one or select **Create a new hub**.
1. If you're creating a new hub and want to customize it, expand the options on the right side of the form and review the following settings:
    - **Resource group**: Select an existing resource group or create a new one.
    - **Location**: Select **East US**.
    - **Azure AI resource connection**: If the form offers **Azure AI Services** or **Azure OpenAI** connection fields, connect the Azure AI resource that you want to use for Content Safety, or create a new one. An Azure OpenAI connection is optional for this module unless you plan to enable the optional groundedness **Reasoning** mode later. Reasoning currently requires an Azure OpenAI **GPT-4o** deployment (version **0513** or **0806**). To use it, you must also enable the system-assigned managed identity on your Azure AI Content Safety resource and grant that identity the **Cognitive Services OpenAI User** (or **Contributor**) role on the Azure OpenAI resource. For step-by-step setup, see [Check groundedness with reasoning](/azure/ai-services/content-safety/quickstart-groundedness#check-groundedness-with-reasoning).
    - **Azure AI Search**: If the form offers an Azure AI Search connection, select **Skip connecting** for this module.
1. Select **Create** or **Create a project**, depending on the portal version, and wait for provisioning to finish.

> [!NOTE]
> Portal labels can change over time. If your current UI doesn't exactly match the steps here, follow the current hub-based project creation flow in the official [Foundry classic project creation documentation](/azure/foundry-classic/how-to/hub-create-projects), and then look for **Guardrails + controls** > **Try it out** after the project opens.

## Open the Content Safety try-it-out experience

You access the Content Safety capabilities within Azure AI Foundry.

1. In your project in [Azure AI Foundry](https://ai.azure.com/), select **Guardrails + controls**.
1. Select **Try it out**.
1. Confirm that you can see panels such as **Moderate text content**, **Moderate image content**, **Groundedness detection**, and **Prompt Shields**.

> [!NOTE]
> The groundedness exercises in this module use the standard detection result. You don't need the optional **Reasoning** feature or an Azure OpenAI deployment unless you want detailed explanations in addition to the groundedness result.

> [!NOTE]
> Depending on the current portal release, the overall moderation result can appear as **Allowed**/**Blocked** or **Accepted**/**Rejected**. The threshold and category behavior is the same either way.

> [!TIP]
> If the **Groundedness detection** panel doesn't appear, confirm that your project is using the Foundry classic flow and is connected to an Azure AI resource in a supported region such as **East US**. For current support details, see [Region availability](/azure/ai-services/content-safety/overview#region-availability).

## Download the project files

Project files are available in the [data](https://github.com/Azure-Samples/RAI-workshops/tree/main/data) folder of the Azure-Samples/RAI-workshops repository. Download the repository so you can access the files used in the text and image moderation exercises. In the downloaded repo, use `bulk-text-moderation-data.csv` from the `data` folder and the image samples from `data/Image Moderation`. To download the repository, select **Code** > **Download ZIP**.

> [!NOTE]
> Don't unzip the **bulk-image-moderatation-dataset.zip** file in the **data/Image Moderation** folder. The sample repository currently uses that exact filename, and the `.zip` format is required for the image moderation exercise.

> [!WARNING]
> The **Image Moderation** folder contains graphic images that depict scenes of harm. These image files have **blood** in the name and are used for the image moderation exercise. You don't need to view the images to complete the exercise. The image moderation feature includes a **Blur image** toggle that hides uploaded images by default.
