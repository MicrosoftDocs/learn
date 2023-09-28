With an active Azure subscription, you and your crew are ready to create an Azure Quantum workspace. An Azure Quantum workspace resource, or workspace for short, is a collection of assets associated with running quantum or optimization applications.

First-time users automatically get $500 (USD) free [Azure Quantum Credits](/azure/quantum/azure-quantum-credits) for use with each participating quantum hardware provider (see the [full quantum provider list](/azure/quantum/qc-target-list)). Your free Azure Quantum Credits become available once you create a new Azure Quantum workspace. If you need more credits, you can apply to the [Azure Quantum Credits program](/azure/quantum/credits-faq).

If you don't have an Azure account with an active subscription, choose from one of the following subscriptions or see [Microsoft Azure Offer Details](https://azure.microsoft.com/support/legal/offer-details/) for a full list.

### [Pay-as-you-go (recommended)](#tab/payg)

Register for free and sign up for a [pay-as-you-go subscription](https://azure.microsoft.com/pricing/purchase-options/pay-as-you-go/). With the Azure Quantum Credits you'll have $500 (USD) to use in each quantum hardware provider. Once you've consumed all your credits, you'll only pay for the services you use and you can cancel anytime.

### [Free Trial](#tab/free)

Sign up for a [free trial subscription for 30 days](https://azure.microsoft.com/free/?WT.mc_id=A261C142F). With the Azure Quantum Credits, you'll have $500 (USD) to use in each quantum hardware provider. After you've been signed up for 30 days or once you've consumed all your Azure Quantum Credits (whichever occurs first), you **must** upgrade to a [pay-as-you-go subscription](https://azure.microsoft.com/pricing/purchase-options/pay-as-you-go). After you exhaust your Azure Quantum Credits, you'll only pay for the services you use, and you can cancel anytime.

In addition, the free Azure trial gets you started with $200 (USD) in Azure credits to be used in Azure first-party services (Azure Quantum is not eligible) within the first 30 days of sign-up.

### [Students](#tab/student)

Sign up for an [Azure for Students subscription](https://azure.microsoft.com/offers/ms-azr-0170p/). With the Azure Quantum Credits, you'll have $500 (USD) to use in each quantum hardware provider. Once you've consumed all your credits, you must upgrade to a [pay-as-you-go subscription](https://azure.microsoft.com/pricing/purchase-options/pay-as-you-go), and you can cancel anytime.

Azure for Students gets you started with $100 (USD) in Azure credits to be used in Azure first-party services (Azure Quantum is not eligible), and you don't need a credit card to sign up.

### [Enterprise Agreement](#tab/EA)

If your organization has an Enterprise Agreement (EA) purchasing contract with Microsoft, your organization's Account Owners can create [Enterprise Dev/Test subscriptions](https://azure.microsoft.com/offers/ms-azr-0148p/) for active Visual Studio subscribers under the EA.

---

Once you have an active Azure subscription, follow these steps to create an Azure Quantum workspace:

1. Sign in to the [Azure portal](https://portal.azure.com), using the credentials for your Azure subscription.

1. Select **Create a resource** and then search for **Azure Quantum**. On the results page, you should see a tile for the **Azure Quantum** service.

1. Select **Azure Quantum** and then select  **Create**. A form to create a workspace will open.

1. Select a subscription to associate with the new workspace. 
1. Select **Quick create** or **Advanced create**:

   |Option | Description |
   |--- | --- |
   | Quick create | The quick create option is the easiest path to creating a workspace. It automatically creates the necessary resource group and storage account, adds the Quantinuum, IonQ, and Microsoft QIO providers, and includes free Azure Quantum Credits for Quantinuum and IonQ hardware ($500 USD each). Your workspace can still be customized after creation, if needed. |
   | Advanced create | Use the advanced create option to manually configure your resource group and storage account, select other payment options for your providers, and set tags to categorize resources. By default, the advanced create option also adds the Quantinuum, IonQ, and Microsoft QIO providers, and includes free Azure Quantum Credits for Quantinuum and IonQ hardware (USD 500 each). |

### [Quick create](#tab/tabid-quick)

1. Enter a name for the workspace.
1. Select the region for the workspace.
1. Select **Create**.

### [Advanced create](#tab/tabid-advanced)

1. Select an existing [resource group](/azure/azure-resource-manager/management/manage-resource-groups-portal) or create a new one.
1. Enter a name for the workspace.
1. Select the region for the workspace.
1. Select or create a storage account for the workspace:
   - To have Azure automatically create a storage account, select **Create a new storage account with default settings**.
   - To use an existing storage account in your subscription or to create a new one manually, select **Customize storage account settings**.

   > [!IMPORTANT]
   > You must be an **Owner** of the resource group you use to create a new storage account. For more information about how resource groups work in Azure, see [Manage Azure resource groups by using the Azure portal](/azure/azure-resource-manager/management/manage-resource-groups-portal).

1. Select **Next**.
1. The Quantinuum, IonQ, and Microsoft QIO providers are automatically added to the workspace. To add another available provider, select **Add** on that provider's tile. To modify the pricing plan for any of the selected providers, select **Modify**.

    > [!NOTE]
    > Pricing for Azure Quantum varies by provider. Please consult the information in the Providers tab of your Azure Quantum workspace in the Azure portal for the most up-to-date pricing information, or visit the [Azure Quantum pricing page](https://azure.microsoft.com/pricing/details/azure-quantum/).

1. Select **Next**.
1. To add optional tags to your workspace, enter a name/value pair, or select **Next**. 
1. Review the settings you've selected and if everything is correct, select **Create** to create your workspace.

***

Deployment of your workspace may take a few minutes. The status and deployment details will be updated in the portal.

> [!NOTE]
> If you have any questions regarding the workspace creation process or run into any issue at any point using Azure Quantum, bookmark [Azure Quantum office hours](https://aka.ms/AQ/OfficeHours) and join our open office hours every Thursday 8∶30 AM Pacific Standard Time zone (PST).

Congratulations! You're set up to start using the Azure Quantum service. In the next unit, you'll learn how to run Q# code using a Jupyter notebook in the Azure Quantum workspace you've created.
