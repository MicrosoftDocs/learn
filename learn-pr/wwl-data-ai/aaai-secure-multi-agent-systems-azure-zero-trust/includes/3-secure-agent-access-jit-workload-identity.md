Azure Privileged Identity Management (PIM) and AKS workload identity federation minimize the time window and credential surface area for agent access to sensitive resources. In this unit, you configure just-in-time access for high-sensitivity operations, bind Kubernetes service accounts to managed identities, and validate caller identity in agent-to-agent requests.

## Implement just-in-time access for sensitive operations

For highly sensitive operations—accessing production customer data, modifying security configurations, or accessing non-anonymized source code—don't maintain permanent access. Use Azure Privileged Identity Management (PIM) to grant temporary elevated access only when the operation is requested and approved.

Configure PIM role assignments that require approval:

1. Define an eligible role assignment in Azure AD (agent identity is eligible for "Sensitive Data Reader" role but doesn't have it active by default)
2. When the agent needs sensitive access, request activation via PIM API
3. Designated approvers receive notification and approve/deny the request
4. If approved, the role activates for a limited duration (1-4 hours)
5. After expiration, access automatically revokes

This approach creates an audit trail for every sensitive access attempt and ensures that even if an agent is completely compromised, the attacker must still pass human approval to access the most critical data.

## Configure workload identity for containerized agents

When agents run in Azure Kubernetes Service (AKS), use workload identity federation to bind Kubernetes service accounts to Azure AD managed identities. This eliminates the need to store credentials in pod configurations or environment variables.

Enable workload identity on the AKS cluster:

```azurecli
az aks create \
  --resource-group fabrikam-agents-production \
  --name fabrikam-aks-cluster \
  --enable-oidc-issuer \
  --enable-workload-identity
```

Create a federated identity credential linking the Kubernetes service account to an Azure managed identity:

```azurecli
az identity federated-credential create \
  --name fabrikam-security-scanner-federated \
  --identity-name fabrikam-security-scanner-identity \
  --resource-group fabrikam-agents-production \
  --issuer $(az aks show -n fabrikam-aks-cluster -g fabrikam-agents-production --query "oidcIssuerProfile.issuerUrl" -o tsv) \
  --subject system:serviceaccount:agents:security-scanner \
  --audience api://AzureADTokenExchange
```

In the Kubernetes deployment manifest, annotate the service account:

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: security-scanner
  namespace: agents
  annotations:
    azure.workload.identity/client-id: <security-scanner-managed-identity-client-id>
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: security-scanner
  namespace: agents
spec:
  template:
    metadata:
      labels:
        azure.workload.identity/use: "true"
    spec:
      serviceAccountName: security-scanner
      containers:
      - name: scanner
        image: fabrikam.azurecr.io/security-scanner:latest
```

The Azure SDK automatically uses workload identity when running in a pod with the annotated service account. No credential management needed in application code:

```python
# agents/security_scanner/client.py
from azure.identity import DefaultAzureCredential
from azure.ai.agents import AgentsClient
import os

# DefaultAzureCredential automatically detects workload identity
credential = DefaultAzureCredential()

agents_client = AgentsClient(
    endpoint=os.environ["PROJECT_ENDPOINT"],
    credential=credential,
)
```

## Validate caller identity in agent-to-agent calls

When one agent receives a request from another agent, validate that the caller's identity matches the expected agent service principal. This prevents a compromised external service from impersonating a legitimate agent.

Implement identity validation middleware:

```python
# agents/shared/auth_middleware.py
from azure.identity import DefaultAzureCredential
from azure.core.credentials import TokenCredential
import jwt
from jwt import PyJWKClient
from typing import Optional

class AgentAuthMiddleware:
    """Validate caller identity for agent-to-agent communication."""
    
    def __init__(self, expected_caller_ids: list[str], audience: str, issuer: str):
        """
        Args:
            expected_caller_ids: List of allowed caller managed identity object IDs
            audience: Expected token audience (app ID URI of this agent service)
            issuer: Expected token issuer (https://login.microsoftonline.com/<tenant-id>/v2.0)
        """
        self.expected_caller_ids = expected_caller_ids
        self.audience = audience
        self.issuer = issuer
        self.credential = DefaultAzureCredential()
        # Cache Azure AD public keys; auto-rotates when Azure publishes new signing keys
        self.jwks_client = PyJWKClient(
            "https://login.microsoftonline.com/common/discovery/v2.0/keys",
            cache_keys=True,
        )
    
    def validate_caller(self, authorization_header: str) -> Optional[str]:
        """
        Validate that the bearer token belongs to an expected agent identity.
        
        Returns:
            Caller's object ID if valid, None if invalid
        """
        if not authorization_header.startswith("Bearer "):
            return None
        
        token = authorization_header.split("Bearer ")[1]
        
        try:
            # Fetch the matching public key from Azure AD's JWKS endpoint.
            # This verifies the token was signed by Azure AD, not a forged key.
            signing_key = self.jwks_client.get_signing_key_from_jwt(token)
            
            # Verify signature, issuer, audience, and expiry in a single call.
            # Skipping any of these checks would allow forged or expired tokens.
            decoded = jwt.decode(
                token,
                signing_key.key,
                algorithms=["RS256"],
                audience=self.audience,
                issuer=self.issuer,
            )
            
            caller_oid = decoded.get("oid")  # Object ID of caller identity
            
            if caller_oid in self.expected_caller_ids:
                return caller_oid
            else:
                return None
                
        except jwt.InvalidTokenError:
            return None

# Usage in orchestrator agent that accepts calls from specialist agents
auth = AgentAuthMiddleware(
    expected_caller_ids=[
        "<security-scanner-identity-oid>",
        "<style-checker-identity-oid>",
        "<syntax-analyzer-identity-oid>",
    ],
    audience="api://<code-review-orchestrator-app-id>",
    issuer="https://login.microsoftonline.com/<tenant-id>/v2.0",
)

@app.post("/analyze")
def handle_analysis_request(request: Request):
    caller_id = auth.validate_caller(request.headers.get("Authorization"))
    
    if not caller_id:
        raise HTTPException(status_code=403, detail="Unauthorized agent caller")
    
    # Process request from verified agent
    return process_analysis(request.body)
```

This validation ensures that only legitimate agents in Fabrikam's system can invoke other agents—external attackers can't call agent APIs even if they breach the network perimeter.

With per-agent identities, least-privilege RBAC, user-context federation, just-in-time access patterns, and workload identity implementation, you establish zero-trust identity foundations. The next layer is network controls that prevent lateral movement between agents.

## Key takeaways

- **Just-in-time (JIT) access** with Azure PIM grants elevated permissions only when needed and for a limited time window, preventing agents from accumulating persistent access to sensitive resources.
- **Workload identity for AKS** replaces static Kubernetes secrets with Azure identity federation, enabling containerized agents to authenticate using managed identities without storing credentials in pods.
- **Caller identity validation** in agent-to-agent calls uses JWT token verification to ensure only legitimate agents can invoke other agents—critical for preventing unauthorized lateral access across the agent network.
