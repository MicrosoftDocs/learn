At the end of the second session we had the VanArsdel solution running up on Azure as an App Service and made it connect to an Azure SQL database. The Azure Data Migration Assistant helped us move our data from the local database instance into the cloud.

## Objectives
In this session, you will:

- Identify the benefits of automated deployments vs manual deployment
- Automate your build and deployment using Azure App Service Deployment Center

To follow along with the session, we recommend getting the project into the state we had at the end of session two.

## The instructions and scripts provided in this document will:

1. Create an App Service Plan
1. Create an App Service
1. Deploy the app directly from Github into the App Service
1. Create a logical database server
1. Creates a Azure SQL Database
1. Configure the App Service to connect to the database

## Prepare your environment

- Fork our repository ([aka.ms/vanarsdelrepo](https://aka.ms/vanarsdelrepo)) if not already done ([fork now](https://github.com/MicrosoftDocs/mslearn-live-migrating-to-the-cloud/fork))
- Clone the repository to your PC
- Open the starter solution under "src/1 - Starter" (you can use Visual Studio 2019 or Visual Studio Code)

### If you are using your own Azure subscription

- Open [Azure Portal](https://portal.azure.com) in your browser and select your subscription
- Open the Cloud Shell (the button is located at the very top, next to the notifications bell and looks like this: >_) and select to use a "Bash" shell.

### If you are using the Learn Live Sandbox

> [!IMPORTANT]
> Activate the Azure Sandbox to execute the lab instructions in a free subscription and locate Azure Cloud Shell on the right-hand side.

Copy the following command and paste it into Cloud Shell:

`wget -O prepsession3.bash https://raw.githubusercontent.com/MicrosoftDocs/mslearn-live-migrating-to-the-cloud/master/scripts/02_deploy_app_service_and_database.bash && chmod +x ./prepsession3.bash && ./prepsession3.bash`

> [!NOTE]
> The script will prompt you to enter the URL of **your fork** of the Github repo.

When finished, the script will output the URL of the App Service and append the query parameter `?forceMigration=true` - please follow this link to ensure the database gets populated with data.

You are now ready to join session three! :-)

## Resources

- Documentation: [Continuous deployment to Azure App Service](https://docs.microsoft.com/en-us/azure/app-service/deploy-continuous-deployment)
