When using agents to deploy artifacts to target servers, the agent must have "line of sight" connectivity to those servers.

## Microsoft-hosted agent connectivity

Microsoft-hosted agent pools have default connectivity to:

- Azure websites
- Servers running in Azure
- Most internet-accessible endpoints

## On-premises deployment requirements

If your on-premises environments don't have connectivity to Microsoft-hosted agent pools due to firewalls or network restrictions, you'll need to set up self-hosted agents.

**Self-hosted agent requirements:**

- Connectivity to target on-premises environments
- Internet access to connect to Azure Pipelines or Azure DevOps Server
- Appropriate network configuration to reach both internal and external resources

:::image type="content" source="../media/agents-stages-behind-firewall-ae9c03be.png" alt-text="Diagram that shows on-premises agents and target on-premises stages are behind the firewall.":::

## Network considerations

**Firewall configuration:** Ensure your self-hosted agents can communicate through firewalls to both Azure DevOps and your target deployment servers.

**Security:** Implement appropriate security measures while maintaining necessary connectivity for deployments.

**Performance:** Consider network latency and bandwidth when planning agent placement relative to deployment targets.
