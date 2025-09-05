Session one ended with the web application being migrated into an Azure App Service. In session two, we migrate the local database and its data into the cloud.

If you don't have access to the deployed solution (maybe you deleted it to save money or used the Learn Live Sandbox), follow these instructions.

## Objectives

In this session, you will:

- Select the appropriate Azure database solution for VanArsdel
- Migrate on-premises data into Azure

## The instructions and scripts provided in this document will

1. Create an App Service Plan
1. Create an App Service
1. Deploy the app directly from GitHub into the App Service

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
wget -O prepsession2.bash https://raw.githubusercontent.com/MicrosoftDocs/mslearn-live-migrating-to-the-cloud/master/scripts/01_deploy_app_service.bash && 
chmod +x ./prepsession2.bash &&
./prepsession2.bash
```

> [!NOTE]
> The script will prompt you to enter the URL of **your fork** of the Github repo.

When finished, the script will output the URL of the App Service and append the query parameter `?forceMigration=true` - follow this link to ensure the database gets populated with data.

You're now ready to join session two! :-)

## Resources

- Data Migration Assistant app: [aka.ms/datamigrationassistant](https://aka.ms/datamigrationassistant)
- Azure Data Studio app: [Azure Data Studio](/sql/azure-data-studio/what-is?view=sql-server-2017)
- SQL Database features overview: [aka.ms/sql-database-features](/azure/azure-sql/database/features-comparison)
- Azure Database Migration Service: [azure.microsoft.com/services/database-migration/](https://azure.microsoft.com/services/database-migration/)
- Run SQL Server Enterprise on a VM: [azure.microsoft.com/pricing/details/virtual-machines/sql-server-enterprise/](https://azure.microsoft.com/pricing/details/virtual-machines/sql-server-enterprise/)
