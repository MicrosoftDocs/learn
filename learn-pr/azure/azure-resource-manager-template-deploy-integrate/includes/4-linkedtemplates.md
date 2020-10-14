As your deployment complexity grows, you may want to move to a modular approach to deploying resources using Azure Resource Manager (ARM) [linked or nested templates](https://docs.microsoft.com/azure/azure-resource-manager/templates/linked-templates?azure-portal=true). Linked and nested templates are ways to breakdown your deployment into many related templates, and then deploy them together through a main template.

## Linked template

Linking templates refer to the act of connecting separate template files, referenced by a link from a main template. They allow you to create reusable, composable, and modular deployments comprised of many individual arm templates.

When referencing a linked template, you must provide a URI value that would be accessible over HTTP or HTTPS, unlike our last unit where we could use a local file.

To use linked templates, the templates must first be staged on a publicly accessible endpoint such as GitHub or an Azure Storage Blob. When using an Azure Storage account secured by a SAS token to keep your templates secure from public access.

To add a linked template to your ARM template, add a *Microsoft.Resources/deployments* resource and the *templateLink* property configured with the location of the template.

:::code language="json" source="../Code/6-Linked-template-sample.json" highlight="10-13,21-28,40-43":::

If needed, you can also pass parameter values into the linked template and get output out of the linked template at deployment time. Parameters can be passed either thought a parameter file of using inline parameters.

:::code language="json" source="../Code/linked-inline-param.json" highlight="11-13":::

For small to medium solutions, a single template is easier to understand and maintain. You can see all the resources and values in a single file. For advanced scenarios, linked templates enable you to break down the solution into targeted components. You can easily reuse these templates for other scenarios

## Nested template

Nested template refers to the act of embedding template syntax within a main template. They allow for advanced deployments scenarios like deploying to multiple ARM scopes or multiple resource groups from a single template file. Unlike linked templates, where each template is stored in its own template files, nested templates allow you to store many individual templates in one file. There are several reasons where you might want to do this such as when deploying resources to multiple resource groups or deployment scopes.

:::code language="json" source="../Code/nestedtemplatesample-update.json" highlight="19-30":::

When using a nested template, you can specify whether template expressions are evaluated within the scope of the parent template or the nested template. The scope determines how parameters, variables, and functions like resourceGroup and subscription are resolved.
