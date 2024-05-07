

## Have an Azure subscription

To access Azure portal you need an Azure subscription. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/?WT.mc_id=academic-15963-cxa) before you begin.

## Create a quantum workspace

A quantum workspace is a container for your quantum programs and resources. If you want to run quantum programs using Azure Quantum, you need to create a quantum workspace.

1. Sign in to the [Azure portal](https://portal.azure.com), using the credentials for your Azure subscription.
1. Select **Create a resource** and then search for **Azure Quantum**. On the results page, you should see a tile for the **Azure Quantum** service.
1. Select **Azure Quantum** and then select  **Create**. A form to create a workspace will open.
1. Select a subscription to associate with the new workspace.
1. Select **Quick create**.
1. Enter a **name** and select the **region** for the workspace.
1. Select **Create**. 

> [!NOTE]
> Deployment of your workspace may take a few minutes. The status and deployment details will be updated in the portal.


## Manage your quantum workspace

The Azure portal allows you to manage your quantum workspace. You can view the details of your workspace, manage your Azure Quantum credits, list your quantum jobs, see the status of the quantum computing providers you have selected, and more.

For example, the following steps show you how to view your workspace details and check your Azure Quantum credits.

### Retrieve your workspace details

For some tasks like connecting to your Azure Quantum workspace, you may need you quantum workspace details, such as the resource ID and the location. 

1. Select your Azure Quantum workspace in the [Azure portal](https://portal.azure.com).
1. Select **Overview** in the left pane.
1. The details of your workspace are displayed. For example, you can find the **Resource ID** and the **Location** of your workspace here.

    :::image type="content" source="../media/azure-portal-workspace-overview.png" alt-text="Screenshot of Azure portal showing how to review your workspace details.":::

### View your Azure Quantum credits

When you create an Azure Quantum workspace for the first time, you get **free USD500 in Azure Quantum Credits** for use in each of the quantum computing providers. 

You can check your remaining Azure Quantum credits in the Azure portal.

1. Select your Azure Quantum workspace in the [Azure portal](https://portal.azure.com).
1. Select **Credits and Quotas** in the left pane.
1. Your remaining credits are displayed in the **Credits** section. You can check the remaining credits for each of the quantum computing providers you have selected for your workspace.

    :::image type="content" source="../media/azure-portal-credits-quotas.png" alt-text="Screenshot of Azure portal showing how to review the remaining credits for your workspace.":::

## Run a quantum program using Azure Quantum notebooks

The Azure Quantum portal includes a notebook gallery with sample notebooks You can use these notebooks to run your own quantum programs.

1. Select your Azure Quantum workspace in the [Azure portal](https://portal.azure.com).
1. Select **Notebooks**, and then select **Sample gallery**.
1. You can select any sample notebook. For example, select **Hello, world: Q#**. You can choose the provider you want to use for running the notebook, for example, **IonQ**. 
1. Click on **Copy to my notebooks**.

    :::image type="content" source="../media/azure-portal-sample-gallery.png" alt-text="Screenshot of the Azure portal showing how to select a sample notebook from the sample gallery.":::

1. The notebook can be found under **My notebooks**. 
1. Open the notebook and click on **Run all** to run the quantum program.





