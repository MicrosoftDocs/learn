A workload set up with a stored client secret, broad permissions, no assigned owner, and no pre-production validation is common when teams move quickly. It's also the combination that creates the most downstream risk.

Each of those setup choices compounds the others, and the combination is what makes the exposure hard to unwind after the fact. Making each decision deliberately, at setup time, is what keeps a workload identity from becoming an unmonitored exposure.

The practices covered here apply to any AI workload identity. If your organization also manages agent identities provisioned by platforms such as Copilot Studio or Microsoft 365, the same least-privilege and credential-selection principles apply to governing those identities in your tenant, though agent identities have platform-specific provisioning and consent models that this module doesn't cover.

In this module, you learned how to:

- Identify setup decisions that create lasting security risk for AI workload identities.
- Configure the right credential type for an AI workload based on its hosting environment.
- Assign least-privilege permissions across Azure RBAC, Microsoft Graph, and app roles.
- Select the correct roles for Key Vault, Azure AI services, storage, and downstream APIs.
- Validate the identity configuration and plan credential maintenance before production.

## Resources

- [Managed identities for Azure resources](/entra/identity/managed-identities-azure-resources/overview?azure-portal=true)
- [Workload identity federation concepts](/entra/workload-id/workload-identity-federation?azure-portal=true)
- [Azure built-in roles](/azure/role-based-access-control/built-in-roles?azure-portal=true)
- [Microsoft Graph permissions reference](/graph/permissions-reference?azure-portal=true)
- [Provide access to Key Vault using Azure RBAC](/azure/key-vault/general/rbac-guide?azure-portal=true)
- [Service principal sign-in logs](/entra/identity/monitoring-health/concept-sign-ins#service-principal-sign-ins?azure-portal=true)
