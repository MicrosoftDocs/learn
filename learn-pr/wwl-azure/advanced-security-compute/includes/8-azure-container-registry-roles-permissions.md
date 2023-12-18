The Azure Container Registry service supports a set of built-in Azure roles that provide different levels of permissions to an Azure container registry. Use Azure role-based access control (Azure RBAC) to assign specific permissions to users, service principals, or other identities that need to interact with a registry, for example to pull or push container images. You can also define custom roles with fine-grained permissions to a registry for different operations.

:::image type="content" source="../media/table-showing-azure-container-registry-roles-permissions-50daaf65.png" alt-text="Screenshot showing an example of Azure container registry role and permissions.":::


## Assign roles

See Steps to add a role assignment for high-level steps to add a role assignment to an existing user, group, service principal, or managed identity. You can use the Azure portal, Azure CLI, Azure PowerShell, or other Azure tools.

When creating a service principal, you also configure its access and permissions to Azure resources such as a container registry.

## Differentiate users and services

Anytime permissions are applied, a best practice is to provide the most limited set of permissions for a person, or service, to accomplish a task. The following permission sets represent a set of capabilities that might be used by humans and headless services.

## CI/CD solutions

When automating docker build commands from CI/CD solutions, you need docker push capabilities. For these headless service scenarios, we recommend assigning the AcrPush role. This role, unlike the broader Contributor role, prevents the account from performing other registry operations or accessing Azure Resource Manager.

## Container host nodes

Likewise, nodes running your containers need the AcrPull role, but shouldn't require Reader capabilities.

## Visual Studio Code Docker extension

For tools like the Visual Studio Code Docker extension, additional resource provider access is required to list the available Azure container registries. In this case, provide your users access to the Reader or Contributor role. These roles allow docker pull, docker push, az acr list, az acr build, and other capabilities.

## Access Resource Manager

:::image type="content" source="../media/azure-access-resource-manager-1e0e04df.png" alt-text="Screenshot showing how to access the Access Resource Manager using Azure CLI commands.":::


## Custom roles

As with other Azure resources, you can create custom roles with fine-grained permissions to Azure Container Registry. Then assign the custom roles to users, service principals, or other identities that need to interact with a registry.

To determine which permissions to apply to a custom role, see the list of Microsoft.ContainerRegistry actions, review the permitted actions of the built-in ACR roles, or run the following command:

:::image type="content" source="../media/azure-cli-custom-roles-operation-show-4acc8eb1.png" alt-text="Screenshot showing Azure CLI commands to use to determine which permissions to apply to a custom role.":::


## Example: Custom role to import images

For example, the following JSON defines the minimum actions for a custom role that permits importing images to a registry.

:::image type="content" source="../media/azure-json-custom-role-import-images-ce376cb9.png" alt-text="Screenshot showing how JSON defines the minimum actions for a custom role that permits importing images to a registry.":::


To create or update a custom role using the JSON description, use the Azure CLI, Azure Resource Manager template, Azure PowerShell, or other Azure tools. Add or remove role assignments for a custom role in the same way that you manage role assignments for built-in Azure roles.
