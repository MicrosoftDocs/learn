By itself, a service principal can't do anything in your Azure environment - just like how a user can't work with your Azure resources unless they're authorized to do so. In this unit, you'll learn how to authorize service principals to deploy and configure Azure resources, while avoiding granting unnecessary permissions.

## Service principal authorization

Up till now, we've focused on what service principals are, and how they can be used to prove the identity of a pipeline to Azure Active Directory (Azure AD). This is all about _authentication_.

Once Azure AD has authenticated a service principal, the next question becomes: what can this service principal do? This is the domain of _authorization, and is the responsibility of Azure's role-based access control (RBAC) system, sometimes called identity and access management (IAM). By using Azure RBAC, you can grant a service principal access to a specific resource group, subscription, or management group.

> [!NOTE]
> Everything we're doing here is using Azure's RBAC system to grant access to create and manage Azure resources, like your storage accounts, App Services, and virtual networks. Azure AD also has its own role system, which is sometimes called _directory roles_. You use these to grant permissions for service principals to manage Azure AD. We don't discuss these in this module, but be aware that the term _role_ can be used for both situations in some documentation.

## Select the right role assignment for your pipeline

A role assignment has three key parts: who the role is assigned to (the **assignee**), what they can do (the **role**), and the resource or resources that the role assignment applies to (the **scope**).

### Who the role is assigned to

When you work with a service principal, you assign roles for that service principal. Sometimes this is called the _assignee_. You use the service principal's application ID to identify the right service principal.

### Which role is assigned

It can be a little more work to figure out which role to assign. In Azure, there are a few common roles:

- **Reader**, which allows the assignee to read information about resources but not modify or delete them.
- **Contributor**, which allows the assignee to create resources, and read and modify existing resources. However, contributors can't grant other principals access to resources.
- **Owner**, which allows full control over resources, including granting other principals access.

There are also lots of very specific roles that provide access just to a subset of functionality. You can even create your own _role definition_ to specify the exact list of permissions that you want to assign.

> [!NOTE]
> Custom role definitions can be a powerful way to grant permissions for your Azure resources, but they can be difficult to work with. It's not always easy to determine exactly which permissions you need to add to a custom role definition, and you might accidentally make the role definitions too restrictive or too permissive. If you're not sure what to do, it's best to use one of the built-in role definitions instead. Custom role definitions are beyond the scope of this module.

### The scope of the assignment

You need to determine how broadly you assign the role. This impacts the number of resources that service principal will be able to modify. Common scopes include:

- **Single resource:** You can grant access just to a specific resource. Typically pipelines don't use this scope, because a pipeline creates resources that don't exist yet, or reconfigures multiple resources.
- **Resource group:** You can grant access to all resources within a resource group. **Contributors** and **Owners** can also create resources within the group. This is a good option for many deployment pipelines.
- **Subscription:** You can grant access to all resources within a subscription. If you have multiple applications, workloads, or environments in a single subscription then this can be unnecessarily permissive for a pipeline.

### How do you select the right role assignment?

Now that you understand the components of a role assignment, you can decide the appropriate values for your scenarios. Here are some general guidelines to consider:

> [!div class="checklist"]
> * Use the least permissive role you can. If your pipeline is only going to deploy basic Bicep templates and won't manage role assignments, don't use the **Owner** role.
> * Use the narrowest scope you can. Most pipelines only need to deploy resources to a resource group, so they shouldn't be given subscription-scoped role assignments.
> * Make sure you consider everything your pipeline does, and everything it might do in the future. For example, we might consider creating a custom role definition for our website's deployment pipeline and only grant permissions for App Service and Application Insights. Next month, we might need to add a Cosmos DB account to our Bicep file, but the custom role will block Cosmos DB resources from being created. Instead, it's often better to use a built-in role to avoid having to repeatedly change your role definitions. Consider using Azure Policy to enforce your governance requirements for allowed services, SKUs, and locations.
> * For many pipelines, a good default option for a role assignment is the **Contributor** role on the resource group scope.
> * Make sure you test the pipeline to verify the role assignment works.

### Mix and match role assignments

You can create multiple role assignments that provide different permissions at different scopes. For example, you might assign a service principal the role of **Reader** with a scope of the entire subscription, and then separately assign the same service principal the role of **Contributor** for a specific resource group. When the service principal tries to work with the resource group, the more permissive assignment is applied.

## Create a role assignment for a service principal

To create a role assignment for a service principal, use the `az role assignment create` command. You need to specify the three pieces of information described above - assignee, role, and scope:

```azurecli
az role assignment create \
  --assignee b585b740-942d-44e9-9126-f1181c95d497 \
  --role Contributor \
  --scope "/subscriptions/f0750bbe-ea75-4ae5-b24d-a92ca601da2c/resourceGroups/ToyWebsite" \
  --assignee-principal-type ServicePrincipal \
  --description "The deployment pipeline for the company's website needs to be able to create resources within the resource group."
```

Let's look at each argument:

- `--assignee` specifies the service principal name. To avoid ambiguity, it's a good practice to use the application ID.
- `--role` specifies the role. If you use a built-in role, you can specify it by name. If you use a custom role definition then you specify the full role definition ID.
- `--scope` specifies the scope. This is usually a resource ID for a single resource, a resource group, or a subscription.
- `--assignee-principal-type` tells Azure that you're providing the role assignment for a service principal. This helps to avoid delays when Azure replicates the role assignment throughout the world.
- `--description` is a human-readable description of the role assignment.

<!-- TODO test the above -->

> [!TIP]
> It's a good practice to provide a justification for your role assignments by specifying a description. This helps anyone who reviews them later to understand the purpose of the role assignment, and to understand how you decided on the assignee, role, and scope.

## Create a service principal and role assignment in one operation

You can also create a role assignment at the same time that you create a service principal. This is similar to the command you used to create a service principal in the previous units, but with some additional arguments:

::: zone pivot="cli"

:::code language="azurecli" source="code/5-create-sp-rbac.sh" highlight="3-4" :::
<!-- TODO test the above -->

::: zone-end

::: zone pivot="powershell"

:::code language="azurepowershell" source="code/5-create-sp-rbac.ps1" highlight="3-4" :::
<!-- TODO test the above -->

::: zone-end

