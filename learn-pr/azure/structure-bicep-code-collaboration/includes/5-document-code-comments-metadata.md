Good Bicep code is _self-documenting_. This means that it uses clear naming and a good structure so that when colleagues read your code, they can quickly understand what's happening. If they need to make changes, they can be confident they're modifying the right places.

In some situations, though, you might need to clarify certain code by adding extra documentation to your Bicep files. Also, after your template is deployed and resources have been created in Azure, it's important that anyone who looks at your Azure environment understands what each resource is and what it's for.

In this unit, you'll learn how to add comments to your Bicep files and how to use resource tags to add metadata to your Azure resources. This additional documentation gives your colleagues insights into what your code does, the logic you used to write the code, and the purpose of your Azure resources.

## Add comments to your code

Bicep allows you to add _comments_ to your code. Comments are human-readable text that documents your code but is ignored when the file is deployed to Azure.

Bicep supports two types of comments:

- **Single-line comments** start with a double slash (`//`) character sequence, and continue to the end of the line, as shown here:

  ::: code language="bicep" source="code/5-comments.bicep" range="1-10" highlight="1, 7" :::

- **Multi-line comments** use the `/*` and `*/` character sequences to surround the comment, and can span multiple lines, as shown here:

  ::: code language="bicep" source="code/5-comments.bicep" range="12-15" :::

> [!TIP]
> Avoid using comments for obvious and clear parts of your code. Having too many comments actually reduces your code's readability. Also, it's easy to forget to update comments when your code changes in the future. Focus on documenting unique logic and complex expressions.

You can also use Bicep comments to add a structured multi-line block at the beginning of each file. Think of it as a _manifest_. Your team might decide that each template and module should have a manifest that describes the purpose of the template and what it contains, such as in this example:

```bicep
/*
  SYNOPSIS: Module for provisioning Azure SQL server and database.
  DESCRIPTION: This module provisions an Azure SQL server and a database, and configures the server to accept connections from within Azure.
  VERSION: 1.0.0
  OWNER TEAM: Website
*/
```

### Add comments to parameter files

Parameter files allow you to create a JSON file to specify a set of parameter values for your deployment. The parameter values need to match the parameters that are declared in the Bicep template.

The values that you specify in parameter files also often benefit from being documented. It's a good practice to add comments to parameter files when you work with parameter values that might not be immediately clear to someone reading the file.

For example, your website's Bicep template might include a parameter for the URL to access your company's product stock API so that your website can display whether your toys are in stock in your warehouse. The URLs to access the stock API for each environment aren't easy to understand, so they're a good candidate for a comment:

::: code language="json" source="code/5-parameters.jsonc" highlight="6" :::

> [!TIP]
> When you work with parameter files and other JSON files that include comments, you usually need to use the _.jsonc_ file extension instead of _.json_. This helps Visual Studio Code and other tools understand that comments are allowed.

## Add descriptions to parameters, variables, and outputs

When you create a parameter, variable, or output, you can apply the `@description()` decorator to help explain its purpose:

::: code language="bicep" source="code/5-descriptions.bicep" highlight="1, 4, 7" :::

Descriptions are more powerful than comments because, when someone uses the Visual Studio Code extension for Bicep, the descriptions are shown whenever someone hovers over a symbolic name. Also, when someone uses your Bicep file as a module, they'll see the descriptions you apply to your parameters.

## Add descriptions to resources

It can also be helpful to add descriptions to the resources that you define. You can apply the `@description()` decorator to resources, too.

Additionally, some resources support adding descriptions or other human-readable information into the resource itself. For example, many Azure Policy resources and Azure role-based access control (RBAC) role assignments include a description property, like this:

::: code language="bicep" source="code/5-role-assignment-description.bicep" highlight="8" :::

It's a good idea to use this property to explain why you've created each role assignment. The description is deployed to Azure with the resource, so anyone who audits your Azure environment's RBAC configuration will immediately understand the purpose of the role assignment.

## Apply resource tags

Comments in your Bicep file don't appear anywhere in your deployed resources. They're there only to help you document your Bicep files. However, there are many situations where you need to track information about your deployed Azure resources, including:

- Allocating your Azure costs to specific cost centers.
- Understanding how the data that's contained in databases and storage accounts should be classified and protected.
- Recording the name of the team or person who's responsible for management of the resource.
- Tracking the name of the environment that the resource relates to, such as production or development.

Resource _tags_ allow you to store important metadata about resources. You define resource tags in your Bicep code, and Azure stores the information with the resource when it's deployed:

::: code language="bicep" source="code/5-tags.bicep" range="5-21" highlight="4-9" :::

You can query a resource's tags by using tools such as Azure PowerShell and the Azure CLI, and you can see tags on the Azure portal:

:::image type="content" source="../media/5-tags-portal.png" alt-text="Screenshot of the Azure portal for a storage account, showing the location of tags." border="true":::

It's common to use the same set of tags for all your resources, so it's often a good idea to define your tags as parameters or variables, and then reuse them on each resource:

```bicep
param tags object = {
  CostCenter: 'Marketing'
  DataClassification: 'Public'
  Owner: 'WebsiteTeam'
  Environment: 'Production'
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  tags: tags
}

resource appServiceApp 'Microsoft.Web/sites@2020-06-01' = {
  tags: tags
}
```
