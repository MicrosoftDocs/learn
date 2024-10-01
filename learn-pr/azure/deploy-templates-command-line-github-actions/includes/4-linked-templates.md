As the complexity of your deployment grows, you might want to move to a modular approach to deploying resources by using Azure Resource Manager (ARM) [linked or nested templates](/azure/azure-resource-manager/templates/linked-templates?azure-portal=true). Linked and nested templates are ways to break down your deployment into many related templates, and then deploy them together through a main template.

## Linked template

*Linked template* refers to the act of connecting separate template files, referenced by a link from a main template. Linked templates allow you to create reusable, composable, and modular deployments that comprise many individual ARM templates.

When you're referencing a linked template, you must provide a URI value that's accessible over HTTP or HTTPS. Unlike our last unit, where we could use a local file as a template.

To use linked templates, you must first stage the templates on a publicly accessible endpoint such as GitHub or Azure Blob Storage. Use an Azure storage account secured by a shared access signature (SAS) token to keep your templates secure from public access.

To add a linked template to your ARM template, add a `Microsoft.Resources/deployments` resource and the `templateLink` property configured with the location of the template.

:::code language="json" source="../code/6-linked-template-sample.json" highlight="10-13,21-28,40-43":::

If needed, you can also pass parameter values into the linked template and get output from the linked template at deployment time. Parameters can be passed either through a parameter file or through inline parameters.

:::code language="json" source="../code/linked-inline-param.json" highlight="11-13":::

For small to medium solutions, a single template is easier to understand and maintain. You can see all the resources and values in a single file. For advanced scenarios, linked templates enable you to break down the solution into targeted components. You can easily reuse these templates for other scenarios.

## Nested template

*Nested template* refers to the act of embedding template syntax within a main template. Nested templates allow for advanced deployment scenarios like deploying to multiple Azure Resource Manager scopes or multiple resource groups from a single template file. Unlike linked templates, where each template is stored in its own template files, nested templates allow you to store many individual templates in one file. There are several reasons why you might want to use this template structure, such as when you're deploying resources to multiple resource groups or deployment scopes.

:::code language="json" source="../code/nestedtemplatesample-update.json" highlight="19-30":::

When you're using a nested template, you can specify whether template expressions are evaluated within the scope of the parent template or the nested template. The scope determines how parameters, variables, and functions like `resourceGroup` and `subscription` are resolved.