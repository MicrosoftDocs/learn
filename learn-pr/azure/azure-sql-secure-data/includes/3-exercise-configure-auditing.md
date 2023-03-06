Auditing is an important piece of any security strategy. In this unit, you'll start by enabling auditing, which will give you auditing data to work with in later exercises.

The auditing feature tracks database and server events and writes events to an audit log in either Azure storage or Azure Monitor logs, or to an Azure event hub. Auditing can help you maintain regulatory compliance, understand database activity, and gain insight into discrepancies and anomalies that could indicate potential security violations. In this activity, you'll set up auditing at the server level, though it's also available at the database level.  

### Set up: Use scripts to deploy Azure SQL Database

At the right is Azure Cloud Shell, which is a way to interact with Azure by using a browser. Before you start the exercise, you'll run a script in Cloud Shell to create your environment, AdventureWorks, in Azure SQL Database. In the script, you'll be prompted for a password for the new database and your local IP address to enable your device to connect to the database.  

These scripts should take three to five minutes to complete. Be sure to note your password, unique ID, and region, because they won't be shown again.

1. Start by obtaining your local IP address. Ensure that you're disconnected from any VPN service, and **open a local PowerShell terminal on your device**. Run the following command, and note the resulting IP address.

    ```powershell
    (Invoke-WebRequest -Uri "https://ipinfo.io/ip").Content
    
    
    ```

1. Run the following commands in Cloud Shell. Enter a complex password and, at the prompt, enter your local public IP address, which you obtained in the preceding step.

    ```powershell
    $adminSqlLogin = "cloudadmin"
    $password = Read-Host "Your username is 'cloudadmin'. Enter a password for your Azure SQL Database server that meets the password requirements"
    # Prompt for local ip address
    $ipAddress = Read-Host "Disconnect your VPN, open PowerShell on your machine and run '(Invoke-WebRequest -Uri "https://ipinfo.io/ip").Content'. Enter the value (include periods) next to 'Address': "
    # Get resource group and location and random string
    $resourceGroup = Get-AzResourceGroup | Where ResourceGroupName -like "<rgn>Sandbox resource group name</rgn>"
    $resourceGroupName = "<rgn>Sandbox resource group name</rgn>"
    $uniqueID = Get-Random -Minimum 100000 -Maximum 1000000
    $storageAccountName = "mslearnsa"+$uniqueID
    $location = $resourceGroup.Location
    # The logical server name has to be unique in the system
    $serverName = "aw-server$($uniqueID)"
    
    
    ```

1. Output and store in a text file the information you'll need throughout the module by running the following code in Cloud Shell. You'll likely need to press Enter after you paste the code, because the last line won't be run by default.

    ```powershell
    Write-Host "Your unique ID for future exercises in this module:" $uniqueID
    Write-Host "Your resource group name is:" $resourceGroupName
    Write-Host "Your resources were deployed in the following region:" $location
    Write-Host "Your server name is:" $serverName
    
    
    ```

    Remember to note your password, unique ID, and region. You'll use them throughout the module.

1. Run the following script to deploy an Azure SQL Database instance and logical server with the AdventureWorks sample. The script will also add your IP address as a firewall rule, enable Advanced Data Security, and create a storage account for use in future units. Allow several minutes for this script to complete. 

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
    # Enable Advanced Defender
    $azureDefender = Enable-AzSqlServerAdvancedDataSecurity `
        -ResourceGroupName $resourceGroupName `
        -ServerName $serverName
    # Create a storage account
    $storageAccount = New-AzStorageAccount -ResourceGroupName $resourceGroupName `
        -AccountName $storageAccountName `
        -Location $location `
        -Type "Standard_LRS"
    ```

