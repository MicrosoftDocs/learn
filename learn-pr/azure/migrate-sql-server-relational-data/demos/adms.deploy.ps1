# Executes the az commands
az login

# Set Account
# az account set --subscription "Visual Studio Ultimate with MSDN"
# az account set --subscription "Pay-As-You-Go"
az account set --subscription "Azure Free Trial"

# Create the resource group
az group create --location centralus --name admsdemorg

# Original from the supplied demo (for reference)
# az group deployment create --name admsdemodeploy --resource-group admsdemo3 --template-uri https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-azure-database-migration-service/azuredeploy.json --parameters https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-azure-database-migration-service/azuredeploy.parameters.json

# This is for local development
# az group deployment create --name admsdemodeploy --resource-group admsdemorg --template-file "C:\Users\arcan\OneDrive\Pluralsight\Azure Migrate your SQL Data to Azure SQL\Microsoft-Written-PoC\migrate-sql-server-relational-data\demos\adms.deploy.json" --parameters "C:\Users\arcan\OneDrive\Pluralsight\Azure Migrate your SQL Data to Azure SQL\Microsoft-Written-PoC\migrate-sql-server-relational-data\demos\adms.parameters.json"

# This is to deploy from the Microsoft github site for this ADMS tutorial
az group deployment create --name admsdemodeploy --resource-group admsdemorg --template-uri https://raw.githubusercontent.com/MicrosoftDocs/mslearn-migrate-sql-server-relational-data/master/adms.deploy.json --parameters https://raw.githubusercontent.com/MicrosoftDocs/mslearn-migrate-sql-server-relational-data/master/adms.parameters.json


#------------------------------------------------------------------------------
# This section is just some useful helper commands for use in dev
#------------------------------------------------------------------------------
# To reset when done, delete the group
# az group delete --name admsdemorg

# List locations
# az account list-locations --output table

#------------------------------------------------------------------------------
# This section has tips for troubleshooting the customs script extension
#------------------------------------------------------------------------------
# Basic Instructions from:
# https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/custom-script-windows#troubleshoot-and-support

# In the vm, install the Azure module
# Install-Module Az

# Then use the cmdlet to extract the logs

