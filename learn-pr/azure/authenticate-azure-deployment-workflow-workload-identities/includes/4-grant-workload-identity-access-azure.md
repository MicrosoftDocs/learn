By itself, a workload identity can't do anything in your Azure environment. It's just like how a user can't work with your Azure resources unless they're authorized to do so. In this unit, you'll learn how to authorize workload identities to deploy and configure Azure resources, while avoiding granting unnecessary permissions.

## Workload identity authorization

Until now, you've focused on what workload identities are and how they can be used to prove the identity of a deployment workflow to Microsoft Entra ID. This is all about _authentication_.

After Microsoft Entra ID has authenticated a workload identity, the next question becomes: what can this workload identity do? This is the concept of _authorization_. It's the responsibility of the Azure role-based access control (RBAC) system, sometimes called identity and access management (IAM). By using Azure RBAC, you can grant a workload identity access to a specific resource group, subscription, or management group.

> [!NOTE]
> Everything you're doing here is using the Azure RBAC system to grant access to create and manage Azure resources, like your storage accounts, Azure App Service plan, and virtual networks. Microsoft Entra ID also has its own role system, which is sometimes called _directory roles_. You use these roles to grant permissions for workload identities to manage Microsoft Entra ID. This module doesn't discuss this subject in depth, but be aware that the term _role_ can be used for both situations in some documentation.

## Select the right role assignment for your workflow

A role assignment has three key parts: who the role is assigned to (the _assignee_), what they can do (the _role_), and which resource or resources the role assignment applies to (the _scope_).

### Assignee

When you work with a workload identity, you assign roles for it. To assign a role, you need to first create a _service principal_, which enables you to grant your application roles in Azure. After you create the service principal, you can continue to work with the application registration's application ID.

::: zone pivot="cli"

To create a service principal, use the `az ad sp create` command and specify the application registration's app ID:

```azurecli
az ad sp create --id b585b740-942d-44e9-9126-f1181c95d497
```

::: zone-end

::: zone pivot="powershell"

To create a service principal, use the `New-AzADServicePrincipal` cmdlet and specify the application registration's app ID:

```azurepowershell
New-AzADServicePrincipal -AppId b585b740-942d-44e9-9126-f1181c95d497
```

::: zone-end

### Role

It can be a little more work to figure out which role to assign. In Azure, there are a few common roles:

- **Reader**: Allows the assignee to read information about resources but not modify or delete them.
- **Contributor**: Allows the assignee to create resources, and to read and modify existing resources. However, contributors can't grant other principals access to resources.
- **Owner**: Allows full control over resources, including granting other principals access.

> [!CAUTION]
> Grant workload identities only the minimum permissions that they need to do their jobs. Most of the time, the Owner role is too permissive for a deployment workflow.

There are also many specific roles that provide access to a subset of functionality. You can even create your own _custom role definition_ to specify the exact list of permissions that you want to assign.

> [!NOTE]
> Custom role definitions can be a powerful way to grant permissions for your Azure resources, but they can be difficult to work with. It's not always easy to determine exactly which permissions you need to add to a custom role definition. You might accidentally make the role definitions too restrictive or too permissive.
>
> If you're not sure what to do, it's best to use one of the built-in role definitions. Custom role definitions are beyond the scope of this module.

### Scope

You need to determine how broadly you assign the role. This decision affects the number of resources that the workload identity can modify. Common scopes include:

- **Single resource**: You can grant access to a specific resource. Typically, deployment workflows don't use this scope because a workflow creates resources that don't exist yet, or it reconfigures multiple resources.
- **Resource group**: You can grant access to all resources within a resource group. Contributors and Owners can also create resources within the group. This is a good option for many deployment workflows.
- **Subscription**: You can grant access to all resources within a subscription. If you have multiple applications, workloads, or environments in a single subscription, you can grant permissions to the subscription's scope. This is usually too permissive for a deployment workflow, though. You should instead consider scoping your role assignments to resource groups, unless your deployment workflow needs to create resource groups.

Remember that role assignments are inherited. If you assign a role at a subscription, the assignee will have access to every resource group and resource inside that subscription.

### Selecting the right role assignment

Now that you understand the components of a role assignment, you can decide the appropriate values for your scenarios. Here are some general guidelines to consider:

> [!div class="checklist"]
>
> - Use the least permissive role that you can. If your workflow is only going to deploy basic Bicep files and won't manage role assignments, don't use the Owner role.
> - Use the narrowest scope that you can. Most workflows only need to deploy resources to a resource group, so they shouldn't be given subscription-scoped role assignments.
> - For many workflows, a good default option for a role assignment is the Contributor role on the resource group scope.
> - Consider everything your workflow does, and everything it might do in the future. For example, you might consider creating a custom role definition for your website's deployment workflow and grant permissions for only App Service and Application Insights. Next month, you might need to add an Azure Cosmos DB account to your Bicep file, but the custom role will block Azure Cosmos DB resources from being created.
>
>   Instead, it's often better to use a built-in role, or a combination of built-in roles, to avoid having to repeatedly change your role definitions. Consider using Azure Policy to enforce your governance requirements for allowed services, SKUs, and locations.
> - Test the workflow to verify that the role assignment works.

