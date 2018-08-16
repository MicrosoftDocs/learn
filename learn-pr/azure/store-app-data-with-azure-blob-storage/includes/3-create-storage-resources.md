Once we have an idea of how we're going to store data across storage accounts, containers and blobs, we can think about the Azure resources we need to create to support the app.

### Storage accounts

Storage account creation is an administrative/management activity that takes place prior to deploying and running your app. Accounts are usually created by a deployment or environment setup script, an ARM template, or manually by an administrator. Applications other than administrative tools generally should not have permissions to create storage accounts.

### Containers

Unlike storage account creation, container creation is a lightweight activity that makes sense to perform from within an app. It's not uncommon for apps to create and delete containers as part of their work.

For apps that rely on a known set of containers with hardcoded or preconfigured names, let the app create the containers it needs on startup or first usage if they don't already exist. Letting your app create containers instead of doing it as part of your app's deployment eliminates the need for both your application and your deployment process to know the names of the containers the app uses.

## Exercise

We're going to complete an unfinished ASP.NET Core app by adding code to use Blob storage. This exercise is more about exploring the Blob storage API than it is about designing an organization and naming scheme, but here's a quick overview of the app and how it stores data:

**TODO screenshot of app, since they're not going to see it run until the end**

Our app works like a shared folder that accepts file uploads and makes them available for download. It doesn't use a database for organizing blobs &mdash; instead, it sanitizes the names of uploaded files and uses them as blob names directly. All uploaded files are stored in a single container.

The code we'll start with compiles and runs, but the parts responsible for storing and loading data are empty and don't yet do anything. After we fill in the gaps, we'll deploy the app to Azure App Service and try it out.

Let's set up the storage infrastructure for our app.

### Create a resource group and storage account
First we'll create a resource group to contain all of the resources in this exercise. We'll delete it at the end to clean up everything we create. We'll also create the storage account our app will use to store blobs.

Use the Cloud Shell terminal on the right to create the resource group and storage account by running the following Azure CLI commands. You'll need to provide a unique name for the storage account &mdash; make a note of it for later. The choice of `eastus` for the location is arbitrary.

```console
az group create --name blob-exercise-group --location eastus
az storage account create --name <your-unique-storage-account-name> --resource-group blob-exercise-group --location eastus --kind StorageV2
```

** TODO below should go in Azure Storage module**

> [!NOTE]
> Why `--kind StorageV2`? There are a few different kinds of storage accounts, but we don't need to cover them in detail here. For most scenarios, you should use general-purpose v2 storage accounts (signified here with `StorageV2`). The only reason they need to be specified here is that they are still fairly new and have not yet been made the default in the Azure Portal or the CLI.

### Create a container?
The app we'll be working with in this module uses a single container. We're going to follow the best practice of letting the app create the container at startup, so we don't need to create a container right now. However, container creation can be done from the Azure CLI: run `az storage container create -h` in the Cloud Shell terminal if you'd like to see the documentation.