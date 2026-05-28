Good security practices require that you control which users, apps, and workloads can access Azure OpenAI deployments. This module focuses on securing Azure OpenAI in current Microsoft Foundry project and resource scenarios. You'll compare key-based authentication with Microsoft Entra ID authentication, learn how managed identities fit into keyless authentication, and see how least-privilege RBAC role sets and local-authentication controls reduce risk.

Role choices depend on the target surface. Use Foundry roles for current Microsoft Foundry project access, Cognitive Services User or a narrower custom role with the documented `Microsoft.CognitiveServices/accounts/MaaS/*` wildcard data action for direct Microsoft Foundry Models keyless inference, and Cognitive Services OpenAI roles for classic Azure OpenAI resources and OpenAI feature access on Azure OpenAI resources upgraded to Foundry.

Learning objectives:

By the end of this module, you'll be able to:

- Compare key-based authentication with Microsoft Entra ID authentication for Azure OpenAI in Microsoft Foundry.
- Describe how managed identities, service principals, and user credentials work with Microsoft Entra ID authentication.
- Choose role sets for the target surface: Foundry project roles, Cognitive Services User or a narrower custom `Microsoft.CognitiveServices/accounts/MaaS/*` wildcard data-plane role for direct Foundry Models keyless inference, and Cognitive Services OpenAI roles for classic Azure OpenAI resources or OpenAI feature access on Azure OpenAI resources upgraded to Foundry.
- Explain when to disable local authentication after validating Microsoft Entra ID access.
