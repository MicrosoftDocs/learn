A workload set up with a stored client secret, broad permissions, no assigned owner, and no preproduction validation is common when teams move quickly. It's also the combination that creates the most downstream risk.

Each of those setup choices compounds the others, and the combination makes the exposure hard to unwind after the fact. Deliberate decisions at setup time prevent a workload identity from becoming an unmonitored exposure.

In this module, you learned how to:

- Explain what makes identity setup decisions hard to fix after a workload reaches production.
- Configure the right credential type for an AI workload based on its hosting environment.
- Assign least-privilege permissions across Azure RBAC, Microsoft Graph, and app roles.
- Select the correct roles for Key Vault, Azure AI services, storage, and downstream APIs.
- Validate the identity configuration and plan credential maintenance before production.

The practices covered here apply to any AI workload identity built on app registrations, managed identities, or service principals. If your organization also manages agent identities provisioned by platforms such as Copilot Studio or Microsoft 365, the same least-privilege and credential-selection principles apply to governing those identities in your tenant. Agent identities have platform-specific provisioning and consent models that require separate guidance.

## Resources

- [Managed identities for Azure resources](/entra/identity/managed-identities-azure-resources/overview?azure-portal=true)
- [Workload identity federation concepts](/entra/workload-id/workload-identity-federation?azure-portal=true)
- [Azure built-in roles](/azure/role-based-access-control/built-in-roles?azure-portal=true)
- [Microsoft Graph permissions reference](/graph/permissions-reference?azure-portal=true)
- [Provide access to Key Vault using Azure RBAC](/azure/key-vault/general/rbac-guide?azure-portal=true)
- [Service principal sign-in logs](/entra/identity/monitoring-health/concept-sign-ins#service-principal-sign-ins?azure-portal=true)
