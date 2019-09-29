In this exercise, we'll create two Azure SQL databases to represent two fitness locations, and then create a SQL elastic pool to manage two databases.

[!include[](../../../includes/azure-sandbox-activate.md)]

## Create SQL servers

We'll start by creating a SQL server for our fitness databases and we'll add databases for two locations. The steps use Vancouver and Paris but feel free to use other location names. 

1. First declare a few helper variables. SERVERNAME variable will have a random number after the '-'. Replace `<location>` with one of the locations in the list below and replace `<password>` with a complex password for the databases.

    [!include[](../../../includes/azure-sandbox-regions-first-mention-note.md)]
 
    ```azurecli
    ADMIN_LOGIN="ServerAdmin"
    RESOURCE_GROUP=<rgn>[sandbox resource group name]</rgn>
    SERVERNAME=FitnessSQLServer-$RANDOM
    LOCATION=<location>
    PASSWORD=<password>
    ```

1. Create a server named **FitnessSQLServer-nnnn**.
    ```azurecli
    az sql server create \
    --name $SERVERNAME \
    --resource-group $RESOURCE_GROUP \
    --location $LOCATION \
    --admin-user $ADMIN_LOGIN \
    --admin-password $PASSWORD
    ```

1. Add a database named **FitnessVancouverDB** to **FitnessSQLServer-nnnn**.
    ```azurecli
    az sql db create \
    --resource-group $RESOURCE_GROUP \
    --server $SERVERNAME \
    --name FitnessVancouverDB
    ```

1. Add a database named **FitnessParisDB** to **FitnessSQLServer-nnnn**.
    ```azurecli
    az sql db create \
    --resource-group $RESOURCE_GROUP \
    --server $SERVERNAME \
    --name FitnessParisDB
    ```

## Create a SQL elastic pool

We're ready to set up the resources for the SQL elastic pool. We'll switch to the portal to create the elastic pool.

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you used to activate the sandbox.

1. Click on **+ Create a resource** and search for **SQL Elastic database pool**.

1. Select the **SQL Elastic database pool** result and then press the **Create** button on the next screen.

1. Give your new elastic pool a meaningful name such as **FitnessSQLPool**, and ensure the <rgn>[sandbox resource group name]</rgn> resource group is selected.

1. In the **Server** section, ensure your existing **FitnessSQLServer-nnnn** server is selected

1. In the **Compute + storage** section, click **Configure elastic pool**.

1. Click **Basic**, and then click **Apply**.

1. Click **Review + create**. Review your information, and then click **Create**. The SQL elastic pool may take several minutes to provision.

## Add existing databases to the elastic pool

1. Open your newly created SQL elastic pool in the Azure portal and navigate to the **Overview** section. Note there are currently no databases in the pool.

1. Select **Configure** in the **Settings** section.

1. Select the **Databases** tab.

1. Click **+ Add databases**.

1. Select the databases for both locations.

1. Click **Apply**.

1. Click **Save**.

Congratulations, you've successfully added databases to a SQL elastic pool.
