Session three introduced automated builds and deployments to VanArsdel's project. The automation is handy, because in this session we're going to 
write some code to move away from our filesystem-based image storage to a cloud-based solution. 

To follow along with the session, we recommend getting the project into the state we had at the end of session three.

## Objectives

In this session, you will:

- Analyze the existing storage implementation
- Explain the four Azure Storage services
- Select an appropriate storage approach

## The instructions and scripts provided in this document will

1. Create an App Service Plan
1. Create an App Service
1. Deploy the app directly from GitHub into the App Service
1. Create a logical database server
1. Create an Azure SQL Database
1. Configure the App Service to connect to the database

## Prepare your environment

- Fork our repository ([aka.ms/vanarsdelrepo](https://aka.ms/vanarsdelrepo)) if not already done ([fork now](https://github.com/MicrosoftDocs/mslearn-live-migrating-to-the-cloud/fork))
- Clone the repository to your PC
- Open the starter solution under "src/1 - Starter" (you can use Visual Studio 2019 or Visual Studio Code)

### If you're using your own Azure subscription

- Open [Azure portal](https://portal.azure.com) in your browser and select your subscription
- Open the Cloud Shell (the button is located at the top, next to the notifications bell and looks like this: >_) and select to use a "Bash" shell.

### If you're using the Learn Live Sandbox

> [!IMPORTANT]
> Activate the Azure Sandbox to execute the lab instructions in a free subscription and locate Azure Cloud Shell on the right-hand side.

Copy the following command and paste it into Cloud Shell:

```azurecli
wget -O prepsession4.bash https://raw.githubusercontent.com/MicrosoftDocs/mslearn-live-migrating-to-the-cloud/master/scripts/02_deploy_app_service_and_database.bash &&
chmod +x ./prepsession4.bash &&
./prepsession4.bash
```

> [!NOTE]
> The script will prompt you to enter the URL of **your fork** of the Github repo.

When finished, the script will output the URL of the App Service and append the query parameter `?forceMigration=true` - follow this link to ensure the database gets populated with data.

You're now ready to join session four! :-)

## Resources

- [Overview of features of Azure Storage Account settings](/azure/storage/common/storage-introduction#types-of-storage-accounts)
- [Storage Redundancy reference](/azure/storage/common/storage-redundancy)
- [Azure Storage Explorer](https://azure.microsoft.com/features/storage-explorer/)
- [Windows.Azure.Storage.Blob NuGet](https://www.nuget.org/packages/Microsoft.Azure.Storage.Blob/)
- Learn module: [Store Application Data with Azure Blob storage](/training/modules/store-app-data-with-azure-blob-storage/)
- Learn module: [Optimize storage performance and costs using Blob storage tiers](/training/modules/optimize-archive-costs-blob-storage/)
- Learn module: [Secure your Azure Storage Account](/training/modules/secure-azure-storage-account/)
- Learn module: [Connect an app to Azure Storage](/training/modules/connect-an-app-to-azure-storage/)
