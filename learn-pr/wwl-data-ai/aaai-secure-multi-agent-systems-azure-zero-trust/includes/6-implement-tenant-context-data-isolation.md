Azure Cosmos DB partition keys provide database-layer tenant isolation, ensuring each customer's data is physically scoped to their own partition even when agents share infrastructure. In this unit, you propagate tenant context through every agent operation and enforce isolation at the data access layer.

| Isolation Model | Security Level | Cost Efficiency | Update Complexity |
|-----------------|----------------|----------------|-------------------|
| Per-tenant agents | Maximum (complete physical separation) | Low (duplicate infrastructure) | High (coordinate N deployments) |
| Shared agents + logical isolation | High (requires rigorous implementation) | High (shared infrastructure) | Low (single deployment) |
| Hybrid (shared generic + per-tenant sensitive) | High (isolation where it matters most) | Medium (selective duplication) | Medium (partial coordination) |

## Select tenant isolation architecture for your threat model

Three isolation models offer different trade-offs between security, cost, and operational complexity.

**Per-tenant agents** provide maximum isolation by deploying separate agent instances for each customer. Customer A's orchestrator runs in a different Azure Container Apps environment than Customer B's orchestrator. They share no compute resources, no storage, no network paths. This model provides the strongest security guarantee: compromising one tenant's agents doesn't affect others. The cost is substantial—Fabrikam pays for duplicate infrastructure for every customer—and updating 50 customers requires coordinating 50 separate deployments.

**Shared agents with logical isolation** run one set of agents that serve all customers. All tenants' requests flow through the same orchestrator instance. Security depends entirely on correct implementation of tenant context validation: the code must verify that every data access belongs to the requesting tenant. This model is cost-efficient (one infrastructure deployment) and simplifies updates (one deployment update reaches all customers), but requires rigorous security engineering.

**Hybrid architectures** combine both approaches strategically. Generic operations—syntax analysis, style checking—run on shared agents because the risk of cross-tenant leakage is lower. Sensitive operations—accessing customer source code repositories, storing analysis results—use per-tenant agents or per-tenant resources. Fabrikam uses hybrid isolation: shared specialist agents for analysis, per-tenant storage accounts for customer code and reports.

Evaluate your threat model:

- If you handle highly regulated data (healthcare PHI, personal financial data), use per-tenant agents or hybrid with per-tenant storage for sensitive data
- If you handle less sensitive data and cost efficiency is critical, use shared agents with strict logical isolation
- If you have a small number of high-value customers, consider per-tenant infrastructure for premium isolation

## Propagate tenant context through every operation

In the shared agent model, every request carries a tenant identifier. All downstream operations—database queries, storage access, calls to other agents—must propagate this tenant context. Breaking the context chain creates cross-tenant leakage vulnerabilities.

Implement tenant context as middleware that intercepts requests, extracts the tenant ID from authentication claims, and stores it in request-scoped context:

```python
# agents/shared/tenant_context.py
from contextvars import ContextVar
from fastapi import Request, HTTPException
import jwt
from jwt import PyJWKClient

# Azure AD JWKS endpoint; PyJWKClient caches keys and auto-rotates on key rollover
_jwks_client = PyJWKClient(
    "https://login.microsoftonline.com/common/discovery/v2.0/keys",
    cache_keys=True,
)
# Configure audience and issuer to match your app registration
EXPECTED_AUDIENCE = "api://<your-app-id>"  # App ID URI of this service
EXPECTED_ISSUER = "https://login.microsoftonline.com/<tenant-id>/v2.0"

# Thread-local storage for tenant context
current_tenant: ContextVar[str] = ContextVar("current_tenant", default=None)

def extract_tenant_from_token(authorization_header: str) -> str:
    """
    Extract tenant ID from the user's JWT token.
    
    Your identity provider includes tenant ID in custom claims.
    """
    if not authorization_header.startswith("Bearer "):
        raise HTTPException(status_code=401, detail="Missing authorization token")
    
    token = authorization_header.split("Bearer ")[1]
    
    try:
        # Fetch the matching public key from Azure AD's JWKS endpoint.
        # Verifying the signature prevents forged tokens from injecting arbitrary tenant IDs.
        signing_key = _jwks_client.get_signing_key_from_jwt(token)
        
        # Verify signature, issuer, audience, and expiry before extracting any claims.
        decoded = jwt.decode(
            token,
            signing_key.key,
            algorithms=["RS256"],
            audience=EXPECTED_AUDIENCE,
            issuer=EXPECTED_ISSUER,
        )
        tenant_id = decoded.get("tenant_id")
        
        if not tenant_id:
            raise HTTPException(status_code=403, detail="Token missing tenant_id claim")
        
        return tenant_id
    except jwt.InvalidTokenError:
        raise HTTPException(status_code=401, detail="Invalid token")

class TenantContextMiddleware:
    """Middleware to extract and store tenant context for all requests."""
    
    def __init__(self, app):
        self.app = app
    
    async def __call__(self, scope, receive, send):
        if scope["type"] == "http":
            request = Request(scope, receive)
            tenant_id = extract_tenant_from_token(
                request.headers.get("Authorization", "")
            )
            
            # Store in context-local variable
            token = current_tenant.set(tenant_id)
            
            try:
                await self.app(scope, receive, send)
            finally:
                current_tenant.reset(token)
        else:
            await self.app(scope, receive, send)

# Usage: Add to FastAPI app
from fastapi import FastAPI
app = FastAPI()
app.add_middleware(TenantContextMiddleware)
```

