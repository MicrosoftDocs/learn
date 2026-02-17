In this module, you learned how to publish Microsoft Foundry agents to Microsoft Teams and Microsoft 365 Copilot, making your AI assistants available where users already work and collaborate.

## Key takeaways

### Publishing approaches

Microsoft Foundry provides a direct publishing path from the portal that handles most integration scenarios. The process automatically:

- Creates an Azure Bot Service resource to route messages
- Registers a Microsoft Entra ID application for authentication
- Generates a Microsoft 365 publishing package for distribution

For complex scenarios requiring custom SSO, middleware, or multi-environment deployment, the Microsoft 365 Agents Toolkit offers an alternative approach through a proxy application.

### Publish scopes

Choose between two distribution options:

- **Shared scope**: Immediate availability for personal testing and small teams, no admin approval required
- **Organization scope**: Organization-wide distribution, requires admin approval in the Microsoft 365 admin center

### Agent identity

Published agents receive a distinct identity separate from your development project. If your agent uses tools that access Azure resources, remember to reassign RBAC permissions to the published agent identity.

### Work IQ for workplace context

Microsoft Work IQ provides agents with access to Microsoft 365 data through the Model Context Protocol (MCP). During development, Work IQ helps you understand workplace context by querying emails, meetings, documents, and Teams messages.

### Testing strategy

Effective testing spans multiple environments:

- **Foundry playground**: Rapid iteration during development
- **Microsoft Teams**: Validation of the complete integrated experience
- **Ongoing monitoring**: Metrics and feedback after deployment

## Clean up resources

If you created resources during this module that you no longer need:

1. Delete the agent in the Foundry portal
2. Remove the Azure Bot Service resource in the Azure portal
3. Uninstall the agent from Microsoft Teams

## Learn more

Continue your learning with these resources:

- [Publish agents to Microsoft 365 Copilot and Microsoft Teams](/azure/ai-foundry/agents/how-to/publish-copilot)
- [Microsoft Work IQ documentation](/microsoft-365-copilot/extensibility/workiq-overview)
- [Microsoft 365 Agents Toolkit overview](/microsoftteams/platform/toolkit/overview-agents-toolkit)
- [Agent identity concepts in Microsoft Foundry](/azure/ai-foundry/agents/concepts/agent-identity)

## Next steps

Now that you can publish agents to Microsoft 365, consider exploring:

- Adding tools to extend your agent's capabilities
- Implementing grounding with enterprise data sources like Azure AI Search
- Building multi-agent systems for complex workflows
