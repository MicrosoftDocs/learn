
When a user sends a request from any of the Azure tools, APIs, or SDKs, Resource Manager receives the request. It authenticates and authorizes the request. Resource Manager sends the request to the Azure service, which takes the requested action. Because all requests are handled through the same API, you see consistent results and capabilities in all the different tools.

The following image shows the role Azure Resource Manager  plays in handling Azure requests.

:::image type="content" source="../media/consistent-management-layer.png" alt-text="Resource Manager request model showing how Azure tools, APIs, or SDKs, interact with Azure Resource Manager.":::

## Why choose Azure Resource Manager templates?

If you're trying to decide between using Azure Resource Manager templates and one of the other infrastructure as code services, consider the following advantages of using templates:

* **Declarative syntax**: Azure Resource Manager templates allow you to create and deploy an entire Azure infrastructure declaratively. For example, you can deploy not only virtual machines, but also the network infrastructure, storage systems, and any other resources you may need.

* **Repeatable results**: Repeatedly deploy your infrastructure throughout the development lifecycle and have confidence your resources are deployed in a consistent manner. Templates are idempotent, which means you can deploy the same template many times and get the same resource types in the same state. You can develop one template that represents the desired state, rather than developing lots of separate templates to represent updates.

* **Orchestration**: You don't have to worry about the complexities of ordering operations. Resource Manager orchestrates the deployment of interdependent resources so they're created in the correct order. When possible, Resource Manager deploys resources in parallel so your deployments finish faster than serial deployments. You deploy the template through one command, rather than through multiple imperative commands.

## Template file

Within your template, you can write template expressions that extend the capabilities of JSON. These expressions make use of the [functions](/azure/azure-resource-manager/templates/template-functions) provided by Resource Manager.

The template has the following sections:

* [Parameters](/azure/azure-resource-manager/templates/parameters) - Provide values during deployment that allow the same template to be used with different environments.

* [Variables](/azure/azure-resource-manager/templates/variables) - Define values that are reused in your templates. They can be constructed from parameter values.

* [User-defined functions](/azure/azure-resource-manager/templates/user-defined-functions) - Create customized functions that simplify your template.

* [Resources](/azure/azure-resource-manager/templates/resource-declaration) - Specify the resources to deploy.

* [Outputs](/azure/azure-resource-manager/templates/outputs) - Return values from the deployed resources.

