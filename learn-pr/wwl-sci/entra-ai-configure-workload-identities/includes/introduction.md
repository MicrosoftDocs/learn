An organization can secure user access and still create unnecessary risk. AI workloads can use the wrong credential type, receive broad permissions, or create agent identities without clear accountability.

Consider an AI service that runs outside Azure and uses a client secret for authentication. The secret is stored in code, the application is granted broad Microsoft Graph permissions, and no sponsor is assigned to the agent identity. The workload functions, but the design introduces avoidable risk across authentication, access, and lifecycle management.

Those decisions shape how safely the workload authenticates, what it can access, and who makes lifecycle and incident decisions after deployment. To set up AI workload identities well, you need to match the credential model to the hosting environment, scope access to the workload's actual task, and understand how Microsoft Entra Agent ID blueprints govern agent identities.

## Learning objectives

In this module, you'll:

- Recognize the setup choices that create security risk for AI workload identities.
- Select and configure the appropriate credential pattern for an AI workload identity based on where the workload runs.
- Apply least-privilege access by right-sizing Azure RBAC, Microsoft Graph permissions, and app roles.
- Explain how agent identity blueprints govern creation, credentials, and token exchange for agent identities.
- Assign owners, sponsors, and managers to establish accountability for agent identities.
