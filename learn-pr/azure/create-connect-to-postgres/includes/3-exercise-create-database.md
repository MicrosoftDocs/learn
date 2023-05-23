You want to have a large, high-performance database for the trial of your payment app.

In this exercise:

- Create an Azure Database for PostgreSQL instance in the Azure portal
- Change the pricing tier and backup options

The Azure Sandbox gives you a safe, sandboxed environment to use Azure resources to complete the exercises, for free.

1. Sign in to the Azure portal by using the same account that you activated the sandbox with.

    > [!div class="nextstepaction"]
    > [Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

1. Select **Create a resource** > **Databases** > **Azure Database for PostgreSQL**. You can also use the **Search** functionality to find this category. Select **Create**.

    :::image type="content" source="../media/3a-create.png" alt-text="Screenshot shows the create option for Azure Database for PostgreSQL.":::

1. Under **Azure Database for PostgreSQL**, for **Resource type**, select **Single server**, and then select **Create**.

    :::image type="content" source="../media/3b-create-single-server.png" alt-text="Screenshot shows the Single server Resource type.":::

1. The Azure portal displays a PostgreSQL server configuration screen. Enter the following information.

    | Parameter | Value |
    |:----------|:------|
    | On the **Basics** tab, under **Project details**:        |
    | **Subscription**   | Leave as **Concierge subscription** |
    | **Resource group** | learn-xxx                           |
    | Under **Server details**:                                                       |
    | **Server name**       | *Choose a unique name*, such as payment-server-demo     |
    | **Data source**       | Leave as **none**.                                      |
    | **Location**          | Leave the default, or use a region that's close to you. |
    | **Version**           | Leave the default version.                              |
    | **Compute + storage** |  Leave the default of **General Purpose**.              |
    | Under **Administrator account**:                                |
    | **Admin username**            | **paymentadmin**                |
    | **Password/Confirm password** |  Choose and confirm a password. |

1. Note the password and server name for later use.

1. Under the **Compute + storage** option, select **Configure server**.

    :::image type="content" source="../media/3d-form.png" alt-text="Screenshot shows the Basics tab with the Configure server option highlighted.":::

1. On the **Configure** page:

   - Select **35 days** in the **Backup Retention Period** section.

   - Select **Geo-Redundant** in the **Backup Redundancy Options** section. Feel free to increase compute power and storage size, if you like.

   - Select **OK**.

   - Select **Review + create**.

    :::image type="content" source="../media/3e-form.png" alt-text="Screenshot shows the Configure page for the server with the Backup Retention Period slider set to 35 days.":::

1. Select **Create**.

Congratulations! Your database is being deployed to Azure.
