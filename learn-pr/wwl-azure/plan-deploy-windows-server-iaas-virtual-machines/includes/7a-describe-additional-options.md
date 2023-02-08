
Once Contoso has deployed numerous virtual machines in Azure across Windows Server, they'll need to optimize their operations and management tasks. Azure Automanage and Windows Server Azure edition contain specialized functionality to help alleviate day-to-day operational tasks as Contoso's Windows Server infrastructure grows.

## Azure Automanage

Azure Automanage offers a unified solution to simplify IT operations on your Windows Server virtual machines. With point-and-click simplicity, Azure Automanage lets you automate management tasks and apply consistent best practices across the entire lifecycle of Windows Server in Azure. It eliminates the need to discover and know how to onboard and configure certain Azure services to benefit your Window Server VMs. These Azure services help enhance reliability, security, and management and provide the following benefits:

Intelligently onboards virtual machines to select best practices Azure services
Automatically configures each service per Azure best practices
Supports customization of best practice services
Monitors for drift and corrects for it when detected
Provides a simple experience (point, select, set, forget)

### Participating services

After onboarding your Windows Server VMs to Azure Automanage, each best practice service is configured to its recommended settings. The diagram below shows the types of services that can be configured for your VMs using Azure Automanage best practices.

:::image type="content" source="../media/intelligently-onboard-services-1.png" alt-text="Diagram of intelligently onboard services.":::

Your Windows Server VMs will be automatically onboarded to these participating services when you use the best practices configuration profiles. Following is a list of participating services:

|Service |Description |
|--------|------------|
|VM Insights Monitoring |Azure Monitor for VMs monitors the performance and health of your virtual machines, including their running processes and dependencies on other resources. |
|Backup |Azure Backup provides independent and isolated backups to guard against unintended destruction of the data on your VMs. |
|Microsoft Defender for Cloud |Microsoft Defender for Cloud is a unified infrastructure security management system that strengthens the security posture of your data centers, and provides advanced threat protection across your hybrid workloads in the cloud. |
|Microsoft Anti-malware |Microsoft Anti-malware for Azure is a free real-time protection that helps identify and remove viruses, spyware, and other malicious software. It generates alerts when known malicious or unwanted software tries to install itself or run on your Azure systems. |
|Update Management |You can use Update Management in Azure Automation to manage operating system updates for your virtual machines. You can quickly assess the status of available updates on all agent machines and manage the process of installing required updates for servers. |
|Change Tracking & Inventory |Combines change tracking and inventory functions to allow you to track virtual machine and server infrastructure changes. |
|Azure Automanage Machine Configuration |Azure Automanage Machine Configuration is used to monitor the configuration and report on the compliance of the machine. |
|Azure Automation Account |Azure Automation supports management throughout the lifecycle of your infrastructure and applications. |
|Log Analytics Workspace |Azure Monitor stores log data in a Log Analytics workspace, which is an Azure resource and a container where data is collected and aggregated. |

### Automanage Machine Configuration

Automanage Machine Configuration provides native capability to audit or configure operating system settings as code, both for machines running in Azure and hybrid Arc-enabled machines. The feature can be used directly per-machine, or at-scale orchestrated by Azure Policy. As Automanage Machine Best Practices lets customers describe desired state for management services, Machine Configuration provides the same functionality within the actual resources.

When creating an Automanage Best Practices configuration profile, enable Machine Configuration either through creating a built-in profile or a custom profile.

:::image type="content" source="../media/create-custom-profile.png" alt-text="Screenshot of the create custom profile window.":::

## Windows Server Datacenter: Azure Edition

The Azure Edition of Windows Server Datacenter brings additional capabilities for optimizing and managing VMs.

### Azure Extended Network

Extended network for Azure enables you to stretch an on-premises subnet into Azure to let on-premises virtual machines keep their original on-premises private IP addresses when migrating to Azure.

The network is extended using a bidirectional VXLAN tunnel between two Windows Server 2019 VMs acting as virtual appliances, one running on-premises and the other running in Azure, each also connected to the subnet to be extended. Each subnet that you are going to extend requires one pair of appliances. Multiple subnets can be extended using multiple pairs.

### Hotpatch for new virtual machines

Hotpatching is a new way to install updates on supported Windows Server Azure Edition virtual machines (VMs) that doesn’t require a reboot after installation. This article covers information about Hotpatch for supported Windows Server Azure Edition VMs, which has the following benefits:

- Lower workload impact with less reboots
- Faster deployment of updates as the packages are smaller, install faster, and have easier patch orchestration with Azure Update Manager
- Better protection, as the Hotpatch update packages are scoped to Windows security updates that install faster without rebooting

Hotpatch works by first establishing a baseline with a Windows Update Latest Cumulative Update. Hotpatches are periodically released (for example, on the second Tuesday of the month) that build on that baseline. Hotpatches will contain updates that don't require a reboot. Periodically (starting at every three months), the baseline is refreshed with a new Latest Cumulative Update.

:::image type="content" source="../media/hotpatch-sample-schedule.png" alt-text="Hotpatch sample schedule.":::

There are two types of baselines: **planned baselines** and **unplanned baselines**.

- Planned baselines are released on a regular cadence, with hotpatch releases in between. Planned baselines include all the updates in a comparable *Latest Cumulative Update* for that month, and require a reboot.
    - The sample schedule above illustrates four planned baseline releases in a calendar year (five total in the diagram), and eight hotpatch releases.
- Unplanned baselines are released when an important update (such as a zero-day fix) is released, and that particular update can't be released as a Hotpatch. When unplanned baselines are released, a hotpatch release will be replaced with an unplanned baseline in that month. Unplanned baselines also include all the updates in a comparable *Latest Cumulative Update* for that month, and also require a reboot.
    - The sample schedule above illustrates two unplanned baselines that would replace the hotpatch releases for those months (the actual number of unplanned baselines in a year isn't known in advance).

### SMB over QUIC

SMB over QUIC introduces an alternative to the TCP network transport, providing secure, reliable connectivity to edge file servers over untrusted networks like the Internet. QUIC is an IETF-standardized protocol with many benefits when compared with TCP:

- All packets are always encrypted and handshake is authenticated with TLS 1.3
- Parallel streams of reliable and unreliable application data
- Exchanges application data in the first round trip (0-RTT)
- Improved congestion control and loss recovery
- Survives a change in the clients IP address or port

SMB over QUIC offers an "SMB VPN" for telecommuters, mobile device users, and high security organizations. The server certificate creates a TLS 1.3-encrypted tunnel over the internet-friendly UDP port 443 instead of the legacy TCP port 445. All SMB traffic, including authentication and authorization within the tunnel is never exposed to the underlying network. SMB behaves normally within the QUIC tunnel, meaning the user experience doesn't change. SMB features like multichannel, signing, compression, continuous availability, directory leasing, and so on, work normally.

