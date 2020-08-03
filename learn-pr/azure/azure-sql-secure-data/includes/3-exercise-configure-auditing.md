Auditing is an important piece of any security strategy. We're going to start here by enabling auditing first, which will give us auditing data to work with in later exercises.

The auditing feature tracks database and server events and writes events to an audit log in either Azure storage, Azure Monitor logs, or to an Azure Event Hub. Auditing helps maintain regulatory compliance, understand database activity, and gain insight into discrepancies and anomalies that could indicate potential security violations. In this activity, you'll set up auditing at the server level, though it's also available at the database level.  

### Set up: Use scripts to deploy Azure SQL Database

In the right-hand terminal, you'll see the Azure Cloud Shell, which is a way to interact with Azure using a browser. Before you start the labs, you will run a script there in order to create your environment, an Azure SQL Database with the AdventureWorks database. In the script you will be prompted for a password for the new database and your local IP address to enable your device to connect to the database.  

These scripts should take 3-5 minutes to complete. Make sure to note your password, unique ID, and region as it will not be shown again.

1. Start by obtaining your local IP address. Ensure you are disconnected from any VPN service and open a local PowerShell terminal on your device. Run the following command and note the resulting IP address.

    ```powershell
    (Invoke-WebRequest -Uri "https://ipinfo.io/ip").Content
    ```

1. Next, run the following commands in the Azure Cloud Shell on the right. Fill in a complex password and enter your local public IP address you retrieved when prompted.

    ```powershell
    $adminSqlLogin = "cloudadmin"
    $password = Read-Host "Your username is 'cloudadmin'. Please enter a password for your Azure SQL Database server that meets the password requirements"
    # Prompt for local ip address
    $ipAddress = Read-Host "Disconnect your VPN, open PowerShell on your machine and run '(Invoke-WebRequest -Uri "https://ipinfo.io/ip").Content'. Please enter the value (include periods) next to 'Address': "
    # Get resource group and location and random string
    $resourceGroup = Get-AzResourceGroup | Where ResourceGroupName -like "<rgn>Sandbox resource group name</rgn>"
    $resourceGroupName = "<rgn>Sandbox resource group name</rgn>"
    $uniqueID = Get-Random -Minimum 100000 -Maximum 1000000
    $storageAccountName = "mslearnsa"+$uniqueID
    $location = $resourceGroup.Location
    # The logical server name has to be unique in the system
    $serverName = "aw-server$($uniqueID)"
    ```

1. Output and store (in a text file or similar) the information you'll need throughout the module by running the following in the Azure Cloud Shell.  You'll likely need to press `ENTER` after you paste in the code, as the last line will not be run by default.

    ```powershell
    Write-Host "Please note your unique ID for future exercises in this module:"  
    Write-Host $uniqueID
    Write-Host "Your resource group name is:"
    Write-Host $resourceGroupName
    Write-Host "Your resources were deployed in the following region:"
    Write-Host $location
    Write-Host "Your server name is:"
    Write-Host $serverName
    ```

    **Don't forget to note your password, unique ID, and region. You will need these throughout the module.**

