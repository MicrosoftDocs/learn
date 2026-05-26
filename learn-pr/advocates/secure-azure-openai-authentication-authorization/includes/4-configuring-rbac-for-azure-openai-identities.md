Azure role-based access control (Azure RBAC) controls what a Microsoft Entra user, group, service principal, or managed identity can do at a specific scope. RBAC is central to keyless access because Foundry roles are evaluated when an application authenticates with Microsoft Entra ID. If API-key authentication remains enabled, possession of a key can still grant access outside those granular role checks.

This unit separates three related RBAC surfaces: current Microsoft Foundry project access, direct Microsoft Foundry Models keyless inference, and Azure OpenAI feature access on classic resources or resources upgraded to Foundry. Choose roles for the surface the identity uses, because project roles, inference roles, management roles, and quota roles don't grant the same permissions.

## Use least-privilege roles for Foundry projects

Assign the least-privileged role that lets the identity complete its task. For human users, and for service principals where group-based access fits your governance model, prefer assigning roles to Microsoft Entra security groups, then manage membership in those groups. Group-based assignment makes access easier to audit and helps reduce the number of direct role assignments. For managed identities that need predictable validation or quickly revocable permissions, prefer direct role assignments or a user-assigned managed identity with roles applied directly. Managed identity group membership or app-role membership is represented in cached tokens, and managed identity back-end services cache tokens for about 24 hours, so membership changes can take several hours to affect authorization.

Current Foundry project scenarios use Foundry roles. These roles authorize project and resource operations such as building in a project, managing projects, and assigning Foundry access. They're separate from the **Cognitive Services User** role used for direct Microsoft Foundry Models keyless inference and from the **Cognitive Services OpenAI** roles used for Azure OpenAI feature access on classic resources or resources upgraded to Foundry.

Don't use the similarly named **Azure AI Developer** role for Foundry project access. That built-in role applies to Azure Machine Learning workspaces and Foundry hubs, not Foundry projects or Foundry hosted agents. Choose Foundry-specific roles such as **Foundry User**, **Foundry Project Manager**, **Foundry Account Owner**, or **Foundry Owner** according to the required capability and least privilege.

These Foundry RBAC roles were recently renamed from Azure AI roles. When you automate assignments, use role definition IDs to avoid name mismatches during the rename rollout: **Foundry User** `53ca6127-db72-4b80-b1b0-d745d6d5456d`, **Foundry Owner** `c883944f-8b7b-4483-af10-35834be79c4a`, **Foundry Account Owner** `e47c6f54-e4a2-4754-9501-8e0985b135e1`, and **Foundry Project Manager** `eadc314b-1a2d-4efa-be10-5d325db5065e`.

| Foundry role | Common use | Scope guidance |
| --- | --- | --- |
| **Foundry User** | Build or consume models, agents, and project assets as permitted within a project. This role is the usual least-privilege role for developers, applications, and managed identities that need project access. | Assign at the Foundry project scope when access should be limited to one project. Assign at the Foundry resource scope only when the identity needs equivalent access across projects in that resource. |
| **Foundry Project Manager** | Manage projects and project membership, build and develop in projects, and conditionally grant **Foundry User** where role-assignment conditions allow. Publishing agents is a separate resource-scope capability that requires at least **Foundry Project Manager** at the Foundry resource scope. | Assign at project scope only for project-management and build tasks within an existing project. Assign at the Foundry resource scope when the identity must publish agents or manage projects across the resource. Prefer project or Foundry resource scope over resource-group or subscription scope. |
| **Foundry Account Owner** | Manage Foundry accounts, projects, resources, models, and related resource-level settings. This elevated role can conditionally assign **Foundry User**, ACR, and monitoring roles, but it doesn't include the project data actions needed to build or develop in a project. | Assign to account or platform administrators. Don't use it for routine model consumption or development unless the identity also has a project data-action role such as **Foundry User**. |
| **Foundry Owner** | Manage Foundry resources and projects, build and develop in projects, manage models, publish agents, and conditionally assign **Foundry User**, ACR, and monitoring roles. | Assign only when an identity needs broad owner-level Foundry capabilities. Use time-bound or reviewed assignments where possible. |

