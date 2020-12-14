We’ll look at several methods for deploying a singleton Azure SQL Database.

## Deploying via the portal

The process to create a singleton database through the Azure portal is straightforward. While in the portal, on the left-hand navigation menu, select “SQL Databases”. In the resulting slide out dialog, click “Create”:

:::image type="content" source="../media/module-22-plan-implement-final-13.png" alt-text="The Azure portal Azure SQL Database Deployment screen":::

In the blade in the image below, you’ll notice that the subscription should already be provided for you. You will need to supply the following information:

- Resource Group – If there is an existing resource group that you wish to use, you may select it from the drop-down list. You can click on the “Create new” option if you wish to create a new resource group for this Azure SQL Database.
- Database Name – You must provide a database name.
- Server – Each database must reside on a logical server. If you have one already in existence in the appropriate region, you may choose to use it. Otherwise, you can click on the “Create new” and follow the prompts to create a new logical server to house the database.
- Determine whether to use an elastic pool.
- Determine the appropriate compute resources needed. By default, it will be a Gen5, 2vCore, with 32 GB of storage until something else is selected. Click on “Configure database” to view alternate configuration options.

:::image type="content" source="../media/module-22-plan-implement-final-14.png" alt-text="Create SQL Database blade of Azure portal":::

The image below shows the portal blade in which you can configure the database options. Here you will notice that the service tier is General Purpose and compute tier is Provisioned. Provisioned implies that the compute resources are pre-allocated and billed per hour based on the number of configured vCores. The other option is Serverless, which was discussed previously. Serverless is billed per second based on the number of vCores utilized.

:::image type="content" source="../media/module-22-plan-implement-final-15.png" alt-text="Service Tier selection in Azure portal":::

## Deploying an Azure SQL Database via PowerShell/CLI

You can also deploy your database using Azure PowerShell or the Azure CLI. The image below shows the PowerShell example where you are a creating a new resource group, and defining an admin called SqlAdmin and then creating a new server, database, and firewall rule.

```powershell
# Connect-AzAccount

# The SubscriptionId in which to create these objects

$SubscriptionId = ''

# Set the resource group name and location for your server

$resourceGroupName = "myResourceGroup-$(Get-Random)"

$location = "westus2"

# Set an admin login and password for your server

$adminSqlLogin = "SqlAdmin"

$password = "ChangeYourAdminPassword1"

# Set server name - the logical server name has to be unique in the system

$serverName = "server-$(Get-Random)"

# The sample database name

$databaseName = "mySampleDatabase"

# The ip address range that you want to allow to access your server

$startIp = "0.0.0.0"

$endIp = "0.0.0.0"


# Set subscription

Set-AzContext -SubscriptionId $subscriptionId


# Create a resource group

$resourceGroup = New-AzResourceGroup -Name $resourceGroupName -Location $location



# Create a server with a system wide unique server name

$server = New-AzSqlServer -ResourceGroupName $resourceGroupName `

 -ServerName $serverName `

 -Location $location `

 -SqlAdministratorCredentials $(New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $adminSqlLogin, $(ConvertTo-SecureString -String $password -AsPlainText -Force))



# Create a server firewall rule that allows access from the specified IP range

$serverFirewallRule = New-AzSqlServerFirewallRule -ResourceGroupName $resourceGroupName `

 -ServerName $serverName `

 -FirewallRuleName "AllowedIPs" -StartIpAddress $startIp -EndIpAddress $endIp

# Create a blank database with an S0 performance level

$database = New-AzSqlDatabase -ResourceGroupName $resourceGroupName `

 -ServerName $serverName `

 -DatabaseName $databaseName `

 -RequestedServiceObjectiveName "S0" `

 -SampleName "AdventureWorksLT"
```

The Azure CLI can also be used to deploy an Azure SQL Database as shown below:

```bash
#!/bin/bash



# set execution context (if necessary)

az account set --subscription <replace with your subscription name or id>



# Set the resource group name and location for your server

resourceGroupName=myResourceGroup-$RANDOM

location=westus2



# Set an admin login and password for your database

adminlogin=ServerAdmin

password=`openssl rand -base64 16`

# password=<EnterYourComplexPasswordHere1>



# The logical server name has to be unique in all of Azure 

servername=server-$RANDOM



# The ip address range that you want to allow to access your DB

startip=0.0.0.0

endip=0.0.0.0



# Create a resource group

az group create \

 --name $resourceGroupName \

 --location $location



# Create a logical server in the resource group

az sql server create \

 --name $servername \

 --resource-group $resourceGroupName \

 --location $location \

 --admin-user $adminlogin \

 --admin-password $password



# Configure a firewall rule for the server

az sql server firewall-rule create \

 --resource-group $resourceGroupName \

 --server $servername \

 -n AllowYourIp \

 --start-ip-address $startip \

 --end-ip-address $endip



# Create a database in the server

az sql db create \

 --resource-group $resourceGroupName \

 --server $servername 

 --name mySampleDatabase \

 --sample-name AdventureWorksLT \

 --edition GeneralPurpose \

 --family Gen4 \

 --capacity 1 \





# Echo random password

echo $password
```

## Deploying Azure SQL Database Using Azure Resource Manager templates

Another method for deploying resources is as mentioned earlier is using an Azure Resource Manager template. A Resource Manager template gives you the most granular control over your resources, and Microsoft provides a GitHub repository called “Azure-Quickstart-Templates”, which hosts Azure Resource Manager templates that you can reference in your deployments. A PowerShell example of deploying a GitHub based template is shown below:

```powershell
#Define Variables for parameters to pass to template

 

$projectName = Read-Host -Prompt "Enter a project name"

$location = Read-Host -Prompt "Enter an Azure location (i.e. centralus)"

$adminUser = Read-Host -Prompt "Enter the SQL server administrator username"

$adminPassword = Read-Host -Prompt "Enter the SQl server administrator password" -AsSecureString

$resourceGroupName = "${projectName}rg"



#Create Resource Group and Deploy Template to Resource Group



New-AzResourceGroup -Name $resourceGroupName -Location $location

New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName `

 -TemplateUri "https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-sql-logical-server/azuredeploy.json" `

 -administratorLogin $adminUser -administratorLoginPassword $adminPassword



Read-Host -Prompt "Press [ENTER] to continue ..."
```
