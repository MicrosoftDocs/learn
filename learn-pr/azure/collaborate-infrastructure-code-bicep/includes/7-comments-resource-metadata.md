It's a recommended practice to document your code. You can use comments and other metadata in your Bicep files.

In the previous exercise, we refactored our Bicep template and made it more modular and reusable. Now we need to ensure our modules and the main template are **easy to understand** by other project collaborators.

In this unit, you'll learn how to add comments, metadata, and resource tags to your Bicep files. They can provide insights into what the code does and the logic that was used to write the code.

## Add comments to your code

Comments help with understanding the purpose and usage of Bicep templates but they're ignored when deploying them into Azure. You can either use `//` for single-line comments or `/* ... */` for multi-line comments.

> [!TIP]
> Avoid using comments to document obvious and clear parts of your code. Focus mainly on unique logic and complex expressions. Having too many comments could reduce code readability!

Our template doesn't include any comments yet. Let's try to **identify complex or unclear areas in our template**, where adding comments could improve the overall understanding:

|Element  | What to document  |
|---------|---------|
| `roleDefinitionId` parameter     | Explain what role name the default value represents |
| `userAssignedIdentities` property of the `webSite` resource     | Clarify this special syntax        |
| `msi` resource     | Explain its purpose        |
| `roleassignment` resource     | Explain the use of `guid` function and the requirement for name uniqueness       |

The following code snippet shows how you can apply comments:

```bicep
param roleDefinitionId string = 'b24988ac-6180-42a0-ab88-20f7382dd24c' // Default is Contributor role

...

resource webSite 'Microsoft.Web/sites@2020-06-01' = {
  name: webSiteName
  location: location
  tags: {
    'hidden-related:${hostingPlan.id}': 'empty'
    displayName: 'Website'
  }
  properties: {
    serverFarmId: hostingPlan.id
  }
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${msi.id}': {} // Must be in the format: managed identity ID as the key and an empty {} as the value!
    }
  }
}

...

/*
  User-assigned managed identity
  Purpose: Linked with the website, granted an RBAC role (Contributor by default) on the Resource Group level
*/
resource msi 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: managedIdentityName
  location: location
}

...

resource roleassignment 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
  name: guid(roleDefinitionId, resourceGroup().id) // Role assignment names must be GUIDs, using two inputs for the guid function to ensure uniqueness

  properties: {
    principalType: 'ServicePrincipal'
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', roleDefinitionId)
    principalId: msi.properties.principalId
  }
}

```

> [!NOTE]
> Comments are not transferred to ARM JSON template format during the compilation. It is recommended to treat those template as an _intermediate language_ you don't modify or even inspect (unless you need to troubleshoot something).

Another way of using comments is adding a structured multi-line block at the beginning of each file. Think of it as a **template manifest** you could agree within your team that each template or module should have.

Let's try to create such manifest at the top of our `azSQLBackend.bicep`:

```bicep
/*
  SYNOPSIS: Module for provisioning Az SQL server and db
  DESCRIPTION: This modules provisions Azure SQL server and a database, optionally with a firewall setting
  VERSION: 0.1.0
  COMPANY: A toy company
  NOTES: Created for Toy Story project
  PROJECT_TYPE:  External
*/

```

**Note:** such comment block is not recognized by Bicep language in any special way.

## Add metadata to declarations

One type of metadata you could use in Bicep is available for parameters as **decorators**. Decorators can attach constrains and metadata to a parameter. They must be placed above the parameter declaration you want to use it for.

You could either use the `@description` decorator (with a string value), or the `@metadata` decorator (where you can use more complex structure).

When we reviewed the original template, there were two parameters we renamed to bring more clarity. We can add a description to them as well:

```bicep
@description('A SKU name of an App Service hosting plan. Not a free text.')
param hostingPlanSkuName string = 'F1'

@description('Number of instances for the hosting plan. Min 1, max XX')
@minValue(1)
param hostingPlanSkuCapacity int = 1
```

> [!CAUTION]
> If you used `metadata` objects in Resource Manager templates, please note that Bicep [doesn't support](https://github.com/Azure/bicep/issues/223) them, both inside resources declaration and as a top-level object. Try using comments instead.

## Apply resource tags

Comments and metadata aren't carried over to Azure, they only "live" in your infrastructure code. If you want to store some important metadata about your resources as part of their state in Azure, you can use **resource tags**.

Resource tags are key-value pairs and you can have up to 50 of them in your resources, resource groups, and subscriptions. They help you organize your resources by adding valuable metadata to them, for example:

- cost distribution into cost pools / cost centers
- data classification / security zone
- environment type (Dev, Test, Production)

Tags aren't available for classic resources, and there's a few [limitations](/azure/azure-resource-manager/management/tag-resources?tabs=json#limitations) around what characters can be used for tag names and values. Also, not all resource types support tags in Resource Manager model.

> [!TIP]
> Tags are not automatically inherited from Resource Groups to resources. You could consider using [Azure Policies](/azure/azure-resource-manager/management/tag-resources?tabs=json#inherit-tags) to enable it, but defining tags in templates keeps the configuration declarative and it comes from a single source.

In our original template, there are only two resources with tags, declared independently, and a bit cryptic:

```bicep

resource webSite 'Microsoft.Web/sites@2020-06-01' = {
  location: location
  tags: {
    'hidden-related:${hostingPlan.id}': 'empty'
    displayName: 'Website'
  }
...
}

resource AppInsights_webSiteName 'Microsoft.Insights/components@2018-05-01-preview' = {
  tags: {
    'hidden-link:${webSite.id}': 'Resource'
    displayName: 'AppInsightsComponent'
  }
...
}
```

In our project, we want to ensure that we **use tags consistently** in our deployments. There are several ways to declare tags. The most consistent approach is to use a parameter and reference the same tags across all your resources.

We could modify our template and:

- declare a new parameter as an object in the main template. _Let's add two tags in the beginning._
- add `tags` property to all resources in the main template and refer the new parameter
- add a new `resourceTags` parameter to modules (extend their contract)
- add `tags` property to all resources in modules and refer to the new parameter

Updated **mainTemplate.bicep** (extract):

```bicep
...

param resourceTags object = {
  Environment: 'Test'
  Project: 'Octopus'
}

...

resource msi 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: managedIdentityName
  location: location
  tags: resourceTags
}

module backend 'azSQLBackend.bicep' = {
  name: 'sqlBackendDeployment'
  params: {
    location: location
    sqlAdministratorLogin: sqlAdministratorLogin
    sqlAdministratorLoginPassword: sqlAdministratorLoginPassword
    tags: resourceTags
  }
}

```

Example of updated **azSQLBackend.bicep** (extract):

```bicep
param location string = resourceGroup().location
param sqlAdministratorLogin string
param resourceTags object

@secure()
param sqlAdministratorLoginPassword string

var sqlserverName = 'sqlserver${uniqueString(resourceGroup().id)}'
var databaseName = 'sampledb'

...

resource sqlserver 'Microsoft.Sql/servers@2019-06-01-preview' = {
  name: sqlserverName
  location: location
  tags: resourceTags
  properties: {
    administratorLogin: sqlAdministratorLogin
    administratorLoginPassword: sqlAdministratorLoginPassword
    version: '12.0'
  }
}

...

```
