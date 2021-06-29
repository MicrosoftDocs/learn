Bicep gives you a lot of flexibility to decide how you structure your code. You can organize your template in the way you like and apply your own style.

So far we managed to break down our template into reusable artifacts. In this unit, we'll continue to refactor the code and optimize the structure of templates and modules. We'll also revisit some key pointers from the original template review.

## Choose your authoring style

Your Bicep templates can contain many **elements**:

- parameters (with or without default values)
- variables
- resources (including syntaxes for conditional and iterative deployments)
- modules (also with conditional and iterative deployments, or deployments to different scopes)
- outputs (with an option of iterative syntax)
- target scope for the entire template

As a declarative language that doesn't come with a strict schema, **these elements can be written in any order**. During the deployment, when your Bicep file is compiled to a Resource Manager template, all the elements will be placed according to the JSON schema.

There are **two authoring styles** used in the community. You and your team should agree on one and use it consistently:

### All element types grouped together

- our original template follows this style
- easy to adopt if you have a prior experience with Resource Manager templates
- for bigger templates it can be challenging to navigate and jump between the elements

  > [!TIP]
  > To overcome this challenge you can use built-in features in VS Code like "Go to Definition", "Find All References", or "Peak Definition".

### All elements belonging to one resource grouped together

- exceptions are common elements like the `location` parameter in our template. Those common elements should be placed together, ideally at the top of the Bicep file.
- it can simplify navigation

In our project, we'll use the first style. *Practically it means we won't need to make many structural changes.*

## Choose free-form vs. known configurations

One of the goals is to design and author a reusable and flexible infrastructure code. You don't want to have single-purpose templates with hardcoded configuration. On the other hand, exposing all resource properties as parameters can be problematic too.

There are two common approaches you can choose from:

### Free-form configuration

- provides maximum flexibility and many variations
- all resource properties are made available as parameters, allowing the user to provide all input values
- makes it difficult to exclude incorrect combinations and apply input validations

  > [!TIP]
  > Having potentially dozens of parameters in a template can be overwhelming. This could be simplified by grouping related parameters together in form of a parameter object. This will however reduce your ability to validate provided inputs.

### Known configuration

- also known as *T-shirt sizing*
- allows you to select from a set of defined configurations based on size, criticality, or environment type
- offers lower flexibility but delivers tested and validated configurations
- it also abstracts more complexity from end users, for example a domain-specific knowledge
- it's easier to support, test, and troubleshoot

If we wanted to use the second approach for our template, instead of exposing all the capacity details for the `serverFarm` resource, we could introduce two "sizes":

| Environment  | Specification  |
|---------|---------|
|Production     | P2V3 SKU and three worker nodes        |
|Test     | S2 SKU and one worker node        |

To implement this change, we would:

1. Create a new `environment` parameter with two allowed values,
2. Add a `webFarmSizing` variable that would hold both configuration options, and
3. Update the `sku` property in the `hostingPlan` resource.

The following code snippet shows how such implementation could look like:

```bicep
@description('Select what environment you want to provision. Allowed values are Production and Test')
@allowed([
  'Production'
  'Test'
])
param environment string = 'Test'

var webFarmSizing = {
  Production: {
    name: 'P2V3'
    capacity: 3
  }
  Test: {
    name: 'S2'
    capacity: 1
  }
}

...

resource hostingPlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: hostingPlanName
  location: location
  sku: webFarmSizing[environment]
}
```

## Make your Bicep code dynamic

Whatever approach you prefer, you still want to **avoid hardcoding values directly** in resources declaration, which would make parts of your code less reusable. *You could still consider it for values that don't change frequently.*

In our template, most of the properties are defined dynamically with the following exception:

::: code language="bicep" source="code/2-template.bicep" range="44-49" :::

Let's quickly fix it by introducing a new parameter and referencing its value:

```bicep
param sqlSkuName string = 'Basic'

resource sqlserverName_databaseName 'Microsoft.Sql/servers/databases@2020-08-01-preview' = {
  name: '${sqlserver.name}/${databaseName}'
  location: location
  sku: {
    name: sqlSkuName
  }
```

For many properties you'll need to create **complex expressions**, concatenate several values, and use built-in functions. It's a good practice to create these expressions as variables and reference them in other parts of your code like resources and modules.

A good example from our template is the value of `DefaultConnection` property:

::: code language="bicep" source="code/2-template.bicep" range="91-99" :::

Let's look how the code would look like after we refactor it to follow the recommendation:

```bicep
var dbConnectionString = 'Data Source=tcp:${sqlserver.properties.fullyQualifiedDomainName},1433;Initial Catalog=${databaseName};User Id=${sqlAdministratorLogin}@${sqlserver.properties.fullyQualifiedDomainName};Password=${sqlAdministratorLoginPassword};'

resource webSiteConnectionStrings 'Microsoft.Web/sites/config@2020-06-01' = {
  name: '${webSite.name}/connectionstrings'
  properties: {
    DefaultConnection: {
      value: dbConnectionString
      type: 'SQLAzure'
    }
  }
}
```

