## Lab exercise 1 - Host a website in Azure Blob Storage

Create a resource group to house all of the resources you create in this unit. You will create an Azure Storage account and a storage container to host your static resources.

## Before you begin

If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/?WT.mc_id=A261C142F) before you begin.

## Open Azure Cloud Shell

Azure Cloud Shell is a free, interactive shell that you can use to run the steps in this article. Common Azure tools are pre-installed and configured in Cloud Shell for you to use with your account. Just select the **Copy** button to copy the code, paste it in Cloud Shell, and then press **Enter** to run it. Cloud Shell should appear on the right-hand side of the screen. Select the blue **Login** button to launch Cloud Shell.

## Create a resource group

An Azure resource group is a logical group in which Azure resources are deployed and managed. Create a resource group with the [az group create][az-group-create] command.

The following example creates a resource group named *serverlessRG* in the *eastus* location and exports them to variables so you can use them through out this unit. As you create other resources you need to be sure to use the same region as you select in this first step.

```azurecli
export rg=servlessRG
export location=eastus
az group create --name $rg --location $location
```

## Create an Azure Storage account

The static content for this unit will be hosted in an Azure Blob Storage account, which will serve content directly to the Internet.

The commands below create the storage account using the name, *serverlessStorage*, in a variable.  The storage account name must be globally unique as it creates a DNS entry so change the value below that you export to something unique.

```azurecli
export storageAccount=serverlessStorage
az storage account create --name $storageAccount --location $loc --resourceGroup $rg --kind StorageV2 --sku test
```

## Create a container

Next, you need to create a container in your storage account to host the files.

The following command will export *serverlessContainer* as a variable for the container name and then create the account. If you want to use a different name feel free to change the export.

```azurecli
export storageContainer=serverlessContainer
az storage container create --name $storageContainer --account-name $storageAccount --public-access blob
```

## Install the application

The application that will be loaded by customers is stored in a GitHub repository. The first step you will need to do is retrieve the code from the repo by using `git clone`.

The following commands will clone the repo and then upload it into the container you created in the previous steps.

```azurecli
git clone https://github.com/david-stanford/serverless.git
cd serverless
find the rest of the commands.
```

Now you need to retrieve the URL to the newly created web application.  The following command retrieves the URL to the index.html file in your storage account.

```azurecli
az storage blob url -c $storageContainer --name index.html --account-name $storageAccount
```

Navigate to the URL in your favorite web browse to see that the application has correctly deployed to your Azure Blob Storage.

![Serverless web application][serverless-webapp]

<!-- Images -->
[serverless-webapp]: ../media/lab-1-storage-final.png

<!-- Links - Internal -->
[az-group-create]: /cli/azure/group#az_group_create