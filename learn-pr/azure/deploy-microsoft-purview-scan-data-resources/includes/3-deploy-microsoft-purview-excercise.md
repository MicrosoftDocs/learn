# Exercise - Deploy a Microsoft Purview Account

In this unit, you'll use the [Azure portal](https://portal.azure.com) to create a Microsoft Purview account.

1. Sign in to the [Azure portal](https://portal.azure.com), expand the portal menu and select **Create a resource**.  
    :::image type="content" source="../media/01.01-create-resource.png" alt-text="Screenshot of the Azure portal, with the left menu expanded and Create a resource selected.":::

1. Search the Marketplace for "Microsoft Purview" and select **Create**.  
    :::image type="content" source="../media/01.02-create-purview.png" alt-text="Screenshot of the Microsoft Purview create a resource page, with Create selected.":::

1. Provide the necessary inputs on the **Basics** tab.
    * Select an existing Azure subscription.
    * Select an existing resource group or create a new resource group.
    * Enter a globally unique Microsoft Purview account name.
    * Select a location.
    * Optionally, overwrite the auto-generated managed resource group name.  
    :::image type="content" source="../media/01.03-create-basic.png" alt-text="Screenshot of Microsoft Purview account creation - Basic tab, with the information boxes highlighted.":::

1. On the **Networking** tab, select **All networks**.  
    :::image type="content" source="../media/01.04-create-networking.png" alt-text="Screenshot of the Microsoft Purview account creation Networking tab, with All networks selected.":::

1. On the **Review + Create** tab, once the message in the ribbon returns "Validation passed", verify your selections and select **Create**.  
    :::image type="content" source="../media/01.05-create-create.png" alt-text="Screenshot of the Microsoft Purview account creation, with validation passing and Create selected.":::

1. Wait several minutes while your deployment is in progress. Once complete, select **Go to resource**.  
    :::image type="content" source="../media/01.06-goto-resource.png" alt-text="Screenshot of the deployment dashboard window with the deployment completed, and the go to resource button selected.":::
