In this exercise, you'll review and manage your firewall rules by using the Azure portal. You'll also configure the most secure connection while you're using the public endpoint.  

## Secure the network

When you deployed your database in Azure SQL Database, the script you ran configured **Allow Azure services and resources access to this server** to **Yes**, which allows any resource from any region or subscription access to your resource. It is important to switch the setting to **No** to ensure the most secure configuration of the public endpoint. When set to **No**, it will block all connections and networks other than the ones you've added. 

In this exercise, you'll see how to view and edit firewall rules. Setting up firewall rules can be complicated, because you'll need to specify a range of IP addresses for all your connections, which can sometimes use dynamic IP addresses. Alternative methods for securing your network are provided in a demonstration video at the end of this exercise.  

### Manage firewall rules in the Azure portal

1. In the Azure portal resource menu, select **SQL databases** and then select your Azure SQL Database logical server (AdventureWorks).

1. In the command bar of your SQL database, select **Set server firewall**.  

    :::image type="content" source="../media/4-firewall-virtual-network.png" alt-text="Screenshot of how to go to firewalls and virtual networks.":::  

1. For **Allow Azure services and resources to access this server**, select **No**. 

1. You should have added your Client IP address during deployment, but if one of the rules doesn't match your Client IP, under **Rule name** add the   

1. Select **Save** from the command bar. In the SQL database menu, select **Overview** to return to Essentials view of your database.  

1. To confirm that you still have access from your local machine, go to SQL Server Management Studio (SSMS) and refresh your connection to the Azure SQL Database logical server. If no errors occur, you have successfully configured secure access to your Azure SQL Database logical server for your IP address.  

    :::image type="content" source="../media/4-db-refresh.png" alt-text="Screenshot of how to refresh the database connection.":::  

1. Optionally, you can see how you're connecting to your Azure SQL Database instance by running the following T-SQL query:  

    ```sql
    SELECT client_net_address FROM sys.dm_exec_connections WHERE session_id=@@SPID;
    ```  

    The result should be the *public* IP address of your local machine. You can confirm your IP address by opening an Azure PowerShell terminal on your local machine and running the following command:
    
    '(Invoke-WebRequest -UseBasicParsing -Uri "https://ipinfo.io/ip").Content'
    
    You used a similar command to find the IP address at the beginning of the module. This query should return the same IP address.  

### Manage firewall rules with Azure Cloud Shell  

You can also use the Azure CLI command `az sql server firewall-rule` to create, delete, and view server-level firewall rules. You can use the Azure CLI through the command-line interface of your Azure virtual machine (VM) or through a PowerShell notebook. For this exercise, you'll experiment with Cloud Shell. You can open a Cloud Shell terminal through the Azure portal, but for now, use the sandbox built-in terminal at the right, which is essentially the same thing.  

1. Run the following command to configure your environment:  

    ```powershell
    $database_name = "AdventureWorks"
    $server = Get-AzureRmSqlServer -ResourceGroupName <rgn>Sandbox resource group name</rgn>
    $logical_server = $server.ServerName
    ```

1. Enter the following command to list your server's firewall settings:  

    ```azurecli
    az sql server firewall-rule list -g <rgn>Sandbox resource group name</rgn> -s $logical_server
    ```

    The client IP address rule output should match what you saw displayed in the Azure portal in the preceding section.  

Setting up server-level firewall rules by using either the Azure portal or Cloud Shell grants your client IP address access to all the databases in your logical server. You can  configure database-level firewall rules, which apply to individual databases by using the T-SQL command `EXECUTE sp_set_database_firewall_rule`. T-SQL is the only method available for configuring firewall rules for a specific database. For more information, see the references on the Summary page of this module.  

## Go further

You've now seen how to update firewall rules for specific IP addresses or ranges of IP addresses on the server and at the database level. In a production environment, you might also need access from various virtual networks or resources, such as Azure apps or Azure VMs. Azure VMs have dynamic IP addresses, which means that the addresses change. You can set up static IP addresses, which can be difficult to maintain using firewall rules. Alternatively, you can use virtual network rules to manage access from specific subnets that contain your VMs or other services. Or, you could configure a private endpoint, the most secure way to connect to an Azure SQL Database instance.

In this video, you will see how to create, configure, and compare the various methods of connecting to a database in Azure SQL Database: 
* Allow access to Azure resources
* Firewall rules 
* Virtual network rules
* Private endpoint

> [!VIDEO https://www.microsoft.com/en-us/videoplayer/embed/RE4Mx9S]
