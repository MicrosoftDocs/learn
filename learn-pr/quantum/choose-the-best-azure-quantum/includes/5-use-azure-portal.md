In this unit, you learn how to use the Azure portal to manage your quantum workspace and view information about your quantum jobs.

## Create an Azure subscription

To access the Azure portal, you need an Azure subscription. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn&?WT.mc_id=academic-15963-cxa) before you begin.

## Create a quantum workspace

A quantum workspace is a container for your quantum programs and resources. If you want to run quantum jobs through Azure Quantum, then you need to create a quantum workspace on the Azure portal.

1. Sign in to the [Azure portal](https://portal.azure.com) with the credentials for your Azure subscription.
1. Choose **Create a resource**, and then search for **Azure Quantum** in the search bar. Find the **Azure Quantum** tile on the search results page.
1. In the **Azure Quantum** tile, open the **Create** dropdown, and then choose **Azure Quantum**. A workspace creation page opens.
1. Select a subscription for the new workspace.
1. Select **Quick create**.
1. Enter a **Workspace name** and select an Azure **Region**.
1. Choose **Review + create** and then deploy your workspace.

> [!NOTE]
> It takes a few minutes for your workspace to deploy. The status and deployment details are updated and displayed on the Azure portal.

## Manage your quantum workspace

The Azure portal allows you to manage your quantum workspace. You can view the details of your workspace, list your quantum jobs, review the status of the quantum computing providers that you selected, and more.

### Retrieve your workspace details

For certain tasks in the Azure portal, you might need details about your quantum workspace, such as the resource ID and Azure region. To get details about your quantum workspace, follow these steps:

1. Select your Azure Quantum workspace in the [Azure portal](https://portal.azure.com).
1. Log in to the [Azure portal](https://portal.azure.com), and navigate to your quantum workspace.
1. Choose the **Overview** menu on the main workspace blade.
1. The details of your workspace are displayed. For example, you can find the **Resource ID** and **Location** of your workspace here.

    :::image type="content" source="../media/azure-portal-workspace-overview.png" alt-text="Screenshot of Azure portal showing how to review your workspace details.":::

### Manage your quantum jobs

To manage your quantum jobs in the Azure portal, follow these steps:

1. Go to your quantum workspace in the Azure portal.
1. Expand the **Operations** dropdown.
1. Choose **Job management**. A table appears that lists all the jobs you've submitted to Azure Quantum.
1. Choose a job to access job information such as the job ID, job state, submission and completion time, and provider.
