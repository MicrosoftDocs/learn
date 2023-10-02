When you use the agent to deploy artifacts to a set of servers, it must-have "line of sight" connectivity to those servers.

The Microsoft-hosted agent pools, by default, have connectivity to Azure websites and servers running in Azure.

Suppose your on-premises environments don't have connectivity to a Microsoft-hosted agent pool (because of intermediate firewalls). In that case, you'll need to manually configure a self-hosted agent on the on-premises computer(s).

The agents must have connectivity to the target on-premises environments and access to the Internet to connect to Azure Pipelines or Azure DevOps Server, as shown in the following diagram.

:::image type="content" source="../media/agents-stages-behind-firewall-ae9c03be.png" alt-text="Diagram that shows on-premises agents and target on-premises stages are behind the firewall.":::
