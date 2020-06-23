You've now seen the Azure portal, SSMS, and SQL Notebooks in ADS, but there are other tools available to you to use to manage Azure SQL. Two of the most popular are the Azure CLI and Azure PowerShell. They are similar in their functionality, but for this activity we will focus on the Azure CLI.  

To complete this activity, you could use a PowerShell notebook, which is the same concept as a SQL notebook, but the coding language is PowerShell. You can use PowerShell notebooks to leverage Azure CLI or Azure PowerShell, but we will focus on Azure CLI commands. For both of these tools, you can also use the Azure Cloud Shell, which is an interactive shell environment that you can use through your browser in the Azure portal. In this exercise, you'll use the Azure Cloud Shell. Since it displays on the right-hand side of this browser, meaning you don't have to install the Azure CLI or Azure PowerShell modules!  

### Intro to Azure Cloud Shell and Azure CLI

In the example that follows, you'll explore the latency effects of using different connection policies in Azure SQL.  

> [!NOTE]
> In PowerShell in the Azure Cloud Shell, you can use the PowerShell Az module or the Azure CLI. In this activity, you'll explore the Azure CLI, but you should know there are similar commands available for the PowerShell Az module.  

1. Setup  

    You'll run all of the commands using the integrated terminal to your right. You can easily copy them and then leverage `SHIFT + INSERT` to paste into the terminal.

    You can configure a default resource group and Azure SQL Database logical server, so you don't have to specify with every `az` command:
 
    ```powershell
    $resourceGroup = Get-AzResourceGroup | Where ResourceGroupName -like learn*
    $server = Get-AzureRmSqlServer -ResourceGroupName $resourceGroup.ResourceGroupName
    $logical_server = $server.ServerName
    $resource_group = $resourceGroup.ResourceGroupName
    $databaseName = Get-AzureRmSqlDatabase -ResourceGroupName $resourceGroup.ResourceGroupName -ServerName $logical_server | Where DatabaseName -like Adventure*
    $databaseName = $databaseName.DatabaseName

    # Specify your default resource group and Azure SQL Database logical server
    az configure --defaults group=$resource_group sql-server=$logical_server

    # Confirm the defaults have been set
    az configure --list-defaults
    ```

2. Sample Azure CLI commands

    Now that you've got your details plugged in, let's see what you can do with the Azure CLI.  

    ```powershell
    # Show all databases in the Azure SQL Database logical server
    az sql db list
    ```

    There's a lot of information above. What if we just want to see specifics for the AdventureWorks database?  

    ```powershell
    az sql db show --name $databaseName
    ```

    You can also determine database size and usage.  

    ```powershell
    az sql db list-usages --name $databaseName
    ```

    You've now seen a few examples for how the `az sql db` commands work. There are also commands related to the Azure SQL Database logical server, and these fall under `az sql server`.  

    There are also similar commands for `az sql mi` and `az sql midb` (commands for databases within a Managed Instance, sometimes referred to as "Managed Databases").  

    For detailed explanations of all the commands available, refer to the Azure CLI documentation.  

### Example: Managing connection policies with the Azure CLI 

One thing that you might use the Azure CLI or Azure PowerShell commands for is updating the connection policy. We'll use this as an example for how you can manage Azure SQL using a tool like the Azure CLI. In this example, you'll look at Azure SQL Database and its commands for managing the connection policies, but the implementation is very similar in Azure SQL Managed Instance.  

1. Check current connection policy

    Let's see what the current policy is using the Azure CLI.  

    ```powershell
    az sql server conn-policy show
    ```

    So the results above tell you the connection type is "Default".

2. Change connection policy to Proxy

    Let's set the connection policy to "Proxy" and determine the round trip time.  

    ```powershell
    # update policy
    az sql server conn-policy update --connection-type Proxy
    # confirm update
    az sql server conn-policy show
    ```

3. Determine network latency for Proxy

    If you want to test round trip time, you can connect with SSMS, create a new query (below), and choose to "Include Client Statistics" in your results. Be sure to right-click on the database and select **New Query**. In the results, the "Wait time on server replies" is the best indicator of network latency. You can run this a few times to get a good average.  

    ```sql
    -- Proxy
    SELECT * FROM SalesLT.Product
    GO 10
    ```

    After 10 trials, I had an average wait time on server replies of `46.6000`, depending on your internet connection, your results will vary. Make a note of the time you observe.  

4. Update connection policy to Redirect

    What if we want to make everything `Redirect` so we can attempt to achieve reduced latency?

    First, for anything that is **outside Azure**, you need to allow inbound and outbound communication on ports in the range of 11000 - 11999. This is required for the Redirect connection policy.  

    > Note: This is likely already configured on your local device, but if you hit errors in the next steps, you may need to enable the ports above, [more guidance available here](https://docs.microsoft.com/azure/sql-database/sql-database-develop-direct-route-ports-adonet-v12).  

    Update the connection policy and confirm that update with the following two commands.  

    ```powershell
    # update policy
    az sql server conn-policy update --connection-type Redirect
    # confirm update
    az sql server conn-policy show
    ```

5. Determine network latency for Redirect

    Now, to test network latency from the `Redirect` policy, connect with SSMS, create a new query (below), and choose to "Include Client Statistics" in your results. Compare the "Wait time on server replies" with your query for `Proxy`.  

    You'll need to create a **new connection to query** to evaluate (i.e. right-click on the Adventure Works database and select New Query, do not use the query window you used to test Proxy).

    ```sql
    -- Redirect
    SELECT * FROM SalesLT.Product
    GO 10
    ```

    After 10 trials, I have an average wait time on server replies of `25.8000`, which is almost half that of the Proxy connection policy. Remember, exact timings will vary depending on your connection, but compared to your Proxy test earlier, this time should be significantly reduced.  

6. Clean up

    Set the policy back to default for the next exercise, by using the similar commands.  

    ```powershell
    # update policy
    az sql server conn-policy update --connection-type Default
    # confirm update
    az sql server conn-policy show
    ```

### To review

Redirect is faster because after the intial connection, you can bypass the gateway and go straight to the database. This means less hops, which results in less latency, which ultimately helps in preventing bottlenecks, which is especially important for chatty applications. In the performance module, you'll learn more about how to improve and optimize performance.  