Avoid assigning **Owner**, **Contributor**, **Foundry Owner**, or **Foundry Account Owner** for routine inference or development. Generic Azure **Reader** and **Contributor** roles can be useful for separate control-plane discovery or management scenarios, but they aren't substitutes for least-privilege Foundry project roles and **Contributor** alone can't create role assignments.

For current Foundry role details, see [Role-based access control for Microsoft Foundry](/azure/foundry/concepts/rbac-foundry).

## Use Cognitive Services User for direct Foundry Models inference

Some workloads call the Microsoft Foundry Models inference endpoint directly with Microsoft Entra ID. For that keyless inference surface, assign **Cognitive Services User** at the Foundry resource scope. This role is different from **Cognitive Services OpenAI User** and doesn't grant Foundry project management permissions.

Microsoft documentation uses **Cognitive Services User** for direct Foundry Models keyless inference, but the built-in role is broader than inference-only access. It can read and list keys for Cognitive Services accounts and includes broad `Microsoft.CognitiveServices/*` data actions. For a narrower custom-role option, use the documented `Microsoft.CognitiveServices/accounts/MaaS/*` data action. Because this permission uses a wildcard, review available data actions periodically and replace it with explicit permissions if Microsoft exposes more granular Foundry Models operations.

| Role | Use for | Scope guidance |
| --- | --- | --- |
| **Cognitive Services User** | Microsoft Entra-authenticated inference calls to the direct Microsoft Foundry Models inference endpoint. | Assign at the Foundry resource scope to callers that need direct Foundry Models inference. Don't use it as a substitute for Foundry project roles or Cognitive Services OpenAI roles for Azure OpenAI feature access. |

After you validate Microsoft Entra-authenticated inference with the built-in or custom role, disable local authentication so possession of an API key doesn't bypass RBAC. For Foundry Models keyless inference details, see [Configure keyless authentication with Microsoft Entra ID](/azure/foundry/foundry-models/how-to/configure-entra-id).

## Choose an appropriate scope

A role assignment applies at the scope where it's assigned and is inherited by child scopes. Use the narrowest scope that contains the project or resource the identity needs to access:

- **Foundry project scope**: Use for most team members, applications, and managed identities that work in one project.
- **Foundry resource scope**: Use when the same access must apply across multiple projects, when publishing agents, or when a role's management capabilities require the resource scope.
- **Resource group scope**: Use only when the identity must manage or discover multiple resources in that group.
- **Subscription scope**: Use only for subscription-wide administration, discovery, quota, or policy scenarios. Subscription-level assignments are inherited by all child resource groups and resources, so review them carefully.

The documented Foundry RBAC guidance includes a few scope patterns that are useful in different situations:

| Pattern | Assignments | Use when |
| --- | --- | --- |
| Minimum starter setup | Assign **Foundry User** on the Foundry resource to the user's principal and to the project's managed identity. | Use this pattern when getting started so the user and project managed identity can access Foundry features. If the project creator can assign roles, these assignments might be added automatically. |
| Least-privilege project team | Assign **Foundry User** on the Foundry project and **Reader** on the Foundry resource. | Use this enterprise pattern for team members or developers who build in one project with pre-deployed Foundry models and connections. The project role grants project data actions, while **Reader** gives resource-level visibility without granting broader project access. |
| Resource-wide Foundry access | Assign the needed Foundry role at the Foundry resource scope. | Use this pattern only when the identity needs the same access across projects in the resource, needs to create or manage projects, needs to publish agents, or needs capabilities that the role supports only at resource scope. |

Don't assign a broad scope for convenience. Broad assignments can override narrower least-privilege planning and expose unrelated projects or resources.

## Use Cognitive Services OpenAI roles for Azure OpenAI feature access

Some solutions still use Azure OpenAI resources in Microsoft Foundry Models (classic), and some call OpenAI features on Azure OpenAI resources that were upgraded to Foundry. These OpenAI feature scenarios use Azure OpenAI roles that start with **Cognitive Services OpenAI**. On upgraded Foundry resources, these roles continue to apply to OpenAI features. Use Foundry roles for broader Foundry project access and non-OpenAI Foundry capabilities.

