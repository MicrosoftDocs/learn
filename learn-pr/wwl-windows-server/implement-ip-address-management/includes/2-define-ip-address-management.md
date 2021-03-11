Managing the allocation of IP addresses can be a complex task in large networks such as at Contoso. IPAM provides a framework for discovering, auditing, and managing the IP address space of your network. The benefits of using IPAM include:

- IPv4 and IPv6 address space planning and allocation.
- IP address space utilization statistics and trend monitoring.
- Static IP inventory management, lifetime management, and DHCP and DNS record creation and deletion.
- Service and zone monitoring of DNS servers.
- IP address lease and sign-in event tracking.

## Overview of IPAM

Infrastructure support staff at Contoso can use IPAM to:

- Monitor and administer DHCP. 
- Monitor and administer DNS.
- Determine where specific IP addresses are allocated.
- Collect statistics from AD DS domain controllers. 
- Collect statistics from  Network Policy Server (NPS) servers. 

> [!TIP]
> You can use either the Windows Internal Database (WID), or optionally, a Microsoft SQL Server database, to store the collected data.

### The Four Modules of IPAM

IPAM consists of four modules as described in the following table.

|Module|Description|
|----------|-----------|
|IPAM discovery|You can configure IPAM to use AD DS for discovering servers, domain controllers, or servers that have DHCP or DNS installed. You can also add servers manually.|
|IP address space management|You can use this module to examine, monitor, and manage the IP address space. With DHCP, you can dynamically issue or statically assign addresses. You can also track address utilization and detect overlapping DHCP scopes.|
|Multiserver management and monitoring|You can use this module to manage and monitor multiple DNS and DHCP servers. Use multiserver management when you need tasks to run across multiple servers. For example, you can configure and edit DHCP properties and scopes, and you can track the status of DHCP and scope utilization. You can also monitor multiple DNS servers and monitor the health and status of DNS zones across authoritative DNS servers.|
|Operational auditing and IP address tracking|You can use the auditing tools to track potential configuration problems. You can collect, manage, and examine details of configuration changes from managed DHCP servers. You can also collect address lease tracking from DHCP lease logs, and sign-in event information from NPS and domain controllers.|

## IPAM topology

An IPAM deployment includes two components, described in the following table. 

| Component| Description|
| ----------- | ------------ |
| IPAM server | The IPAM server performs data collection from the managed servers. Additionally, the IPAM server manages the WID or a SQL Server database, and it provides role-based access control (RBAC). |
| IPAM client | The IPAM client provides the client computer interface and interacts with the IPAM server, invoking Windows PowerShell cmdlets to perform remote management, DHCP configuration, and DNS monitoring. The IPAM client can be a Windows client operating system or Windows Server operating system. |

> [!IMPORTANT]
> IPAM servers don't coordinate with each other or roll up information from one IPAM server to another. 

When deploying IPAM, Contoso IT staff must choose between the available topology options: centralized, distributed, or hybrid.

### Centralized topology

For a centralized topology, you deploy a single IPAM server for your entire forest. A single IPAM server provides centralized control and visibility for IP addressing tasks. You can examine your entire IP addressing infrastructure from a single console when you're using the centralized topology. You can use a single IPAM server for multiple AD DS forests with a two-way trust in place.

The following graphic displays an example deployment of IPAM using a centralized approach. Displayed in the graphic are:

- The IPAM client. An administrator uses Server Manager to access the IPAM server. RBAC controls the level of access that the administrator has. 

    > [!TIP]
    > An administrator can also install the **RSAT: IP Address Management (IPAM) Client** feature and manage IPAM from another server or Windows 10 client.

- The IPAM server. The server connects to a configured database to provide storage for IPAM. Scheduled tasks are also available on the IPAM server.
- Managed servers. A collection of DNS, DHCP, NPS servers, and domain controllers are discovered and accessible by IPAM. 

:::image type="content" source="../media/m14-ipam-architecture.png" alt-text="A diagram that depicts IPAM components as discussed in the preceding text." border="false":::

### Distributed topology

For a distributed topology, you deploy an IPAM server to each site in your forest. It's common to use the distributed topology when your organization has multiple sites with significant IP addressing infrastructure in place. Servers in each location can help to distribute a workload that might be too large for a single server to manage. 

The following graphic displays an example deployment of IPAM using a distributed approach. Displayed in the graphic are:

- A branch office. The branch office has its own IPAM server and managed servers, such as a domain controller, and DHCP, NPS, and DNS servers. 
- A regional datacenter. Similar to the branch office, the regional datacenter has its own IPAM server and managed servers.
- A corporate datacenter. This location supports many managed servers, and also has its own IPAM server. 
- System admins, forensic admins, and network admins. These users, controlled through RBAC, can perform different management tasks on the managed servers throughout the organization. 

:::image type="content" source="../media/m14-ipam-architecture-2.png" alt-text="A diagram that displays IPAM components as discussed in the preceding text." border="false":::

> [!TIP]
> You can also use the distributed topology to enable separate locations or business units to administer their own IP addressing management.

### Hybrid topology

You can also implement a hybrid topology with a centralized IPAM server and an IPAM server at each site. Both the local IPAM server and the centralized IPAM server monitor managed servers. You can control the management scope by monitoring some services centrally and monitoring others at each site.
