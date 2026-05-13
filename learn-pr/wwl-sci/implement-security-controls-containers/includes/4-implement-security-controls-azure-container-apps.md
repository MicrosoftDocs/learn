Azure Container Apps provides a managed platform for running containerized microservices, APIs, and event-driven workloads. Unlike Container Instances, which run individual workloads in isolation, Container Apps environments group multiple services together and share infrastructure. That shared model requires deliberate configuration to prevent services with different trust levels from interfering with each other, and to ensure that internal services aren't unintentionally exposed to the internet.

## Understand the Container Apps environment as an isolation boundary

Every Container App runs inside a **Container Apps environment**. The environment defines the virtual network subnet, shared log analytics workspace, and Dapr configuration that all apps in the environment share. Apps within the same environment can communicate over a private internal address space. Apps in different environments are isolated by default.

This architecture has a direct security implication: apps with different trust levels shouldn't share an environment. An e-commerce platform that runs both public-facing APIs and internal backend services should use separate environments — the backend environment configured for VNet-only access, the frontend environment for external ingress. Mixing services with different exposure requirements in a single environment means a misconfigured ingress rule on one app could expose other services in the same environment.

## Assign managed identities to Container Apps

Container Apps support both system-assigned and user-assigned managed identities. Use managed identities to pull images from Azure Container Registry, retrieve secrets from Azure Key Vault, call Azure OpenAI and Azure AI Foundry endpoints, and interact with any other Azure service that supports Microsoft Entra authentication.

To assign a system-assigned identity to a Container App:

```azurecli
az containerapp identity assign \
  --name <app-name> \
  --resource-group <rg> \
  --system-assigned
```

Grant the identity the roles it needs. For ACR image pull:

```azurecli
az role assignment create \
  --assignee <managed-identity-principal-id> \
  --role AcrPull \
  --scope /subscriptions/<subscription-id>/resourceGroups/<rg>/providers/Microsoft.ContainerRegistry/registries/<registry-name>
```

User-assigned identities are useful when multiple Container Apps share the same permissions. Create the identity once, assign it the required roles, and attach it to each app that needs it. This is more efficient than creating separate system-assigned identities that each need the same role assignments.

## Control ingress access

Ingress determines how a Container App receives network traffic. Two ingress modes are available:

- **External ingress**: The app is accessible from the public internet. It receives a public FQDN and can be fronted by Azure Front Door or Application Gateway.
- **Internal ingress**: The app is accessible only from within the Container Apps environment or other resources in the same VNet. No public IP address is assigned.

Set backend APIs, queue processors, and data services to internal ingress. Only services that genuinely need to be reachable from outside your network should use external ingress. The Contoso Retail environment had every service set to external, exposing internal services to the public internet without a business reason — internal ingress removes that exposure with a single configuration change.

You can restrict external ingress further using IP security restrictions. Configure an allowlist of trusted source IP addresses or CIDR ranges:

```azurecli
az containerapp ingress access-restriction set \
  --name <app-name> \
  --resource-group <rg> \
  --rule-name allow-corporate \
  --ip-address 203.0.113.0/24 \
  --action Allow
```

For apps that serve authenticated users, use the built-in authentication middleware — often called EasyAuth — to require Microsoft Entra ID login before a request reaches your container code. Configure it in the Azure portal under **Authentication** on your Container App, or with the CLI. The middleware intercepts unauthenticated requests and redirects users to the Microsoft Entra ID sign-in page. No application code changes are required.

## Manage secrets with Key Vault references

Container Apps provide two mechanisms for managing secrets.

**Environment-level secrets** are stored within the Container Apps platform and injected as environment variables or volume mounts at runtime. They're suitable for configuration values that change infrequently and don't require centralized rotation or audit.

**Key Vault references** point to a secret in Azure Key Vault by URI and retrieve the value at runtime using the app's managed identity. The secret value is never stored in the Container Apps configuration — the platform fetches it each time it's needed. This is the recommended approach for credentials, connection strings, and any value that must be audited or rotated centrally.

To reference a Key Vault secret:

```azurecli
az containerapp secret set \
  --name <app-name> \
  --resource-group <rg> \
  --secrets "db-connection=keyvaultref:<key-vault-secret-uri>,identityref:<managed-identity-resource-id>"
```

When you rotate the secret value in Key Vault, the Container App retrieves the updated value on the next container restart. You don't update the Container App configuration to pick up the new secret — the Key Vault URI remains the same; only the value it points to changes.

## Secure service-to-service communication with Dapr

Dapr (Distributed Application Runtime) is a Cloud Native Computing Foundation (CNCF) project that provides application-level capabilities through a sidecar architecture. In Azure Container Apps, enabling Dapr adds a sidecar container alongside your application container. The sidecar handles service-to-service invocation, pub/sub messaging, state management, and external bindings — your application communicates with the sidecar over localhost rather than directly with other services or infrastructure.

The most important security behavior Dapr provides is **mutual TLS (mTLS)**. Dapr sidecars automatically negotiate and enforce mTLS for all service-to-service communication within the Container Apps environment. Traffic between two Dapr-enabled apps is encrypted in transit without any configuration required in the application code. You don't manage certificates or implement TLS in your services — Dapr handles it.

When you're assessing a Container Apps environment that uses Dapr, verify these security configurations:

- **Component scoping**: Dapr components — such as state stores, pub/sub brokers, and secret stores — can be scoped to specific apps. Without scoping, any Dapr-enabled app in the environment can use any component. Apply app-level scoping to restrict each component to the apps that legitimately need it.
- **Secret store configuration**: Configure Dapr's secret store component to use Azure Key Vault, backed by the app's managed identity. This eliminates hardcoded credentials in Dapr component configuration.
- **Dapr dashboard exposure**: The Dapr dashboard provides observability into running Dapr components and active services. Confirm it isn't exposed with external ingress — it should only be accessible within the environment or over a private network connection.

> [!TIP]
> For a full overview of Dapr integration in Container Apps, including how to configure components and enable Dapr on an existing app, see [Dapr integration with Azure Container Apps](/azure/container-apps/dapr-overview).
