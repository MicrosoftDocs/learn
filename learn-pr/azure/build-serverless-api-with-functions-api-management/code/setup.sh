#!/bin/bash
# Set up randomized names for a storage account and two functions, which must be globally unique
STORAGE_ACCOUNT_NAME=storestorage$(openssl rand -hex 5)
PRODUCT_FUNCTION_NAME=ProductFunction$(openssl rand -hex 5)
ORDER_FUNCTION_NAME=OrderFunction$(openssl rand -hex 5)
# Get the resource group
RESOURCE_GROUP=$(az group list --query "[0].name" -o tsv)
printf "The resource group is called $RESOURCE_GROUP\n"
# Create a storage account
printf "Creating a storage account for the functions...\n"
az storage account create --name $STORAGE_ACCOUNT_NAME --location westus --resource-group $RESOURCE_GROUP  --sku Standard_LRS
printf "Storage account created.\n"
# Create two functions in Azure
printf "Creating function apps in Azure...\n"
az functionapp create --resource-group $RESOURCE_GROUP --consumption-plan-location westus --name $PRODUCT_FUNCTION_NAME --storage-account $STORAGE_ACCOUNT_NAME --runtime dotnet
az functionapp create --resource-group $RESOURCE_GROUP --consumption-plan-location westus --name $ORDER_FUNCTION_NAME --storage-account $STORAGE_ACCOUNT_NAME --runtime dotnet
printf "Function apps created.\n"
# Use zip deploy to publish the code
printf "Publishing function source code...\n"
az functionapp deployment source config-zip -g $RESOURCE_GROUP -n $PRODUCT_FUNCTION_NAME --src ProductDetailsFunc.zip
az functionapp deployment source config-zip -g $RESOURCE_GROUP -n $ORDER_FUNCTION_NAME --src OrderShippingFunc.zip
printf "Code published. Functions are ready to use.\n"