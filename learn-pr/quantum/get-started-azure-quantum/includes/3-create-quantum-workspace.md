With an active Azure subscription, you and your crew are ready to create an Azure Quantum workspace. An Azure Quantum workspace resource, or workspace for short, is a collection of assets associated with running quantum or optimization applications.

> [!Tip]
> **Free trial.** If you don’t have an Azure subscription, you can [create a free account](https://azure.microsoft.com/free/?WT.mc_id=A261C142F) before you begin. For more information you can see the [Create an Azure account](/learn/modules/create-an-azure-account/?azure-portal=true) learning module. 

Once you have an Azure subscription, follow these steps to create an Azure Quantum workspace:

1. Sign in to the [Azure portal](https://portal.azure.com), using the credentials for your Azure subscription.

1. Select **Create a resource** and then search for **Azure Quantum**. On the results page, you should see a tile for the **Azure Quantum** service.

1. Select **Azure Quantum** and then select  **Create**. This opens a form to create a workspace.

1. Select a subscription to associate with the new workspace. 
1. Select **Quick create** or **Advanced create**:

   |Option | Description |
   |--- | --- |
   | Quick create | This option is the easiest path to creating a workspace. It automatically creates the necessary resource group and storage account, adds the Quantinuum, IonQ, and Microsoft QIO providers, and includes free Azure Quantum Credits for Quantinuum and IonQ hardware (USD 500 each). You workspace can still be customized after creation, if needed. |
   | Advanced create | Use this option to manually configure your resource group and storage account, select other payment options for your providers, and set tags to categorize resources. By default, this option also adds the Quantinuum, IonQ, and Microsoft QIO providers, and includes free Azure Quantum Credits for Quantinuum and IonQ hardware (USD 500 each). |


### [Quick create](#tab/tabid-quick)

1. Enter a name for the workspace. 
1. Select the region for the workspace.
1. Click **Create**.

### [Advanced create](#tab/tabid-advanced)

1. Select an existing [resource group](/azure/azure-resource-manager/management/manage-resource-groups-portal) or create a new one.
1. Enter a name for the workspace.
1. Select the region for the workspace.
1. Select or create a storage account for the workspace:
   - To have Azure automatically create a storage account, select **Create a new storage account with default settings**.
   - To use an existing storage account in your subscription or to create a new one manually, select **Customize storage account settings**.

   > [!IMPORTANT]
   > You must be an **Owner** of the resource group you use to create a new storage account. For more information about how resource groups work in Azure, see [Manage Azure resource groups by using the Azure portal](/azure/azure-resource-manager/management/manage-resource-groups-portal).

1. Click **Next**. 
1. The Quantinuum, IonQ, and Microsoft QIO providers are automatically added to the workspace. To add another available provider, click **Add** on that provider's tile. To modify the pricing plan for any of the selected providers, click **Modify**. 

    > [!NOTE]
    > Pricing for Azure Quantum varies by provider. Please consult the information in the Providers tab of your Azure Quantum workspace in the Azure portal for the most up-to-date pricing information, or visit the [Azure Quantum pricing page](https://azure.microsoft.com/pricing/details/azure-quantum/).

1. Click **Next**.
1. To add optional tags to your workspace, enter a name/value pair, or click **Next**. 
1. Review the settings you've selected and if everything is correct, select **Create** to create your workspace.

***

Deployment of your workspace may take a few minutes. The status and deployment details will be updated in the portal. 

> [!NOTE]
> If you have any questions regarding the workspace creation process or run into any issue at any point using Azure Quantum, bookmark [Azure Quantum office hours](https://aka.ms/AQ/OfficeHours) and join our open office hours every Thursday 8∶30 AM Pacific Standard Time zone (PST).

Congratulations! You're set up to start using the Azure Quantum service. In the next unit you will learn how to run Q# code using a Jupyter notebook in the Azure Quantum worskpace you have just created. 
