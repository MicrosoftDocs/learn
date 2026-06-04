These roles are the OpenAI RBAC roles that are available to be assigned to identities. Always choose a role that provides the least amount of privilege required for that identity to do the tasks it needs to perform. For more detail on OpenAI RBAC roles, see [Role-based access control for Azure OpenAI in Microsoft Foundry Models (classic)](/azure/ai-foundry/openai/how-to/role-based-access-control).

- The **Cognitive Services OpenAI User** role allows viewing resources, endpoints, and model deployments, using playground experiences, and making inference API calls. However, it doesn't permit creating resources, viewing/copying/regenerating keys, or managing model deployments.
- The **Cognitive Services OpenAI Contributor** role includes all user permissions plus the ability to create custom fine-tuned models, upload datasets, and manage model deployments. It doesn't allow creating new resources or managing keys.
- The **Cognitive Services Contributor** role permits creating Azure OpenAI resources in a resource group where the role assignment applies, such as at resource-group or broader scope. It also permits viewing, copying, and regenerating keys, creating and managing model deployments, and using playground experiences. It doesn't allow access to quota or making inference API calls with Microsoft Entra ID. Because this role can manage keys, use it only when key or resource-management permissions are intentionally required; for keyless chat access to an existing Azure OpenAI resource, prefer a resource-scoped **Cognitive Services OpenAI User** assignment.
- The **Cognitive Services Usages Reader** role allows viewing quota usage across a subscription. This role provides minimal access and is typically combined with other roles.

## Configuring role assignments in the Azure portal

> [!NOTE]
> The Cognitive Services roles discussed in this unit are associated with Azure OpenAI in Microsoft Foundry Models resources (the classic Azure OpenAI resource type), not Microsoft Foundry projects. Assign Cognitive Services OpenAI User, Cognitive Services OpenAI Contributor, and Cognitive Services Contributor at the appropriate resource scope; use Cognitive Services Usages Reader at subscription scope for quota visibility.

To enable keyless authentication, follow these steps to configure the necessary role assignments:

1. Select Azure OpenAI: Navigate to your specific Azure OpenAI resource within the Azure portal.
2. Access Control: Select the Access Control (IAM) option from the left navigation pane.
3. Add Role Assignment: Select Add role assignment, and on the subsequent screen, choose the Role tab.
4. Select Role: Choose the desired role you wish to assign, such as Cognitive Services OpenAI User for inference and chat completions, or Cognitive Services OpenAI Contributor for managing deployments and fine-tuned models.
5. Members Tab: On the Members tab, select a user, group, service principal, or managed identity to assign the role.
6. Review and Assign: On the Review + assign tab, confirm your selections and select Review + assign to finalize the role assignment.

Within a few minutes, the selected user or identity will be granted the assigned role at the chosen scope, enabling them to access Azure OpenAI services without needing an API key.

## Configuring role assignments in the Azure CLI

To configure role assignments using Azure CLI, perform the following steps:

1. Find the role for your usage of Azure OpenAI. Depending on how you intend to set that role, you'll need either the name or ID.

    - **Role name** - For Azure CLI or Azure PowerShell, you can use a role name.
    - **Role ID** - For Bicep, you need the role ID.

2. Use the following table to select a role and ID:

| **Use case** | **Role name** | **Role ID** |
|---|---|---|
| **Model deployments** | Cognitive Services OpenAI Contributor | a001fd3d-188f-4b5d-821b-7da978bf7442 |
| **Chat completions** | Cognitive Services OpenAI User | 5e0bd9bd-7b93-4f28-af87-19fc36ad61bd |

> [!NOTE]
> The Azure OpenAI Assistants API is deprecated and will retire on August 26, 2026. For new agent workloads, use the generally available [Microsoft Foundry Agents service](/azure/foundry/agents/overview). Plan migration of existing Assistants workloads before the retirement date by using the [migration guide](/azure/foundry/agents/how-to/migrate).

3. Select an identity type to use.

    - **Personal identity**: This identity is your personal identity tied to your sign in to Azure.
    - **Managed identity**: This is an identity managed by and created for use on Azure. Azure supports both **system-assigned managed identities** (tied to a single Azure resource) and **user-assigned managed identities** (standalone resources that can be associated with one or more Azure resources). For Azure-hosted apps that need to authenticate to Azure OpenAI, create or use a managed identity that is assigned to the host (for example, an App Service, Container App, or VM). When you assign an RBAC role, assign it to the managed identity's **principal (object) ID**. For a user-assigned managed identity, you also need its **Client ID** (also called the app ID) to reference it from code.

4. Find your personal identity and use the ID as the \<identity-id> in the next step.

For local development, to get your own identity ID, use the following command. You need to sign in with `az login` before using this command:

```azurecli
az ad signed-in-user show \
    --query id -o tsv
```

Assign the role-based access control (RBAC) role to the identity for your Azure OpenAI resource. To grant your identity permissions to your resource through RBAC, assign a role using the Azure CLI command `az role assignment create`.

```azurecli
az role assignment create \
    --role "Cognitive Services OpenAI User" \
    --assignee "\<identity-id>" \
    --scope "/subscriptions/\<subscription-id>/resourceGroups/\<resource-group-name>/providers/Microsoft.CognitiveServices/accounts/\<azure-openai-resource-name>"
```

Where applicable, replace `<identity-id>`, `<subscription-id>`, `<resource-group-name>`, and `<azure-openai-resource-name>` with your actual values. Scoping the assignment to the specific Azure OpenAI resource follows the principle of least privilege. If you need the assignment to cover multiple Azure OpenAI resources in the same resource group, omit the trailing `/providers/Microsoft.CognitiveServices/accounts/\<azure-openai-resource-name>` segment.

Managed identities provide many benefits over API keys because they eliminate the need to store credentials within application code, reducing the risk of credential leaks. They provide a more secure and automated method for accessing Azure services by using Microsoft Entra ID for authentication. This approach simplifies credential management and enhances security by ensuring that credentials aren't hard-coded or exposed.