## Apply consistent naming convention

A naming [convention](https://en.wikipedia.org/wiki/Naming_convention_(programming)) is a set of rules for choosing the character sequence to be used for identifiers and other entities in source code and documentation. There are many commonly used conventions, for example:

|Name  |Example for 'SKU Name' variable  |
|---------|---------|
| Camel case     | `skuName`        |
| Pascal case     | `SkuName`        |
| Snake case     | `sku_name`        |
| Flat case     | `skuname`        |
| Train case     | `Sku-Name`        |

While choosing a naming convention is a matter of personal preference, it's important to agree on one standard within your team and use it consistently! Also make sure you use **descriptive names** that aren't ambiguous.

### Symbolic names

> [!IMPORTANT]
> All symbolic names (identifiers) must be unique within one Bicep template. In Resource Manager templates it is possible to have both a parameter and a variable called `location`. You would reference them using functions - `[parameters('location')]` and `[variables('location')]`. This is not possible in Bicep.

The most commonly used convention in Resource Manager templates and inherently Bicep files is **Camel case**. Let's say we decided to use it in our project. When inspecting the original template, there are three identifiers we need to rename to have one standard in our code:

| Line  | Description  | Old name  | New name  |
|---------|---------|---------|---------|
| 17     | Parameter for SQL Server SKU name       | `skuName`        | `sqlServerSkuName`        |
| 20     | Parameter for SQL Server SKU capacity        | `skuCapacity`        | `sqlServerSkuCapacity`        |
| 56     | Symbolic name for SQL firewall rule(s)        | `sqlserverName_AllowAllWindowsAzureIps`        | `sqlServerAllowAllIps`        |
| 106     | Symbolic name for Role assignment        | `roleassignment`        | `roleAssignment`        |
| 116     | Symbolic name for Application Insights        | `AppInsights_webSiteName`        | `appInsights`        |

> [!IMPORTANT]
> When renaming identifiers, you need to make sure you rename them consistently in all parts of your template.

Visual Studio Code offers a convenient way to **rename symbols**:

1. Select the identifier,
2. Press the F2 key,
3. Provide a new name,
4. Confirm the change by pressing Enter

:::image type="content" source="../media/4-rename-symbol.png" alt-text="Screenshot from VS Code showing how to rename a symbol." border="false":::

This action will rename not only the identifier but also all references!

### Resource names

In the previous chapter, we addressed the naming convention of identifiers but there's another important area: **naming convention of resources**. Almost every resource type has certain naming [rules and restrictions](/azure/azure-resource-manager/management/resource-name-rules).

Many organizations define their own naming convention that works for them. There's a specific [guidance](/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging) in the **Cloud Adoption Framework** for Azure (CAF) that can help you define yours.

Following the naming convention can become a complex problem, especially since you can't rename your resource post deployment. A **well-written Bicep template should hide this complexity** from its users and handle it internally.

There are two common patterns that can be used (or even combined):

- using **parameter decorators** to limit and validate inputs from users
- using variables to construct resource names internally and using parameters to receive only parts of resource names. Typically a prefix or a suffix

In our template, there are several variables used to generate resource names, for example the `hostingPlanName` variable used for the `serverfarms` resource name:

```bicep
var hostingPlanName = 'hostingplan${uniqueString(resourceGroup().id)}'
```

> [!IMPORTANT]
> You should always check what rules apply to resources you have in your templates and ensure incorrect names won't break the deployment.

In this specific example, the `serverfarms` resource [requires](/azure/azure-resource-manager/management/resource-name-rules) its name must be:

- unique within the resource group,
- the length can be between 1-40 alphanumeric characters (with an option to use hyphens).

The variable above is a concatenation of `hostingplan` string and an autogenerated, [unique](/azure/azure-resource-manager/templates/template-functions-string), 13 characters long string, that is derived from the Resource Group ID.

Since the only dynamic part is the unique string, we're certain that it will always match the rules. If we wanted to allow users to influence how the final name looks like, we could introduce a new parameter for name prefix. We would use the `@maxLenght()` decorator to ensure the prefix won't exceed 27 characters and add the `@description()` decorator to provide additional information.

```bicep
@maxLength(27)
@description('Naming prefix for web farm resource. Only alphanumeric characters and hyphen are allowed. Max size is 27 characters.')
param hostingPlanNamePrefix string = 'hostingplan'

var hostingPlanName = '${hostingPlanNamePrefix}${uniqueString(resourceGroup().id)}'
```

> [!NOTE]
> Currently there isn't a possibility to use regular expressions to validate, if a parameter value only contains allowed characters. That is why it's sometimes better to fully control resource naming within the template.
