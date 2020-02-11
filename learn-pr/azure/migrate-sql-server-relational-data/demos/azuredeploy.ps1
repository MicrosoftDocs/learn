# Executes the az commands
az login

# Set Account
az account set --subscription "Visual Studio Ultimate with MSDN"
az account set --subscription "Pay-As-You-Go"

# Original (for reference)
# az group create --location "Central US" --name admsdemo3
# az group deployment create --name admsdemodeploy --resource-group admsdemo3 --template-uri https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-azure-database-migration-service/azuredeploy.json --parameters https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-azure-database-migration-service/azuredeploy.parameters.json

# Modified for this project
az group create --location centralus --name admsdemo3
az group deployment create --name admsdemodeploy --resource-group admsdemo3 --template-uri https://raw.githubusercontent.com/ps-dev/Microsoft-Written-PoC/master/migrate-sql-server-relational-data/demos/azuredeploy.json?token=ADTTGN2XOT65FFR63V6RXXC57JQT6 --parameters https://raw.githubusercontent.com/ps-dev/Microsoft-Written-PoC/master/migrate-sql-server-relational-data/demos/azuredeploy.parameters.json?token=ADTTGN45PBKC6TMLA3NWY4S57JQYQ

<#
Above command generates this error:

Azure Error: InvalidTemplateDeployment
Message: The template deployment 'admsdemodeploy' is not valid according to the validation procedure. The tracking id is '421cb8cc-2db3-4fdd-8059-eafba0e9f99e'. See inner errors for details.
Exception Details:
        Error Code: InvalidRequest
        Message: The SKU is not supported for this resource, the resource kind does not match the SKU, or the capacity is out of range.
#>


#------------------------------------------------------------------------------
# This section is just some useful helper commands for use in dev
#------------------------------------------------------------------------------
# To reset when done, delete the group
az group delete --name admsdemo3

# List locations
az account list-locations --output table