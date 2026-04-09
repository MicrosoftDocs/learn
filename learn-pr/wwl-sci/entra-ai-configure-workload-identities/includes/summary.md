At the start of this module, the challenge was to set up AI workload identities without carrying forward weak credentials, excessive permissions, or agent identities that lack clear accountability.

You can now address that challenge by choosing the credential model that fits the hosting environment, scoping access to the workload's task, and using the blueprint and accountability model correctly for agent identities.

In this module, you learned how to:

- Recognize the setup choices that create security risk for AI workload identities.
- Select and configure the appropriate credential pattern for an AI workload identity based on where the workload runs.
- Apply least-privilege access by right-sizing Azure RBAC, Microsoft Graph permissions, and app roles.
- Explain how agent identity blueprints govern creation, credentials, and token exchange for agent identities.
- Assign owners, sponsors, and managers to establish accountability for agent identities.

The most important setup discipline is to treat successful authentication as only one checkpoint. A secure setup also requires scoped permissions, documented ownership, required sponsorship, and a configuration model that matches how the workload or agent actually operates.

## Resources

- [Managed identities for Azure resources](https://learn.microsoft.com/entra/identity/managed-identities-azure-resources/overview?azure-portal=true)
- [Workload identity federation concepts](https://learn.microsoft.com/entra/workload-id/workload-identity-federation?azure-portal=true)
- [Create an agent identity blueprint](https://learn.microsoft.com/entra/agent-id/identity-platform/create-blueprint?azure-portal=true)
- [Create agent identities in agent identity platform](https://learn.microsoft.com/entra/agent-id/identity-platform/create-delete-agent-identities?azure-portal=true)
- [Administrative relationships in Microsoft Entra Agent ID](https://learn.microsoft.com/entra/agent-id/identity-platform/agent-owners-sponsors-managers?azure-portal=true)
