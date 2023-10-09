> [!IMPORTANT]
> The language you select will be the language you need to use for the rest of module, so choose wisely!

Setting up your environment and deploying some resources to start with is an important step in building full stack applications.

Recall in the catching the bus sample, you'll use resources, including Azure SQL Database, Azure Functions, and Azure Logic Apps. Here, you'll deploy Azure SQL Database with the required configurations.

> [!NOTE]
> If you completed the previous module of this learning path, you built the foundation of the architecture with Azure SQL Database, and you're redeploying that here. If you did not complete the previous module, everything you need will be completed during this exercise.

You'll then deploy an empty Azure Function app and configure its yaml file and GitHub secrets for continuous integration and continuous delivery (CI/CD). Setting up CI/CD with GitHub will automate the build process as you make changes in future exercises. Later in the module, you'll complete, publish, and monitor the Azure Function in action.

## Configure your environment for development using Visual Studio Code

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

1. Sign in to GitHub in Visual Studio Code using your GitHub account.

    > [!NOTE]
    > If you do not have a GitHub account, [create one here](https://github.com/join).

1. In a browser, sign in to GitHub with your GitHub account and navigate to the [Azure-Samples repository](https://github.com/Azure-Samples/serverless-full-stack-apps-azure-sql).

1. In the top-right corner of your browser, select **Fork** to create your own copy of the repository. The label for the fork in the top left should now read **\<yourID\>/serverless-fullstack-apps-azure-sql**.

1. Below the toolbar, select the green **Code** button and copy the HTTPS Clone URL; for example, *`https://github.com/<github-username>/serverless-full-stack-apps-azure-sql.git`*.

1. In Visual Studio Code, select **View** > **Source Control** > **Clone Repository** (or select **View, Command Palette** and enter **Git:Clone**), paste the Git repository URL you copied in the previous step, and then select <kbd>Enter</kbd>.

1. In the file explorer dialog, select or create a local folder where you would like the repository to be copied to, and then select **Select Repository Location**.  Your forked repo of the Azure Samples is copied to your local folder. Visual Studio Code displays a notification that the repository was cloned.

1. In the resulting popup notification, select **Open**. Visual Studio displays the folder in the Explorer pane of your Visual Studio Code session.

1. Confirm that you see the same repository structure and files that you see in your GitHub fork.

## Deploy and configure Azure SQL Database using PowerShell

In order to set up the database for the bus-catching scenario, you'll first need to deploy a database to work with. To deploy a database, you'll use the Azure Cloud Shell that's open on the right side of this page. The Azure Cloud Shell is also available through the Azure portal, and allows you to create and manage Azure resources. Azure Cloud Shell comes preinstalled with various tools, including the Azure CLI, Azure PowerShell, and sqlcmd. In this exercise, you'll use Azure PowerShell, but you can accomplish the same tasks with the Azure CLI. In one of the scripts, you'll be prompted for a password for the new database and your local IP address to enable your device to connect to the database.  

These scripts should take three to five minutes to complete. Be sure to note your password, unique ID, and region, because they won't be shown again.

1. Start by obtaining your local public IP address. Ensure that you're disconnected from any VPN service, and open a local PowerShell terminal on your device. Run the following command, and note the resulting IP address.

    ```powershell
    (Invoke-WebRequest -Uri "https://ipinfo.io/ip").Content
    ```

    > [!TIP]
    > If you're not on a Windows device, you need to locate your IP address with another method. In your terminal, you can run `curl ifconfig.co`.

1. Run the following code in Cloud Shell.

    ```powershell
    # Collect password 
    $adminSqlLogin = "cloudadmin"
    $password = Read-Host "Your username is 'cloudadmin'. Please enter a password for your Azure SQL Database server that meets the password requirements"
    # Prompt for local ip address
    $ipAddress = Read-Host "Please enter your IP address (include periods)"
    ```

1. When prompted, enter a **complex password** and press <kbd>Enter</kbd>. You'll be prompted to enter an IP address. Enter the IP address that you obtained in the preceding step and press <kbd>Enter</kbd>.

    > [!Note]
    > A **complex password** must consist of:
    >
    > - 8 characters minimum and 16 characters maximum
    > - Requires 3 out of 4 of the following:
    >    - Lowercase characters
    >    - Uppercase characters
    >    - Numbers ( 0-9 )
    >    - Symbols ( @ # $ % ^ & * - _  + = [ ] { } | \ : ‘ , . ? / ` ~ “ ( ) ; )

1. Output and store the information you'll need throughout the module by running the following code in Cloud Shell. You'll likely need to press Enter after you paste the code, because the last line won't be run by default.

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

    If you have any issues or want to confirm the resources were deployed, you can review them in the Azure portal.

    > [!div class="nextstepaction"]
    > [The Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

1. In a text file, notepad, or on paper, determine the connection string for your Azure SQL Database. It will be something like `Server=<server-name>.database.windows.net,1433;Initial Catalog=bus-db;User Id=cloudadmin;Password=<your-password>;Connection Timeout=30;`

1. In a browser, navigate to your forked repository in GitHub for this module. Make sure that you're signed in to GitHub. It will be something like `https://github.com/<your-git-username>/serverless-full-stack-apps-azure-sql`.

1. In the repository toolbar, select **Settings**.

1. In the Settings page navigation pane, select **Secrets**, then select **Actions**. On the Action Secrets pane, select **New repository secret**, and then enter the following items:
    1. *Name*: **AZURE_SQL_CONNECTION_STRING**
    1. *Value*: **Connection string from prior step**

1. Select **Add secret** to add an entry to the **Repository secrets** section.

1. Next, you need to configure the yaml template for your repo. In Visual Studio Code, select **Explorer** from the left-hand taskbar. The files and folders for your **serverless-full-stack...** repository should display. If you don't see them, select **File** > **Open folder** and navigate to the location where you cloned the repository.

1. Under the folder `.github\workflows`, rename **`azuresqldatabase.yml.template`** to **`azuresqldatabase.yml`**.

1. Select the **Source Control** icon on the left-hand taskbar.

1. In the *Message* box, enter "Enable database yaml" or some other message and select the **checkmark**.

    > [!TIP]
    > If the Source Control list of items is empty, you can choose to create an empty commit to push and kick off GitHub actions.

1. Select the ellipsis in the toolbar and then select **Push**, which will kick off a build. Confirm it builds successfully by opening your GitHub repository, and selecting **Actions** on the toolbar. What you've done is enable the GitHub SQL Action, which takes care of deploying the appropriate schema that is required by the database.

1. By this point, the script in the Azure Cloud Shell to the right should be complete. Run the following code to start a bash session. The final step is to load in the route reference data.

    ```powershell
    bash
    ```

1. Copy the following code to a text file, update \<server-name\> with your server name and \<password\> with password. Then enter this in the Cloud Shell. This will start a sqlcmd session.

    ```bash
    TERM=dumb
    sqlcmd -S <server-name>.database.windows.net -P <password> -U cloudadmin -d bus-db
    ```

1. In sqlcmd to the right, copy and paste the following script to import the flat file of routes data. For more details on what is done here, you can optionally review the previous module in the associated learning path.

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
        ('Crossroads', 'POLYGON ((-122.14797019958493 47.6330073774962,-122.1187877655029 47.63289169873832,-122.11861610412595 47.61518983198667,-122.14891433715819 47.61542126760543,-122.14797019958493 47.6330073774962))');
    INSERT INTO dbo.[MonitoredRoutes] (RouteId) VALUES (100113);
    INSERT INTO dbo.[MonitoredRoutes] (RouteId) VALUES (100136);
    GO
    ```

    1. Finally, select <kbd>Ctrl+C</kbd> to exit sqlcmd and run **`pwsh`** to switch back to PowerShell.

## Deploy and configure the Azure Function app

Now that your database and GitHub repository are configured, it's time to deploy an Azure Function app. This Azure Function will be used to retrieve the real-time bus data, call Azure SQL Database, and call Azure Logic Apps.

1. First, configure your variables.

    ```powershell
    $resourceGroupName = "<rgn>[sandbox resource group name]</rgn>"
    $resourceGroup = Get-AzResourceGroup | Where ResourceGroupName -like $resourceGroupName
    $uniqueID = Get-Random -Minimum 100000 -Maximum 1000000
    $location = $resourceGroup.Location
    # Azure function name
    $azureFunctionName = $("azfunc$($uniqueID)")
    # Get storage account name
    $storageAccountName = (Get-AzStorageAccount -ResourceGroup $resourceGroupName).StorageAccountName
    $storageAccountName
    ```

    > [!WARNING]
    > If the `$storageAccountName` variable is empty, you need to create a new storage account with the below commands.
    >
    > ```powershell
    > $storageAccountName = $("storageaccount$($uniqueID)")
    > $storageAccount = New-AzStorageAccount -ResourceGroupName $resourceGroupName -AccountName $storageAccountName -Location $location -SkuName Standard_GRS
    > ```

1. Run the following in the Cloud Shell to deploy an empty function in your language of choice.

    ::: zone pivot="csharp"

    ```powershell
    $functionApp = New-AzFunctionApp -Name $azureFunctionName `
        -ResourceGroupName $resourceGroupName -StorageAccount $storageAccountName `
        -FunctionsVersion 4 -RuntimeVersion 6 -Runtime dotnet -Location $location
    ```

    ::: zone-end

    ::: zone pivot="python"

    ```powershell
    $functionApp = New-AzFunctionApp -Name $azureFunctionName `
        -ResourceGroupName $resourceGroupName -StorageAccount $storageAccountName `
        -FunctionsVersion 4 -RuntimeVersion 3.9 -Runtime python -Location $location
    ```

    ::: zone-end

    ::: zone pivot="node"

    ```powershell
    $functionApp = New-AzFunctionApp -Name $azureFunctionName `
        -ResourceGroupName $resourceGroupName -StorageAccount $storageAccountName `
        -FunctionsVersion 4 -RunTimeVersion 16 -Runtime node -Location $location
    ```

    ::: zone-end

    If you have any issues or want to confirm the resources were deployed, you can review in the Azure portal.

    > [!div class="nextstepaction"]
    > [The Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)
