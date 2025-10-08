**Azure Bicep** comes with its own syntax. However, it's easy to understand and follow. We won't go deep into the syntax and structure, but let's review the main concepts using an example.

## Sample Bicep file

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

The **scope** defines the subscription or management level that you're deploying to. You can choose from a `subscription`, `resourceGroup`, `managementGroup`, and `tenant`. In the sample file, the target scope is a **resource group**, which is the default deployment scope.

**Available scopes:**

- **Resource group:** Default scope for most deployments.
- **Subscription:** For resources that need subscription-level access.
- **Management group:** For enterprise-scale deployments.
- **Tenant:** For tenant-wide configurations.

## Parameters

**Parameters** are used to make templates more reusable by supplying values during deployment. If you look at the sample file, you'll find `storagePrefix`, `storageSKU`, and `location`, all of which are used later in the file.

**Parameters** can have default values to simplify the process. In the sample file, the `location` defaults to the location of the target resource group.

### Decorators

In addition to default values, **decorators** are used to provide extra control over the usage of the **parameters**. An example is the `allowed` decorator, which restricts certain values from being supplied. **Bicep** also supports other common decorators such as `maxLength`, `minLength`, `maxValue`, and `minValue`.

**Common decorators:**

- **@allowed:** Restricts values to a specific list.
- **@minLength / @maxLength:** Enforces string length constraints.
- **@minValue / @maxValue:** Enforces numeric range constraints.
- **@description:** Documents the parameter purpose.
- **@secure:** Marks sensitive values like passwords.

## Variables

Like any other programming language, **variables** are also supported in **Bicep**. They provide simple name-value pairs with global scopes, which means they're accessible anywhere in the **Bicep** file.

**Variables** help:

- Avoid repetition in templates.
- Calculate values based on parameters.
- Improve template readability.

## Resources

Now comes the essential part of the template: the **resource**. This is where you define the **Azure** resources to be deployed or modified as part of the deployment process. In the sample file, the resource block deploys a **storage account** with **file services** and a **file share** as child resources.

### Parent-child relationships

With child resources being displayed differently from the **JSON** templates, it becomes easier to understand the parent-child relationships in the resource groups and deployment. In the sample template, you can see that the **file service** and **file share** are defined as children of the **storage account**, creating a clear hierarchy.

**Child resource syntax:**

```bicep
resource parent 'Microsoft.Provider/type@version' = {
  name: 'parentName'

  resource child 'childType' = {
    name: 'childName'
  }
}
```

### Conditional deployment

Defining resources with **Bicep** also supports conditions. You can deploy resources conditionally based on parameter values or other conditions.

**Conditional syntax:**

```bicep
resource conditionalResource 'type@version' = if (condition) {
  // resource definition
}
```

## Modules

To improve code reusability and manageability, you can refer to another **Bicep** template as a **module**. Just like any other resource, you can add a condition to a **module**, which will evaluate to true before deploying it.

> [!NOTE] > **Modules** allow you to reuse code from a **Bicep** file in other **Bicep** files. A **module** is a **Bicep** file that's deployed from another **Bicep** file.

**Module syntax:**

```bicep
module moduleName 'path/to/module.bicep' = {
  name: 'deploymentName'
  params: {
    parameterName: parameterValue
  }
}
```

**Benefits of modules:**

- Code reuse across multiple templates.
- Simplified maintenance and updates.
- Logical separation of infrastructure components.
- Easier testing and validation.

## Outputs

**Outputs** are used to return values from a deployment, such as hostnames or IP addresses. These will be returned once a deployment is complete.

**Output syntax:**

```bicep
output outputName string = resourceName.properties.hostname
```

**Common uses for outputs:**

- Return connection strings.
- Retrieve resource IDs for use in other deployments.
- Get dynamically assigned values like IP addresses.
- Pass values to subsequent deployment stages.

## Using modules in practice

If you want truly reusable templates, you can't avoid using a **module**. **Modules** enable you to reuse a **Bicep** file in other **Bicep** files. In a **module**, you define what you need to deploy and any parameters needed. When you reuse it in another file, all you need to do is reference the file and provide the parameters. The rest is taken care of by **Azure Bicep**.

In the sample file, you're using a **module** that presumably is deploying a web app (`webModule`). The **module** references `./webApp.bicep` and passes parameters like `skuName` and `location`.

For more information, see [Using Modules in Bicep](/azure/azure-resource-manager/bicep/modules/).

## Working with outputs

You can use **outputs** to pass values from your deployment to the outside world, whether it is within a **CI/CD pipeline** or in a local terminal or **Cloud Shell**. This enables you to access values such as storage endpoints or application URLs after the deployment is finished.

All you need is the `output` keyword and the property you would like to access:

```bicep
output storageEndpoint object = stg.properties.primaryEndpoints
```

In the sample file, the output returns the **primary endpoints** of the deployed **storage account**, which includes blob, file, queue, and table endpoints.

To find more information, see [Outputs in Bicep](/azure/azure-resource-manager/bicep/outputs/).

## Other features

There are many other features available within a **Bicep** file such as:

- **Loops:** Iterate over arrays to create multiple resources.
- **Conditional deployment:** Deploy resources based on conditions.
- **Multiline strings:** Define long strings across multiple lines.
- **Existing resources:** Reference existing **Azure** resources.
- **Functions:** Any valid function within an **ARM template** is also valid within a **Bicep** file.

## Next steps

In the next unit, you'll learn how to deploy **Bicep** files using **Azure Pipelines**.
