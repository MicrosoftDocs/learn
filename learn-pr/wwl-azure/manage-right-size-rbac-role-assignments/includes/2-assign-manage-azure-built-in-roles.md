Assigning Azure roles at the correct scope with the least-privileged role prevents security incidents and reduces administrative overhead. In Contoso's environment, 37 Owner assignments at subscription scope create an unnecessary blast radius—any of those accounts could accidentally delete production resources or assign roles to unauthorized users. Here, you learn how to assign built-in roles at the narrowest effective scope and choose service-specific roles instead of broad permissions.

| Step | Action |
|------|--------|
| Identify the scope | Determine the narrowest scope where the user or workload needs access (resource, resource group, subscription, or management group) |
| Select the role | Choose the most specific built-in role that grants required permissions without excess privileges |
| Verify existing access | Check what permissions the user or managed identity from inherited or group-based assignments |
| Assign the role | Add the role assignment at the target scope using the Azure portal, CLI, or infrastructure as code |
| Remove broader assignments | Delete any over-permissioned assignments that the new, narrower assignment replaces |

## The RBAC scope hierarchy—narrower is safer

Azure role-based access control (RBAC) operates across four scope levels: management group, subscription, resource group, and resource. Child scopes automatically inherit all role assignment from the parent scope—there's no way to block inherited permissions using Azure RBAC alone.

The core security principle is to assign roles at the narrowest scope that allows the person or workload to complete their job. Contoso's 37 Owner assignments at subscription scope illustrate the risk of broad assignments. An Owner can create, modify, and delete any resource in the subscription AND assign roles to other users. Create, modify, and delete are the broadest possible blast radius—a compromised Owner account could destroy the entire subscription or escalate privileges to other identities.

The correct pattern assigns roles to match job responsibilities precisely. A network engineer who manages virtual networks (VNets) in one resource group gets Network Contributor at that resource group scope—not at the subscription scope. If the engineer needs access to VNets in three resource groups, assign Network Contributor three times, once per resource group. Small assignments limit the challenges of compromised credentials or accidental changes to only the resources within those three groups.

## Choose the right built-in role—service-specific first

Before assigning Contributor or Owner, ask whether a service-specific built-in role exists that grants exactly the required permissions. Azure provides over 300 built-in roles, most of which target specific services or operations.

Three general roles exist for broad access scenarios:

| Role | What it grants | When to use it |
|------|----------------|----------------|
| **Owner** | Full control including role assignment delegation | Only when the user explicitly needs to assign roles to other users or managed identities |
| **Contributor** | Full resource management without role assignment capability | Only when no service-specific role exists for the required operations |
| **Reader** | Read-only access across the scope | Audit, monitoring, and view-only scenarios where no modifications are needed |

Service-specific roles replace Contributor for most scenarios. Network Contributor manages VNets, network security groups (NSGs), and load balancers but can't modify virtual machines or storage accounts. Virtual Machine Contributor manages VMs but not the underlying network or storage. Key Vault Secrets User reads secrets from a specific vault without accessing the vault's management plane. Storage Blob Data Reader reads blob data without accessing storage account keys or changing storage account settings. Monitoring Reader views metrics and logs without managing monitoring configuration.

The search pattern is: look for `<service> Contributor` and `<service> Reader` in the Azure portal role list before falling back to the general Contributor role. For data plane operations like reading blobs or secrets, look for roles with "Data" in the name—these grant access to the data itself rather than the resource management plane.

> [!TIP]
> In the Azure portal, navigate to any scope → **Access control (IAM)** → **Roles** and use the search box to filter by service name. The results show all roles that apply to that service, sorted by permission level.

## Managed identity role assignments

Managed identities eliminate credentials from workload authentication. Assigning roles to managed identities is a security engineer's core responsibility because it determines what resources an application or automation can access.

