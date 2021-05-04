Create an ARM template to create, configure, and deploy Azure Services.  This assumes Azure CLI has been installed and can be run from the command prompt or PowerShell.  Also, this assumes that you have your Azure account set up and appropriate AD privileges to create resource groups and resources.

The ARM Template logic has been integrated into a Visual Studio solution that drives a data simulator.  

## Download or pull the Visual Studio Solution directly from the Github repository

1.	Download the repository from Github or pull it directly using Git management tools.
2.	Unzip the repository (if necessary) 

## Login to Azure using Azure CLI

1.	Locate the **azuredeploy.bicep** script that has been created for you.  Typically, this resides in the root of the repository folder that you just unzipped or pulled.
2.	Start **Windows PowerShell** from the start menu.  All Azure CLI commands will be executed in your PowerShell console 
i.	Windows Command Prompt can be used, but syntax in this module follows PowerShell requirements.
3.	Change the current path to the location of the **azuredeploy.bicep** script identified in step 1.

`cd <path for azuredeploy.bicep>`

4.	Login to Azure by typing **az login** in the shell window and pressing **Enter**.  This will spawn a browser window and prompt for authentication. 
i.	If the CLI fails to spawn the appropriate browser window, use the device code flow in your PowerShell window **az login --use-device-code**.  You will be returned a unique code.  [Open the device login page](https://aka.ms/devicelogin) in your browser and enter the code displayed in your terminal, into the website.

<!-- :::image type="content" source="" alt-text=""::: -->

## Set reusable variables in PowerShell

1.	Set the project name variable, keeping it to a maximum of 14 characters, all lowercase, and no special characters (dashes permitted). This is the overall unique name for your Azure resources.  Additional random characters will be appended to the name.
`$projectname="myproj"`
2.	Set the App Registration name, keeping it to a maximum of 14 characters.  This is the name of the application registration for your HoloLens app
`$appreg="myappreg"`

## Create the App Registration

1.	Run the following command
`az ad sp create-for-rbac --name ${appreg} --skip-assignment`

> [!TIP]
> Save the output to a text file in a secure location.  You will need the credentials to configure the telemetry simulator application later.

<!-- :::image type="content" source="" alt-text=""::: -->

## Obtain the ObjectID of the App Registration and the UserID
1.	Create and set a variable for the ObjectID in PowerShell and press Enter.
` $objectid=$(az ad sp list --display-name ${appreg} --query [0].objectId --output tsv)`
`2.	Validate that the variable contains a GUID by using the echo command and then press Enter.  If not, examine your previous steps
`echo $objectid`
`3.	Create and set a variable for the UserID as below, then press Enter. 
`$userid=$(az ad signed-in-user show --query objectId -o tsv)`
4.	Validate that the variable contains a GUID by using the echo command and then press Enter.  If not, examine your previous steps
`echo $userid`

<!-- :::image type="content" source="" alt-text=""::: -->

## Create the Azure Resource Group

1.	Create the Resource Group by using the **az group** command in PowerShell, as listed below and press **Enter**.  Pay particular attention to the location, as it must be eastus, as this specified one of the valid regions for **Microsoft.SignalRService/SignalR** and **Microsoft.DigitalTwins/digitalTwinsInstances** used later.
`az group create --name ${projectname}-rg --location eastus`
	
## Deploy the ARM template to the newly created Azure Resource Group

1.	Deploy the supplied .bicep file to your Resource group and pipe the output to a text file.  This process can take several minutes to complete.

`az deployment group create -f azuredeploy.bicep -g ${projectname}-rg --parameters projectName=${projectname} userId=${userid} appRegObjectId=${objectid} >> ARM_deployment_out.txt`

> [!TIP]
> If you need to re-create the Azure resources for any reason, you will need to be sure that you delete all previous instances of resources and resource groups.