1. Run the following script to deploy an Azure SQL Database and logical server with the AdventureWorks sample. This will also add your IP address as a firewall rule, enable Advanced Data Security, and create a storage account for use in future units.

    ```powershell
    # The logical server name has to be unique in the system
    $serverName = "aw-server$($uniqueID)"
    # The sample database name
    $databaseName = "AdventureWorks"
    # The storage account name has to be unique in the system
    $storageAccountName = $("sql$($uniqueID)")
    # Create a new server with a system wide unique server name
    $server = New-AzSqlServer -ResourceGroupName $resourceGroupName `
        -ServerName $serverName `
        -Location $location `
        -SqlAdministratorCredentials $(New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $adminSqlLogin, $(ConvertTo-SecureString -String $password -AsPlainText -Force))
    # Create a server firewall rule that allows access from the specified IP range and all Azure services
    $serverFirewallRule = New-AzSqlServerFirewallRule `
        -ResourceGroupName $resourceGroupName `
        -ServerName $serverName `
        -FirewallRuleName "AllowedIPs" `
        -StartIpAddress $ipAddress -EndIpAddress $ipAddress 
    $allowAzureIpsRule = New-AzSqlServerFirewallRule `
        -ResourceGroupName $resourceGroupName `
        -ServerName $serverName `
        -AllowAllAzureIPs
    # Create a database
    $database = New-AzSqlDatabase  -ResourceGroupName $resourceGroupName `
        -ServerName $serverName `
        -DatabaseName $databaseName `
        -SampleName "AdventureWorksLT" `
        -Edition "GeneralPurpose" -Vcore 2 -ComputeGeneration "Gen5"
    # Enable Advanced data security
    $advancedDataSecurity = Enable-AzSqlServerAdvancedDataSecurity `
        -ResourceGroupName $resourceGroupName `
        -ServerName $serverName
    # Create a Storage Account
    $storageAccount = New-AzStorageAccount -ResourceGroupName $resourceGroupName `
        -AccountName $storageAccountName `
        -Location $location `
        -Type "Standard_LRS"
    ```

1. Open SSMS and create a new connection to your logical server. For server name, input the name of your Azure SQL Database logical server. If you did not save it above, you may need to refer to the Azure portal to get this, for example, *aw-server`<unique ID>`.database.windows.net*.  

    > [!div class="nextstepaction"]
    > [Azure Portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

    Once you're in the Azure portal you can search in the top bar for `AdventureWorks` to find your database and its associated logical server.

    Change the authentication to **SQL Server Authentication**, and input the corresponding Server Admin Login and Password (the one you provided during deployment in the previous exercise).  

    Check the **Remember password** box and select **Connect**.  

    :::image type="content" source="../media/3-connect-azure-sql.png" alt-text="Screenshot of how to connect to SQL Database in SSMS.":::  

    > [!NOTE]
    > Depending on your local configuration (for example, VPN), your client IP address may differ from the IP address the Azure portal used during deployment. If it does, you'll get a pop-up which reads "Your client IP address does not have access to the server. Sign in to an Azure account and create a new firewall rule to enable access." If you get this message, sign-in using the account you're using for the sandbox, and add a firewall rule for your client IP address. You can complete all of these steps using the pop-up wizard in SSMS.  

### Configure auditing

1. Open the Azure portal and navigate to your Azure SQL Database to enable Auditing on the logical server. Set **Auditing** to **ON**.

    > [!div class="nextstepaction"]
    > [Azure Portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

1. In the left-hand menu, under Security, select **Auditing**. Review the options and then select **View server settings**.

    :::image type="content" source="../media/3-db-audit.png" alt-text="Screenshot of the database-level auditing blade.":::  

    You can apply auditing at the server level, which then applies to all databases within the Azure SQL Database logical server. If you also apply at the database level (you won't do that today), that would mean the two audits would happen in parallel (one does not override the other). You could alternatively only audit at the database level.

1. Select **Log Analytics (Preview)** and the **Configure** button.  

1. Select **+ Create New Workspace**.  Fill in the information according to the subscription, resource group, and location, that you are using to complete this module.  We recommend naming your Log Analytics Workspace **azuresql`<unique ID>`-la**, using your unique ID for your resources. Select **OK**.

    This process may take a few moments to validate and create. You should then see your Log Analytics account in the Auditing view.

1. Next, select **Storage**, then select **Configure**. This option allows you to collect XEvent log files in an Azure Blob storage account. In a later activity, you'll see more on how this differs from Log Analytics.

1. Next, select the **Concierge Subscription** you're using for this module as well as the storage account in the resource group with your ID that was created for you (should be *sqlva* + *a random string of letters and numbers*). In this storage account, auditing logs will be saved as a collection of blob files within a container named **sqldbauditlogs**.  

    Depending on your organization, in production you may consider having a separate storage account for the audit logs.

1. For **Retention (Days)** enter 7, and for **Storage access key**, select **Primary**.

1. After you've configured your options, select **OK**.  

1. Select **Save**.  

    :::image type="content" source="../media/3-save-workspace.png" alt-text="Screenshot of saving Log Analytics details.":::  

    Once it saves, you can select the **X** button to close the server level Auditing pane.  

1. Navigate back to your Azure SQL Database (not logical server) and under Security, select **Auditing**. In the Azure SQL Database Auditing overview, you may notice that the **Auditing** option says **OFF**, but that **Server-level Auditing: Enabled** is also displayed. It's important to note that if auditing is enabled on the server, it will always apply to the database.  

    :::image type="content" source="../media/3-db-audit-off.png" alt-text="Screenshot of Auditing being OFF.":::  

You've now enabled auditing to a storage account and an Azure Monitor workspace. Later on, you'll dive deeper into auditing capabilities in Azure SQL and see how to analyze the audit logs to view all of the changes you've made throughout the module, as well as some other interesting use cases.  
