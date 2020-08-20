As your deployment complexity grows, you may want to move to a modular approach to deploying resources using Azure Resource Manager (ARM) [linked or nested templates](https://docs.microsoft.com/azure/azure-resource-manager/templates/linked-templates?WT.mc_id=MSLearn-ARM-pierrer). Linked templates are a way to breakdown your deployment into many related templates, and then deploy them together through a main template.

There are 2 ways of modularizing your deployment

## Linked template

Linking templates refer to the act of connected separate template files, referenced by a link from a main template.  They allow you to  create reusable, composable, and modular deployments comprised of many individual arm templates.

Unlike the last unit, When referencing a linked template, you cannot use a local file or a file that is only available on your local network. You must provide a URI value that downloadable as http or https.

To use linked templates, the templates must first be staged on a publicly accessible endpoint such as GitHub or an Azure Storage Blob. When using an Azure Storage account secured by a SAS token to keep your templates secure from public access.

To add a linked template to your ARM template, add a *Microsoft.Resources/deployments* resource and the templateLink property configured with the location of the template.

:::code language="json" source="../Code/linkedtemplatesample.json" highlight="8-15":::

If needed, you can also pass parameter values into the linked template and get output out of the linked template at deployment time. Parameters can be passed either thought a parameter file of using inline parameters.

:::code language="json" source="../Code/linked-inline-param.json" highlight="12-14":::

For small to medium solutions, a single template is easier to understand and maintain. You can see all the resources and values in a single file. For advanced scenarios, linked templates enable you to break down the solution into targeted components. You can easily reuse these templates for other scenarios

## Nested template

Nesting template refers to the act of embedding template syntax within a main template. They allow for advanced deployments scenarios like deploying to multiple ARM scopes or multiple resource groups from a single template file. Unlike linked templates, where each template is stored in its own template files, nested templates allow you to store many individual templates in one file. There are several reasons where you might want to do this such as when deploying resources to multiple resource groups or deployment scopes.

:::code language="json" source="../Code/nestedtemplatesample.json" highlight="7-17":::

When using a nested template, you can specify whether template expressions are evaluated within the scope of the parent template or the nested template. The scope determines how parameters, variables, and functions like resourceGroup and subscription are resolved.
