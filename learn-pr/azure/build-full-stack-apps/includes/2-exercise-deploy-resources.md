Setting up your environment and deploying some resources to start with is an important step in building full stack applications. For the catching the bus sample, you'll use resources including Azure SQL Database, Azure Static Web Apps, and GitHub Actions. If you're following the learning path (not required), you focused on how to build the database foundation, serverless APIs, and notifications in previous modules. In this exercise, you'll deploy some foundational services that you'll use in future exercises. This exercise includes setting up your development environment, and then deploying and configuring Azure SQL Database. The rest of the module will be focused on building the application with Azure Static Web Apps.

## Configure your environment with Visual Studio Code

In order to complete the exercises, you'll need to configure your environment. If you already have these components installed and configured, you don't need to repeat the steps.

1. Download and install [Visual Studio Code](https://code.visualstudio.com/Download).
1. Download and install the [Azure Functions Core Tools](/azure/azure-functions/functions-run-local?tabs=windows%2Ccsharp%2Cbash#install-the-azure-functions-core-tools).
1. In Visual Studio Code, install the following extensions:
    - [**Azure Account**](https://marketplace.visualstudio.com/items?itemName=ms-vscode.azure-account): This extension allows you to authenticate to Azure.
    - [**Azure Functions**](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions): This extension allows you to manage Azure Functions.
    - [**GitHub Pull Requests and Issues**](https://marketplace.visualstudio.com/items?itemName=GitHub.vscode-pull-request-github): This extension allows you to authenticate to GitHub and manage repositories.
    - [**Azure Resources**](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azureresourcegroups): This extension allows you to manage Azure resources.
    - [**SQL Server (mssql)**](https://marketplace.visualstudio.com/items?itemName=ms-mssql.mssql): This extension includes tools for querying SQL Server and Azure SQL resources.
    - [**Live Server**](https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer): This extension enables you to run web applications locally with ease.

1. Sign in to GitHub in Visual Studio Code using your GitHub account. If you don't have a GitHub account, [create one here](https://github.com/join).
1. Sign in to GitHub with your GitHub account and navigate to [this repository](https://github.com/Azure-Samples/serverless-full-stack-apps-azure-sql). In the top-right corner of your browser, select the **Fork** button.
1. On the same page, select **Code** and copy the HTTPS Clone URL, for example, *`https://github.com/<github-username>/serverless-full-stack-apps-azure-sql.git`*.
1. Back in Visual Studio Code, select **Source Control** > **...** > **Clone** and enter the URL copied in a previous step. Select the location you would like the repository to be copied locally.
1. In Visual Studio Code, select **File** > **Open folder** and navigate to the location where you cloned the repository. This step will open the folder in your Visual Studio Code session.
1. Select the **Explorer** blade from the left-hand taskbar. Confirm that you see the repository files.

## Deploy Azure SQL Database using PowerShell

To set up the database back end for the bus-catching scenario, you'll first need to deploy a database to work with. To deploy, you'll use Azure Cloud Shell, which is on the right side of this page. Cloud Shell is also available through the Azure portal, and it allows you to create and manage Azure resources. It comes preinstalled with various tools, including the Azure CLI, Azure PowerShell, and sqlcmd. In this exercise, you'll use Azure PowerShell, but you can accomplish the same tasks with the Azure CLI. In the script, you'll be prompted for a password for the new database and your local IP address to enable your device to connect to the database.  

These scripts should take three to five minutes to complete. Be sure to note your password, unique ID, and region, because they won't be shown again.

1. Start by obtaining your local public IP address. Ensure that you're disconnected from any VPN service, and open a local PowerShell terminal on your device. Run the following command, and note the resulting IP address.

    ```powershell
    (Invoke-WebRequest -Uri "https://ipinfo.io/ip").Content
    ```

    > [!TIP]
    > If you are not on a Windows device, you need to locate your IP address with another method. In your terminal, you can run `curl ifconfig.co`.

1. Run the following commands in Cloud Shell. Enter a complex password and, at the prompt, enter your local public IP address, which you obtained in the preceding step.

    ```powershell
    # Collect password 
    $adminSqlLogin = "cloudadmin"
    $password = Read-Host "Your username is 'cloudadmin'. Please enter a password for your Azure SQL Database server that meets the password requirements"
    # Prompt for local ip address
    $ipAddress = Read-Host "Disconnect your VPN, open PowerShell on your machine and run '(Invoke-WebRequest -Uri "https://ipinfo.io/ip").Content'. Please enter the value (include periods) next to 'Address': "
    Write-Host "Password and IP Address stored"
    ```

1. Output and store in a text file the information you'll need throughout the module by running the following code in Cloud Shell. You'll likely need to press <kbd>Enter</kbd> after you paste the code, because the last line won't be run by default.

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

1. Run the following script to deploy an empty Azure SQL Database instance and logical server. The script will also add your IP address as a firewall rule.

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

    The script will take several minutes to complete. While it's completing, you can configure your database for CI/CD with GitHub Actions.

    > [!TIP]
    > If you want to learn more about the Serverless database that you are deploying and the various commands, you can review the first module in the associated learning path, which goes into the details of building the foundation of modern applications with Azure SQL Database.

    If you have any issues or want to confirm the resources were deployed, you can review in the Azure portal.

    > [!div class="nextstepaction"]
    > [The Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

## Configure database schema using GitHub Actions

1. In a text file, notepad, or on paper, determine the connection string for your Azure SQL Database. It will be something like `Server=<your-server-name>.database.windows.net,1433;Initial Catalog=bus-db;User Id=cloudadmin;Password=<your-password>;Connection Timeout=30;`

1. Go to your repository for this module on GitHub (make sure you're signed in). It will be something like `https://github.com/<your-git-username>/serverless-full-stack-apps-azure-sql`.

1. Select **Settings** for the repository.

1. Select **Secrets and variables** > **Actions**, and then **New repository secret**. Enter the following items:
    1. *Name*: **AZURE_SQL_CONNECTION_STRING**
    1. *Value*: **Connection string from prior step**

1. Next, you must configure the yaml file. In Visual Studio Code, select **Explorer** icon on the left-hand taskbar to view the repository files. If you don't see them, select **File** > **Open folder** and go to the location where you cloned the repository.

1. Under the folder `.github\workflows`, rename **`azuresqldatabase.yml.template`** to **`azuresqldatabase.yml`**.

1. Select the **Source Control** icon on the left-hand taskbar.

1. In the *Message* box, enter "Enable database yaml" or some other message and select the **checkmark**.

    > [!TIP]
    > If you've already done this step in the previous module, you can choose to create an empty commit to push and kick off GitHub actions.

1. Select the **...** > **Push** to kick off a build. Confirm it builds successfully by going to the repository in GitHub and selecting **Actions**.

## Import route reference data into Azure SQL Database

The final step is to load in the route reference data and identify a bus route to monitor.

1. By this point, the script in Azure Cloud Shell to the right should be complete. Run the following command to start a bash session.

    ```powershell
    bash
    ```

1. Start a sqlcmd session running the following commands. Note you'll need to add your server name and password.

    ```bash
    TERM=dumb
    sqlcmd -S [server-name].database.windows.net -P [password] -U cloudadmin -d bus-db
    ```

1. In sqlcmd to the right, copy and paste the following script to import the flat file of routes data. This script also adds a few sample bus data points.

    ```sql
    ALTER DATABASE SCOPED CREDENTIAL AzureBlobCredentials
    WITH IDENTITY = 'SHARED ACCESS SIGNATURE',
    SECRET = 'sp=r&st=2021-03-12T00:47:24Z&se=2025-03-11T07:47:24Z&spr=https&sv=2020-02-10&sr=c&sig=BmuxFevKhWgbvo%2Bj8TlLYObjbB7gbvWzQaAgvGcg50c%3D';
    DROP EXTERNAL DATA SOURCE RouteData;
    CREATE EXTERNAL DATA SOURCE RouteData
    WITH (
        TYPE = blob_storage,
        LOCATION = 'https://azuresqlworkshopsa.blob.core.windows.net/bus',
        CREDENTIAL = AzureBlobCredentials
    );
    DELETE FROM dbo.[Routes];
    INSERT INTO dbo.[Routes]
    ([Id], [AgencyId], [ShortName], [Description], [Type])
    SELECT 
    [Id], [AgencyId], [ShortName], [Description], [Type]
    FROM
    openrowset
    (
        bulk 'routes.txt', 
        data_source = 'RouteData', 
        formatfile = 'routes.fmt', 
        formatfile_data_source = 'RouteData', 
        firstrow=2,
        format='csv'
    ) t;
    SET QUOTED_IDENTIFIER ON;
    SET ANSI_NULLS ON;
    INSERT INTO dbo.[GeoFences] 
        ([Name], [GeoFence]) 
    VALUES
        ('Crossroads', 0xE6100000010407000000B4A78EA822CF4740E8D7539530895EC03837D51CEACE4740E80BFBE630895EC0ECD7DF53EACE4740E81B2C50F0885EC020389F0D03CF4740E99BD2A1F0885EC00CB8BEB203CF4740E9DB04FC23895EC068C132B920CF4740E9DB04FC23895EC0B4A78EA822CF4740E8D7539530895EC001000000020000000001000000FFFFFFFF0000000003);
    INSERT INTO dbo.[MonitoredRoutes] (RouteId) VALUES (100113);
    GO
    DECLARE @RC int
    DECLARE @payload NVARCHAR(max) = N'[{
            "DirectionId": 1,
            "RouteId": 100113,
            "VehicleId": 1,
            "Position": {
                "Latitude": 47.61703550242447,
                "Longitude": -122.14263367613601 
            },
            "TimestampUTC": "20201031"
        },{
            "DirectionId": 2,
            "RouteId": 100113,
            "VehicleId": 2,
            "Position": {
                "Latitude": 47.61703550242447,
                "Longitude": -122.14263367613601 
            },
            "TimestampUTC": "20201030"
        },{
            "DirectionId": 2,
            "RouteId": 100113,
            "VehicleId": 2,
            "Position": {
                "Latitude": 47.61528240582737,
                "Longitude": -122.14308643341062
            },
            "TimestampUTC": "20201031"
    }]';
    EXECUTE @RC = [web].[AddBusData] 
       @payload
    GO
    ```

    > [!NOTE]
    > If you get errors that some artifacts are not found (for example, RouteData or web.AddBusData), be sure to confirm that the build successfully occurred in the previous section, *Configure database schema using GitHub Actions*.

1. Finally, press <kbd>Ctrl+C</kbd> to exit sqlcmd, and run **`pwsh`** to switch back to PowerShell.
