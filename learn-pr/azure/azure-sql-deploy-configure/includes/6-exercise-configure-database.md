You've now seen the Azure portal, and SQL Server Management Studio (SSMS). Other tools for managing Azure SQL products are available. Two of the most popular are the Azure CLI and Azure PowerShell. They're similar in functionality. For both of these tools, you can also use Azure Cloud Shell, which is an interactive shell environment that you can use through your browser in the Azure portal.

This activity focuses on the Azure CLI. In this exercise, we use Cloud Shell. It already includes the Azure CLI and Azure PowerShell modules.

## Connecting with Azure Cloud Shell and the Azure CLI

In the example that follows, you explore the latency effects of using different connection policies in Azure SQL.  

Run all of the commands by using Cloud Shell. You can easily copy them and then select **Shift**+**Insert** to paste into the terminal.

> [!NOTE]
> In PowerShell by using Azure Cloud Shell, you can use the PowerShell Az module or the Azure CLI. In this activity, we explore the Azure CLI, but similar commands are available for the PowerShell Az module.

1. Go to [shell.azure.com](https://shell.azure.com) and sign in to your Azure account, if prompted.

1. Configure a default resource group and an Azure SQL Database logical server, so you don't have to specify them with every `az` command. Run the following commands to set some variables. Replace `<resource-group>` and `<your-server>` with the values that you used when you created your SQL instance in the previous exercise.

    ```azurecli
    resourceGroup="<resource-group>"
    logical_server="<your-server>"
    databaseName="AdventureWorks"
    ```

1. Set the defaults in Cloud Shell to specify your default resource group and Azure SQL Database logical server:

    ```azurecli
    az configure --defaults group=$resourceGroup sql-server=$logical_server
    ```

1. Run the following command to confirm that the defaults have been set:

    ```azurecli
    az configure --list-defaults
    ```

1. Run the following command to show all databases in the Azure SQL Database logical server:

    ```azurecli
    az sql db list
    ```

1. The list of databases is a lot of information. Run the following command if you just want to see specifics for the `AdventureWorks` database:

    ```azurecli
    az sql db show --name $databaseName
    ```

1. Run the following command to determine database size and usage:

    ```azurecli
    az sql db list-usages --name $databaseName
    ```

These examples use the [az sql db](/cli/azure/sql/db) commands. There are also commands related to the Azure SQL Database logical server. They fall under [az sql server](/cli/azure/sql/server).  

There are similar commands for [az sql mi](/cli/azure/sql/mi) and [az sql midb](/cli/azure/sql/midb). They're commands for databases within a managed instance, sometimes called *managed databases*.  

For detailed explanations of all the available commands, refer to the [Azure CLI documentation](/cli/azure/).  

## Manage connection policies with the Azure CLI

One thing for which you might use the Azure CLI or Azure PowerShell commands is updating the connection policy. This update is an example of how you can manage Azure SQL by using a tool like the Azure CLI. In this example, you look at Azure SQL Database and its commands for managing the connection policies. The implementation is similar in Azure SQL Managed Instance.  

1. Discover the current policy by using the Azure CLI.  

    ```azurecli
    az sql server conn-policy show
    ```

    The results tell you the connection type is `Default`.

1. Set the connection policy to `Proxy` and determine the round-trip time.  

    ```azurecli
    # update policy
    az sql server conn-policy update --connection-type Proxy
    # confirm update
    az sql server conn-policy show
    ```

1. To test round-trip time, connect by using SSMS. On your device, open SSMS and connect to your database. Right-click your database and select **New Query**. Create a new query with the following text, and then select **Query** > **Include Client Statistics**. In the results, **Wait time on server replies** is the best indicator of network latency. You can run this query a few times to get a good average.  

    ```sql
    -- Proxy
    SELECT * FROM SalesLT.Product
    GO 10
    ```

    After 10 trials, an average wait time on server replies might be something like `46.6000`. Depending on your internet connection, your results might vary. Make a note of the time that you observe.  

1. What if you want to make everything `Redirect` so you can try to achieve reduced latency?

    For anything that's outside Azure, you need to allow inbound and outbound communication on ports in the range of 11000 to 11999. Opening these ports is required for the `Redirect` connection policy.  

    > [!NOTE]
    > This is likely already configured on your local device. If you hit errors in the next steps, you might need to enable the ports mentioned earlier. For more information, see [Ports beyond 1433 for ADO.NET 4.5](/azure/sql-database/sql-database-develop-direct-route-ports-adonet-v12?azure-portal=true).  

    Update the connection policy and confirm that update with the following two commands.  

    ```azurecli
    # update policy
    az sql server conn-policy update --connection-type Redirect
    # confirm update
    az sql server conn-policy show
    ```

1. To test network latency from the `Redirect` policy, connect with SSMS on your local device. Create a new query by using the following text, and choose **Include Client Statistics** for your results. Compare **Wait time on server replies** with your query for `Proxy`.  

    ```sql
    -- Redirect
    SELECT * FROM SalesLT.Product
    GO 10
    ```

    After 10 trials, an average wait time on server replies might be around `25.8000`, which is almost half that of the proxy-connection policy. Exact timings vary depending on your connection. The time should be significantly reduced compared to your earlier proxy test.  

1. Set the policy back to default for the next exercise by using the following commands:

    ```azurecli
    # update policy
    az sql server conn-policy update --connection-type Default
    # confirm update
    az sql server conn-policy show
    ```

Redirect is faster because after the initial connection you can bypass the gateway and go straight to the database. This bypass means fewer hops, which results in less latency. Less latency helps in preventing bottlenecks, which is especially important for chatty applications. In the performance module, you learn more about how to improve and optimize performance.
