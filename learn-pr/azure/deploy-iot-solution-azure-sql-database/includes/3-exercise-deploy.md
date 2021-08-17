Setting up your environment and deploying the template is the first step in getting hands on with Azure SQL Database for IoT scenarios. For this sample, you'll use resources including Azure SQL Database, Azure Functions, Azure Virtual Machines, and Azure ARM templates.

In this exercise, you'll deploy the main solution and configure your environment.

## Deploy the Azure Resource Manager (ARM) template

To deploy the template, you'll use Azure Cloud Shell, which is on the right side of this page. Cloud Shell is also available through the Azure portal, and it allows you to create and manage Azure resources. It comes preinstalled with various tools, including the Azure CLI, Azure PowerShell, and sqlcmd. In this exercise, you'll use both the bash and PowerShell interfaces. Throughout the script, you'll be prompted for pieces of information to enable you to connect to the Azure Virtual Machine and Azure SQL Database that you will deploy. 

These scripts should take three to five minutes to complete. Be sure to note your password, unique ID, region, and the full ssh key. You can copy and paste them into a tool like NotePad, OneNote, or another tool of choice.

1. In bash on the right-hand side of your screen, enter the following code to generate a key. This key will enable easy access from the Cloud Shell to your virtual machine.

    ```bash
    mkdir .ssh
    ssh-keygen -m PEM -t rsa -b 4096 -f .ssh/id_rsa
    ```

1. Select the <kbd>Enter</kbd> key twice when prompted for a passphrase (no passphrase).

1. Run the following code and copy the entire result into your notes tool of choice (include *ssh-rsa* at the beginning).

    ```bash
    cat .ssh/id_rsa.pub
    ```

1. Next, you need to obtain your local public IP address. Ensure that you're disconnected from any VPN service, and open a local PowerShell terminal on your device. Run the following command, and note the resulting IP address.

    ```powershell
    (Invoke-WebRequest -Uri "https://ipinfo.io/ip").Content
    ```

    > [!TIP]
    > If you are not on a Windows device, you need to locate your IP address with another method. In your terminal, you can run `curl ifconfig.co`.

1. In the Azure Cloud Shell on the right-hand side of the screen, enter `pwsh` to switch from bash to PowerShell.

1. Run the following commands in Cloud Shell. Be sure to paste in the entire ssh key. Then, enter a complex password and, at the prompt, enter your local public IP address, which you obtained in a preceding step.

    ```powershell
    # Collect ssh key
    $sshPublicKey=Read-Host "Please enter your ssh public key you just created" -MaskInput
    # Collect password 
    $adminSqlLogin = "cloudadmin"
    $password = Read-Host "Your username is 'cloudadmin'. Please enter a password for your Azure SQL Database server that meets the password requirements"
    # Prompt for local ip address
    $ipAddress = Read-Host "Disconnect your VPN, open PowerShell on your machine and run '(Invoke-WebRequest -Uri "https://ipinfo.io/ip").Content'. Please enter the value (include periods) next to 'Address': "
    Write-Host "Password and IP Address stored"
    ```

1. Output and store in your notes tool of choice the information you'll need throughout the module by running the following code in Cloud Shell. You'll likely need to press <kbd>Enter</kbd> after you paste the code, because the last line won't be run by default.

    ```powershell
    # Get resource group and location and random string
    $resourceGroupName = "[sandbox resource group name]"
    $resourceGroup = Get-AzResourceGroup | Where ResourceGroupName -like $resourceGroupName
    $uniqueID = Get-Random -Minimum 100000 -Maximum 1000000
    $location = $resourceGroup.Location
    # Create several uniquely named services
    $iotHub = "iothub$($uniqueID)"
    $serverName = "iotserver$($uniqueID)"
    $iotSite = "iotsite$($uniqueID)"
    $iotServerFarm = "iotfarm$($uniqueID)"
    $iotSimulator = "iotsimulator$($uniqueID)"
    $logWorkspace = "iotlogs$($uniqueID)"
    $iotStorageAccount = "iotstorageaccount$($uniqueID)"
    $storageContainer = "iotstoragecontainer$($uniqueID)"
    $networkInterface = "iotnic$($uniqueID)"
    $vNet = "iotvnet$($uniqueID)"
    $ipAddressName="publicip$($uniqueID)"
    Write-Host "Please note your unique ID for future exercises in this module:"  
    Write-Host $uniqueID
    Write-Host "Your resource group name is:"
    Write-Host $resourceGroupName
    Write-Host "Your resources will be deployed in the following region:"
    Write-Host $location
    Write-Host "Your server name is:"
    Write-Host $serverName
    ```

    Remember to note your password, unique ID, and region. You'll use them throughout the module.

