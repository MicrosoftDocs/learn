<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: remind the learner of the core idea(s) from the preceding learning-content unit (without mentioning the details of the exercise or the scenario)

    Heading: do not add an H1 or H2 title here, an auto-generated H1 will appear above this content

    Example: "A storage account represents a collection of settings that implement a business policy."

    [Exercise introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=master#rule-use-the-standard-exercise-unit-introduction-format)
-->
Setting up your environment and deploying some resources to start with is an important step in building full stack applications.

<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario covered in this exercise

    Heading: a separate heading is optional; you can combine this with the topic sentence into a single paragraph

    Example: "Recall that in the chocolate-manufacturer example, there would be a separate storage account for the private business data. There were two key requirements for this account: geographically-redundant storage because the data is business-critical and at least one location close to the main factory."

    Recommended: image that summarizes the entire scenario with a highlight of the area implemented in this exercise
-->
Recall in the catching the bus sample, you'll leverage resources including Azure SQL Database, Azure Static Web Apps, Azure Functions, and Azure Logic Apps. In the previous modules of this learning path, you focused on the various elements that make up the solution. In this module, you'll deploy the entire solution.

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

## Deploy Azure SQL Database
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

## Deploy Azure Logic App

The first step is to deploy the Azure Logic App using a combination of Azure PowerShell and ARM templates. You'll need to first gather some information from GitHub in order to access the ARM template from the Azure Cloud Shell. 

1. In your GitHub account settings, near the bottom left, select **Developer settings** > **Personal access tokens** > **Generate new token** > **check all boxes** and generate the token. Make a note of the token as you'll need it shortly.

1. Make note of your GitHub repository (e.g. https://github.com/[username]/serverless-full-stack-apps-azure-sql).

1. The following script clones the repository and deploys an Azure Logic App according to an ARM template.

    ```powershell
    # Resource group name and resource group
    $resourceGroupName = "<rgn>[sandbox resource group name]</rgn>"
    $resourceGroup = Get-AzResourceGroup | Where ResourceGroupName -like $resourceGroupName
    $location = $resourceGroup.Location
    # Get the repository name
    $appRepository = Read-Host "Enter your GitHub repository URL (e.g. https://github.com/[username]/serverless-full-stack-apps-azure-sql):"
    # Clone the repo - note this asks for the token
    $cloneRepository = git clone $appRepository
    # Get subscription ID 
    $subId = [Regex]::Matches($resourceGroup.ResourceId, "(\/subscriptions\/)+(.*\/)+(.*\/)").Groups[2].Value
    $subId = $subId.Substring(0,$subId.Length-1)
    # Deploy logic app
    az deployment group create --name DeployResources --resource-group $resourceGroupName `
        ` --template-file ./serverless-full-stack-apps-azure-sql/deployment-scripts/template.json `
        --parameters subscription_id=$subId location=$location  
    ```

## Review and update the Logic App

The next step is to configure the Logic App and update the Application Setting for your Azure Function App.

1. Once your Logic App is deployed, navigate to your Resource Group in the Azure portal and select the **Logic App** you deployed.

    > [!div class="nextstepaction"]
    > [The Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

1. Under *Development Tools*, select **Logic app designer**. Review the flow.

1. You'll notice there's an error for the Outlook.com connection. Select **Add new**.

1. Sign in to an Outlook account that you have access to.

1. Once successfully connected, you will see the email and it's contents. In the *To* field, enter the email address where you'd like to receive notifications.

1. Select **Save**.

1. Select **When a HTTP request is received** and copy the **HTTP POST URL**.

1. In the Azure portal, navigate back to your Azure Function App.

1. Under *Settings*, select **Configuration**.

1. Select the **Edit** pencil icon for **LogicAppUrl** and update the value with the Logic App POST URL you just copied.

1. Select **OK**.

1. Select **Save**.

## Monitor and observe results

Now that everything is updated, it's time to monitor the results (and your inbox).

1. Navigate to your Azure Function App in the Azure portal and select **Functions** > **GetBusData** > **Monitor**.

1. Note that the **Invocations** has ~5 minute delay, whereas the **Logs** are closer to real-time. Review the **Logs**.

1. When a bus activates a GeoFence, what do you see? Did you receive an email? The answers to these questions should help you understand if your application is working properly.

> [!TIP]
> Depending on what time you are testing this out, you may have to wait a significant time for a bus to enter a GeoFence. If you want to trigger it, connect to your Azure SQL Database in Azure Data Studio and run the following T-SQL:
>
>```sql
>    DECLARE @RC int
>    DECLARE @payload NVARCHAR(max) = N'[{
>            "DirectionId": 1,
>            "RouteId": 100113,
>            "VehicleId": 1,
>            "Position": {
>                "Latitude": 47.61703550242447,
>                "Longitude": -122.14263367613601 
>            },
>            "TimestampUTC": "20201031"
>        },{
>            "DirectionId": 2,
>            "RouteId": 100113,
>            "VehicleId": 2,
>            "Position": {
>                "Latitude": 47.61703550242447,
>                "Longitude": -122.14263367613601 
>            },
>            "TimestampUTC": "20201030"
>        },{
>            "DirectionId": 2,
>            "RouteId": 100113,
>            "VehicleId": 2,
>            "Position": {
>                "Latitude": 47.61528240582737,
>                "Longitude": -122.14308643341062
>            },
>            "TimestampUTC": "20201031"
>    }]';
>    EXECUTE @RC = [web].[AddBusData] 
>       @payload
>    GO
>```

## Deploy an Azure Static Web App

The main goal is to deploy an Azure Static Web App using the Azure portal.

1. Navigate to the Azure portal.

    > [!div class="nextstepaction"]
    > [The Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

1. In the search bar, type **static web app** and select **Static Web App (Preview)** under *Marketplace*. This will take you to the create page.

1. Select the default subscription and your Resource Group (it will be the only Resource Group in the drop-down).

1. Enter **bus-app** for *Name*.

1. Select the region where your other resources are deployed. If that region is not available, select the closest region to where you are.

1. At the bottom, select **Sign in with GitHub**.

1. Log in with your GitHub account and select **Authorize Azure-App-Service-Static-Web-Apps**. You may also need to enter your password.

1. Fill in the *Organization*, *Repository*, and *Branch* drop-downs with the corresponding information for the GitHub repository you've been using for this module.

1. Select **Vue.js** in the *Build Presets* drop-down.

::: zone pivot="csharp"

1. For *App location*, enter **azure-static-web-app/client**.

1. For *Api location*, enter **azure-static-web-app/api/dotnet**.

::: zone-end

::: zone pivot="python"

1. For *App location*, enter **azure-static-web-app/client**.

1. For *Api location*, enter **azure-static-web-app/api/python**.

::: zone-end

::: zone pivot="node"

1. For *App location*, enter **azure-static-web-app/client/**.

1. For *Api location*, enter **azure-static-web-app/api/node**.

::: zone-end

1. Select **Review + Create**.

1. Select **Create**.

1. Once it finishes creating, select **Go to resource**.

> [!TIP]
> If you click on the Azure Static Web App and don't see the map with a GeoFence and buses, that's OK for now. In the next exercise, you'll configure the application.

The last step in setting up your application is to configure the connection from Azure Static Web Apps to Azure SQL Database.

Here, you'll configure the application settings, view the functioning application, and review the GitHub Action runs.

## Configure application settings

In order for your Azure Static Web App to access your Azure SQL Database, you must configure an application setting which contains the Azure SQL Database connection string which works with the language you chose in and earlier exercise (.NET, Python, or Node.js).

1. In a text file, determine the connection string that you will need to be able to connect to your Azure SQL Database. The format should be as follows:

::: zone pivot="python"

```cmd
Driver={ODBC Driver 17 for SQL Server};Server=[serverName].database.windows.net,1433;Database=bus-db;UID=cloudadmin;PWD=[yourPassword];Connection Timeout=30;
```

::: zone-end

::: zone pivot="csharp"

```cmd
Server=tcp:[serverName].database.windows.net,1433;Database=bus-db;User ID=cloudadmin;Password=[yourPassword];Encrypt=true;Connection Timeout=30;
```

::: zone-end

::: zone pivot="node"

```cmd
mssql://cloudadmin:[yourPassword]@[serverName].database.windows.net/bus-db?encrypt=true
```

::: zone-end

1. Navigate to your Azure Static Web App in the Azure portal.

> [!div class="nextstepaction"]
> [The Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

1. From the *Overview* pane of your Azure Static Web App in the Azure portal, select **Configuration** under *Settings* on the left-hand menu.

1. Select **+ Add** and create a new setting named **AzureSQLConnectionString** with the value set to the connection string obtained in an earlier step.

1. Select **OK**.

1. Check the box next to the new application settings and select **Save**.

<!-- Not sure this is needed 
::: zone pivot="python"

1. Navigate to your GitHub repository in GitHub to the new workflow file that has been added under **serverless-full-stack-apps-azure-sql/.github/workflows**. It will be similar in name to `azure-static-web-apps-random-words&letters&numbers.yml`.

1. Select **Edit** to edit within the browser. 

1. Replace **ubuntu-latest** with **ubuntu-18.04** on *Line 15*.

1. Create a new line after *Line 20: `submodules: true` and add the following:

    ```yaml
    - name: Setup Python
    uses: actions/setup-python@v2
    with:
        python-version: '3.8.x'
    - name: Install dependencies
    run: |
        python -m pip install --target=".python_packages/lib/site-packages" -r requirements.txt
        echo "" > requirements.txt # blank out requirements.txt so it doesn't get installed again
    working-directory: 'azure-static-web-app/api/python'
    ```

1. Select **Start commit** > **Commit changes**.

1. In GitHub, navigate to **Actions** and confirm that the one titled *Azure Static Web Apps CI/CD* completes successfully.

::: zone-end
-->

