These roles are the OpenAI RBAC roles that are available to be assigned to identities. Always choose a role that provides the least amount of privilege required for that identity to do the tasks it needs to perform. For more detail on OpenAI RBAC roles, see the **Introduction to authentication to Azure OpenAI** learn module.

- The **Cognitive Services OpenAI User** role allows viewing resources, endpoints, and model deployments, using playground experiences, and making inference API calls. However, it doesn't permit creating resources, viewing/copying/regenerating keys, or managing model deployments.
- The **Cognitive Services OpenAI Contributor** role includes all user permissions plus the ability to create custom fine-tuned models, upload datasets, and manage model deployments. It doesn't allow creating new resources or managing keys.
- The **Cognitive Services Contributor** role permits creating new resources, viewing and managing keys, creating and managing model deployments, and using playground experiences. It doesn't allow access to quota or making inference API calls.
- The **Cognitive Services Usages Reader** role allows viewing quota usage across a subscription. This role provides minimal access and is typically combined with other roles.

## Configuring role assignments in the Azure portal

To enable keyless authentication, follow these steps to configure the necessary role assignments:

1. Select Azure OpenAI: Navigate to your specific Azure OpenAI resource within the Azure portal.
2. Access Control: Select the Access Control (IAM) option from the left navigation pane.
3. Add Role Assignment: Select Add role assignment, and on the subsequent screen, choose the Role tab.
4. Select Role: Choose the desired role you wish to assign, such as Reader or Contributor.
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
| **Assistants** | Cognitive Services OpenAI Contributor | a001fd3d-188f-4b5d-821b-7da978bf7442 |
| **Chat completions** | Cognitive Services OpenAI User | 5e0bd9bd-7b93-4f28-af87-19fc36ad61bd |

3. Select an identity type to use.

    - **Personal identity**: This identity is your personal identity tied to your sign in to Azure.
    - **Managed identity**: This is an identity managed by and created for use on Azure. For managed identity, create a user-assigned managed identity. When you create the managed identity, you need the Client ID, also known as the app ID.

4. Find your personal identity and use the ID as the \<identity-id> in the next step.

For local development, to get your own identity ID, use the following command. You need to sign in with `az login` before using this command:

```azurecli
az ad signed-in-user show \
    --query id -o tsv
```

Assign the role-based access control (RBAC) role to the identity for the resource group. To grant your identity permissions to your resource through RBAC, assign a role using the Azure CLI command `az role assignment create`.

```azurecli
az role assignment create \
    --role "Cognitive Services OpenAI User" \
    --assignee "\<identity-id>" \
    --scope "/subscriptions/\<subscription-id>/resourceGroups/\<resource-group-name>"
```

Where applicable, replace `<identity-id>`, `<subscription-id>`, and `<resource-group-name>` with your actual values.

Managed identities provide many benefits over API keys because they eliminate the need to store credentials within application code, reducing the risk of credential leaks. They provide a more secure and automated method for accessing Azure services by using Microsoft Entra ID for authentication. This approach simplifies credential management and enhances security by ensuring that credentials aren't hard-coded or exposed.
