As your deployment complexity grows, you may want to move to a modular approach to deploying resources using Azure Resource Manager (ARM) [linked or nested templates](https://docs.microsoft.com/azure/azure-resource-manager/templates/linked-templates?WT.mc_id=MSLearn-ARM-pierrer). Linked templates are a way to breakdown your deployment into many related templates, and then deploy them together through a main template.

There are 2 ways of modularizing your deployment

## Nested template

Nesting template refers to the act of embedding template syntax within a main template. 

:::code language="json" source="../Code/nestedtemplatesample.json" highlight="7-17":::

When using a nested template, you can specify whether template expressions are evaluated within the scope of the parent template or the nested template. The scope determines how parameters, variables, and functions like resourceGroup and subscription are resolved.

## Linked template

Linking templates refer to the act of connected separate template files, referenced by a link from a main template.  Unlike the last unit, When referencing a linked template, you cannot use a local file or a file that is only available on your local network. You must provide a URI value that downloadable as http or https. Azure Resource Manager must be able to access the template. You can place your linked template in a storage account, and use the URI for that item. Or, use a Github repo to store your templates.

:::code language="json" source="../Code/linkedtemplatesample.json" highlight="8-15":::

Just like local templates you can use parameter in the same manner. Either thought a parameter file of using inline parameters.

:::code language="json" source="../Code/linked-inline-param.json" highlight="12-14":::

The related templates can be separate files or template syntax that are embedded within the main template.   This article uses the term linked template to refer to a separate template file that is referenced via a link from the main template. It uses the term nested template to refer to embedded template syntax within the main template.

For small to medium solutions, a single template is easier to understand and maintain. You can see all the resources and values in a single file. For advanced scenarios, linked templates enable you to break down the solution into targeted components. You can easily reuse these templates for other scenarios
