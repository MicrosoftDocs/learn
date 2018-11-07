This unit serves to familiarize you with the steps you'll take in the next unit when you actually perform the exercise to create a server. Refer back to this section if you get stuck in the next unit.

## Scenario

Let's assume you're using an on-premises PostgreSQL database. Your company is now looking at expanding device support, availability, data tracking, and processing features by moving your server into Azure. You'll investigate how much effort it takes to automate the creation of an Azure Database for PostgreSQL server.

Creating a single Azure Database for PostgreSQL server using the Azure portal is easy. Creating more than one database and running on-going maintenance using only the portal may become tedious. You'll use the Azure CLI to create scripts when you want to automate management tasks.

Creating almost any resource within Microsoft Azure can be automated using the Azure CLI. In this unit, you'll learn how to automate management of your Azure Database for PostgreSQL servers using the Azure CLI.

## What is the Azure CLI?

The [Azure CLI](https://docs.microsoft.com/cli/azure?azure-portal=true) is Microsoft’s cross-platform command-line environment for managing Azure resources. You can use the Azure CLI from your browser with Azure Cloud Shell, or you can install the Azure CLI locally on macOS, Linux, or Windows. The Azure CLI is run from a local command line using bash or PowerShell. Running the Azure CLI locally requires additional setup. We'll use Azure Cloud Shell for executing the Azure CLI commands.

## What is Azure Cloud Shell?

Azure Cloud Shell is a browser-based shell experience that's hosted in the cloud and allows you to connect to Azure using an authenticated session. You can execute the Azure CLI commands to automate the management of an Azure Database for PostgreSQL server. Common Azure CLI tools are pre-installed and configured in Cloud Shell for you to use with your account.

> [!NOTE]
> Cloud Shell requires an Azure storage resource to persist any files you create while working in Cloud Shell. On first launch, Cloud Shell prompts to create a resource group, storage account, and Azure Files share on your behalf. This is a one-time step and will be automatically attached for all future Cloud Shell sessions.

## Create an Azure Database for PostgreSQL server using the Azure CLI

You'll use the Azure Cloud Shell terminal on the right to create an Azure Database for PostgreSQL server using Azure CLI.

The Azure CLI server creation command usage help showing all available parameters looks like the following example:

```azurecli
az postgres server create [-h] [--verbose] [--debug]
                            [--output {json,jsonc,table,tsv}]
                            [--query JMESPATH]
                            --resource-group RESOURCE_GROUP_NAME --name SERVER_NAME
                            --sku-name SKU_NAME [--location LOCATION]
                            --admin-user ADMINISTRATOR_LOGIN
                            [--admin-password ADMINISTRATOR_LOGIN_PASSWORD]
                            [--backup-retention BACKUP_RETENTION]
                            [--geo-redundant-backup GEO_REDUNDANT_BACKUP]
                            [--ssl-enforcement {Enabled,Disabled}]
                            [--storage-size STORAGE_MB]
                            [--tags [TAGS [TAGS ...]]]
                            [--version VERSION]
                            [--subscription _SUBSCRIPTION]

```

The optional parameters are surrounded in brackets. Let's examine a few of the common ones.

### Parameters

The `--resource-group <resource_group_name>` parameter specifies the resource group within which to create the server.

The server `admin-user` and `admin-password` that you specify is required to sign in to the server and its databases. Remember or record this information for later when interacting with the new server.

You use the `--sku-name` parameter to specify part of the pricing tier, in this case, compute resource. The value follows the convention `{pricing tier}_{compute generation}_{vCores}`.

Examples:

- `--sku-name B_Gen4_4` maps to Basic, Gen 4, and 4 vCores.
- `--sku-name GP_Gen5_32` maps to General Purpose, Gen 5, and 32 vCores.
- `--sku-name MO_Gen5_2` maps to Memory Optimized, Gen 5, and 2 vCores.

Recall that we discussed the three pricing tiers in the unit where we created the server using the portal.

Let's assume you want to use a Basic, Gen 5, and 1 vCore compute resource. You'll specify the parameter as `--sku-name B_Gen5_1`.

You use the `--storage-size` parameter to specify part of the pricing tier. If the value isn't specified, then it defaults to 5,120 MB. Valid storage sizes range from 5,120 MB and increases in increments of 1,024 MB up to 1,048,576 MB.

The `--backup-retention` parameter is used when you need to specify the retention period for backups, which is specified in days. If the value isn't specified, then it defaults to seven days.

You use the `--version` parameter to specify the major version of PostgreSQL that you'd like to use.

You've now seen the steps to create an Azure Database for PostgreSQL server using the Azure CLI. In the next unit, you'll create an Azure Database for PostgreSQL server using the Azure CLI.