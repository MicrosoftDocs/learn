By now, you're used to deploying Azure Resource Manager templates (ARM templates) to Azure by using Bicep or JSON. You create a template file, and then you submit it to Azure by creating a deployment. Azure Resource Manager orchestrates the creation or reconfiguration of your resources. 

When you work with template specs, you still send the template to Azure. But instead of deploying it, Azure saves it for you to use in the future. Then, you can go back later and tell Azure to deploy the template spec. You can even use the same template spec repeatedly to deploy more environments.

## Why use template specs?

At your toy company, you created lots of reusable templates, including:

| Template name | Description |
|-|-|
| Storage account |  Deploys a storage account and enforces Microsoft Entra authentication. |
| Cosmos DB account | Deploys an Azure Cosmos DB account with continuous backup enabled. |
| Virtual network | Deploys a virtual network that has the right configuration to peer with the main hub network. |
| Product launch website | Deploys an Azure App Service plan, app, and storage account for websites that feature product launches of new toys. |

Template specs are a great way to create a library of reusable ARM templates for common scenarios in your organization. An expert can build a template with a preconfigured resource or set of resources. That expert can then publish it as a template spec, enabling other people in the organization to deploy it. 

You can use template specs to ensure that the resources your team creates are configured according to your requirements. For example, you could publish a template spec like the storage account template we described earlier. Then, whenever anyone in your organization deploys your template spec, you can be sure that they create a storage account with the right authentication settings.

Template specs are stored within Azure, so you don't need to maintain shared template files yourself. You manage who can use and modify your template specs with Azure role-based access controls. Without template specs, you need to choose a storage location, like Azure Storage, to keep your template files. You also need to control access yourself.

::: zone pivot="biceppowershell,bicepcli"

### How do template specs compare to Bicep modules?

When you work with Bicep, you can create reusable _modules_ to define sets of resources in a single file. Template specs and Bicep modules are both ways of adding reusability to your templates, but they're optimized for different things:

* Template specs are designed to be deployable as a complete template. You can deploy template specs by using Azure portal and tooling like the Azure CLI and Azure PowerShell. Bicep modules are intended to be combined into a larger deployment. However, if you create a template spec, Bicep also enables you to use it as a module if you want.
* Template specs provide versioning and access control capabilities. You need to manage the versions and security for your Bicep code yourself.
* Template specs are stored in Azure as a resource. You need to store Bicep modules somewhere that you control, like a version control system such as Git, or your file system.
* Bicep modules retain all of the original Bicep code, including comments, symbolic names, and whitespace. When you create a template spec by using Bicep, your Bicep code is converted to JSON and some of this information is lost. So you need to keep the source Bicep file somewhere else as well.

When you're deciding between template specs and Bicep modules, a good rule of thumb is: if the template is going to be deployed as is throughout your organization, template specs are probably a good fit. But if you're likely to reuse this template within multiple parent templates, Bicep modules might serve your needs better.

::: zone-end

## How template specs work

A template spec is an Azure resource, just like a storage account or virtual machine. It must be created within a resource group, although the template itself can deploy resources to a subscription, management, or tenant scope.

When you work with template specs, you create two resources:

* The *template spec* is the container resource. It contains one or multiple versions.
* *Template spec versions* contain the actual template to deploy.

You work with template specs and versions by using their resource IDs. Here's an example resource ID for a template spec:

```
/subscriptions/f0750bbe-ea75-4ae5-b24d-a92ca601da2c/resourceGroups/SharedTemplates/providers/Microsoft.Resources/templateSpecs/StorageWithoutSAS
```

A version is a child resource of the template spec. It has a resource ID like this example:

```
/subscriptions/f0750bbe-ea75-4ae5-b24d-a92ca601da2c/resourceGroups/SharedTemplates/providers/Microsoft.Resources/templateSpecs/StorageWithoutSAS/versions/1.0
```

When you deploy a template spec, you need to specify the resource ID of the template spec version.

Here's an illustration of the workflow that you follow when you use template specs:

:::image type="content" source="../media/2-workflow.png" alt-text="Diagram that shows the workflow for using template specs." border="false":::

:::image type="icon" source="../media/callout-01.png"::: You create a template the way you're used to. There's nothing special about a template that you create for a template spec. You declare resources, create parameters and variables, use functions, and so forth.

:::image type="icon" source="../media/callout-02.png"::: When your template is ready, you create a template spec resource. You then publish your template to the template spec as a version. The tooling that you use to create template specs enables you to do these steps all in one operation. Your template spec is stored in Azure as a resource, after you publish it. You can view it, edit it, and control access to it just like any other Azure resource. You can publish your template spec from your local machine or from a deployment pipeline.

:::image type="icon" source="../media/callout-03.png":::  Whenever you want to deploy your template spec, you refer to the template spec version's resource ID from the deployment. You can deploy it to any resource group, or even to another subscription or scope. Azure reads the template spec and uses that as the template for the deployment.
