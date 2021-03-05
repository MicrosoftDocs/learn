It is easy to set up Azure Data Factory from within the Azure portal, you only require the following information:

- **Name**: The name of the Azure Data Factory instance
- **Subscription**: The subscription in which the ADF instance is created
- **Resource group**: The resource group where the ADF instance will reside
- **Version**: select V2 for the latest features
- **Location**: The datacenter location in which the instance is stored

Enable Git provides the capability to integrate the code that you create with a Git repository enabling you to source control the code that you would create. Define the GIT url, repository name, branch name, and the root folder. 

> [!div class="mx-imgBorder"]
> ![Creating an Azure Data Factory Instance](../media/create-azure-data-factory-instance.png)

Alternatively, there are a number of different ways that you can provision the service programmatically. In this example you can see PowerShell at work to set up the environment.


``` PowerShell
######################################################################
##                PART I: Creating an Azure Data Factory            ##
######################################################################


# Sign in to Azure and set the WINDOWS AZURE subscription to work with
$SubscriptionId = "add your subscription in the quotes"

Add-AzureRmAccount
Set-AzureRmContext -SubscriptionId $SubscriptionId

# register the Microsoft Azure Data Factory resource provider
Register-AzureRmResourceProvider -ProviderNamespace Microsoft.DataFactory

# DEFINE RESOURCE GROUP NAME AND LOCATION PARAMETERS
$resourceGroupName = "cto_ignite"
$rglocation = "West US 2"

# CREATE AZURE DATA FACTORY
New-AzureRmDataFactoryV2 -ResourceGroupName $resourceGroupName -Name "ctoigniteADF" -Location $rglocation
```