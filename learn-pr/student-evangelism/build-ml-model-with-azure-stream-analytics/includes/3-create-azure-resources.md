We're going to be using several Azure services together to create our Polar Bear scanner. In this unit, we'll identify and create all of the necessary resources to manage the photographs.

- A resource group to hold all the necessary Azure resources.
- A general-purpose Azure Storage account.
- A blob container to hold the photographs taken by the remote cameras.

## Create a resource group

The first thing you would normally do when starting a project is create a _resource group_ to hold the related Azure resources. In this case, we're going to use an existing resource group created for you by activating the Azure Sandbox environment.

Make sure to activate the Sandbox before you continue with the instructions.

You can get all the details on the resource group that has been created for you by typing the following command into the Cloud Shell on the right.

```bash
az group list
```

[!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]

## Create an Azure Storage account

You need a unique name for the Azure Storage account. The name must be from 3 to 24 characters in length and can contain only numbers and lowercase letters. Create a unique name with a prefix with your birthday or initials. Since this name is used in several places, create an environment variable to hold the value.

We will use the pre-created resource group in the Azure Sandbox named <rgn>[sandbox resource group name]</rgn>.

1. Type the following command into the Cloud Shell on the right, replacing the `{name}` value with the unique name of the storage account. Make sure to use a value you'll remember since you will need to type it into some code later.

    ```bash
    export ACCOUNT_NAME="{name}"
    ```

1. Type or paste the following command to create a general-purpose storage account.

    ```azurecli
    az storage account create \
        --name $ACCOUNT_NAME \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --location southcentralus \
        --kind Storage \
        --sku Standard_LRS
    ```

    > [!TIP]
    > If the command fails and indicates that the storage account name is in use, change your environment variable value and try again.

## Create a Blob container

Before you can upload images to a storage account, you must create a blob container to store them in.

1. Use the following command to create a container named "photos" in the storage account with public access to the images.

    ```azurecli
    az storage container create \
        --name photos \
        --account-name $ACCOUNT_NAME
        --public-access blob
    ```

You now have a storage account for storing photos taken by your simulated cameras, and a container to store them in.