1. Run the following script to clone the repository that contains the ARM template and deploy it to Azure.

    ```powershell
    $appRepository =  "https://github.com/Azure-Samples/azure-sql-iot.git" #Read-Host "Enter your GitHub repository URL (for example, 'https://github.com/[username]/azure-sql-iot'):"
    $cloneRepository = git clone $appRepository
    az deployment group create -g $resourceGroupName `
    --template-file ./azure-sql-iot/azure_deployment/template.json `
        --parameters `
        iothub_name=$iotHub `
        server_sql_name=$serverName `
        server_admin_name=$adminSqlLogin `
        server_admin_password=$password `
        site_iot_name=$iotSite `
        serverfarm_iot_name=$iotServerFarm `
        virtualmachine_devicesimulator_name=$iotSimulator `
        logworkspace_name=$logWorkspace `
        storageaccount_iothub_name=$iotStorageAccount `
        storageaccount_iothub_container=$storageContainer `
        networkinterface_devicesimulator_name=$networkInterface `
        virtualnetwork_iot_name=$vNet `
        ip_address_name=$ipAddressName `
        ssh_public_key=$sshPublicKey 
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
    az vm show --resource-group $resourceGroupName --name $iotSimulator --show-details --query publicIps
    ```

    The script will take several minutes to complete.

    > [!TIP]
    > If you have any issues or want to confirm the resources were deployed, you can review in the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true).

## Configure the application settings for the `iot-workload` function

1. In your notes tool of choice document the connection string for your Azure SQL Database. It will be something like `Server=<your-server-name>.database.windows.net,1433;Initial Catalog=iot-db;User Id=cloudadmin;Password=<your-password>;Connection Timeout=30;`

1. Navigate in the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true) to your resource group for the exercises.

1. Select the **IoT Hub** service.

1. On the left-hand menu, under *Settings*, select **Shared access policies**.

1. Click **iothubowner** and copy the *Primary connection string* in your notes tool of choice.

1. You'll also need the *Event Hub-comptabile endpoint*.

1. On the left-hand menu, under *Settings*, select **Built-in endpoints**.

1. Copy the *Event Hub-compatible endpoint* in your notes tool of choice. Make sure you label the two connection strings as one is used for the simulator and the other is used for Azure Functions.

1. Navigate back to your resource group in the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true) and select the storage account that starts with **iotstorageaccount** followed by a series of numbers.

1. Under *Security + networking*, select **Access keys**.

1. Copy the *Primary connection string* in your notes tool of choice.

1. Navigate back to your resource group in the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true).

1. Select the **Function App** service.

1. On the left-hand menu, under *Settings*, select **Configuration**.

1. Select **EventHubConnectionAppSetting** and update it with your *Event Hub-compatible endpoint* for IoT Hub. Select **OK**.

1. Select **SQLDBConnectionString** and update it with your Azure SQL Database connection string. Select **OK**.

1. Select **AzureWebJobsStorage** and update it with your Azure Storage Account connection string.

1. Select **Save** to add the new settings. Select **Continue** to confirm.

## Deploy the Azure Function code with GitHub Actions

1. Navigate to [this repository](https://github.com/Azure-Samples/azure-sql-iot) and sign in to GitHub with your GitHub account.

1. In the top-right corner of your browser, select the **Fork** button.

1. Go to your forked repository for this module on GitHub (make sure you are signed in). It will be something like `https://github.com/<your-git-username>/azure-sql-iot`.

1. In a separate window, navigate to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true) to your Azure Function with a name starting with **iotsite** followed by a series on numbers.

