Bicep is a rich and concise declarative language that you can use to specify resources to create in an Azure subscription. The Azure Developer CLI creates Bicep files when it deploys .NET solutions to Azure. You can edit those files to customize your deployment.

In your outdoor equipment retailer, you want to add extra Azure resources to the deployed eShop .NET Aspire solution. You also want those files to be managed in version control with your C# code files and the rest of the code base.

In this unit, you'll learn how to customize and control the Bicep files that Azure Developer CLI creates to alter your deployments.

## Why use Bicep files?

Bicep is a text file format that defines a declarative syntax for deploying Azure resources. By writing Bicep files, you can define a complete Azure infrastructure with multiple connected resources, such as virtual machines, containers, Azure Functions, Azure Monitor resources, and many other types of object. Bicep has a concise syntax, safe types, and supports code reuse.

Your Bicep files define a consistent infrastructure that is created in an Azure subscription. You can use them to ensure that testing, staging, and deployment environments are consistent. As text files, they define infrastructure as code and can be stored in your version control system.

You can also use Bicep files to integrate the resources for your .NET Aspire solution into a larger Azure infrastructure.

## Create Bicep files

Bicep is a text file format so you can create files with any text editor. Both Visual Studio and Visual Studio Code have extensions for Bicep. When you use these extensions, you get intellisense and syntax checking. However, you'll need a good understanding of the infrastructure your solution requires.

The completed .NET Aspire solution defines all the resources it needs in C# code files. Instead of writing Bicep files manually, you can use the Azure Developer CLI to automatically create Bicep from your solution. Use these commands:

```azd
azd config set alpha.infraSynth on
azd init
azd infra synth
```

The command generates these files:

- _infra/main.bicep_: This file defines the main entry point for the deployment.
- _infra/main.parameters.json_: This file stores environment variables.
- _infra/resources.bicep_: This file defines all the Azure resources to deploy, except the microservice containers.
- _manifests/*.yaml_: These files define a container app for each microservice in your .NET Aspire solution.

## Bicep format

In a Bicep file, you use the `param` keyword to define parameters. You can use each parameter multiple times in the resources you create. You use the `resource` keyword to create Azure resources, such as Log Analytics workspaces and Azure Container Apps environments.

As an example, here's the start of the _resources.bicep_ file the Azure Developer CLI creates for the Aspire Starter template. It starts by defining the `location` and `principalId` parameters and goes on to create managed identity and container registry resources:

```bicep
@description('The location used for all deployed resources')
param location string = resourceGroup().location
@description('Id of the user or app to assign application roles')
param principalId string = ''

@description('Tags that will be applied to all resources')
param tags object = {}

var resourceToken = uniqueString(resourceGroup().id)

resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: 'mi-${resourceToken}'
  location: location
  tags: tags
}

resource containerRegistry 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: replace('acr-${resourceToken}', '-', '')
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: true
  }
  tags: tags
}
```

Use Visual Studio, Visual Studio Code, or your preferred text editor to customize these Bicep files before deployment.

## Using a modified Bicep file in a deployment

When you have completed your customized Bicep files, use the following commands to provision and deploy your .NET Aspire solution:

```azd
azd provision
azd deploy
```

## Using custom Bicep templates

You've seen that you can use the `azd infra synth` command to generate the Bicep files necessary to deploy a .NET Aspire app. You can then modify those Bicep files to alter the deployment. But you can also intervene in the creation of Bicep files earlier, during coding by linking to a Bicep file in the app host project.

Consider the following Bicep file, which creates an Azure Storage account:

```bicep
param storageName string
param location string = resourceGroup().location

resource myStorageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageName
  location: location
  kind: 'StorageV2'
  sku:{
    name:'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    accessTier: 'Hot'
  }
}

output endpoint string = myStorageAccount.properties.primaryEndpoints.blob
```

The Bicep accepts a string parameter named `storageName` and uses it to name the new account. It also returns a string that contains a path to the Blob storage endpoint for the new account.

By adding the following code to the app host's _Program.cs_ file, you can ensure that a storage account is created when you deploy your .NET Aspire solution:

```csharp
var storage = builder.AddBicepTemplate(
    name: "storage",
    bicepFile: "../infra/storage.bicep")
	.WithParameter("storageName", "eShopStorage");

var endpoint = storage.GetOutput("endpoint");

var apiService = builder.AddProject<Projects.AspireSample_ApiService>(name: "apiservice")
    .WithEnvironment("STORAGE_ENDPOINT", endpoint);
```

In the above code, notice that:

- The `bicepFile` value specifies the location of the Bicep file relative to the app host project.
- You pass a value a named parameter in the Bicep file by using the `.WithParameter()` extension method.
- You retrieve output from the Bicep file by using the `GetOutput()` method.
- In this example, the output is the blob endpoint for the new storage account and this endpoint is passed as an environment variable to the API service.

## Learn more

- [What is Bicep?](/azure/azure-resource-manager/bicep/overview)
- [Understand the structure and syntax of Bicep files](/azure/azure-resource-manager/bicep/file)
- [Generate Bicep from .NET Aspire project model](/dotnet/aspire/deployment/azure/aca-deployment-azd-in-depth#generate-bicep-from-net-aspire-project-model)
- [Use custom Bicep templates](/dotnet/aspire/deployment/azure/custom-bicep-templates)
