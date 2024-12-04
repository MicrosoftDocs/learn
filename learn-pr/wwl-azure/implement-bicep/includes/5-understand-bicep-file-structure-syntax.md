Azure Bicep comes with its own syntax, however, it's easy to understand and follow. We won't go deep into the syntax and structure, but let's review the main concepts using an example.

## Sample Bicep `.bicep` file

```Bicep
@minLength(3)
@maxLength(11)
param storagePrefix string

param storageSKU string = 'Standard_LRS'
param location string = resourceGroup().location

var uniqueStorageName = '${storagePrefix}${uniqueString(resourceGroup().id)}'

resource stg 'Microsoft.Storage/storageAccounts@2019-04-01' = {
    name: uniqueStorageName
    location: location
    sku: {
        name: storageSKU
    }
    kind: 'StorageV2'
    properties: {
        supportsHttpsTrafficOnly: true
    }

    resource service 'fileServices' = {
        name: 'default'

        resource share 'shares' = {
            name: 'exampleshare'
        }
    }
}

module webModule './webApp.bicep' = {
    name: 'webDeploy'
    params: {
        skuName: 'S1'
        location: location
    }
}

output storageEndpoint object = stg.properties.primaryEndpoints
```

## Scope

By default the target scope of all templates is set for `resourceGroup`, however, you can customize it by setting it explicitly. As other allowed values, `subscription`, `managementGroup`, and `tenant`.

## Parameters

You've already used the parameters in the previous unit. They allow you to customize your template deployment at run time by providing potential values for names, location, prefixes, etc.

Parameters also have types that editors can validate and also can have default values to make them optional at deployment time. Additionally, you can see they can have validation rules to make the deployment more reliable by preventing any invalid value right from the authoring. For more information, see [Parameters in Bicep](/azure/azure-resource-manager/bicep/parameters/).

## Variables

Similar to parameters, variables play a role in making a more robust and readable template. Any complex expression can be stored in a variable and used throughout the template. When you define a variable, the type is inferred from the value.

In the above example, the `uniqueStorageName` is used to simplify the resource definition. For more information, see [Variables in Bicep](/azure/azure-resource-manager/bicep/variables/).

## Resources

The `resource` keyword is used when you need to declare a resource in your templates. The resource declaration has a symbolic name for the resource that can be used to reference that resource later either for defining a subresource or use its properties for an implicit dependency like a parent-child relationship.

There are certain properties that are common for all resources such as `location`, `name`, and `properties`. There are resource-specific properties that can be used to customize the resource pricing tier, `SKU`, and so on.

You can define subresources within a resource or outside by referencing the parent. In the above example, a file share is defined within the storage account resource. If the intention was to define the resource outside of it, you would need to change your template:

```Bicep
resource storage 'Microsoft.Storage/storageAccounts@2021-02-01' = {
    name: 'examplestorage'
    location: resourceGroup().location
    kind: 'StorageV2'
    sku: {
        name: 'Standard_LRS'
    }
}

resource service 'Microsoft.Storage/storageAccounts/fileServices@2021-02-01' = {
    name: 'default'
    parent: storage
}

resource share 'Microsoft.Storage/storageAccounts/fileServices/shares@2021-02-01' = {
    name: 'exampleshare'
    parent: service
}
```

For more information, see [Resource declaration in Bicep](/azure/azure-resource-manager/bicep/resource-declaration/).

## Modules

If you want truly reusable templates, you can't avoid using a module. Modules enable you to reuse a Bicep file in other Bicep files. In a module, you define what you need to deploy, and any parameters needed and when you reuse it in another file, all you need to do is reference the file and provide the parameters. The rest is taken care of by Azure Bicep.

In the above example, you're using a module that presumably is deploying an `App Service`. For more information, see [Using Modules in Bicep](/azure/azure-resource-manager/bicep/modules/).

## Outputs

You can use outputs to pass values from your deployment to the outside world, whether it is within a CI/CD pipeline or in a local terminal or *Cloud Shell*. That would enable you to access a value such as storage endpoint or application URL after the deployment is finished.

All you need is the `output` keyword and the property you would like to access:

```Cloud Shell
output storageEndpoint endpoints = stg.properties.primaryEndpoints

```

To find more information, see [Outputs in Bicep](/azure/azure-resource-manager/bicep/outputs/).

## Other features

There are many other features available within a Bicep file such as loops, conditional deployment, multiline strings, referencing an existing cloud resource, and many more. In fact, any valid function within an ARM template is also valid within a Bicep file.

## Next steps

In the next unit, you'll learn how to use Bicep in an Azure Pipeline.
