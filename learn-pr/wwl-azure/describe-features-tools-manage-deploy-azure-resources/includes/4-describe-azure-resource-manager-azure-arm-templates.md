Azure Resource Manager (ARM) is the deployment and management service for Azure. It provides a management layer that enables you to create, update, and delete resources in your Azure account. Anytime you do anything with your Azure resources, ARM is involved.

When a user sends a request from any of the Azure tools, APIs, or SDKs, ARM receives the request. ARM authenticates and authorizes the request. Then, ARM sends the request to the Azure service, which takes the requested action. You see consistent results and capabilities in all the different tools because all requests are handled through the same API.

:::image type="content" source="../media/arm-request-flow.png" alt-text="Diagram showing the Azure Resource Manager request flow from tools like Azure Portal, CLI, and SDKs through ARM authentication and orchestration to Azure services like Compute, Networking, and Storage, with Infrastructure as Code options including ARM Templates and Bicep.":::

## Azure Resource Manager benefits

With Azure Resource Manager, you can:

 -  Manage your infrastructure through declarative templates rather than scripts. A Resource Manager template is a JSON file that defines what you want to deploy to Azure.
 -  Deploy, manage, and monitor all the resources for your solution as a group, rather than handling these resources individually.
 -  Re-deploy your solution throughout the development life-cycle and have confidence your resources are deployed in a consistent state.
 -  Define the dependencies between resources, so they're deployed in the correct order.
 -  Apply access control to all services because RBAC is natively integrated into the management platform.
 -  Apply tags to resources to organize your subscription and support cost reporting.

The following video provides an overview of Azure Resource Manager.

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=d257e6ec-abab-47f4-a209-22049e7a40b4]

## Infrastructure as code

Infrastructure as code (IaC) means managing infrastructure through code and templates instead of manual configuration. At a fundamentals level, this can start with Azure CLI or Azure PowerShell and grow into repeatable environment deployments by using ARM templates and Bicep.

### ARM templates

ARM templates describe desired Azure resources in declarative JSON. Azure validates the template before deployment, then orchestrates resource creation in the right order and in parallel when possible. Teams define the desired end state, and ARM handles deployment execution.

Templates can also call PowerShell or Bash deployment scripts when setup steps are needed before or after resource creation.

### Benefits of using ARM templates

ARM templates provide several key benefits:

 -  **Declarative syntax**: Define what to deploy instead of writing step-by-step deployment commands.
 -  **Repeatable results**: Reuse the same template across environments for consistent outcomes.
 -  **Orchestration**: ARM handles dependency order and parallel deployment automatically.
 -  **Modularity**: Split templates into reusable components and nested templates.
 -  **Extensibility**: Add deployment scripts when additional setup actions are required.

### Bicep

Bicep is a declarative language for deploying Azure resources through ARM. Compared to JSON ARM templates, Bicep is generally simpler and more concise.

Benefits of Bicep include:

 -  **Support for current Azure resources**: Bicep tracks Azure resource types and API versions.
 -  **Simple syntax**: Bicep is easier to read and write than equivalent JSON templates.
 -  **Repeatable deployments**: Bicep files are idempotent for consistent lifecycle deployments.
 -  **Built-in orchestration**: ARM handles dependencies and parallel deployment execution.
 -  **Modularity**: Reuse logic by organizing deployments into Bicep modules.

