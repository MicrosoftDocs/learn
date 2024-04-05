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

Azure Resource Manager access is required for the Azure portal and registry management with the Azure command line interface. For example, to get a list of registries by using the az acr list command, you need this permission set.

## Create and delete registry

The ability to create and delete Azure container registries.

## Push image

The ability to docker pull a non-quarantined image, or pull another supported artifact such as a Helm chart, from a registry. Requires authentication with the registry using the authorized identity.

## Delete image data

The ability to delete container images, or delete other supported artifacts such as Helm charts, from a registry.

## Change policies

The ability to configure policies on a registry. Policies include image purging, enabling quarantine, and image signing.

## Sign images

The ability to sign images, usually assigned to an automated process, which would use a service principal. This permission is typically combined with push image to allow pushing a trusted image to a registry.

## Custom roles

As with other Azure resources, you can create custom roles with fine-grained permissions to Azure Container Registry. Then assign the custom roles to users, service principals, or other identities that need to interact with a registry.
