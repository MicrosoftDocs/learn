Azure portal lets you create and deploy Azure Batch jobs and create other Azure resources. The portal allows to choose the right properties that fit your compute scenario.

[!INCLUDE [azure-optional-exercise-subscription-note](../../../includes/azure-optional-exercise-subscription-note.md)]

## Create a resource group

Create a new resource group to hold the data lake storage. You'll use the resource group to administer related services and applications together. A resource group will also make resource cleanup easier when you finish this module. 

To create a resource group in the Azure portal, follow these steps:

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. On the left, select **Create a resource**.

1. In the search box, type **Resource** and select **Resource group** from the results.

1. Select **Create** to add a new resource group.

1. On the **Basics** tab, select the subscription you want to work in.

1. Name the resource group **BatchResourceGroup**.

1. Choose the region (location) for the resource group. Typically, you'll want a location that's close to you or to the data you'll work with.

    :::image type="content" source="../media/2-create-resource-group.png" alt-text="Screenshot showing how to create a resource group in the Azure portal.":::

## Create new storage account

1. Navigate to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) in your favorite browser.

1. On the Azure portal menu or from the Home page, select **Create a resource**.

1. Enter **storage account** in the **Search the Marketplace** search box, then select **Storage account**.

1. Select **Create** to open the **Create storage account** form, as shown in the following screenshot.

   :::image type="content" source="../media/3-create-storage-account.png" alt-text="Screenshot of the 'create storage account' form open on the Basics tab.":::

1. **Subscription**: Select the appropriate subscription that you want to use.

1. **Resource group**: Select an existing resource group, or select **Create new** to create a new resource group.

1. In the **Storage account name** field, enter a unique name. An example might be **cutifypets&lt;date&gt;&lt;your initials&gt;**.

    > [!NOTE]
    > Your storage account name must be globally unique, and only lowercase characters and numbers are allowed.

1. Select a location close to you from the available options.

1. Leave all the other options as their defaults and select **Review + create**, followed by **Create**.

1. Wait for the deployment to complete. We now have a storage account that we'll use in our processing to store input and output files. We'll associate this storage account with our Batch account shortly.

### Add input data

Here, we'll add input data for a Batch task that you'll use in the next exercise.

1. Navigate to the storage account you just created by clicking **Go to resource** after the storage account deployment is complete.

1. On the left, select **Containers** under "Blob Service".

1. Create a container by clicking the **Container** button. Name the container **input-data** and set public access level as **Private**.

    :::image type="content" source="../media/2-create-container.png" alt-text="Screenshot of the Containers page in the Azure portal, with the 'Add Container' button highlighted.":::

1. Download [this video](https://github.com/MicrosoftDocs/mslearn-create-batch-account/raw/main/LowPriVMs-1.mp4) that we'll use as input data for a Batch task shortly.

1. Click on the **input-data** container you just created. Upload the video you just downloaded by selecting the **Upload** button and navigating to where you downloaded the video to (most likely your local Downloads folder).

## Create a Batch account

Next, you'll create the Azure Batch account and pool in a virtual network for your test scenario.

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. Select **Create a resource**.

1. Enter **batch service** in the **Search the Marketplace** search box, then select **Batch Service** from the list.

1. Select **Create** to open the **New Batch account** form.

1. Enter the following settings in the **Basics** tab in the **Project details** section:

    * **Subscription**: Select the appropriate subscription that you want to use.

    * **Resource group**: Select an existing resource group, or select **Create new** to create a new resource group.

   :::image type="content" source="../media/3-diagram-1.png" alt-text="A screenshot of the 'Create Batch account' page in the Azure portal.":::

1. Enter the following settings in the **Basics** tab in the **Instance details** section:

    * **Account name**: The name you choose must be unique within the Azure region where the account is created (see **Location** below). The account name can contain only lowercase characters or numbers, and must be 3-24 characters in length.

    * **Location**: The Azure region in which to create the Batch account. Only the regions supported by your subscription and resource group are displayed as options.

1. On the **Basics** tab in the **Storage account** section, select **Select a storage account**, then select the storage account that you created earlier.

   :::image type="content" source="../media/3-diagram-2.png" alt-text="A screenshot of the 'Create storage account' page in the Azure portal.":::

1. Select **Next: Advanced &gt;**, then enter the following settings in the **Advanced** tab:

    * **Identity type**: Leave as the default.

    * **Public network access**: Leave as the default, which should be **Enabled**.

    * **Pool allocation mode**: Leave as the default, which should be **Batch service**.

    > [!NOTE]
    > If had you specified **User subscription**, that would create the pool in the subscription where you were creating your Batch service.

    :::image type="content" source="../media/3-diagram-3.png" alt-text="A screenshot of the pool allocation method selection in the 'Advanced' tab when creating a Batch account in the Azure portal.":::

1. Leave all the other options as their defaults and select **Review + create**, followed by **Create**.

Your deployment may take a few minutes to complete.

## Create a virtual network

Once you have created a VNet and assigned a subnet to it, you can create a Batch pool with that VNet. Follow these steps to create a pool from the Azure portal.

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. Select **Create a resource**.

1. Enter **virtual network** in the **Search the Marketplace** search box, then select **Virtual Network** from the list.

1. Select **Create** to open the **Create virtual network** form.

1. Enter the following settings in the **Basics** tab in the **Project details** section:

    * **Subscription**: Select the same subscription as your Batch account from previous steps.

    * **Resource group**: Select the same resource group as your Batch account from previous steps.

1. Enter the following settings in the **Basics** tab in the **Instance details** section:

    * **Name**: Enter a name for your virtual network.

    * **Location**: Select the same region as your Batch account from previous steps.

    :::image type="content" source="../media/4-diagram-1.png" alt-text="A screenshot of the 'Create virtual network' page in the Azure portal.":::

    > [!NOTE]
    > If had any unique IP address settings for your virtual network, you would select **Next : IP Addresses &gt;** and specify those settings in the **IP Addresses** tab.

1. Leave all the other options as their defaults and select **Review + create**, followed by **Create**.

## Create a Batch pool

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. Select **Resource groups**, then select the resource group that contains the Batch account that you created in previous steps.

1. In the settings window for your resource group, select **Overview**, then select your Batch account.

1. In the settings window for your Batch account, select the **Pools** menu item.

1. In the **Pools** window, select **Add**.

1. In the **Add Pool** window, enter a name for your **Pool ID** using a combination of alphanumeric characters, hyphens, and underscores.

1. For this exercise, specify the following options in the **Operating System** section.

    * Select **Marketplace** from the **Image Type** dropdown menu.

    * Select **microsoftwindowsserver** for the **Publisher**.

    * Select **windowsserver** for the **Offer**.

    * Select **2019-datacenter** for the **Sku**.

1. For this exercise, select **Standard A1** from the **VM size** dropdown menu.

1. Set the **Target dedicated nodes** to **1** and **Target low-priority nodes** to **0**.

    * To learn more about low-priority VMs, see [Use low-priority VMs with Batch](https://docs.microsoft.com/azure/batch/batch-low-pri-vms).

1. For the **Virtual Network**, select the virtual network that you created earlier.

1. Specify any desired optional settings, then select **OK**.
