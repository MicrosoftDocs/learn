The first step in this guided project is to create a project and the supporting resources in Azure AI Foundry. This module intentionally uses a **hub-based project** in the **Foundry (classic)** experience because the later units rely on classic navigation such as **Data + indexes**, **Guardrails + controls**, and **Evaluation**.

## Create an Azure AI Foundry hub-based project

> [!IMPORTANT]
> Use the **East US 2** region for this exercise. Current evaluation guidance lists **East US 2** as supporting the full risk-and-safety evaluator set used later in this module, including **Protected material**, **Indirect attack**, and **Groundedness Pro**. Feature availability still changes over time, so verify both model and feature support before you create resources. For more information, see [Microsoft Foundry feature availability across cloud regions](/azure/foundry/reference/region-support), [Rate limits, region support, and enterprise features for evaluation](/azure/ai-foundry/concepts/evaluation-regions-limits-virtual-network), and [Azure AI Content Safety region availability](/azure/ai-services/content-safety/overview#region-availability).

1. Go to [Azure AI Foundry](https://ai.azure.com).
1. If the **New Foundry** toggle is on, turn it off so you're using **Foundry (classic)**. This guided project assumes the classic left navigation and hub-based project flow.
1. Select **Create new**. If you're already in a project, select the project breadcrumb and then select **Create new resource**.
1. On the **Select resource type** screen, select **AI hub resource**, and then select **Next**.
1. Enter a name for the project.
1. Choose an existing hub, or create a new hub.
1. If you create a new hub, expand the customization options and set the **Location** to **East US 2**. Choose or create the **Resource group** you want to use.
1. Select **Create** and wait for the project to finish provisioning.

> [!NOTE]
> If your UI doesn't match the screenshots, first confirm that you're in **Foundry (classic)**. The current portal uses different menu names, such as **Discover** > **Model catalog**, **Build** > **Evaluations**, and **Operate** > **Compliance**. If you're already in the classic experience and still don't see **Data + indexes**, **Guardrails + controls**, or **Evaluation**, select **... More** to customize the left pane. For background, see [What is Microsoft Foundry (classic) portal?](/azure/foundry-classic/what-is-foundry), [Create a hub project for Microsoft Foundry (classic)](/azure/foundry-classic/how-to/hub-create-projects), and [Migrate from the Foundry (classic) portal](/azure/foundry/how-to/navigate-from-classic).

> [!TIP]
> If **Create new resource** or **AI hub resource** isn't available, confirm that you have the required permissions on the hub or resource group. Official hub-project guidance calls out **Owner** or **Contributor** permissions for creating or using hub resources in the portal.

You also need an **Azure AI Search** resource before you create the product index later in this module. If your project doesn't already have one connected, you can create or connect one during the index-creation workflow.

## Download the project files

Sample files for this guided project are available in the [Measure and Mitigate Workshop](https://github.com/Azure-Samples/RAI-workshops/tree/main/Measure%20and%20Mitigate%20Workshop) folder. Download the repository to access the files required for this module. To download the repository, select **Code** > **Download ZIP**.

After extracting the ZIP file, note the location of the **Products** folder and the evaluation `.jsonl` files because you use them in later units. Keep the extracted file and folder names unchanged so they match the steps in this module.
