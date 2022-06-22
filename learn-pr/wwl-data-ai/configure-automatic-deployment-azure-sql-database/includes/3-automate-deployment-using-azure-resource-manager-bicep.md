Automating database deployment is a crucial ability to create a reliable and sustainable development process. This module will also provide you with the information to be able to use ARM templates and bicep files in your database deployments.

## ARM template

Azure Resource Manager (ARM) templates are JavaScript Object Notation (JSON) documents that describe the resources to deploy within an Azure Resource Group. ARM templates are declarative, and allow you to specify your resources and properties without having to write a full sequence of programming commands.

ARM templates allow you to create and deploy your entire infrastructure using a declarative framework. For example, you can deploy not only a virtual machine, but its network and storage dependencies in a single document. ARM templates also support orchestration, which manages the deployment of interdependent resources so that they're created in the correct order and extensibility, which allows you to run PowerShell or Bash scripts after you've deployed your resources.

### Benefits

ARM templates offer the following benefits:

- **Repeatable –** ARM templates are *idempotent*, which means it allows you to repeatedly deploy your infrastructure throughout the development lifecycle and have confidence your resources are deployed in a consistent manner.

- **Orchestration –** ARM templates take care of the complexities of ordering operations for deployments and when possible will deploy resources in parallel rather than serial for faster deployments.

- **Modular –** ARM templates can be split and combined at will, so you can create the deployments you need.

- **Exportable code –** A great way to learn the template syntax is to export the current template. Exporting templates allow you to easily recreate your environment for Disaster Recovery or documentation purposes.

- **Authoring tools –** ARM templates can be authored using the freely available Visual Studio Code and the template tool extension. It provides intellisense, syntax highlighting, in-line help, and many other language functions. In addition to Visual Studio Code, you can also use Visual Studio.

### Deploy an ARM template with PowerShell

You have several options for the scope of your deployment when using PowerShell and ARM templates. You can deploy to a resource group, a subscription, a Management Group (a collection of subscriptions under the same Azure template and commonly used in large enterprise deployments), or a tenant. 

Let's look at a JSON ARM template definition to create a single database in SQL Database:

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "metadata": {
    "_generator": {
      "name": "bicep",
      "version": "0.5.6.12127",
      "templateHash": "17606057535442789180"
    }
  },
  "parameters": {
    "serverName": {
      "type": "string",
      "defaultValue": "[uniqueString('sql', resourceGroup().id)]",
      "metadata": {
        "description": "The name of the SQL logical server."
      }
    },
    "sqlDBName": {
      "type": "string",
      "defaultValue": "SampleDB",
      "metadata": {
        "description": "The name of the SQL Database."
      }
    },
    "location": {
      "type": "string",
      "defaultValue": "[resourceGroup().location]",
      "metadata": {
        "description": "Location for all resources."
      }
    },
    "administratorLogin": {
      "type": "string",
      "metadata": {
        "description": "The administrator username of the SQL logical server."
      }
    },
    "administratorLoginPassword": {
      "type": "secureString",
      "metadata": {
        "description": "The administrator password of the SQL logical server."
      }
    }
  },
  "resources": [
    {
      "type": "Microsoft.Sql/servers",
      "apiVersion": "2021-08-01-preview",
      "name": "[parameters('serverName')]",
      "location": "[parameters('location')]",
      "properties": {
        "administratorLogin": "[parameters('administratorLogin')]",
        "administratorLoginPassword": "[parameters('administratorLoginPassword')]"
      }
    },
    {
      "type": "Microsoft.Sql/servers/databases",
      "apiVersion": "2021-08-01-preview",
      "name": "[format('{0}/{1}', parameters('serverName'), parameters('sqlDBName'))]",
      "location": "[parameters('location')]",
      "sku": {
        "name": "Standard",
        "tier": "Standard"
      },
      "dependsOn": [
        "[resourceId('Microsoft.Sql/servers', parameters('serverName'))]"
      ]
    }
  ]
}

```

As we can see above, a single database that has one of two purchasing models was defined. As part of creating a single database, you also specify the server to be responsible for managing it, and the region in which it should be placed within Azure.

As we can see in the PowerShell example below, this file can be deployed from a URI:

```PowerShell
$projectName = Read-Host -Prompt "Enter a project name that is used for generating resource names"
$location = Read-Host -Prompt "Enter an Azure location (i.e. centralus)"
$adminUser = Read-Host -Prompt "Enter the SQL server administrator username"
$adminPassword = Read-Host -Prompt "Enter the SQL server administrator password" -AsSecureString

$resourceGroupName = "${projectName}rg"

New-AzResourceGroup -Name $resourceGroupName -Location $location
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateUri "https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/quickstarts/microsoft.sql/sql-database/azuredeploy.json" -administratorLogin $adminUser -administratorLoginPassword $adminPassword
```

## Bicep

Azure Bicep is a declarative language that allows you to deploy Azure resources. Bicep provides a first-class authoring experience that is concise, reliable and allow for code reuse, and it's commonly described as an Infrastructure-as-Code (IaC) tool.

Bicep isn't meant to be a general programming language. It's meant as a tool to allow you to create a file declaring Azure infrastructure resources and properties that can be used throughout the development lifecycle, allowing resource deployment in a consistent manner.

### Benefits

The following are some benefits of Bicep:

- **Continuous full support –** Bicep provides support for all resource types and API versions for Azure services, which means that as soon as a resource provider introduces new resource types and API versions, you can use them in your Bicep file without waiting for a tool update.

- **Simple syntax –** Compared to an equivalent JSON file, Bicep files will be more concise and easier to read.

- **Easy to use:** Bicep requires no previous knowledge of programming languages and is easy to write and understand.

    ![Animated GIF of Bicep file example showing how easy is to write and understand.](../media/module-66-automation-final-04.gif)

The following examples show the difference between a Bicep file and the equivalent JSON template. Both examples deploy a storage account.

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "location": {
      "type": "string",
      "defaultValue": "[resourceGroup().location]"
    },
    "storageAccountName": {
      "type": "string",
      "defaultValue": "[format('toylaunch{0}', uniqueString(resourceGroup().id))]"
    }
  },
  "resources": [
    {
      "type": "Microsoft.Storage/storageAccounts",
      "apiVersion": "2021-06-01",
      "name": "[parameters('storageAccountName')]",
      "location": "[parameters('location')]",
      "sku": {
        "name": "Standard_LRS"
      },
      "kind": "StorageV2",
      "properties": {
        "accessTier": "Hot"
      }
    }
  ]
}
```

