In this module, you learned how to configure plugin governance settings and manage the Security Copilot agent lifecycle across Contoso's workspace environment.

You started with plugin governance. Using the Plugin Settings page, you configured user-scope and organization-scope permissions to control who can add custom plugins for their own sessions and who can publish plugins for everyone in the organization. You learned that the organization-scope permission only becomes available once user-scope access is extended to contributors. You restricted preinstalled plugin availability for specific workspaces and understood why those restrictions immediately affect embedded experiences in Defender and other Microsoft portals. You added custom plugins using the Security Copilot plugin and OpenAI plugin formats, and you understood the difference between private and organization-wide plugin scope.

You then moved to agent deployment. Using the agent library, you browsed Microsoft-built and partner-built agents. Then you completed the full setup flow for a Microsoft-built agent—selecting a dedicated agent identity. You configured the trigger and permissions, and ran the agent for its first output. You understood why dedicated agent identities are recommended over shared user accounts. You learned how agent workspace context determines which capacity and plugins the agent can use.

You acquired a partner agent through the Security Store integrated in Security Copilot. You understood the distinction between Security Store subscription costs and Security Compute Unit (SCU) consumption, and why removing an agent from Security Copilot doesn't cancel a partner subscription. For an agent requiring access to Microsoft Defender data, you completed the Global Administrator approval workflow—copying the approval link, waiting for administrator consent, and finishing setup after approval was granted. You then configured the agent's dependent plugin to make the agent fully operational.

Finally, you managed deployed agents over time. You controlled agent execution using automatic triggers and manual one-time runs, edited agent configuration to adjust parameters, and used the pause function before planning workspace reassignment. You provided targeted feedback to improve agent performance and used the memory management interface to review and remove outdated feedback entries.

## Contoso's outcome

With plugin governance and agents in place, Contoso's Security Copilot deployment is operating at full capability:

The **SOC workspace** runs threat-hunting and triage agents with dedicated Defender XDR and Microsoft Sentinel plugin access. SOC analysts benefit from automated preanalysis while maintaining visibility into agent activity.

The **compliance workspace** runs governance-focused agents scoped to Purview, with plugin access restricted to compliance-relevant data sources. The compliance team can focus on investigating alerts rather than manually querying data.

The **sandbox workspace** enables the security architecture team to test custom plugins and experimental agents in isolation. Plugins that prove their value in the sandbox are reviewed and published to production workspaces by the Security Architect.

## Next steps

To continue building your Security Copilot expertise, consider exploring:

- **[Custom agents](/copilot/security/developer/custom-agent-overview)** - Build agents tailored to your organization's specific security and operational workflows using natural language, the agent builder interface, or YAML manifests.
- **[Custom plugins](/copilot/security/custom-plugins)** - Extend Security Copilot's capabilities by developing plugins that connect to your organization's proprietary data sources and security tools.
- **[Describe the embedded experiences of Microsoft Security Copilot](/training/modules/security-copilot-embedded-experiences/)** - Understand how Security Copilot integrates into Defender XDR, Purview, Intune, and Microsoft Entra portals to deliver in-context AI capabilities.
- **[Build your own promptbooks](/copilot/security/build-promptbooks)** - Create multi-step automated workflows to standardize investigation and response procedures across your workspaces.

## Learn more

- [Manage plugins in Microsoft Security Copilot](/copilot/security/manage-plugins)
- [Plugins overview](/copilot/security/plugin-overview)
- [Setup and manage Security Copilot agents](/copilot/security/agents-manage)
- [Discover agents in Microsoft Security Copilot](/copilot/security/discover-agents)
- [Microsoft Security Store in Microsoft Security Copilot](/copilot/security/security-store-integration)
- [What is Microsoft Security Store?](/security/store/what-is-security-store)