Every agent service uses this middleware to establish tenant context at request ingress. All downstream operations read the context to enforce tenant isolation.

## Enforce tenant isolation in data access operations

When agents query databases or storage, include the tenant ID as a mandatory filter condition. Never trust the application layer alone—enforce tenant isolation in the data layer with partitioning and query validation.

In Azure Cosmos DB, use tenant ID as the partition key:

```python
# agents/orchestrator/data_access.py
from azure.cosmos import CosmosClient, PartitionKey
from agents.shared.tenant_context import current_tenant

class CodeReviewRepository:
    """Data access layer with tenant isolation."""
    
    def __init__(self, connection_string: str):
        client = CosmosClient.from_connection_string(connection_string)
        database = client.get_database_client("fabrikam-code-review")
        
        # Container partitioned by tenant_id
        self.container = database.get_container_client("reviews")
    
    def save_review(self, review_data: dict):
        """Save code review with automatic tenant scoping."""
        
        tenant_id = current_tenant.get()
        if not tenant_id:
            raise ValueError("No tenant context available")
        
        # Inject tenant_id into document
        document = {
            "id": review_data["review_id"],
            "tenant_id": tenant_id,  # Partition key
            "code_file": review_data["code_file"],
            "findings": review_data["findings"],
            "timestamp": review_data["timestamp"]
        }
        
        self.container.create_item(document, partition_key=tenant_id)
    
    def get_review(self, review_id: str) -> dict:
        """Retrieve code review with tenant isolation enforced."""
        
        tenant_id = current_tenant.get()
        if not tenant_id:
            raise ValueError("No tenant context available")
        
        try:
            # Query scoped to tenant partition
            item = self.container.read_item(
                item=review_id,
                partition_key=tenant_id
            )
            return item
        except:
            # Item not found in this tenant's partition
            return None
    
    def list_reviews(self, limit: int = 100) -> list[dict]:
        """List code reviews for current tenant only."""
        
        tenant_id = current_tenant.get()
        if not tenant_id:
            raise ValueError("No tenant context available")
        
        # Query automatically scoped to tenant partition
        query = "SELECT * FROM c ORDER BY c.timestamp DESC OFFSET 0 LIMIT @limit"
        
        items = self.container.query_items(
            query=query,
            parameters=[{"name": "@limit", "value": limit}],
            partition_key=tenant_id
        )
        
        return list(items)
```

Because the container uses `tenant_id` as the partition key, Cosmos DB physically isolates data by tenant. Even if application code has a bug and queries without filtering, Cosmos DB only returns documents from the specified partition. This provides defense in depth—the database enforces isolation even if application logic fails.

## Key takeaways

- **Tenant isolation architecture** choices range from shared containers with partition keys (cost-effective) to separate accounts (maximum isolation)—select based on your threat model and compliance requirements.
- **Tenant context propagation** ensures every operation carries the tenant identifier from the initial request through all agent-to-agent calls, preventing context-free operations that could leak data.
- **Data access enforcement** validates tenant scope at the database query level, ensuring queries are physically scoped to a single tenant's partition and never span tenant boundaries.
