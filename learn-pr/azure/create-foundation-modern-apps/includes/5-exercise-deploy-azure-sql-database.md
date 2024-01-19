Azure SQL Database is a great choice for operational, transactional, and hybrid analytical workloads.

In the bus-catching scenario, we selected Azure SQL Database due to it being an enterprise database with modern capabilities, like JSON and geospatial support.

Here, you'll deploy Azure SQL Database using scripts, connect to it in Azure Data Studio, and set up the database for the scenario using T-SQL. You'll then explore the JSON and geospatial support as relates to catching the bus.

## Deploy Azure SQL Database using PowerShell

In order to set up the database for the bus-catching scenario, you first need to deploy a database to work with. To do this, you'll use Azure Cloud Shell on the right side of this page. Cloud Shell is also available through the Azure portal, and it allows you to create and manage Azure resources. It comes preinstalled with various tools, including the Azure CLI, Azure PowerShell, and sqlcmd. In this exercise, you'll use Azure PowerShell, but you can accomplish the same tasks with the Azure CLI. In the script, you'll be prompted for a password for the new database and your local IP address to enable your device to connect to the database.  

These scripts should take three to five minutes to complete. Be sure to note your password, unique ID, and region, because they won't be shown again.

1. Start by obtaining your local public IP address. Ensure that you're disconnected from any VPN service, and open a local PowerShell terminal on your device. Run the following command, and note the resulting IP address.

    ```powershell
    (Invoke-WebRequest -Uri "https://ipinfo.io/ip").Content
    ```

    > [!TIP]
    > If you're not on a Windows device, you need to locate your IP address with another method. In your terminal, you can run `curl ifconfig.co`.

