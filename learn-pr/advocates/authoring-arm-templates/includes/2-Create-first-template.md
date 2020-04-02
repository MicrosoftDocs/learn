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

#### Schema

#### contentVersion

#### Parameters

#### Variables

#### User-defined functions

#### Resources

#### Output

### Deployment methods

#### AzureCLI & Powershell

#### Azure Portal

#### 



----

### References

