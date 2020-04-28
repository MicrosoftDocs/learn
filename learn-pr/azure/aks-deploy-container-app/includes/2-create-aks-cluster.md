You were asked to spin up an Azure AKS Service so the company would be able to deploy all the applications. As the first step towards this implementation, you need to create and deploy an AKS cluster.

## Creating an AKS Cluster

You can create an AKS cluster in one of two ways: Either by the Azure Portal via Browser, or via Azure CLI.

#### [Browser](#tab/browser/)

First of all access the [Azure Portal](https://portal.azure.com):

:::image type="content" source="../media/2-access-azure-portal.png" alt-text="Azure Portal":::

Once in the portal you'll have three options to create a new AKS cluster:

__Option 1:__ AKS already in home screen

If your Azure Portal already shows "Kubernetes Services" in the home screen, under "Azure Services", just click it.

:::image type="content" source="../media/2-option-azure-services.png" alt-text="Azure Portal: AKS on Home Screen":::

__Option 2:__ Search box

You can also press `G+/` or click the top search box and search for `kubernetes`, then click "Kubernetes Services" right in the search results.

:::image type="content" source="../media/2-option-search-box.png" alt-text="Azure Portal: AKS on search bar":::

__Option 3:__ "Create a resource" button

You can also click the "Create a resource" button in the home screen to be taken to the product selection screen.

:::image type="content" source="../media/2-option-add-new.png" alt-text="Azure Portal: AKS on add New":::

Then you can search or, if it's present, click the "Kubernetes Service" button right at the bottom right of your screen

:::image type="content" source="../media/2-search-aks.png" alt-text="Azure Portal: AKS on add New":::

> [!NOTE]
> Despite there are different ways to access the Kubernetes Service, all of those options should bring you to the AKS Creation Form

After clicking the button, you'll be taken to the AKS creation screen:

:::image type="content" source="../media/2-aks-creation-screen.png" alt-text="Azure Portal: AKS on add New":::

In this screen you'll notice there are several tabs at the top

#### [Bash](#tab/bash/)

shell content

---
