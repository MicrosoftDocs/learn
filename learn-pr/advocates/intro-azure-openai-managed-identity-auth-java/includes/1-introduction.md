Good security practices require controlling how applications access cloud services. For Java applications that use Azure OpenAI in Microsoft Foundry, keyless authentication lets you use Microsoft Entra ID tokens instead of storing API keys in code or configuration.

In this module, you'll learn how Azure RBAC role assignments authorize access to Azure OpenAI, how DefaultAzureCredential supports local development, and how managed identities support Azure-hosted Java applications.

Learning objectives:

By the end of this module, you'll be able to:

- Describe how Microsoft Entra ID and Azure RBAC enable keyless access to Azure OpenAI.
- Configure an Azure OpenAI RBAC role assignment for a user or managed identity.
- Implement DefaultAzureCredential in a Java app for local development.
- Implement managed identity authentication for Azure-hosted Java apps.