Azure Key Vault customer-managed keys and Microsoft Sentinel enforce data isolation at the cryptographic and monitoring layers, ensuring tenant boundaries hold even when application code fails. In this unit, you implement boundary validation at every API endpoint, configure per-tenant encryption, and monitor for cross-tenant access attempts.

## Validate tenant boundaries at every API boundary

Every inter-agent API call must validate that the tenant context in the request matches the tenant context in the operation. Agent A serving Customer X should never make a request on behalf of Customer Y—even accidentally.

Implement tenant boundary validation as a decorator:

```python
# agents/shared/tenant_validation.py
from functools import wraps
from fastapi import HTTPException
from agents.shared.tenant_context import current_tenant

def require_tenant_match(extract_tenant_from_args):
    """
    Decorator that validates tenant ID in operation matches current tenant context.
    
    Args:
        extract_tenant_from_args: Function that extracts tenant ID from operation arguments
    """
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            # Get current tenant from request context
            request_tenant = current_tenant.get()
            if not request_tenant:
                raise HTTPException(status_code=403, detail="No tenant context")
            
            # Extract tenant from operation arguments
            operation_tenant = extract_tenant_from_args(*args, **kwargs)
            
            # Validate match
            if request_tenant != operation_tenant:
                # LOG SECURITY INCIDENT
                print(f"SECURITY: Attempted cross-tenant access - request tenant {request_tenant} tried to access {operation_tenant} data")
                raise HTTPException(status_code=403, detail="Cross-tenant access denied")
            
            return func(*args, **kwargs)
        return wrapper
    return decorator

# Usage in agent endpoint
class OrchestatorAgent:
    
    @require_tenant_match(lambda self, review_id, **kw: self._extract_tenant_from_review_id(review_id))
    def get_review_result(self, review_id: str):
        """Retrieve review result with tenant boundary validation."""
        
        # Validation passed - safe to proceed
        return self.repository.get_review(review_id)
    
    def _extract_tenant_from_review_id(self, review_id: str) -> str:
        """Parse tenant ID from review ID format tenant_timestamp_uuid."""
        return review_id.split("_")[0]
```

Any attempt to access data from a different tenant triggers an exception and generates a security log. This creates an audit trail of potential cross-tenant access attempts for investigation.

## Use customer-managed encryption keys for maximum isolation

For maximum data isolation, use customer-managed encryption keys (CMK) stored in customer-controlled Azure Key Vaults. Each customer's data is encrypted with their own key. Even Fabrikam staff cannot read customer data without the customer's key authorization.

Configure Cosmos DB with per-tenant encryption keys:

```azurecli
# Customer A provides their Key Vault and key
az cosmosdb create \
  --name fabrikam-reviews-customer-a \
  --resource-group fabrikam-production \
  --key-uri https://customer-a-kv.vault.azure.net/keys/cosmos-encryption-key \
  --assign-identity [system]

# Grant Cosmos DB managed identity access to customer's Key Vault
az keyvault set-policy \
  --name customer-a-kv \
  --object-id <cosmos-managed-identity-oid> \
  --key-permissions get unwrapKey wrapKey
```

With CMK, each customer's data is encrypted with a unique key they control. If Customer A revokes Fabrikam's access to their key, Fabrikam's agents can no longer decrypt Customer A's data—providing a cryptographic guarantee of data control.

## Monitor and alert on cross-tenant access attempts

Despite all defensive controls, monitor for cross-tenant access attempts as indicators of compromise or bugs. Log every operation that fails tenant boundary validation and aggregate patterns.

Export tenant validation logs to Azure Sentinel:

```kusto
// Sentinel KQL query: Detect cross-tenant access patterns
FabrikamAgentLogs
| where EventType == "TenantBoundaryViolation"
| summarize AttemptCount=count(), DistinctTargetTenants=dcount(TargetTenantId) by RequestTenant=SourceTenantId, AgentName, bin(TimeGenerated, 1h)
| where AttemptCount > 10  // More than 10 violations per hour indicates systematic issue
| project TimeGenerated, RequestTenant, AgentName, AttemptCount, DistinctTargetTenants
```

Generate alerts when:

- A single tenant generates many cross-tenant access attempts (possible compromise)
- A single agent generates violations for many different tenants (possible code bug)
- Violations spike suddenly (possible attack or deployment regression)

Treat these alerts as high-priority security incidents requiring immediate investigation.

With tenant context propagation, data layer isolation, boundary validation, customer-managed encryption, and monitoring in place, you establish comprehensive multitenant isolation. The final security layer is configuring compliance controls that map regulatory requirements to agent behaviors.

## Key takeaways

- **API boundary validation** enforces tenant identity checks at every service endpoint, returning HTTP 403 for cross-tenant access attempts even if the caller is authenticated.
- **Customer-managed encryption keys (CMK)** give each tenant control over their data encryption, ensuring one tenant's data cannot be decrypted using another tenant's key material.
- **Cross-tenant monitoring** uses Azure Monitor alerts to detect and respond to anomalous access patterns that could indicate data leakage or compromised credentials.