1. Open SQL Server Management Studio (SSMS), and then create a new connection to your logical server. For server name, enter the name of your Azure SQL Database logical server (for example, *aw-server`<unique ID>`.database.windows.net*). If you didn't save the name earlier, you might need to go to the Azure portal to get it.  

    > [!div class="nextstepaction"]
    > [The Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

    In the Azure portal, search for **AdventureWorks** to find your database and its associated logical server.

    Change the authentication to **SQL Server Authentication**, and enter the corresponding server admin login and password, which you provided during deployment in the previous exercise.  

    Select the **Remember password** check box, and then select **Connect**.  

    :::image type="content" source="../media/3-connect-azure-sql.png" alt-text="Screenshot of how to connect to SQL Database in SSMS.":::  

    > [!NOTE]
    > Depending on your local configuration (for example, VPN), your client IP address might differ from the IP address that the Azure portal used during deployment. If it does differ, you'll get a pop-up message that reads, "Your client IP address does not have access to the server. Sign in to an Azure account and create a new firewall rule to enable access." If you get this message, sign in with the account you're using for the sandbox, and add a firewall rule for your client IP address. You can complete all of these steps by using the pop-up wizard in SSMS.  

### Configure auditing

1. In the [The Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true) search bar, enter **Log analytics**, and then select **Log Analytics workspaces** from the results. The **Log Analytics workspaces** pane appears.

1. Select **Create**. The **Create Log Analytics workspace** appears.
  
1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    |---|---|
    | **Project Details** |
    | Subscription | Concierge Subscription |
    | Resource group | From the dropdown list, select <rgn>[Sandbox resource group]</rgn> |
    | **Instance Details** |
    | Name | Enter *azuresql-la* |
    | Region | Select a location closest to you from the following list |

    [!INCLUDE [](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)] 

1. Select **Review + create**, wait until your inputs have been validated, and then select **Create**. Wait until the resource is deployed.
  
1. Select **Go to resource**. The **Overview** pane for your Log Analytics workspace appears.

1. In the Azure portal, go to your **AdventureWorks** SQL Database.

1. On the menu, under **Security**, select **Auditing**. Review the options.

    You can apply auditing at the server level, which applies to all databases within the Azure SQL Database logical server. If you also apply auditing at the database level (which you will do in this unit), both audits occur in parallel; one does not override the other.

1. Select the slide toggle to **Enable Azure SQL Auditing**.

1. Select the  **Storage** check box, and then complete the required fields.
     - For **Subscription**, from the dropdown list, select the Concierge Subscription.
     - For **Storage Account**, from the dropdown list, select the account that starts with **sqlva** followed by a random string of letters and numbers.

   The **sqlva** storage account will be used to collect XEvent log files, which are saved as a collection of blob files within a container named **sqldbauditlogs**. In a later activity, you'll review the container to learn how log files differ from Log Analytics.

    > [!TIP]
    > If you do not see any storage accounts, create a new account. You may need to refresh your page after a couple minutes before it shows up.  

    If you are going to be auditing your production environment, consider having a separate storage account for audit logs.

1. Select **Advanced properties** to expand the section and set the following configuration items:
    - For **Retention (Days)**, enter **7**
    - For **Storage access key**, select **Primary**.

    > [!NOTE]
    > If you do not see an **Advanced properties**, select **Save** from the command bar, and then repeat the configuration instructions for this page.  

    1. Select the **Log Analytics** check box, and then complete the required fields. 
     - For **Subscription**, select the Concierge Subscription from the dropdown list.
     - For **Log Analytics**, select the Log Analytics workspace you created earlier in this exercise (asuresql-laNNN).

1. From the command bar, select **Save**.  

    It may take a few minutes for the configuration to process. 

1. Select **OK** to save your configuration.

    After the configuration is saved, in the breadcrumbs, select AdventureWorks to close the Audit pane.  

You've now enabled auditing for a storage account and an Azure Log Analytics workspace. Later, you'll dive deeper into the auditing capabilities in Azure SQL. You'll see how to analyze the audit logs to view all the changes you've made throughout the module, as well as some other interesting use cases.  
