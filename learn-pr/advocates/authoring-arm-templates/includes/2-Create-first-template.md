ARM templates are a JavaScript Object Notation (JSON) files that defines the infrastructure and configuration for your deployment. The template uses a declarative syntax. The declarative syntax is a way of building the structure and elements that outline what resources will look like without describing its control flow. Declarative syntax is different than imperative syntax, which uses commands for the computer to perform. Imperative scripting focuses on specifying each step in deploying the resources.

ARM templates allow you declare what you intend to deploy without having to write the sequence of programming commands to create it.  In a template, you specify the resources and the properties for those resources, then the [Azure Resource Manager](https://docs.microsoft.com/azure/azure-resource-manager/management/overview) uses that information to deploys the resources in an organized and consistent manner.

## Benefits of using ARM Templates

Using ARM templates allows you to automate deployments and use the practice of infrastructure as code (IaC). The ARM code becomes part of your infrastructure and development projects. Just like application code, you can store the IaC files in a source repository such as [Azure Repos](https://azure.microsoft.com/services/devops/repos/) and version it.

Any one on your team can leverage the templates you build in order to deploy similar environments (dev, test, UAT, prod...) in exactly the same way, ensuring consistency.

Other benefits, to name a few, are:

- **Idempotent**: Templates are idempotent, which means you can deploy the same template many times and get the same resource types in the same state

- **Orchestration**: Unlike a script, You don't have to worry about the order of operations. The Azure Resource Manager orchestrates the deployment of the resources so they're created in the correct order and when possible, in parallel so your deployments finish faster than scripted  deployments.

    ![Template Processing](../media/template-processing.png)

- **Built-in validation**: Your template has to pass validation before starting the deployment. Azure Resource Manager checks the template before starting the deployment to make sure the deployment will succeed. Unlike a script that may run halfway and stop in a half-finished state.


- **Modular**: You can break your templates into smaller, reusable components and link them together at deployment time. You can also nest one or multiple templates inside another templates.

- **Tracked deployments**: In the Azure portal, you can review your deployment history and get information about the state of the deployment. You can see all the parameter values passed in, and any output values.

- **CI/CD integration**: You can integrate templates into continuous integration and continuous deployment (CI/CD) tools like [Azure Pipelines](https://azure.microsoft.com/services/devops/pipelines/), which can automate your release pipelines for fast and reliable application and infrastructure updates. By using Azure DevOps and ARM template tasks, you can continuously build and deploy your projects.


## Template file structure
When writing an ARM template, you need to understand all the parts that makes up the template and what they do. In the template files (JSON), you will notice that these files are made up of the following elements:

- Schema
- ContentVersion
- apiProfile
- Parameters
- Variables
- Functions
- Resources
- Outputs

Each of the section serves a defined purpose.

The **schema** is a required section that defines the location of the JSON schema file that describes the structure of JSON data. The version number you use depends on the scope of the Understand the structure and syntax of ARM templates documentation.deployment and your JSON editor.  you can find more information on what schema you should use in the [Understand the structure and syntax of ARM templates](https://docs.microsoft.com/azure/azure-resource-manager/templates/template-syntax) documentation.

The **contentVersion** is a required section that defines the version of your template (such as 1.0.0.0). It allows you to provide any value for this element. You can use this value to document significant changes in your template and therefore can help you ensure you're deploying the right template.

the **apiProfile** section is an optional section, that defines a collection of API versions for resource types.  You can use this value to avoid having to specify API versions for **each resource** in the template. When you specify an API profile version and don't specify an API version for the resource type, Resource Manager uses the API version for that resource type that is defined in the profile.

The **parameters** section is an optional section, where you define the values that are provided when deployment is executed to customize resource deployment.  These values can be provided by a parameter file, by command-line parameters or in the portal.  Depending on your deployment mechanism.

The **variables** section is an optional section, where you define values that are used to simplify template language expressions. These variables can be constructed by modifying, or processing parameters and/or other strings with several template functions.

The **functions** section is an optional section, where you can define [User-defined functions](https://docs.microsoft.com/azure/azure-resource-manager/templates/template-user-defined-functions) that are available within the template. User-defined functions are separate from the standard template functions that are automatically available within your template. You can create your own functions when you have complicated expressions that are used repeatedly in your template.

The **Resources** is a required section that defines the actual items you want to deploy or you want to update in a resource group or a subscription. These resources can be a virtual network, a virtual machine, a storage account...  the list of resource provider can be found [here](https://docs.microsoft.com/azure/azure-resource-manager/management/azure-services-resource-providers).

Finally, the **output** section is another optional section where you specify the values that will be returned at the end of the deployment.
