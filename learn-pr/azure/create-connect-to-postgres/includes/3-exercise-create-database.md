We want to have a large, high-performance database for the trial of our payment app.

In this exercise, we'll:

* Create an Azure Database for PostgreSQL instance in the Azure portal
* Change the pricing tier and backup options

The Azure Sandbox gives you a safe, sandboxed environment to use Azure resources to complete the exercises, for free.

1. Sign in to the Azure portal by using the same account that you activated the sandbox with.

    > [!div class="nextstepaction"]
    > [Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

1. Select **Create a resource** > **Databases** > **Azure Database for PostgreSQL**. You can also use the **Search** functionality to find this category.

    :::image type="content" source="../media/3a-create.png" alt-text="Create Azure Database for PostgreSQL":::

1. In the **Single server** box, select **Create**.

    :::image type="content" source="../media/3b-create-single-server.png" alt-text="Create single server deployment.":::
     > The portal will display a PostgreSQL server configuration screen. Enter the following information.

    |Parameter  |Value  |
    |---------|---------|
    | On the **Basics** tab, under **Project details** section: |
    |**Subscription**     |  Leave as **Concierge subscription**      |
    |**Resource group**     | learn-xxx       |
    | Under **Server details** section: |
    |**Server name** |  *Choose a unique name*, such as payment-server-demo |
    |**Data source** |  Leave as **none**  |
    |**Location**| Leave the default, or use a region that's close to you. |
    |**Version**| Leave as **10** |
    |**Compute + storage**     |  Leave the default of **General Purpose**.       |
    | Under **Administrator account** section: |
    |**Admin username**| **paymentadmin** |
    |**Password/Confirm password**|  Choose and confirm a password. |

1. Note the password and server name down for later use.

1. Under the **Compute + storage** option, select **Configure server**.

    :::image type="content" source="../media/3d-form.png" alt-text="Configuration form.":::

1. On the **Configure** page:

    1. Select **35 days** in the **Backup Retention Period** section.

    1. Select **Geo-Redundant** in the **Backup Redundancy Options** section. Feel free to increase compute power and storage size, if you like.

    1. Select **OK**.

    1. Select **Review + create**.

    :::image type="content" source="../media/3e-form.png" alt-text="Configure server options form.":::

1. Select **Create**.

Congratulations! Your database is being deployed to Azure.