Azure provides two types of managed identities. A **system-assigned managed identity** is tied to the resource's lifecycle—when you delete the virtual machine, function app, or container instance, Azure automatically deletes the identity. Use system-assigned identities for single-resource workloads where the identity never needs to outlive the resource.

A **user-assigned managed identity** has an independent lifecycle and can be shared across multiple resources. Use user-assigned identities when multiple resources need identical permissions, or when the identity needs to persist after you replace or recreate the underlying resource. For example, a user-assigned identity with Storage Blob Data Contributor on a specific storage account can be assigned to both a development VM and a production container app, ensuring consistent permissions across environments.

Least-privilege principles apply identically to managed identities. A managed identity that reads secrets from one Key Vault gets Key Vault Secrets User scoped to that specific vault—not Key Vault Administrator at subscription scope. A managed identity that writes monitoring data gets Monitoring Contributor at the resource group containing the Log Analytics workspace—not Contributor at the subscription scope.

Managed identities appear in the Azure portal under the same identity and access management (IAM) interface as user accounts. When you assign a role, select **Managed identity** instead of **User, group, or service principal** in the Members step, then search for the system-assigned or user-assigned identity by name.

## View effective permissions and assign roles

Before assigning a role, verify what the user or managed identity already has. In the Azure portal, navigate to the target scope (subscription, resource group, or resource) → **Access control (IAM)** → **Check access**. Enter the user's name or managed identity name—Azure shows all role assignments that give this identity access to the current scope, including inherited assignments from parent scopes.

Look for three things:

- existing broader assignments that already cover the required access (adding a narrower assignment can be unnecessary)
- conflicting assignments that suggest the user have more permissions than their job requires
- assignments inherited from group memberships (the assignments don't appear in the user's direct role assignment list but still grant access)

> [!TIP]
> Use the **Access control (IAM)** → **Role assignments** tab at the subscription scope and filter by "Type: User" to see all direct user assignments across the subscription. Sort by "Role" to quickly identify all Owner and Contributor assignments that need review.

Once you confirm the required scope and role, follow these steps to assign Virtual Machine Contributor to a network engineer at resource group scope:

1. Navigate to the resource group in the Azure portal
2. Select **Access control (IAM)** → **+ Add** → **Add role assignment**
3. On the **Role** tab, search for and select **Virtual Machine Contributor**
4. On the **Members** tab, select **User, group, or service principal** → search for the engineer's account
5. Select **Review + assign**
6. Return to **Access control (IAM)** → **Role assignments** to verify the new assignment appears

If the engineer previously had Contributor at subscription scope, remove the over-broad assignment:

7. At the subscription scope, navigate to **Access control (IAM)** → **Role assignments**
8. Find the engineer's existing Contributor assignment
9. Select the assignment → **Remove**

> [!IMPORTANT]
> Always add the narrower assignment BEFORE removing the broader one. If you remove the broader assignment first, you can lock the user out of resources they actively use, causing an incident.

## Assignment limits—planning for scale

Azure supports up to 4,000 role assignments per subscription. This limit includes direct user assignments, managed identity assignments, and group-based assignments. Management group role assignments count separately toward the management group's own limit but child subscriptions still inherit them.

When you approach this limit, group-based assignments become the recommended solution. Assign the role to a Microsoft Entra security group, then add users to the group. Group membership changes don't consume more role assignments—you can add or remove 100 users from a group without increasing the assignment count. The assignment itself belongs to the group, not to individual members.

For automated provisioning in production environments, use Azure Pipelines or infrastructure as code templates with ARM template or Bicep `roleAssignments` resources. This approach ensures assignments are consistent across environments, tracked in source control, and reproducible in disaster recovery scenarios. Hard-coded assignments in the portal create drift and make audits difficult.

Built-in roles cover most scenarios, but sometimes no built-in role grants exactly the right permissions without over-privileging the user. The next unit covers creating custom Azure roles and Microsoft Entra roles for those cases.
