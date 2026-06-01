Zero-trust security operates on a simple principle: never trust, always verify. In traditional network security, once a request passes the perimeter firewall, it's trusted to communicate freely with internal resources. Zero-trust requires every request—even from internal components—to present valid authentication credentials and receive explicit authorization before accessing resources. Apply this principle to multi-agent systems: one agent calling another must authenticate, not just external users calling agents.

| Security Layer | Traditional Perimeter | Zero-Trust Architecture |
|----------------|----------------------|------------------------|
| Network access | Trusted within VNet | Explicit allow-list per agent |
| Identity | Shared service accounts | Per-agent managed identities |
| Authorization | Network-based | Identity + RBAC + context-based |
| Data access | Database credentials | Token-based with scoped permissions |

## Assign unique managed identities to each agent

Each agent service requires its own system-assigned managed identity in Azure. Don't use shared identities between agents. A unique identity per agent ensures that a compromised agent's access is limited to exactly what that specific agent needs—not the combined permissions of all agents.

When Fabrikam's security scanner agent needs to access Azure OpenAI to analyze code patterns, it uses its own managed identity to request an API token. When the reporting agent needs to write results to Azure Blob Storage, it uses a different managed identity with Storage Blob Data Contributor permissions. If the security scanner is compromised, the attacker gains access to Azure OpenAI but not to storage—the managed identity doesn't have storage permissions.

Configure agent identities in Azure Container Apps or Azure Kubernetes Service with system-assigned managed identities:

```azurecli
# Create system-assigned managed identity for each agent container
az containerapp create \
  --name fabrikam-security-scanner-prod \
  --resource-group fabrikam-agents-production \
  --image fabrikam.azurecr.io/security-scanner:latest \
  --system-assigned
```

The system-assigned identity is automatically created and assigned to the container. The identity lifecycle is bound to the container—when you delete the container, Azure automatically deletes the identity. This prevents orphaned identities from accumulating.

## Scope privileges by agent function with RBAC

Apply the principle of least privilege: grant each agent only the minimum permissions required for its specific function. The ingestion agent needs Blob Storage Contributor to write customer code to temporary storage. The analysis agent needs only Storage Blob Data Reader to read that code. The report agent needs Storage Blob Data Contributor only for the output container, not the input container.

Define role assignments at the most specific scope possible. Instead of granting storage permissions at the subscription or resource group level, grant them per storage account or even per container:

```azurecli
# Grant ingestion agent write access to input container only
az role assignment create \
  --assignee <ingestion-agent-managed-identity-id> \
  --role "Storage Blob Data Contributor" \
  --scope /subscriptions/<sub-id>/resourceGroups/<rg>/providers/Microsoft.Storage/storageAccounts/fabrikaminput/blobServices/default/containers/code-uploads

# Grant analysis agent read access to input container only
az role assignment create \
  --assignee <analysis-agent-managed-identity-id> \
  --role "Storage Blob Data Reader" \
  --scope /subscriptions/<sub-id>/resourceGroups/<rg>/providers/Microsoft.Storage/storageAccounts/fabrikaminput/blobServices/default/containers/code-uploads

# Grant report agent write access to output container only
az role assignment create \
  --assignee <report-agent-managed-identity-id> \
  --role "Storage Blob Data Contributor" \
  --scope /subscriptions/<sub-id>/resourceGroups/<rg>/providers/Microsoft.Storage/storageAccounts/fabrikamoutput/blobServices/default/containers/reports
```

This granular scoping means a compromised agent can't access resources outside its designated function. The analysis agent can't write to storage. The report agent can't read input code. Each agent sees only the resources it legitimately needs.

## Use federated identity for user-context operations

Some agent operations need to act on behalf of a user, not as the agent itself. For example, when a customer's developer requests a code review, the ingestion agent must access the customer's private GitHub repository. The agent shouldn't have permanent access to all customer repositories—it should request access in the user's context only when the user authorizes it.

Implement user-context operations with Azure AD federated identity credentials. The agent requests an access token scoped to the specific user and resource:

```python
# agents/ingestion/federated_access.py
from azure.identity import DefaultAzureCredential, OnBehalfOfCredential
from azure.core.credentials import AccessToken

def get_user_context_credential(user_assertion: str, scope: str) -> AccessToken:
    """
    Obtain credential in user context for accessing user-owned resources.
    
    Args:
        user_assertion: JWT token from user's authentication
        scope: Resource scope to access (e.g., 'https://github.com/.default')
    
    Returns:
        Access token valid for the specified scope in user context
    """
    # Azure AD app registration for agent
    client_id = os.environ["AZURE_CLIENT_ID"]
    tenant_id = os.environ["AZURE_TENANT_ID"]
    client_credential = os.environ["AZURE_CLIENT_SECRET"]
    
    # Exchange user token for resource-specific token
    credential = OnBehalfOfCredential(
        tenant_id=tenant_id,
        client_id=client_id,
        client_credential=client_credential,
        user_assertion=user_assertion
    )
    
    token = credential.get_token(scope)
    return token

# Usage: Access user's GitHub repository
user_token = request.headers.get("Authorization").split("Bearer ")[1]
github_token = get_user_context_credential(
    user_assertion=user_token,
    scope="https://github.com/.default"
)

# Now agent can access GitHub as the user
headers = {"Authorization": f"Bearer {github_token.token}"}
response = requests.get(
    "https://api.github.com/repos/customer/private-repo/contents/src",
    headers=headers
)
```

This pattern ensures the agent never accumulates persistent access to customer resources—it only gains temporary access when a user explicitly authorizes the operation through their own authentication.


## Unit summary

- **Per-agent managed identities** eliminate shared credentials by giving each agent its own Azure identity, enabling granular audit trails and independent credential lifecycle management.
- **RBAC scoping by function** restricts each agent to only the Azure resources it needs — the market analysis agent accesses OpenAI but not key vault secrets; the compliance agent accesses document storage but not model deployments.
- **Federated identity with On-Behalf-Of (OBO)** lets agents operate with the user's permissions when accessing customer-specific resources, ensuring the agent never has broader access than the human who invoked it.
