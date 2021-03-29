<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: remind the learner of the core idea(s) from the preceding learning-content unit (without mentioning the details of the exercise or the scenario)

    Heading: do not add an H1 or H2 title here, an auto-generated H1 will appear above this content

    Example: "A storage account represents a collection of settings that implement a business policy."

    [Exercise introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=master#rule-use-the-standard-exercise-unit-introduction-format)
-->
> [!IMPORTANT]
> The language selected will be the language you need to use for the rest of module, so choose wisely!

Setting up your environment and deploying some resources to start with is an important step in building full stack applications. 

<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario covered in this exercise

    Heading: a separate heading is optional; you can combine this with the topic sentence into a single paragraph

    Example: "Recall that in the chocolate-manufacturer example, there would be a separate storage account for the private business data. There were two key requirements for this account: geographically-redundant storage because the data is business-critical and at least one location close to the main factory."

    Recommended: image that summarizes the entire scenario with a highlight of the area implemented in this exercise
-->
Recall in the catching the bus sample, you'll leverage resources including Azure SQL Database, Azure Functions and Azure Logic Apps. In the previous module of this learning path, you built the foundation of the architecture with Azure SQL Database. Here, you'll redeploy Azure SQL Database with the required configurations.

You'll then deploy an empty Azure Function app and configure it's yaml file and GitHub secrets for CI/CD. The Azure Function will be completed and monitored in exercises later in this module.

<!-- 4. Chunked steps -------------------------------------------------------------------------------------

    Goal: List the steps they'll do to complete the exercise.

    Structure: Break the steps into 'chunks' where each chunk has three things:
        1. A heading describing the goal of the chunk
        2. An introductory paragraph describing the goal of the chunk at a high level
        3. Numbered steps (target 7 steps or fewer in each chunk)

    Example:
        Heading:
            "Use a template for your Azure logic app"
        Introduction:
             "When you create an Azure logic app in the Azure portal, you have the option of selecting a starter template. Let's select a blank template so that we can build our logic app from scratch."
        Steps:
             "1. In the left navigation bar, select Resource groups.
              2. Select the existing Resource group [sandbox resource group name].
              3. Select the ShoeTracker logic app.
              4. Scroll down to the Templates section and select Blank Logic App."
-->

## Configure your environment

The first required step is to set up your development environment. Please refer to the brief instructions [here](https://review.docs.microsoft.com/learn/modules/create-foundation-modern-apps/3-exercise-configure-environment) to set up Visual Studio Code and Azure Data Studio. You'll also fork and clone the repository (if you haven't already).

## Deploy and configure Azure SQL Database
In order to set up the database for the bus catching scenario, you'll first need to deploy a database to work with. To do this, you'll use the Azure Cloud Shell which is on the right side of this page. The Azure Cloud Shell is also available through the Azure portal, and allows you to create and manage Azure resources. It comes preinstalled with various tools, including the Azure CLI, Azure PowerShell, and sqlcmd. In this exercise, you'll leverage Azure PowerShell, but you can accomplish the same tasks with the Azure CLI. In the script, you'll be prompted for a password for the new database and your local IP address to enable your device to connect to the database.  

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

    If you have any issues or want to confirm the resources were deployed, you can review in the Azure portal.

    > [!div class="nextstepaction"]
    > [The Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

1. In a text file, notepad, or on paper, determine the connection string for your Azure SQL Database. It will be something like `Server=<server-name>.database.windows.net,1433;Initial Catalog=bus-db;User Id=cloudadmin;Password=<your-password>;Connection Timeout=30;`

1. Navigate to your repository for this module on GitHub (make sure you are signed in). It will be something like `https://github.com/<your-git-username>/serverless-full-stack-apps-azure-sql`.

1. Select **Settings** for the repository.

1. Select **Secrets** > **New repository secret** and enter the following:
    1. *Name*: **AZURE_SQL_CONNECTION_STRING**
    1. *Value*: **Connection string from prior step**

1. Next, you must configure the yaml file. In Visual Studio Code, select **Explorer** icon on the left-hand taskbar to view the repository files. If you do not see them, select **File** > **Open folder** and navigate to the location where you cloned the repository.

1. Under the folder `.github\workflows`, rename **`azuresqldatabase.yml.template`** to **`azuresqldatabase.yml`**.

1. Select the **Source Control** icon on the left-hand taskbar.

1. In the *Message* box, enter "Enable database yaml" or some other message and select the **checkmark**.

> [!TIP]
> If you've already done this step in the previous module, you can choose to create an empty commit to push and kick off GitHub actions.

1. Select the **...** > **Push** which will kick off a build. Confirm it builds successfully by navigating to the repository in GitHub and selecting **Actions**.

1. By this point, the script in the Azure Cloud Shell to the right should be complete. Run the following to start a bash session. The final step is to load in the route reference data, similar to how you did in the previous module.

    ```powershell
    bash
    ```

1. Start a sqlcmd session with the below commands. Note you'll need to add your server name and password.

    ```bash
    TERM=dumb
    sqlcmd -S [server-name].database.windows.net -P [password] -U cloudadmin -d bus-db
    ```

1. In sqlcmd to the right, copy and paste the following script to import the flat file of routes data. For more details on what is done here, review the previous module.

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
    INSERT INTO dbo.[GeoFences] 
        ([Name], [GeoFence]) 
    VALUES
        ('Crossroads', 0xE6100000010407000000B4A78EA822CF4740E8D7539530895EC03837D51CEACE4740E80BFBE630895EC0ECD7DF53EACE4740E81B2C50F0885EC020389F0D03CF4740E99BD2A1F0885EC00CB8BEB203CF4740E9DB04FC23895EC068C132B920CF4740E9DB04FC23895EC0B4A78EA822CF4740E8D7539530895EC001000000020000000001000000FFFFFFFF0000000003);
    INSERT INTO dbo.[MonitoredRoutes] (RouteId) VALUES (100113);
    GO
    ```

1. Finally, select **CTRL+C** to exit sqlcmd and run **`pwsh`** to switch back to PowerShell.

## Deploy and configure the Azure Function app

Now that your database and GitHub repository are configured, it's time to deploy an Azure Function app.

1. Next, configure your variables.

    ```powershell
    $resourceGroupName = "<rgn>[sandbox resource group name]</rgn>"
    $resourceGroup = Get-AzResourceGroup | Where ResourceGroupName -like $resourceGroupName
    $uniqueID = Get-Random -Minimum 100000 -Maximum 1000000
    $location = $resourceGroup.Location
    # Azure function name
    $azureFunctionName = $("azfunc$($uniqueID)")
    # Get storage account name
    $storageAccountName = (Get-AzStorageAccount -ResourceGroup $resourceGroupName).StorageAccountName
    ```

1. Run the following in the cloud shell to deploy the function in your language of choice.

    ::: zone pivot="csharp"

    ```powershell
    $functionApp = New-AzFunctionApp -Name $azureFunctionName `
        -ResourceGroupName $resourceGroupName -StorageAccount $storageAccountName `
        -FunctionsVersion 3 -RuntimeVersion 3 -Runtime dotnet -Location $location
    ```

    ::: zone-end

    ::: zone pivot="python"

    ```powershell
    $functionApp = New-AzFunctionApp -Name $azureFunctionName `
        -ResourceGroupName $resourceGroupName -StorageAccount $storageAccountName `
        -FunctionsVersion 3 -RuntimeVersion 3.8 -Runtime python -Location $location
    ```

    ::: zone-end

    ::: zone pivot="node"

    ```powershell
    $functionApp = New-AzFunctionApp -Name $azureFunctionName `
        -ResourceGroupName $resourceGroupName -StorageAccount $storageAccountName `
        -FunctionsVersion 3 -RunTimeVersion 12 -Runtime node -Location $location
    ```

    ::: zone-end

    If you have any issues or want to confirm the resources were deployed, you can review in the Azure portal.

    > [!div class="nextstepaction"]
    > [The Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

<!-- 5. Validation chunk -------------------------------------------------------------------------------------

    Goal: Helps the learner to evaluate if they completed the exercise correctly.

    Structure: Break the steps into 'chunks' where each chunk has three things:
        1. A heading of "Check your work"
        2. An introductory paragraph describing how they'll validate their work at a high level
        3. Numbered steps (when the learner needs to perform multiple steps to verify if they were successful)
        4. Video of an expert performing the exact steps of the exercise (optional)

    Example:
        Heading:
            "Examine the results of your Twitter trigger"
        Introduction:
             "At this point, our logic app is scanning Twitter every minute for tweets containing the search text. To verify the app is running and working correctly, we'll look at the Runs history table."
        Steps:
             "1. Select Overview in the navigation menu.
              2. Select Refresh once a minute until you see a row in the Runs history table.
              ...
              6. Examine the data in the OUTPUTS section. For example, locate the text of the matching tweet."
-->
<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
<!-- Do not add a unit summary or references/links -->