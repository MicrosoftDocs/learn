In this exercise, you'll lay the groundwork for using the Azure Data Migration Assistant. First, you will need to install the Azure CLI tools so you can issue the proper commands. 

After installing, you'll open up either a CMD or PowerShell command line window. You'll issue the CLI commands to login to Azure, set the subscription you want to use, then create a resource group. Finally, you'll issue the command to deploy a pre-written template that will generate all of the objects you'll need to perform the demos, including a virtual machine, Azure SQL Database, and more.

[!INCLUDE [azure-exercise-subscription-prerequisite](../../../includes/azure-exercise-subscription-prerequisite.md)]

## Install Azure CLI on Windows

In order to create the environment, you will need to install the Azure CLI tools on your computer. You can obtain the CLI toolset at the following URL:

[https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows?view=azure-cli-latest](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows?view=azure-cli-latest)

## Execute the Azure CLI commands

First, you will need to login to Azure.

```powershell
az login
```

After issuing the login command, your default web browser will open and prompt you to login to Azure.

After logging in, you will need to set your subscription. This example will connect to an Azure Free Trial subscription. 

```powershell
az account set --subscription "Azure Free Trial"
```

Some other common values are "Visual Studio Ultimate with MSDN" and "Pay-As-You-Go." Use the name of the subscription you want to use for this learning exercise.

Once you are logged in and set your subscription, you'll need to create a resource group for this exercise. This next command will create a resource group named **admsdemorg** in the **centralus** region.

```powershell
az group create --location centralus --name admsdemorg
```

You may wish to use a different location if you are outside the US. Note, however, that not all regions support the Azure Data Migration Service. 

Finally, issue the command to generate the objects you'll need from a pre-defined template provided by Microsoft.

[//]: # (NOTE: This command will be updated to point to the final GitHub site for the demos)
```powershell
az group deployment create --name admsdemodeploy --resource-group admsdemorg --template-file "C:\Users\arcan\OneDrive\Pluralsight\Azure Migrate your SQL Data to Azure SQL\Microsoft-Written-PoC\migrate-sql-server-relational-data\demos\adms.deploy.json" --parameters "C:\Users\arcan\OneDrive\Pluralsight\Azure Migrate your SQL Data to Azure SQL\Microsoft-Written-PoC\migrate-sql-server-relational-data\demos\adms.parameters.json"
```

When finished, you can navigate to your Azure Portal and open the newly created **admsdemorg** Resource Group. You should see something similar to the image below. Note that not all names will match exactly, as some names are dynamically generated at creation time.

![Migration Workflow](../media/2-01-results.png)
