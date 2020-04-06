### What are Azure resource manager templates (ARM)

Azure Resource Manager (ARM) templates are a JavaScript Object Notation (JSON) file that defines the infrastructure and configuration for your deployment. The template uses a declarative syntax. Declarative syntax is a way of building the structure and elements that outlines what resources will look like without describing its control flow.  Unlike imperative syntax that uses commands for the computer to perform. Imperative scripting focuses on specifying each steps in deploying the resources.

ARM templates allow you state what you intend to deploy without having to write the sequence of programming commands to create it.  In the template, you specify the resources to deploy and the properties for those resources, then the [Azure Resource Manager](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/overview) uses that information to deploys the resources in an organized and consistent manner.

#### Benefits of using ARM Templates

Using ARM templates allows you to automate deployments and use the practice of infrastructure as code (IaC). The ARM code becomes part of your infrastructure and development projects. Just like application code, you can store the IaC files in a source repository such as [Azure Repos](https://azure.microsoft.com/en-us/services/devops/repos/) and version it.

Any one on your team can leverage the templates you build in order to deploy similar environments (dev, test, UAT, prod...) in exactly the same way, ensuring consistency.

Other benefits to name a few are:

- **Orchestration**: Unlike a script, You don't have to worry about the order of operations. The Azure Resource Manager orchestrates the deployment of the resources so they're created in the correct order and when possible, in parallel so your deployments finish faster than scripted  deployments.

    ![Template Processing](../media/template-processing.png)

- **Built-in validation**: Your template has to pass validation before starting the deployment. Azure Resource Manager checks the template before starting the deployment to make sure the deployment will succeed. Unlike a script that may run halfway and stop in a half-finished state.


- **Modular**: You can break your templates into smaller, reusable components and link them together at deployment time. You can also nest one or multiple templates inside another templates.
- **Tracked deployments**: In the Azure portal, you can review your deployment history and get information about the state of the deployment. You can see all the parameter values passed in, and any output values.
- **CI/CD integration**: You can integrate templates into continuous integration and continuous deployment (CI/CD) tools like [Azure Pipelines](https://azure.microsoft.com/en-us/services/devops/pipelines/), which can automate your release pipelines for fast and reliable application and infrastructure updates. By using Azure DevOps and ARM template tasks, you can continuously build and deploy your projects.


### Template file structure
When writing an ARM template you need to understand all the parts that makes up the template and what they do. In the template files (JSON), you will notice that these files are made up of the following elements:

- Schema
- ContentVersion
- apiProfile
- Parameters
- Variables
- Functions
- Resources
- Outputs

Each of these section serves a very defined purpose.

#### Schema
| Required | Description |
|:--- |:--- |
|Yes |Location of the JSON schema file that describes the version of the template language. The version number you use depends on the scope of the deployment and your JSON editor.<br><br>If you're using [VS Code with the Azure Resource Manager tools extension](use-vs-code-to-create-template.md), use the latest version for resource group deployments:<br>`https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#`<br><br>Other editors (including Visual Studio) may not be able to process this schema. For those editors, use:<br>`https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#`<br><br>For subscription deployments, use:<br>`https://schema.management.azure.com/schemas/2018-05-01/subscriptionDeploymentTemplate.json#`<br><br>For management group deployments, use:<br>`https://schema.management.azure.com/schemas/2019-08-01/managementGroupDeploymentTemplate.json#`<br><br>For tenant deployments, use:<br>`https://schema.management.azure.com/schemas/2019-08-01/tenantDeploymentTemplate.json#` |

#### contentVersion
| Required | Description |
|:--- |:--- |
|Yes |Version of the template (such as 1.0.0.0). You can provide any value for this element. Use this value to document significant changes in your template. When deploying resources using the template, this value can be used to make sure that the right template is being used. |

### apiProfile
| Required | Description |
|:--- |:--- |
|No | An API version that serves as a collection of API versions for resource types. Use this value to avoid having to specify API versions for each resource in the template. When you specify an API profile version and don't specify an API version for the resource type, Resource Manager uses the API version for that resource type that is defined in the profile.<br><br>The API profile property is especially helpful when deploying a template to different environments, such as Azure Stack and global Azure. Use the API profile version to make sure your template automatically uses versions that are supported in both environments. For a list of the current API profile versions and the resources API versions defined in the profile, see [API Profile](https://github.com/Azure/azure-rest-api-specs/tree/master/profile).<br><br>For more information, see [Track versions using API profiles](templates-cloud-consistency.md#track-versions-using-api-profiles). |
#### Parameters
| Required | Description |
|:--- |:--- |
|No |Values that are provided when deployment is executed to customize resource deployment. |
#### Variables
| Required | Description |
|:--- |:--- |
|No |Values that are used as JSON fragments in the template to simplify template language expressions. |
#### User-defined functions
| Required | Description |
|:--- |:--- |
|No |User-defined functions that are available within the template. |
#### Resources
| Required | Description |
|:--- |:--- |
|Yes |Resource types that are deployed or updated in a resource group or subscription. |
#### Output
| Required | Description |
|:--- |:--- |
|No |Values that are returned after deployment. |


### Deployment methods

#### AzureCLI & Powershell

#### Azure Portal

#### 



----

### References

