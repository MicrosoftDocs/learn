In session four we added a centralized, cloud-based storage to VanArsdel's solution. Now that the project is fully running in the cloud, we want to make sure things are going well.

To follow along with the session, we recommend getting the project into the state we had at the end of session four.

## Objectives
In this session, you will:

- Monitor your application against metrics
- Configure Alerts when your application hits certain thresholds
- Setup scaling rules for your application

## The instructions and scripts provided in this document will:

1. Create an App Service Plan
1. Create an App Service
1. Deploy the app directly from Github into the App Service
1. Create a logical database server
1. Create an Azure SQL Database
1. Configure the App Service to connect to the database
1. Create an Azure Storage Account
1. Set up Azure Blob Storage
1. Configure the App Service to connect to Azure Storage

## Prepare your environment

- Fork our repository ([aka.ms/vanarsdelrepo](https://aka.ms/vanarsdelrepo)) if not already done ([fork now](https://github.com/MicrosoftDocs/mslearn-live-migrating-to-the-cloud/fork))
- Clone the repository to your PC
- Open the completed solution under "src/2 - Completed" (you can use Visual Studio 2019 or Visual Studio Code)

### If you are using your own Azure subscription

- Open [Azure Portal](https://portal.azure.com) in your browser and select your subscription
- Open the Cloud Shell (the button is located at the very top, next to the notifications bell and looks like this: >_) and select to use a "Bash" shell.

### If you are using the Learn Live Sandbox

> [!IMPORTANT]
> Activate the Azure Sandbox to execute the lab instructions in a free subscription and locate Azure Cloud Shell on the right-hand side.

Copy the following command and paste it into Cloud Shell:

```azurecli
wget -O prepsession5.bash https://raw.githubusercontent.com/MicrosoftDocs/mslearn-live-migrating-to-the-cloud/master/scripts/03_deploy_app_service_and_database_and_storage.bash 
&& chmod +x ./prepsession5.bash && ./prepsession5.bash
```

> [!NOTE]
> The script will prompt you to enter the URL of **your fork** of the Github repo.

When finished, the script will output the URL of the App Service and append the query parameter `?forceMigration=true` - please follow this link to ensure the database gets populated with data.

You are now ready to join session five! :-)