```bicep
param location string = resourceGroup().location
param storageAccountName string = 'toylaunch${uniqueString(resourceGroup().id)}'

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}
```

### Bicep vs. JSON

Both Bicep and JSON can be used to deploy a database. As the example above shows, Bicep is a lot more concise and simpler to read.  Here's an example of a JSON file to deploy a database:

```json
{
  "type": "Microsoft.Sql/servers",
  "apiVersion": "2021-11-01-preview",
  "name": "string",
  "location": "string",
  "tags": {
    "tagName1": "tagValue1",
    "tagName2": "tagValue2"
  },
  "identity": {
    "type": "string",
    "userAssignedIdentities": {}
  },
  "properties": {
    "administratorLogin": "string",
    "administratorLoginPassword": "string",
    "administrators": {
      "administratorType": "ActiveDirectory",
      "azureADOnlyAuthentication": "bool",
      "login": "string",
      "principalType": "string",
      "sid": "string",
      "tenantId": "string"
    },
    "federatedClientId": "string",
    "keyId": "string",
    "minimalTlsVersion": "string",
    "primaryUserAssignedIdentityId": "string",
    "publicNetworkAccess": "string",
    "restrictOutboundNetworkAccess": "string",
    "version": "string"
  }
}
```

Now, compare it to a Bicep file:

```bicep
resource symbolicname 'Microsoft.Sql/servers@2021-11-01-preview' = {
  name: 'string'
  location: 'string'
  tags: {
    tagName1: 'tagValue1'
    tagName2: 'tagValue2'
  }
  identity: {
    type: 'string'
    userAssignedIdentities: {}
  }
  properties: {
    administratorLogin: 'string'
    administratorLoginPassword: 'string'
    administrators: {
      administratorType: 'ActiveDirectory'
      azureADOnlyAuthentication: bool
      login: 'string'
      principalType: 'string'
      sid: 'string'
      tenantId: 'string'
    }
    federatedClientId: 'string'
    keyId: 'string'
    minimalTlsVersion: 'string'
    primaryUserAssignedIdentityId: 'string'
    publicNetworkAccess: 'string'
    restrictOutboundNetworkAccess: 'string'
    version: 'string'
  }
}
```

As you can see, the Bicep file is easier to read and use. You can also install the Bicep extension for Visual Studio Code to create your Bicep files, as the editor provides rich intellisense, and syntax validation.

### Deploying an Azure SQL Database using Bicep with PowerShell

You can easily create an Azure SQL Database using Bicep and PowerShell.  A single database has a defined set of compute, memory, IO, and storage resources using one of two purchasing models. When you create a single database, you also define a server to manage it and place it within Azure resource group in a specified region.  Below is the respective Bicep file.

The Bicep file used in this quickstart is from [Azure Quickstart Templates](https://azure.microsoft.com/resources/templates/sql-database/). 

```Bicep
@description('The name of the SQL logical server.')
param serverName string = uniqueString('sql', resourceGroup().id)

@description('The name of the SQL Database.')
param sqlDBName string = 'SampleDB'

@description('Location for all resources.')
param location string = resourceGroup().location

@description('The administrator username of the SQL logical server.')
param administratorLogin string

@description('The administrator password of the SQL logical server.')
@secure()
param administratorLoginPassword string

resource sqlServer 'Microsoft.Sql/servers@2021-08-01-preview' = {
  name: serverName
  location: location
  properties: {
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
  }
}

resource sqlDB 'Microsoft.Sql/servers/databases@2021-08-01-preview' = {
  parent: sqlServer
  name: sqlDBName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
}

```

To deploy this file, save it as main.bicep on your local computer and run the following commands in PowerShell.

```Azure PowerShell
New-AzResourceGroup -Name exampleRG -Location eastus
New-AzResourceGroupDeployment -ResourceGroupName exampleRG -TemplateFile ./main.bicep -administratorLogin "<admin-login>"
```

## Source control for templates

ARM templates and Bicep files are an example of infrastructure as code. Since all hardware resources are abstracted behind a set of APIs, your entire infrastructure can just be another component of your application code. Just like application or database code, it's important to protect and version this code. In addition to the internal version in the template, your source control system should version your templates. 

In most cases, the database administrator won't be writing their own template from scratch. You may either build them from the Azure portal or using a template from the [quickstart templates](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.sql/sql-database) that are provided by Microsoft on GitHub. 

The image below shows how to create a SQL Database from a template on GitHub.

:::image type="content" source="../media/module-66-automation-final-02.png" alt-text="Screenshot of the GitHub Azure Quickstart Template page.":::

Select **Deploy to Azure**, and you'll need to log into the Azure portal.

:::image type="content" source="../media/module-66-automation-final-03.png" alt-text="Screenshot of the Create a SQL Server and database page on Azure based on the quickstart template.":::

If you select **Edit template**, you'll see the JSON defining the template, which would allow you to change the values to meet your requirements.

After providing the required parameters in the deployment screen, select **Review + create** to deploy your template.