> [!IMPORTANT]
> Before you upgrade an Azure OpenAI resource to Foundry, review existing RBAC assignments and policy controls that could expand access. In particular, audit **Cognitive Services User** assignments, wildcard custom roles, Azure Policy definitions, and model-access policies that don't restrict access to a specific resource kind. After upgrade, **Cognitive Services User** can grant access to all Foundry features, while **Cognitive Services OpenAI User** continues to apply to OpenAI features.

| Role | Use for |
| --- | --- |
| **Cognitive Services OpenAI User** | Least-privilege Microsoft Entra-authenticated inference and playground use for deployed OpenAI models on a classic Azure OpenAI resource or for OpenAI features on a resource upgraded to Foundry. |
| **Cognitive Services OpenAI Contributor** | Model deployment, fine-tuning, and other OpenAI authoring tasks on a classic Azure OpenAI resource or for OpenAI features on a resource upgraded to Foundry, in addition to user capabilities. |
| **Cognitive Services Contributor** | Resource management tasks such as creating Azure OpenAI resources, viewing endpoints, regenerating keys, and managing resource settings. This role is elevated and, by itself, can't make Microsoft Entra-authenticated inference API calls. |
| **Cognitive Services Usages Reader** | Viewing Azure OpenAI quota usage. This role must be assigned at subscription scope and doesn't exist at resource scope. |

Classic portal deployment or edit workflows can also require **Cognitive Services Usages Reader** at subscription scope so the portal can view quota, in addition to the appropriate authoring role such as **Cognitive Services OpenAI Contributor** or **Cognitive Services Contributor**. **Cognitive Services Usages Reader** doesn't grant inference or authoring permissions by itself.

