The Azure Container Registry service supports a set of built-in Azure roles that provide different levels of permissions to an Azure container registry. Use Azure role-based access control (Azure RBAC) to assign specific permissions to users, service principals, or other identities that need to interact with a registry, for example to pull or push container images. You can also define custom roles with fine-grained permissions to a registry for different operations.

| **Role/Permission** | **Access Resource Manager** | **Create/delete registry** | **Push image** | **Pull image** | **Delete image data** | **Change policies** |  **Sign images** |
| ------------------- | --------------------------- | -------------------------- | -------------- | -------------- | --------------------- | ------------------- | ---------------- |
| Owner               | X                           | X                          | X              | X              | X                     | X                   |                  |
| Contributor         | X                           | X                          | X              | X              | X                     | X                   |                  |
| Reader              | X                           |                            |                | X              |                       |                     |                  |
| AcrPush             |                             |                            | X              | X              |                       |                     |                  |
| AcrPull             |                             |                            |                | X              |                       |                     |                  |
| AcrDelete           |                             |                            |                |                | X                     |                     |                  |
| AcrImageSigner      |                             |                            |                |                |                       |                     | X                |

## Assign roles

You can use the Azure portal, Azure CLI, Azure PowerShell, or other Azure tools. When creating a service principal, you also configure its access and permissions to Azure resources such as a container registry.

## Differentiate users and services

Anytime permissions are applied, a best practice is to provide the most limited set of permissions for a person, or service, to accomplish a task. The following permission sets represent a set of capabilities that might be used by humans and headless services.

## CI/CD solutions

When automating docker build commands from CI/CD solutions, you need docker push capabilities. For these headless service scenarios, we recommend assigning the AcrPush role. This role, unlike the broader Contributor role, prevents the account from performing other registry operations or accessing Azure Resource Manager.

## Container host nodes

Likewise, nodes running your containers need the AcrPull role, but shouldn't require Reader capabilities.

## Visual Studio Code Docker extension

For tools like the Visual Studio Code Docker extension, additional resource provider access is required to list the available Azure container registries. In this case, provide your users access to the Reader or Contributor role. These roles allow docker pull, docker push, az acr list, az acr build, and other capabilities.

## Access Resource Manager

:::image type="content" source="../media/new-azure-resource-manager-requirement-641715a8.png" alt-text="Screenshot showing how to get a list of registries by using the Azure command line interface syntax.":::


## Custom roles

As with other Azure resources, you can create custom roles with fine-grained permissions to Azure Container Registry. Then assign the custom roles to users, service principals, or other identities that need to interact with a registry.

To determine which permissions to apply to a custom role, see the list of Microsoft.ContainerRegistry actions, review the permitted actions of the built-in ACR roles, or run the following command:

:::image type="content" source="../media/new-access-resource-manager-ce2407fe.png" alt-text="Screenshot showing how to access the Access Resource Manager using Azure command line interface commands.":::


## Example: Custom role to import images

For example, the following JavaScript Object Notation defines the minimum actions for a custom role that permits importing images to a registry.

:::image type="content" source="../media/new-custom-role-import-images-9499b140.png" alt-text="Screenshot showing how the JavaScript Object Notation defines the minimum actions for a custom role that permits importing images to a registry.":::


To create or update a custom role using the JavaScript Object Notation description, use the Azure command line interface, Azure Resource Manager template, Azure PowerShell, or other Azure tools. Add or remove role assignments for a custom role in the same way that you manage role assignments for built-in Azure roles.
