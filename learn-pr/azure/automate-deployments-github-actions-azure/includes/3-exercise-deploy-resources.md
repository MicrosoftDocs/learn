Setting up your environment and deploying some resources to start with is an important step in building full stack applications.

Recall in the catching the bus sample, you'll use resources including Azure SQL Database, Azure Static Web Apps, Azure Functions, and Azure Logic Apps. In the previous modules of this learning path, you focused on the various elements that make up the solution. In this module, you'll deploy the entire solution.

## Configure your environment for development with Visual Studio Code

In order to complete the exercises, you'll need to configure your environment. If you already have these components installed and configured, you do not need to repeat the steps.

1. Download and install [Visual Studio Code](https://code.visualstudio.com/Download).
1. Download and install the [Azure Functions Core Tools](/azure/azure-functions/functions-run-local?tabs=windows%2Ccsharp%2Cbash#install-the-azure-functions-core-tools).
1. In Visual Studio Code, install the following extensions:
    - [**Azure Account**](https://marketplace.visualstudio.com/items?itemName=ms-vscode.azure-account): This extension allows you to authenticate to Azure.
    - [**Azure Functions**](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions): This extension allows you to manage Azure Functions.
    - [**GitHub Pull Requests and Issues**](https://marketplace.visualstudio.com/items?itemName=GitHub.vscode-pull-request-github): This extension allows you to authenticate to GitHub and manage repositories.
    - [**Azure Resources**](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azureresourcegroups): This extension allows you to manage Azure resources.
    - [**SQL Server (mssql)**](https://marketplace.visualstudio.com/items?itemName=ms-mssql.mssql): This extension includes tools for querying SQL Server and Azure SQL resources.
    - [**Live Server**](https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer): This extension enables you to run web applications locally with ease.

1. Sign in to GitHub in Visual Studio Code using your GitHub account. If you do not have a GitHub account, [create one here](https://github.com/join).
1. Sign in to GitHub with your GitHub account and navigate to [this repository](https://github.com/Azure-Samples/serverless-full-stack-apps-azure-sql). In the top-right corner of your browser, select the **Fork** button.
1. On the same page, select **Code** and copy the HTTPS Clone URL, for example, *`https://github.com/<github-username>/serverless-full-stack-apps-azure-sql.git`*.
1. Back in Visual Studio Code, select **View** > **Source Control** > **Clone Repository** and enter the URL copied in a previous step. Select the location you would like the repository to be copied locally.
1. In Visual Studio Code, select **File** > **Open folder** and navigate to the location where you cloned the repository. This step will open the folder in your Visual Studio Code session.
1. Select the **Explorer** blade from the left-hand taskbar. Confirm that you see the repository files.

## Deploy a database service in Azure using Azure SQL Database

To set up the database for the bus catching scenario, you'll first need to deploy a database to work with. To accomplish this task, you'll use the Azure Cloud Shell, which is on the right side of this page. The Azure Cloud Shell is also available through the Azure portal, and allows you to create and manage Azure resources. It comes preinstalled with various tools, including the Azure CLI, Azure PowerShell, and sqlcmd. In this exercise, you'll use Azure PowerShell, but you can accomplish the same tasks with the Azure CLI. In the script, you'll be prompted for a password for the new database and your local IP address to enable your device to connect to the database.  

These scripts should take three to five minutes to complete. Be sure to note your password, unique ID, and region, because they won't be shown again.

1. Start by obtaining your local public IP address. Ensure that you're disconnected from any VPN service, and open a local PowerShell terminal on your device. Run the following command, and note the resulting IP address.

    ```powershell
    (Invoke-WebRequest -Uri "https://ipinfo.io/ip").Content
    ```

    > [!TIP]
    > If you are not on a Windows device, you need to locate your IP address with another method. In your terminal, you can run `curl ifconfig.co`.

1. Run the following commands in Cloud Shell. Enter a **complex password** and, at the prompt, enter your local public IP address, which you obtained in the preceding step.

    > [!Note]
    > A **complex password** must consist of:
    >
    > - 8 characters minimum and 16 characters maximum
    > - Requires 3 out of 4 of the following:
    >    - Lowercase characters
    >    - Uppercase characters
    >    - Numbers ( 0-9 )
    >    - Symbols ( @ # $ % ^ & * - _  + = [ ] { } | \ : ‘ , . ? / ` ~ “ ( ) ; )

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

    The script will take several minutes to complete.

    If you have any issues or want to confirm the resources were deployed, you can review in the Azure portal.

    > [!div class="nextstepaction"]
    > [The Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

## Deploy the Azure Function App using PowerShell

Next, you'll deploy an Azure Function App.

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

1. Run the following code in the Cloud Shell to deploy the function in your language of choice.

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

## Deploy an Azure Logic App using an ARM template

Next, you need to deploy the Azure Logic App that sends notifications using a combination of Azure PowerShell and ARM templates.

1. Make note of your GitHub repository (for example, 'https://github.com/[username]/serverless-full-stack-apps-azure-sql').

1. The following script clones the repository and deploys an Azure Logic App according to an ARM template.

    ```powershell
    # Resource group name and resource group
    $resourceGroupName = "<rgn>[sandbox resource group name]</rgn>"
    $resourceGroup = Get-AzResourceGroup | Where ResourceGroupName -like $resourceGroupName
    $location = $resourceGroup.Location
    # Get the repository name
    $appRepository = Read-Host "Enter your GitHub repository URL (for example, 'https://github.com/[username]/serverless-full-stack-apps-azure-sql'):"
    # Clone the repo - note this asks for the token
    $cloneRepository = git clone $appRepository
    # Get subscription ID 
    $subId = [Regex]::Matches($resourceGroup.ResourceId, "(\/subscriptions\/)+(.*\/)+(.*\/)").Groups[2].Value
    $subId = $subId.Substring(0,$subId.Length-1)
    # Deploy logic app
    az deployment group create --name DeployResources --resource-group $resourceGroupName `
        ` --template-file ./serverless-full-stack-apps-azure-sql/deployment-scripts/template.json `
        --parameters subscription_id=$subId location=$location  
    Write-Host "Logic App deployed."
    ```

## Review and configure the Azure Logic App

The next step is to configure the Logic App and update the Application Setting for your Azure Function App.

1. Once your Logic App is deployed, navigate to your Resource Group in the Azure portal and select the **Logic App** you deployed.

    > [!div class="nextstepaction"]
    > [The Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

1. Under *Development Tools*, select **Logic app designer**. Review the flow.

1. You'll notice there's an error for the Outlook.com connection. Select **Add new**.

1. Sign in to an Outlook account that you have access to.

1. Once successfully connected, you'll see the email and its contents. In the *To* field, enter the email address where you'd like to receive notifications.

1. Select **Save**.

1. Select **When an HTTP request is received** and copy the **HTTP POST URL** and save it in a text file or notepad.

## Review and configure the Azure Function

1. In a text file, determine the connection string that you'll need to be able to connect to your Azure SQL Database. The format should be as follows:

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

1. In the Azure portal, navigate to your Azure Function App.

1. Under *Settings*, select **Configuration**.

1. Select **+ New application setting** named **LogicAppUrl** and update the value with the Logic App POST URL you copied.

1. Select **OK**.

1. Select **+ New application setting** named **RealTimeFeedUrl** and update the value with `https://s3.amazonaws.com/kcm-alerts-realtime-prod/vehiclepositions_enhanced.json`.

1. Select **OK**.

1. Select **+ New application setting** named **AzureSQLConnectionString** and update the value with the connection string from step 1.

1. Select **OK**.

1. Select **Save** > **Continue**.

## Deploy an Azure Static Web App using PowerShell

The main goal is to deploy an Azure Static Web App using Azure PowerShell. In a future exercise, you'll configure the application in the Azure portal and with GitHub Actions.

1. In your GitHub account settings, near the bottom left, select **Developer settings** > **Personal access tokens** > **Generate new token** > **check all boxes** and generate the token. Make a note of the token as you'll need it shortly.

1. First, configure your variables.

    ```powershell
    # Get resource group and location and random string
    $resourceGroupName = "<rgn>[sandbox resource group name]</rgn>"
    $resourceGroup = Get-AzResourceGroup | Where ResourceGroupName -like $resourceGroupName
    $uniqueID = Get-Random -Minimum 100000 -Maximum 1000000
    $location = $resourceGroup.Location
    # Azure static web app name
    $webAppName = $("bus-app$($uniqueID)")
    # Get the repository name
    $appRepository = Read-Host "Please enter the forked URL (for example, https://github.com/<username>/serverless-full-stack-apps-azure-sql):"
    # Get user's GitHub personal access token
    $githubToken = (Read-Host "In your GitHub account settings, near the bottom left, select Developer settings > Personal access tokens > check all boxes and generate the token. Enter the token").ToString()
    # App service plan name
    $appServicePlanName = (Get-AzAppServicePlan -resourceGroupName $resourceGroupName).Name
    ```

1. Deploy the Azure Static Web App

    ```powershell
    # Deploy Azure static web app
    $staticWebApp = az staticwebapp create -n $webAppName -g $resourceGroupName `
    -s $appRepository -l 'westus2' -b main --token $githubToken
    Write-Host "Azure Static Web App deployed."
    ```

    > [!NOTE]
    > Since Azure Static Web Apps only recently became generally available, not all regions are available, which is why `westus2` is hard-coded above. To check other region availability, see [products available by region](https://azure.microsoft.com/global-infrastructure/services/?products=app-service).

If you have any issues or want to confirm the resources were deployed, you can review in the Azure portal.

> [!div class="nextstepaction"]
> [The Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

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
