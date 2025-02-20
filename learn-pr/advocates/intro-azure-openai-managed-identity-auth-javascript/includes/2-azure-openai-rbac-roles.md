These RBAC roles are available for you to assign to identities for Azure OpenAI Service:

- The *Cognitive Services OpenAI User* role allows viewing resources, endpoints, and model deployments; using playground experiences; and making inference API calls. However, it doesn't permit creating resources, viewing/copying/regenerating keys, or managing model deployments.
- The *Cognitive Services OpenAI Contributor* role includes all user permissions plus the ability to create custom fine-tuned models, upload datasets, and manage model deployments. It doesn't allow creating new resources or managing keys.
- The *Cognitive Services Contributor* role permits creating new resources, viewing and managing keys, creating and managing model deployments, and using playground experiences. It doesn't allow access to quotas or making inference API calls.
- The *Cognitive Services Usages Reader* role allows viewing quota usage across a subscription. This role provides minimal access and is typically combined with other roles.

Always choose a role that provides the lowest amount of privilege required for the identity to do the tasks that it needs to perform. For more detail on Azure OpenAI RBAC roles.

## Configure role assignments in the Azure portal

To enable keyless authentication, follow these steps to configure the necessary role assignments:

1. In the Azure portal, go to your specific Azure OpenAI resource.
2. On the service menu, select **Access Control (IAM)**.
3. Select **Add role assignment**. On the pane that opens, select the **Role** tab.
4. Select the role that you want to assign.
5. On the **Members** tab, select a user, group, service principal, or managed identity to assign to the role.
6. On the **Review + assign** tab, confirm your selections. Select **Review + assign** to finalize the role assignment.

Within a few minutes, the selected user or identity is granted the assigned role at the chosen scope. The user or identity can then access Azure OpenAI services without needing an API key.

## Configure role assignments in the Azure CLI

To configure role assignments by using the Azure CLI, perform these steps:

1. Find the role for your usage of Azure OpenAI. Depending on how you intend to set that role, you need either the name or the ID:

   - For the Azure CLI or Azure PowerShell, you can use a role name.
   - For Bicep, you need the role ID.

   Use the following table to select a role name or role ID:

   | Use case | Role name | Role ID |
   |---|---|---|
   | Assistants | Cognitive Services OpenAI Contributor | a001fd3d-188f-4b5d-821b-7da978bf7442 |
   | Chat completions | Cognitive Services OpenAI User | 5e0bd9bd-7b93-4f28-af87-19fc36ad61bd |

1. Select an identity type to use:

   - A *personal identity* is tied to your Azure sign-in.
   - A *managed identity* is managed by Azure and created for use on Azure. For this choice, create a user-assigned managed identity. When you create the managed identity, you need the client ID (also called the app ID).

1. Find your personal identity and use the ID as the `<identity-id>` value in this step.

   For local development, to get your own identity ID, use the following command. You need to sign in with `az login` before using this command.

   ```azurecli
   az ad signed-in-user show \
       --query id -o tsv
   ```

1. Assign the RBAC role to the identity for the resource group. To grant your identity permissions to your resource through RBAC, assign a role by using the Azure CLI command `az role assignment create`. Replace `<identity-id>`, `<subscription-id>`, and `<resource-group-name>` with your actual values.

   ```azurecli
   az role assignment create \
       --role "Cognitive Services OpenAI User" \
       --assignee "\<identity-id>" \
       --scope "/subscriptions/\<subscription-id>/resourceGroups/\<resource-group-name>"
   ```
