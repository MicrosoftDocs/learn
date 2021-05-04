After you have an idea about how you're going to store data across storage accounts, containers, and blobs, you can think about the Azure resources you'll need to create to support the app.

### Storage accounts

Storage account creation is an administrative/management activity that takes place before deploying and running your app. Accounts are usually created by a deployment or environment setup script, an Azure Resource Manager template, or manually by an admin. Apps other than administrative tools generally should not have permissions to create storage accounts.

### Containers

Unlike storage account creation, container creation is a lightweight activity that makes sense to perform from within an app. It's not uncommon for apps to create and delete containers as part of their work.

For apps that rely on a known set of containers with hard-coded or preconfigured names, the typical practice is to let the app create the containers it needs on startup or first usage if they don't already exist. Letting your app create containers instead of doing it as part of your app's deployment eliminates the need for both your app and your deployment process to know the names of the containers the app uses.

## Exercise

You're going to complete an unfinished ASP.NET Core app by adding code to use Azure Blob storage. This exercise is more about exploring the Blob storage API than it is about designing an organization and naming scheme, but here's a quick overview of the app and how it stores data.

![Screenshot of the FileUploader web app](../media/4-fileuploader-with-files.PNG)

Your app works like a shared folder that accepts file uploads and makes them available for download. It doesn't use a database for organizing blobs &mdash; instead, it sanitizes the names of uploaded files and uses them as blob names directly. All uploaded files are stored in a single container.

The code you'll start with compiles and runs, but the parts responsible for storing and loading data are empty. After you complete the code, you'll deploy the app to Azure App Service and test it.

Let's set up the storage infrastructure for your app.

### Storage account

You'll use the Azure Cloud Shell with the Azure CLI to create a storage account. You'll need to provide a unique name for the storage account &mdash; make a note of it for later.  Replace [your-unique-storage-account-name] with a name you choose. 

To create the storage account, run this command. 

```azurecli
az storage account create \
  --kind StorageV2 \
  --resource-group <rgn>[sandbox resource group name]</rgn> \
  --location centralus \
  --name [your-unique-storage-account-name]
```

### Container

The app you'll be working within this module uses a single container. You're going to follow the best practice of letting the app create the container at startup. However, container creation can be done from the Azure CLI. If you'd like to see the documentation, in the Cloud Shell terminal, run `az storage container create -h`.