For OpenAI role permissions, see [Role-based access control for Azure OpenAI in Microsoft Foundry Models (classic)](/azure/ai-foundry/openai/how-to/role-based-access-control). For upgraded-resource behavior, see [Upgrade from Azure OpenAI to Microsoft Foundry](/azure/foundry/how-to/upgrade-azure-openai#considerations-for-rbac-and-policy-during-upgrade).

## Configure role assignments in the Azure portal

Before assigning roles, sign in with an account that can create role assignments at the target scope. The account needs the **Owner**, **User Access Administrator**, **Role Based Access Control Administrator**, or an equivalent custom role that includes `Microsoft.Authorization/roleAssignments/write`. **Reader** or **Contributor** alone is insufficient for assigning roles.

To configure a role assignment:

1. In the [Azure portal](https://portal.azure.com), go to the narrowest scope that contains the Foundry project or resource.
1. Select **Access control (IAM)**.
1. Select **Add** > **Add role assignment**. If this option is disabled, your account doesn't have permission to assign roles at that scope.
1. On the **Role** tab, select the role that matches the scenario, such as **Foundry User** for project access or **Foundry Project Manager** for project management.
1. Select **Next**.
1. On the **Members** tab, select **User, group, or service principal** for Microsoft Entra users, groups, and applications, or select **Managed identity** for an Azure resource identity.
1. Select the member that needs access, then select **Next**.
1. On the **Review + assign** tab, review the scope, role, and member.
1. Select **Review + assign** to create the role assignment.

For detailed portal steps, see [Assign Azure roles using the Azure portal](/azure/role-based-access-control/role-assignments-portal).

## Configure role assignments with Azure CLI

Use Azure CLI when you need repeatable role assignments for users, groups, service principals, or managed identities. Every `az role assignment create` command needs three inputs: the security principal, the role definition, and the scope. For Foundry roles, use role definition IDs in automation because the Foundry role rename rollout can leave role names in transition while role IDs remain stable.

Use the narrowest scope ID for the scenario:

```azurecli
# Foundry project scope for project-only access. Prefer reading the project ID instead of hand-building it.
PROJECT_SCOPE=$(az cognitiveservices account project show \
  --name "<foundry-resource-name>" \
  --resource-group "<resource-group-name>" \
  --project-name "<project-name>" \
  --query id -o tsv)

# Foundry resource or classic/upgraded Azure OpenAI resource scope.
RESOURCE_SCOPE="/subscriptions/<subscription-id>/resourceGroups/<resource-group-name>/providers/Microsoft.CognitiveServices/accounts/<foundry-or-azure-openai-resource-name>"
```

Project scopes use the same resource hierarchy and end in `/providers/Microsoft.CognitiveServices/accounts/<foundry-resource-name>/projects/<project-name>`. Use `$PROJECT_SCOPE` for Foundry project roles and `$RESOURCE_SCOPE` for resource-level roles such as direct Foundry Models inference or Azure OpenAI feature access.

Then create the assignment with the selected role definition ID or role name. This example uses the **Foundry User** role definition ID:

```azurecli
FOUNDRY_USER_ROLE_ID="53ca6127-db72-4b80-b1b0-d745d6d5456d"

# User: UPN or user object ID.
az role assignment create \
  --assignee "user@contoso.com" \
  --role "$FOUNDRY_USER_ROLE_ID" \
  --scope "$PROJECT_SCOPE"

# Group: Microsoft Entra group object ID.
az role assignment create \
  --assignee-object-id "<group-object-id>" \
  --assignee-principal-type Group \
  --role "$FOUNDRY_USER_ROLE_ID" \
  --scope "$PROJECT_SCOPE"

# Service principal: service principal object ID, not application/client ID.
az role assignment create \
  --assignee-object-id "<service-principal-object-id>" \
  --assignee-principal-type ServicePrincipal \
  --role "$FOUNDRY_USER_ROLE_ID" \
  --scope "$PROJECT_SCOPE"

# Managed identity: principal ID/object ID of the managed identity service principal.
az role assignment create \
  --assignee-object-id "<managed-identity-principal-id>" \
  --assignee-principal-type ServicePrincipal \
  --role "$FOUNDRY_USER_ROLE_ID" \
  --scope "$PROJECT_SCOPE"
```

For users, `--assignee` can be a UPN or user object ID. For service principals and managed identities, use `--assignee-object-id` with `--assignee-principal-type ServicePrincipal` to avoid Microsoft Entra replication or name-resolution issues. Use the service principal object ID, not the application/client ID. For groups, use the group object ID; `--assignee-object-id` with `--assignee-principal-type Group` avoids display-name ambiguity.

Role assignments usually apply within a few minutes, but Azure RBAC changes can take up to 10 minutes. If an interactive user, CLI session, or API client still receives authorization errors, sign in again or refresh the access token before retesting. Managed identity group membership or app-role membership changes can take several hours because managed identity tokens are cached by back-end services for about 24 hours and can't be force-refreshed. Don't rely on managed identity group membership changes for immediate validation or revocation; use direct role assignments or preassigned user-assigned managed identities when permission changes must be predictable.

## Disable local authentication after validation

Microsoft recommends using Microsoft Entra ID authentication instead of API keys where possible. After you verify that every workload can authenticate with Microsoft Entra ID and has the required RBAC assignments, you can harden the resource by disabling local authentication.

Don't disable local authentication until you complete readiness checks. Disabling local authentication prevents API-key use and can break applications, scripts, or operational processes that still depend on keys. Confirm that managed identities, service principals, user access, automation, monitoring, and rollback procedures are ready first.

You can disable local authentication with Azure Policy, an ARM or Bicep deployment that sets `disableLocalAuth` to `true`, or Azure PowerShell. Allow a few minutes for the setting to take effect. If you need to roll back, re-enable local authentication and allow time for the change to propagate. For more information, see [Disable local authentication in Foundry Tools](/azure/ai-services/disable-local-auth).

> [!NOTE]
> If Azure Policy enforces disabled local authentication, rollback might require more than setting `disableLocalAuth` back to `false`. Check policy assignments, exemptions, and remediation tasks before you disable keys and before you attempt emergency rollback. A deny policy can block re-enabling local authentication, and modify or deploy-if-not-exists policies can reapply the disabled setting.