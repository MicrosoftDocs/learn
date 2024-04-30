## Primary scenarios

Use the Log Analytics agent if you need to:

 -  Collect logs and performance data from Azure virtual machines or hybrid machines hosted outside of Azure.
 -  Send data to a Log Analytics workspace to take advantage of features supported by [Azure Monitor Logs](/azure/azure-monitor/logs/data-platform-logs), such as [log queries](/azure/azure-monitor/logs/log-query-overview).
 -  Use [VM insights](/azure/azure-monitor/vm/vminsights-overview), which allows you to monitor your machines at scale and monitor their processes and dependencies on other resources and external processes.
 -  Manage the security of your machines by using [Microsoft Defender for Cloud](/azure/security-center/security-center-introduction) or [Microsoft Sentinel](/azure/sentinel/overview).
 -  Use [Azure Automation Update Management](/azure/automation/update-management/overview), [Azure Automation State Configuration](/azure/automation/automation-dsc-overview), or [Azure Automation Change Tracking and Inventory](/azure/automation/change-tracking/overview) to deliver comprehensive management of your Azure and non-Azure machines.
 -  Use different [solutions](/previous-versions/azure/azure-monitor/insights/solutions) to monitor a particular service or application.

Limitations of the Log Analytics agent:

 -  Can't send data to Azure Monitor Metrics, Azure Storage, or Azure Event Hubs.
 -  Difficult to configure unique monitoring definitions for individual agents.
 -  Difficult to manage at scale because each virtual machine has a unique configuration.

## Comparison to other agents

For a comparison between the Log Analytics and other agents in Azure Monitor, see [Overview of Azure Monitor agents](/azure/azure-monitor/agents/agents-overview).

## Supported operating systems

