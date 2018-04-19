## Lab exercise 1 - Host a website in Azure blob storage

To get started with hosting a website in Azure blob storage perform the following steps:

In this lab we are going to create 

## Before you begin

This tutorial 

## Open Azure Cloud Shell

Azure Cloud Shell is a free, interactive shell that you can use to run the steps in this article. Common Azure tools are preinstalled and configured in Cloud Shell for you to use with your account. Just select the Copy button to copy the code, paste it in Cloud Shell, and then press Enter to run it. Cloud Shell should appear on the right-hand side of the screen. Select the blue **Login** button to launch Cloud Shell.

## Create a resource group

Create a resource group with the [az group create][az-group-create] command. An Azure resource group is a logical group in which Azure resources are deployed and managed.

The following example creates a resource group named *serverlessRG* in the *eastus* location and exports them to variables so you can use them through out this module.

```azurecli
export rg=servlessRG
export location=eastus
az group create --name $rg --location $location
```

## Create a storage account

The static content for this module will be hosted in an Azure Blob Storage account, and served directly to the internet from there.

The following commands will store the storage account name, *serverlessStorage* in this example, in a variable, and create the account.  The storage account name must be globally unique as it creates a DNS entry so change the value that you export.

```azurecli
export storageAccount=serverlessStorage
az storage account create --name $storageAccount --location $loc --resourceGroup $rg --kind StorageV2 --sku test
```

## Create a container

Next, you need to create a container in your storage account to actually host the files.

The following command will export *serverless35* as a variable for the container name and then create the account. If you want to use a different name feel free to change the export.

```azurecli
export storageContainer=serverless35
az storage container create --name $storageContainer --account-name $storageAccount --public-access blob
```

## Install the application

The application that will be loaded by customers is stored in a GitHub repository. The first step we will need to do is retrieve the code from the repo by using the git clone command.

The following commands will clone the repo, change directory into the newly downloaded code, and then upload it into the container you created in the previous steps.

```azurecli
git clone https://github.com/david-stanford/serverless.git
cd serverless
find the rest of the commands.
```

Now we just need to retrieve the URL to our newly created web application.  The following command retrieves the URL to the index.html file in your storage account.

```azurecli
az storage blob url -c $storageContainer --name index.html --account-name $storageAccount
```

To see that the application has correctly deployed to your Blob storage navigate to the URL in your favorite web browser.

![Serverless web application][serverless-webapp]

<!-- Images -->
[serverless-webapp]: ../media/lab-1-storage-final.png

<!-- Links - Internal -->
[az-group-create]: /cli/azure/group#az_group_create