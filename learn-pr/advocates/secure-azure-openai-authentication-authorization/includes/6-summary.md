In this module, you examined how to authenticate and authorize access to Azure OpenAI capabilities in Microsoft Foundry. You compared API keys with Microsoft Entra ID authentication, and learned why keyless authentication with managed identities is the recommended approach for applications that run on Azure.

You also reviewed how authorization changes depending on the target experience:

- For current Microsoft Foundry projects, use **Foundry User** as the least-privilege project access role. Assign **Foundry Project Manager**, **Foundry Account Owner**, or **Foundry Owner** only for progressively elevated management or administration needs; **Foundry Account Owner** doesn't include project data actions by itself.
- For direct Microsoft Foundry Models keyless inference, the documented built-in role is **Cognitive Services User** at the Foundry resource scope. This role is broader than inference-only; for narrower access, use a custom role with the documented `Microsoft.CognitiveServices/accounts/MaaS/*` data action and validate Microsoft Entra ID access before disabling local authentication. Because this custom role uses a wildcard data action, review it periodically and replace it with explicit permissions if more granular Foundry Models operations become available.
- For Azure OpenAI feature access on classic resources, and for OpenAI features on Azure OpenAI resources upgraded to Foundry, use **Cognitive Services OpenAI User** for Microsoft Entra-authenticated inference and **Cognitive Services OpenAI Contributor** for authoring tasks such as creating or editing deployments. Use **Cognitive Services Contributor** for resource management and key access. Assign **Cognitive Services Usages Reader** at subscription scope for quota visibility; it can also be needed alongside **Cognitive Services OpenAI Contributor** for model deployment or edit workflows in the Foundry (classic) portal, but it doesn't grant inference access by itself. Use Foundry roles for broader Foundry project access and non-OpenAI Foundry capabilities.

Before you disable local authentication in production, validate that your applications, tools, automation, and operational runbooks work with Microsoft Entra authentication. After that readiness check, you can plan to disable local authentication to block API key usage. Allow time for the change to propagate and keep a tested re-enable path for emergency rollback, including any Azure Policy exemption or scope change needed if policy enforces disabled local authentication.

## Further reading

- [Use Azure OpenAI without keys](/azure/developer/ai/keyless-connections)
- [Role-based access control for Microsoft Foundry](/azure/foundry/concepts/rbac-foundry)
- [Configure keyless authentication with Microsoft Entra ID for Foundry Models](/azure/foundry/foundry-models/how-to/configure-entra-id)
- [Cognitive Services User built-in role](/azure/role-based-access-control/built-in-roles/ai-machine-learning#cognitive-services-user)
- [Role-based access control for Azure OpenAI in Microsoft Foundry Models (classic)](/azure/ai-foundry/openai/how-to/role-based-access-control)
- [Migrate from the Foundry (classic) portal](/azure/foundry/how-to/navigate-from-classic)
- [Upgrade your Azure OpenAI resource](/azure/foundry/how-to/upgrade-azure-openai)
- [Disable local authentication in Foundry Tools](/azure/ai-services/disable-local-auth)
- [Managed identities for Azure resources](/entra/identity/managed-identities-azure-resources/overview)
