In this exercise, we'll create two Azure SQL databases to represent two fitness locations, then create a SQL elastic pool to manage two databases.

## Create SQL servers

We'll start by creating a SQL server for our fitness databases, then we'll add databases for two locations. The following steps use Vancouver and Paris, but feel free to use other location names.

1. First, declare a few helper variables. The SERVERNAME variable will have a random number after the '-'. Replace `<location>` with one of the locations in the following list, and replace `<password>` with a complex password for the databases.

    [!include[](../../../includes/azure-sandbox-regions-first-mention-note.md)]

    ```azurecli
    ADMIN_LOGIN="ServerAdmin"
    RESOURCE_GROUP=<rgn>[sandbox resource group name]</rgn>
    SERVERNAME=fitnesssqlserver-$RANDOM
    LOCATION=<location>
    PASSWORD=<password>
    ```

1. Create a server named **fitnesssqlserver-nnnn** (the *nnnn* is replaced by a randomly generated number).

    ```azurecli
    az sql server create \
    --name $SERVERNAME \
    --resource-group $RESOURCE_GROUP \
    --location $LOCATION \
    --admin-user $ADMIN_LOGIN \
    --admin-password $PASSWORD
    ```

1. Add a database named **fitnessvancouverdb** to **fitnesssqlserver-nnnn**.

    ```azurecli
    az sql db create \
    --resource-group $RESOURCE_GROUP \
    --server $SERVERNAME \
    --name fitnessvancouverdb
    ```

1. Add a database named **fitnessparisdb** to **fitnesssqlserver-nnnn**.

    ```azurecli
    az sql db create \
    --resource-group $RESOURCE_GROUP \
    --server $SERVERNAME \
    --name fitnessparisdb
    ```

## Create a SQL elastic pool

We're ready to set up the resources for the SQL elastic pool. We'll switch to the portal to create the elastic pool.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you used to activate the sandbox.

1. From the Azure portal menu or the **Home** page, under **Azure services**, select **Create a resource**. The **Create a resource** pane appears.

1. Search for and select **SQL Elastic database pool**. The **SQL Elastic database pool** pane appears.

1. Select **Create**. The **Create SQL Elastic pool** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    |---|---|
    | **Project details** |
    | Subscription | Concierge Subscription |
    | Resource group | From the dropdown list, select <rgn>[sandbox resource group name]</rgn> |
    | **Elastic pool details** |
    | Elastic Pool Name | Provide a meaningful name, such as *fitnesssqlpool*. |
    | Server | Ensure your existing *fitnesssqlserver-nnnn* server is selected. |
    | Compute + storage | Select the **Configure elastic pool** link. The **Configure** pane appears. |

1. On the **Pool settings** tab, enter the following value for the setting.

    | Setting | Value |
    |---|---|
    | **Service and compute tier** |
    | Service tier | From the dropdown list, under **DTU-based purchasing model**, select **Basic (For less demanding workloads)**. |

1. Select **Apply**. The **Create SQL Elastic pool** pane reappears.

1. Select **Review + create**. Review your entries, and then select **Create**. The SQL elastic pool may take several minutes to provision.

## Add existing databases to the elastic pool

1. Upon successfully completing deployment of your resources, select **Go to resource**. Your **SQL elastic pool** pane appears on the *Overview* section. Note there are currently no databases in the pool.

1. In the top menu bar, select **Configure**. The **Configure** pane appears for your SQL elastic pool.

1. Select the **Databases** tab, and then select **Add databases**. The **Add databases** pane appears.

1. Select the databases you created for both locations, then select **Apply**. The **Configure** pane reappears.

1. In the top menu bar, select **Save**.

Congratulations, you've successfully added databases to a SQL elastic pool.