1. Run the following commands in Cloud Shell. Enter a **complex password** and, at the prompt, enter your local public IP address, which you obtained in the preceding step.

    > [!Note]
    > A **complex password** must consist of:
    >
    > * 8 characters minimum and 16 characters maximum
    > * Requires 3 out of 4 of the following:
    >    * Lowercase characters
    >    * Uppercase characters
    >    * Numbers ( 0-9 )
    >    * Symbols ( @ # $ % ^ & * - _  + = [ ] { } | \ : ‘ , . ? / ` ~ “ ( ) ; )

    ```powershell
    # Collect password 
    $adminSqlLogin = "cloudadmin"
    $password = Read-Host "Your username is 'cloudadmin'. Please enter a password for your Azure SQL Database server that meets the password requirements"
    # Prompt for local ip address
    $ipAddress = Read-Host "Disconnect your VPN, open PowerShell on your machine and run '(Invoke-WebRequest -Uri "https://ipinfo.io/ip").Content'. Please enter the value (include periods) next to 'Address': "
    Write-Host "Password and IP Address stored"
    ```

1. Output and store in a text file the information you'll need throughout the module by running the following code in Cloud Shell. You'll likely need to press Enter after you paste the code, because the last line won't be run by default.

    ```powershell
    # Get resource group and location and random string
    $resourceGroupName = "<rgn>[sandbox resource group name]</rgn>"
    $resourceGroup = Get-AzResourceGroup | Where ResourceGroupName -like $resourceGroupName
    $uniqueID = Get-Random -Minimum 100000 -Maximum 1000000
    $location = $resourceGroup.Location
    # The logical server name has to be unique in the system
    $serverName = "bus-server$($uniqueID)"
    # The sample database name
    $databaseName = "bus-db"    
    Write-Host "Please note your unique ID for future exercises in this module:"  
    Write-Host $uniqueID
    Write-Host "Your resource group name is:"
    Write-Host $resourceGroupName
    Write-Host "Your resources were deployed in the following region:"
    Write-Host $location
    Write-Host "Your server name is:"
    Write-Host $serverName
    ```

    Remember to note your password, unique ID, and region. You'll use them throughout the module.

1. Run the following script to deploy an empty Azure SQL Database instance and logical server. The script will also add your IP address as a firewall rule so you can access the database.

    ```powershell
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
        -Edition "GeneralPurpose" -Vcore 4 -ComputeGeneration "Gen5" `
        -ComputeModel Serverless -MinimumCapacity 0.5
    Write-Host "Database deployed."
    ```

    The script will take several minutes to complete. There are four main commands in the preceding block; let's break them down. The first command creates an Azure SQL Database logical server, which serves as the instance to connect to and as a way for grouping metadata and policy settings for all databases assigned to that server. The next two commands create two firewall rules: one to allow your IP address to connect and one to allow other Azure services to connect. This setting will be especially useful when you set up CI/CD pipelines using Azure DevOps and/or GitHub Actions.

    The final command deploys a database into that logical server. From the commands, you can tell the database is a General Purpose, Serverless database with a range of virtual cores between 0.5 and 4. Serverless is meant for intermittent, unpredictable usage with lower average compute utilization over time. Serverless provides automatic compute scaling to simplify performance management and is billed only for the amount of compute used. Serverless also supports automatic pausing and resuming to help further price optimize. When your database is paused, you pay only for storage. Serverless is a great solution for the bus catching scenario as it's in development phase (not used
 24/7) and it's unknown how popular it will be when you launch (how much compute it will need).

    If you have any issues or want to confirm the resources were deployed, you can review in the Azure portal.

    > [!div class="nextstepaction"]
    > [The Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

## Connect to Azure SQL Database with Azure Data Studio

Once your database is deployed, there are many ways that you can connect and interact with it: sqlcmd, Azure Data Studio, SSMS, the query editor in the portal, etc. Here, you'll learn how to connect to the database using Azure Data Studio.

1. Open Azure Data Studio and confirm that the code repository folder is open by selecting the **Explorer** icon on the left-hand taskbar. If you don't see the code files, return to the previous exercise to configure your environment.

1. Select **Connections** from the left-hand taskbar. All your database connections can be created and stored here.

1. Next to *Servers*, select the **New Connection** button (it looks like a server with a plus sign).

1. In the *Connection Details* pane that opens, fill in the following information:  
    *Connection type*: **Microsoft SQL Server**  
    *Server*: **bus-server[uniqueID].database.windows.net**  
    *Authentication type*: **SQL Login**  
    *User name*: **cloudadmin**  
    *Password*: **your-password**  
    *Remember password*: **Check box**  
    *Database*: **bus-db**  
    *Server group*: **Default**  
    *Name (optional)*: **leave-blank**  

1. Select **Connect**.

1. Once a successful connection is made, you should be able to navigate the database's contents in the Connections pane.

## Set up the database's schema with T-SQL

Once you're connected to any database, you'll usually need to deploy the database schema and tailor the database to meet your scenario's requirements by creating tables. Using a series of T-SQL scripts in a SQL notebook in Azure Data Studio, you'll configure the database to support your application and load some initial bus-related data.

1. In Azure Data Studio, select the **Explorer** icon in the left-hand taskbar.

1. Under the folder `database\notebooks`, open **`01-set-up-database.ipynb`**.

1. Follow the steps in the SQL notebook to complete the exercise, then return here.

## Process bus data with Azure SQL Database

Now that your database is configured, it's time to dive deeper into how Azure SQL Database will receive the real-time JSON data and store it in the database. Fortunately, Azure SQL Database has JSON support so that's easily managed. Then, you can use the geospatial capabilities in Azure SQL Database to find the distances between buses, define and store geofences, and even determine if a bus is within a given geofence. With a foundation like this one, your application development becomes greatly simplified. This exercise will be completed in a SQL notebook in Azure Data Studio, similar to the previous activity.

1. In Azure Data Studio, select the **Explorer** icon in the left-hand taskbar.

1. Under the folder `database\notebooks`, open **`02-json-geospatial-sql-db.ipynb`**.

1. Follow the steps in the SQL notebook to complete the exercise, then return here.