For a list of the Windows and Linux operating system versions that are supported by the Log Analytics agent, see [Supported operating systems](/azure/azure-monitor/agents/agents-overview#supported-operating-systems).

> [!IMPORTANT]
> The legacy [Log Analytics agent](/azure/azure-monitor/agents/log-analytics-agent) will be deprecated by August 2024. After this date, Microsoft will no longer provide any support for the Log Analytics agent. [Migrate to Azure Monitor agent](/azure/azure-monitor/agents/azure-monitor-agent-migration) before August 2024 to continue ingesting data.

> [!NOTE]
> Cloning a machine with the Log Analytics Agent already configured is *not* supported. If the agent is already associated with a workspace, cloning won't work for "golden images."

## Azure virtual machine

 -  Use [VM insights](/azure/azure-monitor/vm/vminsights-enable-overview) to install the agent for a [single machine using the Azure portal](/azure/azure-monitor/vm/vminsights-enable-portal) or for [multiple machines at scale](/azure/azure-monitor/vm/vminsights-enable-policy). This installs the Log Analytics agent and [Dependency agent](/azure/azure-monitor/vm/vminsights-dependency-agent-maintenance).
 -  Log Analytics VM extension for [Windows](/azure/virtual-machines/extensions/oms-windows) or [Linux](/azure/virtual-machines/extensions/oms-linux) can be installed with the Azure portal, Azure CLI, Azure PowerShell, or an Azure Resource Manager template.
 -  [Microsoft Defender for Cloud can provision the Log Analytics agent](/azure/security-center/security-center-enable-data-collection) on all supported Azure VMs and any new ones that are created if you enable it to monitor for security vulnerabilities and threats.
 -  Install for individual Azure virtual machines [manually from the Azure portal](/azure/azure-monitor/vm/monitor-virtual-machine?toc=/azure/azure-monitor/toc.json).
 -  Connect the machine to a workspace from the Virtual machines (deprecated) option in the Log Analytics workspaces menu in the Azure portal.

## Windows virtual machine on-premises or in another cloud

 -  Use [Azure Arc-enabled servers](/azure/azure-arc/servers/overview) to deploy and manage the Log Analytics VM extension. Review the [deployment options](/azure/azure-arc/servers/concept-log-analytics-extension-deployment) to understand the different deployment methods available for the extension on machines registered with Azure Arc-enabled servers.
 -  [Manually install](/azure/azure-monitor/agents/agent-windows) the agent from the command line.
 -  Automate the installation with [Azure Automation DSC](/azure/azure-monitor/agents/agent-windows#install-the-agent).
 -  Use a [Resource Manager template with Azure Stack](https://github.com/Azure/AzureStack-QuickStart-Templates/tree/master/MicrosoftMonitoringAgent-ext-win).

## Linux virtual machine on-premises or in another cloud

 -  Use [Azure Arc-enabled servers](/azure/azure-arc/servers/overview) to deploy and manage the Log Analytics VM extension. Review the [deployment options](/azure/azure-arc/servers/concept-log-analytics-extension-deployment) to understand the different deployment methods available for the extension on machines registered with Azure Arc-enabled servers.
 -  [Manually install](/azure/azure-monitor/agents/agent-linux#install-the-agent) the agent calling a wrapper-script hosted on GitHub.
 -  Integrate [System Center Operations Manager](/azure/azure-monitor/agents/om-agents) with Azure Monitor to forward collected data from Windows computers reporting to a management group.

## Data collected

The following table lists the types of data you can configure a Log Analytics workspace to collect from all connected agents.

| **Data Source**                                                                                                | **Description**                                                                               |
| -------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- |
| [Windows Event logs](/azure/azure-monitor/agents/data-sources-windows-events) | Information sent to the Windows event logging system                                          |
| [Syslog](/azure/azure-monitor/agents/data-sources-syslog)                     | Information sent to the Linux event logging system                                            |
| [Performance](/azure/azure-monitor/agents/data-sources-performance-counters)  | Numerical values measuring performance of different aspects of operating system and workloads |
| [IIS logs](/azure/azure-monitor/agents/data-sources-iis-logs)                 | Usage information for IIS websites running on the guest operating system                      |
| [Custom logs](/azure/azure-monitor/agents/data-sources-custom-logs)           | Events from text files on both Windows and Linux computers                                    |

## Other services

The agent for Linux and Windows isn't only for connecting to Azure Monitor. Other services such as Microsoft Defender for Cloud and Microsoft Sentinel rely on the agent and its connected Log Analytics workspace. The agent also supports Azure Automation to host the Hybrid Runbook Worker role and other services such as [Change Tracking](/azure/automation/change-tracking/overview), [Update Management](/azure/automation/update-management/overview), and [Microsoft Defender for Cloud](/azure/security-center/security-center-introduction). For more information about the Hybrid Runbook Worker role, see [Azure Automation Hybrid Runbook Worker](/azure/automation/automation-hybrid-runbook-worker).

## Workspace and management group limitations

For details on connecting an agent to an Operations Manager management group, see [Configure agent to report to an Operations Manager management group](/azure/azure-monitor/agents/agent-manage#configure-agent-to-report-to-an-operations-manager-management-group).

 -  Windows agents can connect to up to four workspaces, even if they're connected to a System Center Operations Manager management group.
 -  The Linux agent doesn't support multi-homing and can only connect to a single workspace or management group.

## Security limitations

The Windows and Linux agents support the [FIPS 140 standard](/windows/security/threat-protection/fips-140-validation), but [other types of hardening might not be supported](/azure/azure-monitor/agents/agent-linux#supported-linux-hardening).

## TLS protocol

To ensure the security of data in transit to Azure Monitor logs, we strongly encourage you to configure the agent to use at least Transport Layer Security (TLS) 1.2. Older versions of TLS/Secure Sockets Layer (SSL) have been found to be vulnerable. Although they still currently work to allow backward compatibility, they are *not recommended*. For more information, see [Sending data securely using TLS](/azure/azure-monitor/logs/data-security#sending-data-securely-using-tls).

## Network requirements

The agent for Linux and Windows communicates outbound to the Azure Monitor service over TCP port 443. If the machine connects through a firewall or proxy server to communicate over the internet, review the following requirements to understand the network configuration required. If your IT security policies do not allow computers on the network to connect to the internet, set up a [Log Analytics gateway](/azure/azure-monitor/agents/gateway) and configure the agent to connect through the gateway to Azure Monitor. The agent can then receive configuration information and send data collected.

:::image type="content" source="../media/agent-for-linux-and-windows-211160f6.png" alt-text="Diagram showing an example of network requirements for linux and windows virtual machines." lightbox="../media/agent-for-linux-and-windows-211160f6.png":::


The following table lists the proxy and firewall configuration information required for the Linux and Windows agents to communicate with Azure Monitor logs.

### Firewall requirements

| **Agent Resource**          | **Ports** | **Direction** | **Bypass HTTPS inspection** |
| --------------------------- | --------- | ------------- | --------------------------- |
| \*.ods.opinsights.azure.com | Port 443  | Outbound      | Yes                         |
| \*.oms.opinsights.azure.com | Port 443  | Outbound      | Yes                         |
| \*.blob.core.windows.net    | Port 443  | Outbound      | Yes                         |
| \*.azure-automation.net     | Port 443  | Outbound      | Yes                         |

For firewall information required for Azure Government, see [Azure Government management](/azure/azure-government/compare-azure-government-global-azure#azure-monitor).

> [!IMPORTANT]
> If your firewall is doing CNAME inspections, you need to configure it to allow all domains in the CNAME.

If you plan to use the Azure Automation Hybrid Runbook Worker to connect to and register with the Automation service to use runbooks or management features in your environment, it must have access to the port number and the URLs described in [Configure your network for the Hybrid Runbook Worker](/azure/automation/automation-hybrid-runbook-worker#network-planning).

### Proxy configuration

The Windows and Linux agent supports communicating either through a proxy server or Log Analytics gateway to Azure Monitor by using the HTTPS protocol. Both anonymous and basic authentication (username/password) are supported.

For the Windows agent connected directly to the service, the proxy configuration is specified during installation or [after deployment](/azure/azure-monitor/agents/agent-manage#update-proxy-settings) from Control Panel or with PowerShell. Log Analytics Agent (MMA) doesn't use the system proxy settings. As a result, the user has to pass the proxy setting while installing MMA. These settings will be stored under MMA configuration (registry) on the virtual machine.

For the Linux agent, the proxy server is specified during installation or [after installation](/azure/azure-monitor/agents/agent-manage#update-proxy-settings) by modifying the proxy.conf configuration file. The Linux agent proxy configuration value has the following syntax:

`[protocol://][user:password@]proxy host[:port]`

| **Property** | **Description**                                                 |
| ------------ | --------------------------------------------------------------- |
| Protocol     | https                                                           |
| user         | Optional username for proxy authentication                      |
| password     | Optional password for proxy authentication                      |
| proxy host   | Address or FQDN of the proxy server/Log Analytics gateway       |
| port         | Optional port number for the proxy server/Log Analytics gateway |

For example: `https://user01:password@proxy01.contoso.com:30443`

> [!NOTE]
> If you use special characters such as "@" in your password, you'll receive a proxy connection error because the value is parsed incorrectly. To work around this issue, encode the password in the URL by using a tool like [URLDecode](https://www.urldecoder.org/).
