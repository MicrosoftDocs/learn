The following steps will walk you through creating an Azure Storage account, creating a resource group, and a storage container to host your static resources.

> [!IMPORTANT] 
> In order to complete this, you will need an Azure subscription. If you don't already have one, you can create a [free account](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).

## Open Azure Cloud Shell

Azure Cloud Shell is an interactive, browser-accessible shell for managing your Azure resources. It provides the flexibility of choosing the shell experience that best suits the way you work. Linux users can opt for a Bash experience, while Windows users can opt for PowerShell.

Common Azure tools are pre-installed and configured in Cloud Shell for you to use with your account. 

For this tutorial, Cloud Shell should appear on the right side of the screen. Select the blue **Login** button to get started using it.

When presented with code snippets throughout this module, you can select the **Copy** button to copy the code, paste it in Cloud Shell, modify it if you need to, and then press **Enter** to run it. 

## Create a resource group

An Azure resource group is a logical container that holds related resources for an Azure solution. The resource group can include all the resources for the solution, or only those resources that you want to manage as a group. Generally, you add resources that share the same lifecycle to the same resource group so you can easily deploy, update, and delete them as a group.

You can create a resource group with Cloud Shell by using the [az group create][az-group-create] command. For example, the following command creates a resource group named *serverlessRG* in the *eastus* location and exports them to variables so you can use them throughout this tutorial. 

> [!IMPORTANT] 
> As you create other resources in this tutorial, you will need to be sure to use the same region as you select in this first step.

```azurecli-interactive
export rg=serverlessRG
export loc=eastus
az group create --name $rg --location $loc
```

> [!NOTE] 
> It is important to note that resource groups store metadata about your resources. This means that when you specify a location for the resource group, you are specifying where that metadata is stored. Keep this in mind when you are using this in a production environment because for compliance reasons, you may need to ensure that your data is stored in a particular region.

## Create an Azure Storage account

The static content in our web application will be hosted in an Azure Blob Storage account, which will serve the content directly to the internet.

The sample command below create an Azure storage account using the name, *serverlessStorage*, in a variable. You will need to modify the storage account name value to something unique before you run this, as storage account names must be globally unique since it creates a DNS entry to be associated with it.

```azurecli-interactive
export storageAccount=serverlessstorage
az storage account create --name $storageAccount --location $loc --resource-group $rg --kind StorageV2 --sku Standard_GRS
```

## Create a Storage container

Next, you need to create a container in your Azure Storage account to host the files.

The command below will export *serverlesscontainer* as a variable for the container name and then create the account. If you want to use a different name, you can change the export.

```azurecli-interactive
export storageContainer=serverlesscontainer
az storage container create --name $storageContainer --account-name $storageAccount --public-access blob
```

## Install the application

The application that we are using for this tutorial and will be loaded by customers is stored in a GitHub repository. 

To clone the repo and upload it in your Azure storage account, you can use `git clone` with Azure Cloud Shell, as shown in the command below:

```azurecli-interactive
git clone https://github.com/david-stanford/serverless.git
for f in $(find ~/serverless -name '*.html' -or -name '*.css' -or -name '*.js'); do az storage blob upload -c $storageContainer --account-name $storageAccount -f $f -n ${f#*/serverless/}; done
```

Next, you need to retrieve the URL to the newly created web application. The following command retrieves the URL to the index.html file in your storage account:

```azurecli-interactive
az storage blob url -c $storageContainer --name index.html --account-name $storageAccount
```

Navigate to the URL in your favorite web browse to see that the application has correctly deployed to your Azure Blob Storage.

![Serverless web application][serverless-webapp]

<!-- Images -->
[serverless-webapp]: ../media/lab-1-storage-final.png

<!-- Links - Internal -->
[az-group-create]: /cli/azure/group#az_group_create

Congratulations - you (hopefully) have a functioning web application hosted via Azure Storage!