### Mixing and matching role assignments

You can create multiple role assignments that provide different permissions at different scopes. For example, you might assign a workload identity the role of Reader with a scope of the entire subscription. And you might separately assign the same workload identity the role of Contributor for a specific resource group. When the workload identity tries to work with the resource group, the more permissive assignment is applied.

### Working with multiple environments

You probably work with multiple environments, like development, test, and production environments for your applications. The resources for each environment should be deployed to different resource groups or subscriptions.

You should create separate workload identities for each environment. Grant each workload identity the minimum set of permissions that it needs for its deployments. Be especially careful to avoid mixing permissions for production deployments with permissions for deployments to non-production environments.

## Create a role assignment for a workload identity

::: zone pivot="cli"

To create a role assignment for a workload identity, use the `az role assignment create` command. You need to specify the assignee, role, and scope:

```azurecli
az role assignment create \
  --assignee b585b740-942d-44e9-9126-f1181c95d497 \
  --role Contributor \
  --scope "/subscriptions/f0750bbe-ea75-4ae5-b24d-a92ca601da2c/resourceGroups/ToyWebsite" \
  --description "The deployment workflow for the company's website needs to be able to create resources within the resource group."
```

Let's look at each argument:

- `--assignee` specifies the workload identity. You can specify this in several ways, but using the application ID is a good practice because it avoids ambiguity.
- `--role` specifies the role. If you use a built-in role, you can specify it by name. If you use a custom role definition, specify the full role definition ID.
- `--scope` specifies the scope. This is usually a resource ID for a single resource, a resource group, or a subscription.
- `--description` is a human-readable description of the role assignment.

::: zone-end

::: zone pivot="powershell"

To create a role assignment for a workload identity, use the `New-AzRoleAssignment` cmdlet. Specify the assignee, role, and scope:

```azurepowershell
New-AzRoleAssignment `
  -ApplicationId b585b740-942d-44e9-9126-f1181c95d497 `
  -RoleDefinitionName Contributor `
  -Scope '/subscriptions/f0750bbe-ea75-4ae5-b24d-a92ca601da2c/resourceGroups/ToyWebsite' `
  -Description "The deployment workflow for the company's website needs to be able to create resources within the resource group."
```

Let's look at each argument:

- `-ApplicationId` specifies the workload identity's application registration ID.
- `-RoleDefinitionName` specifies the name of a built-in role. If you use a custom role definition, specify the full role definition ID by using the `-RoleDefinitionId` argument instead.
- `-Scope` specifies the scope. This is usually a resource ID for a single resource, a resource group, or a subscription.
- `-Description` is a human-readable description of the role assignment.

::: zone-end

> [!TIP]
> It's a good practice to provide a justification for your role assignments by specifying a description. A description helps anyone who reviews the role assignments later to understand their purpose, and to understand how you decided on the assignee, role, and scope.

> [!NOTE]
> Role assignments can take a few minutes to become active.

## Grant access by using Bicep

Role assignments are Azure resources. This means that you can create a role assignment by using Bicep. You might do this if you initialize your resource groups by using Bicep, and then deploy the resources into the resource group by using a workload identity. Here's an example Bicep definition for the preceding role assignment:

```bicep
resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(principalId, roleDefinitionId, resourceGroup().id)
  properties: {
    principalType: 'ServicePrincipal'
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', roleDefinitionId)
    principalId: principalId
    description: 'The deployment workflow for the company\'s website needs to be able to create resources within the resource group.'
  }
}
```

Let's look at each argument:

- `name` is a globally unique identifier (GUID) for the role assignment. It's a good practice to use the `guid()` function in Bicep to create a GUID. To ensure that you create a name that's unique for each role assignment, use the principal ID, role definition ID, and scope as the seed arguments for the function.
- `principalType` should be set to `ServicePrincipal`.
- `roleDefinitionId` is the fully qualified resource ID for the role definition that you're assigning. You mostly work with built-in roles, so you find the role definition ID in the [Azure built-in roles documentation](/azure/role-based-access-control/built-in-roles?azure-portal=true).

   For example, the _Contributor_ role has the role definition ID `b24988ac-6180-42a0-ab88-20f7382dd24c`. When you specify it in your Bicep file, you use a fully qualified resource ID, such as `/subscriptions/f0750bbe-ea75-4ae5-b24d-a92ca601da2c/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c`.
- `principalId` is the service principal's object ID. Make sure you don't use the application ID or the application registration's object ID.
- `description` is a human-readable description of the role assignment.
