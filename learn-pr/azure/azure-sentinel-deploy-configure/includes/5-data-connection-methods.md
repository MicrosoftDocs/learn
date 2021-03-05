To deploy the proof-of-concept environment, you must also understand how connections that use agents differ from built-in connectors.

## Connect to a variety of sources using Syslog or CEF agents

Connect Azure Sentinel to any data source that can perform real-time log streaming by using an agent and the Syslog protocol.

Most appliances use the Syslog protocol to send event messages that include the log and log data. The log format varies, but most appliances support CEF-based format for log data.

The advantage of CEF over Syslog is that it ensures the data is normalized. This makes it more useful for analysis by using Sentinel. Unlike many other Security Information and Event Management products, Sentinel can ingest unparsed Syslog events and perform analytics on them by using query-time parsing.

The Azure Sentinel agent converts CEF-formatted logs into a format that Log Analytics can ingest. Depending on the appliance type, the agent installs directly on the appliance or on a dedicated Linux-based log forwarder. The Azure Sentinel agent is actually the Azure Monitor Log Analytics agent.

The agent for Linux receives events from the Syslog daemon over User Datagram Protocol (UDP) unless you expect the Linux machine to collect a high volume of Syslog events. In that case, they're sent over Transmission Control Protocol (TCP) from the Syslog daemon to the agent. The Syslog daemon then sends the data to Log Analytics. The agent caches data, which helps prevent data loss in case of communication issues between the agent and the cloud.

The Log Analytics agent can collect different types of events from servers and endpoints. After it's enabled through the Azure Sentinel data connectors, events are collected by every agent that's configured to send data to the workspace.

Support for connecting through an agent includes these devices and solutions:

- Data loss prevention (DLP) solutions
- Threat intelligence providers
- Domain Name System (DNS) services
- MBAM/Bitlocker logs
- Internet Information Services
- Linux servers
- Microsoft Endpoint Configuration Manager
- Microsoft SQL Server
- System Monitor (Sysmon)
- Other cloud providers

### Firewalls, internet proxies, and endpoints

- Vectra Cognito
- Check Point
- Cisco ASA
- ExtraHop Reveal(x)
- F5 ASM
- Forcepoint products
- Fortinet
- Palo Alto Networks
- One Identity Safeguard
- Other CEF appliances
- Other Syslog appliances
- Trend Micro Deep Security
- Zscaler

## External appliance connection options

To connect an external appliance to Azure Sentinel, the agent must deploy on a dedicated Azure virtual machine (VM) or an on-premises system to support the communication between the appliance and Azure Sentinel. You can deploy the agent automatically or manually. Automatic deployment is only available if your dedicated machine is a new VM that you create in Azure.

The following diagram illustrates on-premises systems sending Syslog data to a dedicated Azure VM running the Azure Sentinel agent.

:::image type="content" source="../media/sentinel-agent-1.png" alt-text="Diagram of the data flow between on-premises systems that use automatic deployment of the Syslog agent." border="false":::

Alternatively, you can manually deploy the agent on an existing Azure VM, on a VM in another cloud, or on an on-premises machine. The following diagram illustrates on-premises systems sending Syslog data to a dedicated on-premises system that's running the Azure Sentinel agent.

:::image type="content" source="../media/sentinel-agent-2.png" alt-text="Diagram of the data flow between on-premises systems that use manual deployment of the Syslog agent." border="false":::

### Security considerations

Make sure that you configure a system's security according to your organization's security policy. To configure your network to align with a corporate network security policy, change the ports and protocols in the daemon to align with your requirements.

Some Azure security services and features that help secure your VMs and storage data include:

- **Antimalware**: Microsoft Antimalware for Azure Cloud Services and Virtual Machines provides free, real-time protection that you can use to help identify and remove viruses, spyware, and other malicious software.
- **Azure Security Center**: Security Center helps prevent, detect, and respond to threats to your VMs.
- **Encryption**: Azure Disk Encryption provides encryption at the operating system level, and server-side encryption occurs at the platform level.
- **Azure Key Vault and SSH keys**: Azure Key Vault is a service that provides centralized secrets management, with full control over access policies and audit history.
- **Managed identities for Azure resources**: Managed identities for Azure resources provide Azure services with an automatically managed identity in Azure AD.
- **Policies**: Policies enable an organization to enforce various conventions and rules throughout the enterprise.
- **RBAC**: Azure RBAC lets you segregate duties within your team. You can also limit access to your VM to the users who need it to do their jobs.
