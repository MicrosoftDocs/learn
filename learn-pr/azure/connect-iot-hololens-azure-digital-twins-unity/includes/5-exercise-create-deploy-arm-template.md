> [!IMPORTANT]
> This module creates Azure resources.  If you don't plan to use this module again or if you don't complete the module, be sure to remove the created resources.  Instructions for removing all resources are included at the end of the module.

This module assumes you have Azure CLI installed and you can run it from the command prompt or Windows PowerShell, which is our recommendation.  The module also assumes you have an Azure account and at a minimum, the Contributor and User Access Administrator roles on the Azure subscription, or Owner.

> [!IMPORTANT]
> If you belong to an organization, you may need to coordinate with your IT Team to create your AAD user account and grant the appropriate privileges.  Also, Guest accounts associated with your Azure subscription do not meet the minimum requirements.  You must have a member account.

The ARM Template logic has been integrated into a Connection Prefab that drives a data simulator.  

## Download the Visual Studio solution and the ARM template

[Download the repository from GitHub](https://aka.ms/mr-adt-mslearn) and unzip the repository  

## Log in to Azure using Azure CLI

1. Locate the **azuredeploy.bicep** script that has been created for you.  Typically, this is in the root of the repository folder that you just unzipped or pulled.
2. Start **Windows PowerShell** from the start menu.  All Azure CLI commands will be executed in your PowerShell console.
3. Change the current path to the location of the **azuredeploy.bicep** script identified in step 1.

    ```console
    cd <path for azuredeploy.bicep>
    ```

4. Log in to Azure by typing **az login** in the shell window and pressing **Enter**.  This will spawn a browser window and prompt for authentication. 
    - If the CLI fails to spawn the appropriate browser window, use the device code flow in your PowerShell window **az login --use-device-code**.  You'll be returned a unique code.  [Open the device login page](https://aka.ms/devicelogin) in your browser and enter the code displayed in your terminal, into the website.

    :::image type="content" source="../media/az-login-results.png" alt-text="Screenshot of the Shell using the Windows PowerShell environment to execute the az login command.":::

## Set variables in PowerShell

1. Set the **projectname** variable, keeping it to a maximum of 14 characters, all lowercase, and no special characters (dashes permitted). This is the base unique name for your Azure resources that will be created in this exercise.  Additional random characters will be appended to the projectname.  Make sure your values are enclosed in double quotes.

    ```console
    $projectname="myproj"
    ```

    > [!IMPORTANT]
    > Your project name must be kept to a maximum of 14 characters, and may contain lowercase letters and numbers only.
    
    > [!NOTE]
    > Variables in PowerShell are prefixed with the **$** symbol.

2. Set the App Registration name, keeping it to a maximum of 14 characters.  This is the name of the application registration for your mixed reality app

    ```console
    $appreg="myappreg"
    ```

## Create the App Registration

Run the following command to create a service principal and configure its access to Azure resources.

```console
az ad sp create-for-rbac --name ${appreg} --role Contributor --scopes /subscriptions/<SUBSCRIPTION-ID> > AppCredentials.txt
```

> [!NOTE]
> The output from this command will be saved by redirecting standard output to **AppCredentials.txt** text file in the same directory in which you are running the az scripts.  Any errors, should they occur will be displayed in your PowerShell console.  You will need to open this file to retrieve these credentials to configure the telemetry simulator application later.  Be wary of leaving this file on your filesystem long term, as it will contain credentials.  Consider deleting the file after completing this learning path.

:::image type="content" source="../media/az-app-reg.png" alt-text="Screenshot of the command-line interface using the PowerShell environment to set app product and registration names and create the app registration.":::

## Obtain the ObjectID of the App Registration and the UserID

1. Create and set a variable for the ObjectID in PowerShell by inputting the below commands and press **Enter**.

    ```console
    $objectid=$(az ad sp list --display-name ${appreg} --query [0].objectId --output tsv)
    ```

2. Validate that the variable contains a GUID by using the **echo** command and then press **Enter**.  If not, examine your previous steps

    ```console
    echo $objectid
    ```

3. Create and set a variable for the UserID as below, then press **Enter**. 

    ```console
    $userid=$(az ad signed-in-user show --query objectId -o tsv)
    ```

4. Validate that the variable contains a GUID by using the **echo** command and then press **Enter**.  If not, examine your previous steps

    ```console
    echo $userid
    ```

    :::image type="content" source="../media/object-and-user-id.png" alt-text="Screenshot of the command-line interface using the Windows PowerShell environment to get the apps object and user ID.":::

## Create the Azure Resource Group

Create the Resource Group by using the **az group** command in PowerShell, as listed below and press **Enter**.  Pay particular attention to the location, as it must be **eastus**, as this specified one of the valid regions for **Microsoft.SignalRService/SignalR** and **Microsoft.DigitalTwins/digitalTwinsInstances** used later.

```console
az group create --name ${projectname}-rg --location eastus
```
 
## Deploy the ARM template to the newly created Azure Resource Group

Deploy the supplied.bicep** file to your Resource group and redirect the output to a text file called **ARM_deployment_out.txt**.  The file is for reference only and is not required for the rest of this module.  Note that this process can take 10-15 minutes to complete

```console
az deployment group create -f azuredeploy.bicep -g ${projectname}-rg --parameters projectName=${projectname} userId=${userid} appRegObjectId=${objectid} > ARM_deployment_out.txt
```

> [!NOTE]
> You may receive several WARNING messages regarding valid URI renaming, that the output contains credentials, and type availability.  Please review these warnings, but no immediate action is required, and this will not affect this module.

> [!TIP]
> If you need to re-create the Azure resources for any reason, you will need to be sure that you delete all previous instances of resources and resource groups.

## Install the Azure CLI extension

Install the **azure-iot** extension for the Azure CLI in PowerShell by using the **az extension** command in PowerShell, as listed below and press **Enter**.  This will download and install the extension, or if you've it installed already, you'll be alerted.

```console
az extension add --name azure-iot
```

## Query Azure deployment for key configuration parameters

Query the Azure deployment by using the **az deployment** command in PowerShell, as listed below and press **Enter**.  The command below redirects the output to a file named **Azure_config_settings.txt** into the same directory in which you're running the command.

```console
az deployment group show -n azuredeploy -g ${projectname}-rg --query properties.outputs.importantInfo.value > Azure_config_settings.txt
```

## Query Azure deployment for resource group connection parameter

1.	Use the **az iot** command to query the IoT hub for the Resource Group connection string parameter that you'll use later in the module.   Query the connection string for your Resource Group by using the **az iot** hub command in PowerShell, as listed below and press **Enter**.  The command below redirects the output and appends it (note the use of two ‘>’ symbols instead of one) to the file named **Azure_config_settings.txt** into the same directory in which you're running the command.  This file was created in the previous step.

    ```console
    az iot hub connection-string show --resource-group ${projectname}-rg >> Azure_config_settings.txt
    ```

2. Confirm the contents of the output text file in PowerShell, as listed below and press **Enter**. This will display several key configuration parameters for later use in this module.  

    ```console
    get-content Azure_config_settings.txt
    ```

    :::image type="content" source="../media/query-azure-deployment-to-file.png" alt-text="Screenshot of the command-line interface running the get-content command prompt.":::