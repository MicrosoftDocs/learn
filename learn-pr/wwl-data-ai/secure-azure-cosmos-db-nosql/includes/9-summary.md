You secure an Azure Cosmos DB application and account by matching authentication, permissions, network access, and field exposure to the workload's needs. These decisions give you specific boundaries to verify with the intended identity and application environment.

## What you learned

- You choose Microsoft Entra managed identity for supported Azure hosts and distinguish local developer credentials from explicit managed identity credentials in deployed applications.
- You store account keys in Azure Key Vault and refresh every consumer's credentials during rotation, verifying replacement use before regenerating the old key.
- You distinguish control-plane account management from data-plane operations and assign least-privilege roles at appropriate scopes, checking broader grants and permissions that expose account keys.
- You distinguish IP firewalls and service endpoints from private endpoints, verify private DNS resolution, and explicitly disable public access when configuring a private-only account.
- You apply dynamic data masking to read projections, restrict unmask permission, and account for query inference, unmasked write responses, and unchanged stored data.

## Learn more

- [Connect with Microsoft Entra authentication](/azure/cosmos-db/how-to-connect-role-based-access-control)
- [Rotate account keys](/azure/cosmos-db/how-to-rotate-keys)
- [Review data-plane roles and permissions](/azure/cosmos-db/reference-data-plane-security)
- [Configure private endpoints and DNS](/azure/cosmos-db/how-to-configure-private-endpoints)
- [Configure virtual network service endpoints](/azure/cosmos-db/how-to-configure-vnet-service-endpoint)
- [Configure IP firewall rules](/azure/cosmos-db/how-to-configure-firewall)
- [Configure dynamic data masking](/azure/cosmos-db/dynamic-data-masking)
