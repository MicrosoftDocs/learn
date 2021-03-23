<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: remind the learner of the core idea(s) from the preceding learning-content unit (without mentioning the details of the exercise or the scenario)

    Heading: do not add an H1 or H2 title here, an auto-generated H1 will appear above this content

    Example: "A storage account represents a collection of settings that implement a business policy."

    [Exercise introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=master#rule-use-the-standard-exercise-unit-introduction-format)
-->
Azure SQL Database is a great choice for operational, transactional, and hybrid analytical workloads.

<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario covered in this exercise

    Heading: a separate heading is optional; you can combine this with the topic sentence into a single paragraph

    Example: "Recall that in the chocolate-manufacturer example, there would be a separate storage account for the private business data. There were two key requirements for this account: geographically-redundant storage because the data is business-critical and at least one location close to the main factory."

    Recommended: image that summarizes the entire scenario with a highlight of the area implemented in this exercise
-->
In the bus catching scenario, Azure SQL Database was selected due to it being an enterprise database with modern capabilities, like JSON and geospatial support.

TODO: add your scenario image

<!-- 3. Task performed in the exercise ---------------------------------------------------------------------

    Goal: State concisely what they'll implement here; that is, describe the end-state after completion

    Heading: a separate heading is optional; you can combine this with the sub-task into a single paragraph

    Example: "Here, you will create a storage account with settings appropriate to hold this mission-critical business data."

    Optional: a video that shows the end-state
-->
Here, you will deploy Azure SQL Database using scripts, connect to it in Azure Data Studio, and set up the database for the scenario using T-SQL.

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
    $resourceGroupName = "Sandbox resource group name"
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

    The script will take several minutes to complete. There are four main commands above, let's break them down. The first creates an Azure SQL Database logical server, which serves as something to connect to as well as a way for grouping metadata and policy settings for all databases assigned to that server. The next two commands create two firewall rules: one to allow your IP address to connect and one to allow other Azure services to connect. This will especially useful when you set up CI/CD pipelines using Azure DevOps and/or GitHub Actions.

    The final command deploys a database into that logical server. From the commands, you can tell the database is a General Purpose, Serverless database with a range of virtual cores between 0.5 and 4. Serverless is meant for intermittent, unpredictable usage with lower average compute utilization over time. Serverless provides automatic compute scaling to simplify performance management and is billed only for the amount of compute used. Serverless also supports automatic pausing and resuming to help further price optimize. When your database is paused, you pay only for storage. This is a great solution for the bus catching scenario as it is in development phase (perhaps not utilized 24/7) and it is unknown how popular it will be (i.e. how much compute it will need). 

## Connect with Azure Data Studio
Once your database is deployed, there are many ways that you can connect and interact with it: sqlcmd, Azure Data Studio, SSMS, the query editor in the portal, etc. Here, you'll learn how to connect to the database using Azure Data Studio.

1. Open Azure Data Studio and confirm by selecting the **Explorer** icon on the left-hand taskbar that the code repository folder is open. If you do not see the code files, please return to the previous exercise to configure your environment.

1. Select **Connections** from the left-hand taskbar. This is where all your database connections can be created and stored.

1. Next to *Servers*, select the **New Connection** button (it looks like a server with a plus sign).

1. In the *Connection Details* pane that opens, fill in the following information:
    *Connection type*: **Microsoft SQL Server**
    *Server*: **bus-server<uniqueID>.database.windows.net**
    *Authentication type*: **SQL Login**
    *User name*: **cloudadmin**
    *Password*: **<your-password>**
    *Remember password*: **Check box**
    *Database*: **bus-db**
    *Server group*: **<Default>**
    *Name (optional)*: **<leave-blank>**

1. Once a successful connection is made, you should be able to navigate the database's contents in the Connections pane.

## Set up the database
Once you're connected to any database, you usually need to deploy the database schema and tailor the database to meet your scenario's requirements by creating tables. Using a series of T-SQL scripts in a SQL notebook in Azure Data Studio, you'll configure the database to support your application and load some initial bus-related data.

1. In Azure Data Studio, select **Explorer** icon in the left-hand taskbar.

1. Under the folder `database\notebooks`, open **`01-set-up-database.ipynb`**.

1. Follow the steps in the SQL notebook to complete the exercise, and then return here.

## Process bus data with Azure SQL Database
Now that your database is configured, it's time to dive deeper into how Azure SQL Database will receive the real-time JSON data and store it in the database. Fortunately, Azure SQL Database has JSON support which makes this a simple task. Then, you can leverage the geospatial capabilities in Azure SQL Database to find the distances between buses, define and store GeoFences, and even determine if a bus is within a given GeoFence. With a foundation like this one, your application development becomes greatly simplified. This exercise will be completed in a SQL notebook in Azure Data Studio, similar to the previous activity.

1. In Azure Data Studio, select **Explorer** icon in the left-hand taskbar.

1. Under the folder `database\notebooks`, open **`02-json-geospatial-sql-db.ipynb`**.

1. Follow the steps in the SQL notebook to complete the exercise, and then return here.

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

## Check your work
<!-- Introduction paragraph -->
1. <!-- Step 1 (if multiple steps are needed) -->
1. <!-- Step 2 (if multiple steps are needed) -->
1. <!-- Step n (if multiple steps are needed) -->
Optional "exercise-solution" video

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->
