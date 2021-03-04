In this exercise, you'll review and manage your firewall rules by using the Azure portal. You'll also configure the most secure connection while you're using the public endpoint.  

## Secure the network

When you deployed your database in Azure SQL Database, the script you ran configured **Allow Azure services and resources access to this server** to **Yes**. By keeping this **Yes** setting, you're allowing any resource from any region or subscription the possibility of accessing your resource. If you can, switch the setting to **No** to help ensure the most secure configuration of the public endpoint, because it will block all connections and networks other than the ones you've added. 

In this exercise, you'll see how to view and edit your firewall rules. Setting them up can be complicated, because it means you'll have to specify a range of IP addresses for all your connections, which can sometimes have dynamic IP addresses. Some alternative methods for securing your network are provided in a demonstration video that follows the exercise.  

### Manage firewall rules in the Azure portal

1. Go to the Azure portal, and look for your Azure SQL Database logical server.

    > [!div class="nextstepaction"]
    > [The Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

1. On the left pane, under **Security**, select **Firewalls and virtual networks**.  

    :::image type="content" source="../media/4-firewall-virtual-network.png" alt-text="Screenshot of how to go to firewalls and virtual networks.":::  

1. Select **No** for **Allow Azure services and resources to access this server**. During deployment, you should have added your Client IP address already, but if one of the rules doesn't match your Client IP, select **Add Client IP**.  

1. Select **Save**. You can select **Overview** on the left pane to go back to the overview of your database.  

1. To confirm that you still have access from your local machine, go to SQL Server Management Studio (SSMS) and refresh your connection to the Azure SQL Database logical server. If no errors occur, you have successfully configured access to your Azure SQL Database logical server for your IP address only.  

    :::image type="content" source="../media/4-db-refresh.png" alt-text="Screenshot of how to refresh database connection.":::  

1. Optionally, you can create a new query and check to see how you're connecting to your Azure SQL Database instance by running the following T-SQL query:  

    ```sql
    SELECT client_net_address FROM sys.dm_exec_connections WHERE session_id=@@SPID;
    ```  

    The result should be the *public* IP address of your local machine. You can confirm this address by opening an Azure PowerShell terminal on your local machine and running the following command:
    
    '(Invoke-WebRequest -UseBasicParsing -Uri "https://ipinfo.io/ip").Content'
    
    This is similar to how you found the IP address at the beginning of the module. The two IP addresses should match.  

### Manage firewall rules with Azure Cloud Shell  

You can also use the command `az sql server firewall-rule` to create, delete, and view server-level firewall rules. You can use the Azure CLI through the command-line interface of your Azure virtual machine (VM) or through a PowerShell notebook. For this part of the exercise, you'll experiment with Cloud Shell.  

1. You can access Cloud Shell through the portal but, in this unit, you'll use the built-in terminal at the right, which is essentially the same thing. To configure your environment, run the following command:  

    ```powershell
    $database_name = "AdventureWorks"
    $server = Get-AzureRmSqlServer -ResourceGroupName <rgn>Sandbox resource group name</rgn>
    $logical_server = $server.ServerName
    ```

1. Now that you're set up, you can list your server's firewall settings by using the following command:  

    ```azurecli
    az sql server firewall-rule list -g <rgn>Sandbox resource group name</rgn> -s $logical_server
    ```

    Your client IP address rule should match what you displayed in the preceding section by using the Azure portal.  

Setting up firewall rules by using either the Azure portal or Cloud Shell grants your client IP address access to all the databases in your logical server. After you've configured the server-level firewall rule, you can optionally configure database-level firewall rules that apply to individual databases. This can be done only with T-SQL, by using the command `EXECUTE sp_set_database_firewall_rule`. For more information, see the references in the summary of this module.  

## Go further

You've now seen how to update firewall rules for specific IP addresses or ranges of IP addresses on the server or database level. If you were running in production, you might also need access from various virtual networks or resources, such as Azure apps or Azure VMs. For example, Azure VMs have dynamic IP addresses, which means that the addresses change. You can set up static IP addresses, but even this can be difficult to maintain by using firewall rules. You can, alternatively, use virtual network rules to manage access from specific subnets that contain your VMs or other services. Or you could configure a private endpoint, the most secure way to connect to an Azure SQL Database instance.

In the video that follows, you can see how to create, configure, and compare the various methods of connecting to a database in Azure SQL Database: 
* Allow access to Azure resources
* Firewall rules 
* Virtual network rules
* Private endpoint

> [!VIDEO https://www.microsoft.com/en-us/videoplayer/embed/RE4Mx9S]
