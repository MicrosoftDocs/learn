In this exercise, we're going to create a Hyperscale instance using the Azure portal. Our server group will have:

* One coordinator node, with 4 vCores and 0.5 TiB of storage
* Two worker nodes, each with 4 vCores and 0.5 TiB of storage

For a total of 12 vCores and 1.5 TiB of storage.

[!include[](../../../includes/azure-exercise-subscription-prerequisite.md)]

1. Sign in to the Azure portal using your Azure account.

    > [!div class="nextstepaction" target="_blank"]
    > [Azure portal](https://portal.azure.com?azure-portal=true)

1. Next, select **Create a resource**, **Databases**, and **Azure Database for PostgreSQL**. You can also use the **Search** functionality to find this category.

    :::image type="content" source="../media/3a-select-postgres.png" alt-text="Select create database.":::

1. Select **Create** in the **Hyperscale (Citus) server group** box.

    :::image type="content" source="../media/3a-hyper.png" alt-text="Select Hyperscale deployment.":::

    > The portal will display a PostgreSQL server configuration screen.

1. On the **Basics** tab, enter the following information:  

    |Parameter  |Value  |
    |---------|---------|
    |**Subscription**     |  Select **Free Trial** or **your existing subscription**       |
    |**Resource group**     | Select **Create new** and name your resource group **Hyperscale**       |
    |         **Server name** |  **Choose a unique name**, such as payment-server-demo  |
    |**Location**| Use a region that's close to you, or leave as default |
    |**Compute + storage**     |  Leave as default, we'll configure this in the next step      |
    | **Admin username**| Citus will be selected by default |
    | **Password/Confirm Password**|  Choose a password |

    1. Note the server name and password down for later use.
    1. Select **Configure server group** in the **Compute + storage** options.

    :::image type="content" source="../media/3c-form.png" alt-text="Configure Hyperscale form.":::

1. Increase compute and storage if you want. Next, scroll to the bottom of the page and select the blue **Save** box.
1. Select the **Networking** tab at the top of the page
1. Select **Add 0.0.0.0 - 255.255.255.255**, then select **Continue**.

    :::image type="content" source="../media/3d-firewall.png" alt-text="Configure Hyperscale firewall.":::

1. Scroll to the bottom of the page and select the blue **Review + create** button.

1. Select the blue **Create** button at the bottom of the page.

Congratulations! Your Hyperscale server group is being deployed to Azure.
