An Azure Resource Manager template contains a JSON-formatted definition of one or more Azure resources, along with parameters and variables that facilitate customizing their configuration.

In its simplest structure, a template has the following elements:

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "",
  "apiProfile": "",
  "parameters": {  },
  "variables": {  },
  "functions": [  ],
  "resources": [  ],
  "outputs": {  }
}
```

| Element name | Required | Description |
|--|--|--|
| $schema | Yes | Location of the JavaScript Object Notation (JSON) schema file that describes the version of the template language. The version number you use depends on the scope of the deployment and your JSON editor.<br><br>If you're using Visual Studio Code with the Azure Resource Manager tools extension, use the latest version for resource group deployments:<br>`https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#`<br><br>Other editors (including Visual Studio) might not be able to process this schema. For those editors, use:<br>`https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#`<br><br>For subscription deployments, use:<br>`https://schema.management.azure.com/schemas/2018-05-01/subscriptionDeploymentTemplate.json#`<br><br>For management group deployments, use:<br>`https://schema.management.azure.com/schemas/2019-08-01/managementGroupDeploymentTemplate.json#`<br><br>For tenant deployments, use:<br>`https://schema.management.azure.com/schemas/2019-08-01/tenantDeploymentTemplate.json#` |
| contentVersion | Yes | Version of the template (such as 1.0.0.0). You can provide any value for this element. Use this value to document significant changes in your template. When deploying resources using the template, this value can be used to make sure that the right template is being used. |
| apiProfile | No | An API version that serves as a collection of API versions for resource types. Use this value to avoid having to specify API versions for each resource in the template. When you specify an API profile version and don't specify an API version for the resource type, Resource Manager uses the API version for that resource type that's defined in the profile.<br><br>The API profile property is especially helpful when deploying a template to different environments, such as Azure Stack and global Azure. Use the API profile version to make sure your template automatically uses versions that are supported in both environments. For a list of the current API profile versions and the resources API versions defined in the profile, see [API Profile](https://github.com/Azure/azure-rest-api-specs/tree/master/profile).<br><br>For more information, see [Track versions using API profiles](/azure/azure-resource-manager/templates/template-cloud-consistency#track-versions-using-api-profiles). |
| [parameters](/azure/azure-resource-manager/templates/syntax#parameters) | No | Values that are provided when deployment is executed to customize resource deployment. |
| [variables](/azure/azure-resource-manager/templates/syntax#variables) | No | Values that are used as JSON fragments in the template to simplify template language expressions. |
| [functions](/azure/azure-resource-manager/templates/syntax#functions) | No | User-defined functions that are available within the template. |
| [resources](/azure/azure-resource-manager/templates/syntax#resources) | Yes | Resource types that are deployed or updated in a resource group or subscription. |
| [outputs](/azure/azure-resource-manager/templates/syntax#outputs) | No | Values that are returned after deployment. |

## Optional demo

- [Demonstration: Explore QuickStart templates](https://go.microsoft.com/fwlink/?linkid=2260572&clcid=0x409)