1. In the *Overview* pane, select **Get publish profile** to download the Azure Function publish profile. The publish profile acts as a connection string to the function.

1. Returning to your GitHub repository window, Select **Settings** for the repository.

1. Select **Secrets** > **New repository secret** and enter the following items:
    1. *Name*: **AZURE_FUNCTIONAPP_PUBLISH_PROFILE**
    1. *Value*: **Connection string from prior step**

1. Select **Save**.

1. Near the top left of the GitHub window, select **Code** to return to the code of your forked GitHub repository.

1. Navigate in the repository to **.github** > **workflows** and select **dotnetfunction.yml.template**.

1. Select the pencil **Edit** icon near the top right of the file to edit the file.

1. Change the name of the file to **dotnetfunction.yml**.

1. At the bottom of the page, select **Commit changes** to kick off the GitHub Action that will deploy the code sample to your Azure Functions app.

1. Confirm the action completes successfully by selecting **Actions** near the top of the window and reviewing the progress and completion.

1. If you face any errors, confirm you have included the right connection strings in the right places in the previous section of this exercise.

1. Once complete, you have deployed the code that configures the function to support the scenario.

## Deploy the schema to Azure SQL Database

1. Deploy the database schema using a script from the GitHub repository. Update the code below and run the the Azure Cloud Shell (you may want to copy to a text file to easily modify). Note you'll need to add your server name and password.

    ```bash
    sqlcmd -S [server-name].database.windows.net -P [password] -U cloudadmin -d bus-db -i azure-sql-iot/sql_schema/script.sql
    ```

1. Finally, select **CTRL+C** to exit sqlcmd

## Connect to the Azure Virtual Machine and start the simulator

1. Back in the Azure Cloud Shell on the right-hand side of this page, the script should be complete and you should see a public IP address, which is the public IP address of your Azure Virtual Machine. Note it down.

1. Run `bash` to switch back to the bash shell.

1. Using the IP address you noted earlier and replacing `0.0.0.0`, run the following and follow the prompts to log in to your Azure Virtual Machine.

    ```bash
    ssh cloudadmin@0.0.0.0
    ```

1. Since you'll be using containers to run the simulation, run the following script to install the necessary packages.

    ```bash
    sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
    ```

1. Next, download the Docker installation files.

    ```bash
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    ```

1. Finally, install Docker.

    ```bash
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu `lsb_release -cs` test"
    sudo apt update
    sudo apt install -y docker-ce    
    ```

1. Replace <IoTHubConnectionEndpoint> with your IoT Hub connection string in the code below. Then, run it in the Azure Cloud Shell to provision the simulated devices.

    ```bash
    sudo docker run -it -e "IotHubConnectionString=<IoTHubConnectionString>" -e DeviceCount=1000 mcr.microsoft.com/oss/azure-samples/azureiot-simulatordeviceprovisioning:latest
    ```

1. Replace <IoTHubConnectionEndpoint> with your IoT Hub connection string in the code below. Then, run it in the Azure Cloud Shell to start generating messages on the provisioned devices.

    ```bash
    sudo docker run -it -e "IotHubConnectionString=<IoTHubConnectionString>" -e Template="{ \"deviceId\": \"$.DeviceId\", \"temp\": $.Temp, \"Ticks\": $.Ticks, \"Counter\": $.Counter, \"time\": \"$.Time\", \"engine\": \"$.Engine\" }" -e Variables="[{name: \"Temp\", \"random\": true, \"max\": 25, \"min\": 23}, {\"name\":\"Counter\", \"min\":100}, {name:\"Engine\", values: [\"on\", \"off\"]}]" -e MessageCount=0 -e DeviceCount=1000 -e Interval=100  mcr.microsoft.com/oss/azure-samples/azureiot-telemetrysimulator:latest
    ```

You have now successfully deployed the template and configured the resources. You are now simulating activity on 1,000 devices and using Azure Functions to ingest the data into Azure SQL Database.
