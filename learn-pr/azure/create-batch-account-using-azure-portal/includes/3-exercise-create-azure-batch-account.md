You can use the Azure portal to create and deploy Azure Batch jobs and create other Azure resources. The portal helps you choose the right properties that fit your compute scenario.

[!INCLUDE [azure-optional-exercise-subscription-note](../../../includes/azure-optional-exercise-subscription-note.md)]

## Create a resource group

Create a resource group to hold a Batch account that you'll create later. You'll use the resource group to administer related services and applications together. A resource group also makes resource clean up easier when you finish this module.

To create a resource group in the Azure portal:

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. On the left, select **Create a resource**.

1. In the search box, type **Resource** and select **Resource group** from the results.

1. Select **Create** to add a new resource group.

1. On the **Basics** tab, select the subscription in which you want to work.

1. Name the resource group **BatchResourceGroup**.

1. Choose the region (location) for the resource group. Typically, you'll want a location that's close to you or close to the data you'll work with.

   :::image type="content" source="../media/2-create-resource-group.png" alt-text="Screenshot that shows how to create a resource group in the Azure portal.":::

1. Select **Review + create**, then select **Create**.

## Create a storage account

1. On the Azure portal menu or from the home page, select **Create a resource**.

1. Enter **storage account** in the **Search services and marketplace** search box, and then select **Storage account**.

1. Select **Create** to open the **Create storage account** form.

   :::image type="content" source="../media/3-create-storage-account-2022.png" alt-text="Screenshot of the form for creating a storage account on the Basics tab.":::

1. For **Subscription**, select the appropriate subscription that you want to use.

1. For **Resource group**, select the resource group that you created in the previous section (**BatchResourceGroup**).

1. In the **Storage account name** box, enter a unique name. An example might be **cutifypets&lt;date&gt;&lt;your initials&gt;**.

    > [!NOTE]
    > Your storage account name must be globally unique, and only lowercase characters and numbers are allowed.

1. Select a location close to you from the available options.

1. Leave all the other options as their defaults. Select **Review + create**, then select **Create**.

1. Wait for the deployment to finish. You now have a storage account that you'll use in your processing to store input and output files. You'll associate this storage account with your Batch account shortly.

### Add input data

Here, you'll add input data for a Batch task that you'll use in the next exercise.

1. Select **Go to resource** after the storage account deployment is complete.

1. On the left, select **Containers** under **Data storage**.

1. Select the **+ Container** button to create a container. Name the container **input-data** and set the public access level as **Private**.

    :::image type="content" source="../media/3-create-container.png" alt-text="Screenshot of the Containers page in the Azure portal, with the button for creating a container highlighted.":::

1. Select **Create**.

1. Download [this video](https://github.com/MicrosoftDocs/mslearn-create-batch-account/raw/main/LowPriVMs-1.mp4). You'll use it as input data for a Batch task shortly.

1. Select the **input-data** container that you created. Upload the video that you downloaded by selecting the **Upload** button and browsing to where you downloaded the video. It's most likely your local *Downloads* folder.

1. Once you've selected the video, select the **Upload** button.

## Create a Batch account

Next, you'll create the Azure Batch account and pool in a virtual network for your test scenario.

1. From the Azure portal home, select **Create a resource**.

1. Enter **batch service** in the **Search services and marketplace** search box, then select **Batch Service** from the list.

1. Select **Create** to open the **New Batch account** form.

1. Enter the following settings on the **Basics** tab, in the **Project details** section:

    - **Subscription**: Select the appropriate subscription that you want to use.

    - **Resource group**: Select the name of the resource group that you created earlier (**BatchResourceGroup**).

   :::image type="content" source="../media/3-diagram-1.png" alt-text="A screenshot of the page for creating a new Batch account in the Azure portal.":::

1. Enter the following settings on the **Basics** tab, in the **Instance details** section:

    - **Account name**: A name that's unique within the Azure region where the account is created. The account name can contain only lowercase characters or numbers, and it must be 3 to 24 characters in length.

    - **Location**: The Azure region in which to create the Batch account. Only the regions your subscription and resource group support are displayed as options.

1. On the **Basics** tab, in the **Storage account** section, select **Select a storage account**, then select the storage account that you created earlier.

   :::image type="content" source="../media/3-storage-account-section.png" alt-text="A screenshot of the dialog for creating a storage account in the Azure portal.":::

1. Select **Next: Advanced**, and then enter the following settings on the **Advanced** tab:

    - **Identity type**: Leave as the default.

    - **Pool allocation mode**: Leave as the default, which should be **Batch service**.

    > [!NOTE]
    > If you'd specified **User subscription**, Azure would create the pool in the subscription where you were creating your Batch service.

    :::image type="content" source="../media/3-batch-account-advanced-tab.png" alt-text="A screenshot of the pool allocation mode selection on the Advanced tab when creating a Batch account in the Azure portal.":::

1. Select **Next: Networking**. Leave **Public network access** as the default, which should be **All networks**.

1. Leave all the other options as their defaults. Select **Review + create**, then select **Create**.

Your deployment might take a few minutes to finish.

## Create a virtual network

After you've created a virtual network and assigned a subnet to it, you can create a Batch pool with that virtual network. Follow these steps to create a pool from the Azure portal:

1. From the Azure portal home, select **Create a resource**.

1. Enter **virtual network** in the **Search the Marketplace** search box, and then select **Virtual Network** from the list.

1. Select **Create** to open the **Create virtual network** form.

1. Enter the following settings on the **Basics** tab, in the **Project details** section:

    - **Subscription**: Select the same subscription as your Batch account from previous steps.

    - **Resource group**: Select the same resource group as your Batch account from previous steps (**BatchResourceGroup**).

1. Enter the following settings on the **Basics** tab, in the **Instance details** section:

    - **Name**: Enter a name for your virtual network.

    - **Location**: Select the same region as your Batch account from previous steps.

    :::image type="content" source="../media/4-diagram-1.png" alt-text="A screenshot of the page for creating a virtual network in the Azure portal.":::

    > [!NOTE]
    > If you had any unique IP address settings for your virtual network, you would select **Next: IP Addresses** and specify those settings on the **IP Addresses** tab.

1. Leave all the other options as their defaults. Then select **Review + create**, followed by **Create**.

## Create a Batch pool

1. From the Azure portal home, select **Resource groups**, and then select the resource group that contains the Batch account (**BatchResourceGroup**).

1. From your resource group **Overview** page, select your Batch account.

1. Select **Pools** under **Features** in the left menu.

1. In the **Pools** window, select **+ Add**.

1. In the **Add Pool** window, enter a name for **Pool ID** by using a combination of alphanumeric characters, hyphens, and underscores.

1. For this exercise, specify the following options in the **Operating System** section:

    - Select **Marketplace** from the **Image Type** dropdown menu.

    - Select **microsoftwindowsserver** for **Publisher**.

    - Select **windowsserver** for **Offer**.

    - Select **2019-datacenter** for **Sku**.

1. For this exercise, select **Standard A1** from the **VM size** dropdown menu.

1. Set the **Target dedicated nodes** to **1**, and set **Target Spot/low-priority nodes** to **0**.

   To learn more about low-priority VMs, see [Use low-priority VMs with Batch](/azure/batch/batch-low-pri-vms).

1. For **Virtual Network**, select the virtual network that you created earlier.

1. Specify any desired optional settings (or leave any other settings as their defaults), then select **OK**.
