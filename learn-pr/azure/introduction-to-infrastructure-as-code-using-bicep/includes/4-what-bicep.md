Now that your team understands how Azure Resource Manager works, you decide to use ARM templates for your resource provisioning. You understand that you can write ARM templates in two different ways: by using JSON or by using Bicep. You want to learn more about Bicep templates so that you can make an informed decision about which language to use.

In this unit, you learn about the Bicep template language and the benefits it provides to template authoring.

## Bicep language

Bicep is a Resource Manager template language that's used to declaratively deploy Azure resources. Bicep is designed for a specific scenario or *domain*, which makes it a domain-specific language. Bicep isn't meant to be used as a standard programming language for writing applications. Bicep is used only to create Resource Manager templates. Bicep is intended to be easy to understand and straightforward to learn, regardless of your experience with other programming languages. All resource types, API versions, and properties are valid in Bicep templates.

> [!NOTE]
> If you previously looked into using JSON templates, you might have noticed that Bicep simplifies the template creation experience. It provides a syntax that's easier to understand, better support for modularity and reusable code, and improved type safety. Creating a JSON ARM template requires complicated expressions, and the final result might be verbose.

## Benefits of Bicep

Bicep provides many improvements over JSON for template authoring, including:

- **Simpler syntax**: Bicep provides a simpler syntax for writing templates. You can reference parameters and variables directly, without using complicated functions. String interpolation is used in place of concatenation to combine values for names and other items. You can reference the properties of a resource directly by using its symbolic name instead of complex reference statements. These syntax improvements help both with authoring and reading Bicep templates.

- **Modules**: You can break down complex template deployments into smaller module files and reference them in a main template. These modules provide easier management and greater reusability. You can even share your modules with your team.

- **Automatic dependency management**: In most situations, Bicep automatically detects dependencies between your resources. This process removes some of the work involved in template authoring.

- **Type validation and IntelliSense**: The Bicep extension for Visual Studio Code features rich validation and IntelliSense for all Azure resource type API definitions. This feature helps provide an easier authoring experience.

Take a look at the following example of a Bicep template that defines an Azure storage account. The template automatically generates the name of the storage account. After deployment, the resource ID is returned as output to the user who executes the template.

```bicep
param location string = resourceGroup().location
param namePrefix string = 'storage'

var storageAccountName = '${namePrefix}${uniqueString(resourceGroup().id)}'
var storageAccountSku = 'Standard_RAGRS'

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: storageAccountSku
  }
  properties: {
    accessTier: 'Hot'
    supportsHttpsTrafficOnly: true
  }
}

output storageAccountId string = storageAccount.id
```
