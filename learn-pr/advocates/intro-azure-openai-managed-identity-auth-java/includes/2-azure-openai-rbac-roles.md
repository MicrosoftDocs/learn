These roles are Azure OpenAI RBAC roles that are available to be assigned to identities. Always choose a role that provides the least amount of privilege required for that identity to do the tasks it needs to perform. For more detail on Azure OpenAI RBAC roles, see the **Introduction to authentication to Azure OpenAI** Learn module.

For classic Azure OpenAI resources, these Cognitive Services roles are assigned through Azure RBAC at the Azure OpenAI resource, resource group, or subscription scope. They're different from Microsoft Foundry project roles, which control access within a Foundry project.

- The **Cognitive Services OpenAI User** role allows viewing resources, endpoints, and model deployments, using playground experiences, and making data-plane inference API calls. Use this role for keyless inference. It doesn't permit creating resources, viewing/copying/regenerating keys, or managing model deployments.
- The **Cognitive Services OpenAI Contributor** role includes all user permissions plus the ability to create custom fine-tuned models, upload datasets, and manage model deployments. Use this role only when the identity needs to manage deployments or fine-tuning. It doesn't allow creating new resources or managing keys.
- The **Cognitive Services Contributor** role permits creating new resources, viewing and managing keys, creating and managing model deployments, and using playground experiences. It doesn't grant Azure OpenAI data-plane inference permissions, so it isn't sufficient for keyless inference calls.
- The **Cognitive Services Usages Reader** role allows viewing quota usage across a subscription. Assign this role at subscription scope. This role provides minimal access and is typically combined with other roles.

## Configuring role assignments in the Azure portal

To enable keyless authentication, follow these steps to configure the necessary role assignments:

1. Navigate to your Azure OpenAI resource in the Azure portal.
1. Select **Access Control (IAM)** from the left navigation pane.
1. Select **Add** > **Add role assignment**, and then select the **Role** tab.
1. Choose the least-privileged Azure OpenAI role for the task:
    - Select **Cognitive Services OpenAI User** for keyless inference, such as chat completions and embeddings.
    - Select **Cognitive Services OpenAI Contributor** only when the identity needs to manage model deployments or fine-tuning.
    - Select **Cognitive Services Usages Reader** only for viewing quota usage, and assign it at subscription scope.
1. On the **Members** tab, select a user, group, service principal, or managed identity to assign the role. For a managed identity, the role is assigned to the identity's principal, also known as its object ID.
1. On the **Review + assign** tab, confirm your selections and select **Review + assign** to finalize the role assignment.

Within a few minutes, the selected user or identity is granted the assigned role at the chosen scope. Don't use generic **Reader** or **Contributor** roles for keyless inference because they don't provide the required Azure OpenAI data-plane permissions.

## Configuring role assignments in the Azure CLI

To configure role assignments using Azure CLI, perform the following steps:

1. Find the role for your usage of Azure OpenAI. Azure CLI can use the role name. Infrastructure-as-code tools might require the role ID.

    - **Role name** - For Azure CLI or Azure PowerShell, you can use a role name.
    - **Role ID** - For Bicep, you need the role ID.

1. Use the following table to select a role and ID:

| **Use case** | **Role name** | **Role ID** |
|---|---|---|
| **Keyless inference, such as chat completions and embeddings** | Cognitive Services OpenAI User | 5e0bd9bd-7b93-4f28-af87-19fc36ad61bd |
| **Model deployment or fine-tuning management** | Cognitive Services OpenAI Contributor | a001fd3d-188f-4b5d-821b-7da978bf7442 |

Assign **Cognitive Services Usages Reader** at subscription scope when the identity needs to view quota usage across the subscription.

1. Select an identity type to use.

    - **Personal identity**: This identity is your personal identity tied to your sign in to Azure.
    - **Managed identity**: This is an identity managed by and created for use on Azure. For role assignment, use the managed identity's principal ID, also known as the object ID. The client ID is used by the SDK to select a user-assigned managed identity, not to assign Azure RBAC permissions.

1. Find the principal or object ID for the identity.

    For local development, to get your own identity ID, use the following command. You need to sign in with `az login` before using this command:

```azurecli
az ad signed-in-user show \
    --query id -o tsv
```

    For a user-assigned managed identity, use the `principalId` value:

```azurecli
az identity show \
    --name <managed-identity-name> \
    --resource-group <resource-group-name> \
    --query principalId -o tsv
```

1. Get the Azure OpenAI resource ID to use as the least-privileged assignment scope:

```azurecli
az cognitiveservices account show \
    --name <azure-openai-resource-name> \
    --resource-group <resource-group-name> \
    --query id -o tsv
```

1. Assign the RBAC role to the identity at the Azure OpenAI resource scope. To grant your identity permissions to your resource through RBAC, assign a role using the Azure CLI command `az role assignment create`.

```azurecli
az role assignment create \
    --role "Cognitive Services OpenAI User" \
    --assignee "<identity-principal-or-object-id>" \
    --scope "<azure-openai-resource-id>"
```

Where applicable, replace `<identity-principal-or-object-id>`, `<azure-openai-resource-id>`, `<azure-openai-resource-name>`, `<managed-identity-name>`, and `<resource-group-name>` with your actual values. Use resource group or subscription scope only when the identity intentionally needs the same permissions across multiple resources. Assign **Cognitive Services Usages Reader** at subscription scope.

Managed identities provide many benefits over API keys because they eliminate the need to store credentials within application code, reducing the risk of credential leaks. They provide a more secure and automated method for accessing Azure services by using Microsoft Entra ID for authentication. This approach simplifies credential management and enhances security by ensuring that credentials aren't hard-coded or exposed.
