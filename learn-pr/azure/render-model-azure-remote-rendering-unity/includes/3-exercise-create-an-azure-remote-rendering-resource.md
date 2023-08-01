You need an Azure Remote Rendering account to access the remote rendering service. In this exercise, you learn how to create a Remote Rendering account and locate its account ID, account domain, and primary access key. You use the Remote Rendering resource later in this module to render a model.

## Create the Remote Rendering account

1. After the sandbox activates, [open the Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) and select **Create a resource**.
1. On the **Create a resource** page, enter *remote rendering* in the Search box.
1. On the **Marketplace** page, at the bottom of the **Remote Rendering** tile, select **Create** > **Remote Rendering**.

   :::image type="content" source="../media/marketplace-results.png" alt-text="A screenshot of the Marketplace results with the Create Remote Rendering selection highlighted.":::

1. On the **Create Remote Rendering** page, leave the **Subscription** field populated with the sandbox subscription name. Drop down the arrow next to **Resource group** and select the prepopulated sandbox resource group, which starts with **learn-**.

1. For **Name**, enter a globally unique name with valid characters a-z, 0-9, and -. Leave **Region** at the prepopulated value.

   :::image type="content" source="../media/create-remote-rendering-resource.png" alt-text="A screenshot of the Remote Rendering Account wizard.":::

1. Select **Review + create** at the bottom of the page, and then select **Create**.

It takes a few seconds for the Remote Rendering account to be created. A notification appears after deployment is complete.

## View the subscription keys and endpoint

1. When you see the notification that deployment is complete, select **Go to resource**.

1. The Remote Rendering **Overview** page shows the **Account Domain** and **Account ID**. Copy these values to use later in the module.

   :::image type="content" source="../media/account-domain.png" alt-text="A screenshot of the Remote Rendering overview page with the Account Domain and Account ID highlighted." lightbox="../media/account-domain.png":::

1. In the left navigation, select **Access Keys** under **Settings**.

1. On the **Access Keys** page, copy the **Primary key** value to use later in this module.

   :::image type="content" source="../media/access-keys.png" alt-text="A screenshot of the Access Keys selection and page, highlighting the Copy icon next to the Primary key." lightbox="../media/access-keys.png":::
