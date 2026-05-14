Before you build network controls, you need to know where they belong. Contoso's security team was asked to assess the network posture and identify lateral movement risk across their Azure environment. In this unit, you learn how to examine a virtual network (virtual network) topology. Then understand the default traffic behavior, and identify segmentation gaps that create exposure.

| Network design pattern | Lateral movement risk |
|------------------------|----------------------|
| Flat network (all workloads in one subnet, no network security groups (NSGs)) | **High** – Compromised resource can reach any other resource |
| Segmented network with NSGs between tiers | **Low** – Lateral movement requires bypassing explicit deny rules |

## Understand how Azure VNets work by default

Many security engineers assume that Azure virtual networks (VNets) provide automatic isolation between workloads. This assumption creates risk. While a virtual network is isolated from the public internet and from other VNets by default, **all resources within a VNet can communicate freely with each other**. Subnets don't create security boundaries on their own—subnets are logical containers for organizing IP address ranges.

When you deploy a virtual machine (VM) in a subnet, Azure allows that VM to initiate connections to any other resource. The connection works in the same way as a virtual network on any port, regardless of which subnet the target resource resides in. The default rules in every NSG control this behavior. Two default rules—**AllowVNetInBound** and **AllowVNetOutBound**—permit traffic between any resources in the same virtual network.

The threat model consequence is clear: a compromised VM becomes a foothold to reach everything else in the virtual network. An attacker who gains access to one workload doesn't need to breach another perimeter—the network allows lateral movement by default.

## Recognize lateral movement patterns in Azure

**Lateral movement** is the attacker technique of spreading from one compromised resource to other resources in the same environment. In Azure, this movement happens along the network paths that your virtual network permits. Security teams often focus on **north-south traffic**—traffic flowing between the internet and your virtual network—because it's the most visible threat vector. But **east-west traffic** (traffic flowing between resources inside your virtual network) is where attackers operate after the initial breach.

Common Azure lateral movement paths include:

- **Web tier to app tier**: The web VM sends application requests to backend services. If compromised, the same path lets an attacker probe the app tier for vulnerabilities.
- **App tier to database tier**: Application servers need database access. A compromised app server can exfiltrate data, modify records, or escalate privileges using database credentials.
- **VM to Azure platform services**: VMs in a virtual network can reach Azure SQL, Azure Storage, and Key Vault if those services are accessible on public endpoints or connected via service endpoints. A compromised VM inherits those permissions.
- **VM to VM on administrative ports**: If remote desktop protocol (RDP) on port 3389 or secure shell (SSH) on port 22 are open between subnets, an attacker can spread by brute-forcing credentials or exploiting unpatched services.

In the Contoso scenario, the security team discovered that a web-tier VM can connect to SQL Server on port 1433 (the default SQL port). An attacker who compromises the web VM doesn't need to escalate privileges or exploit a vulnerability—the network permits the connection. The attacker can query databases, extract sensitive data, or use SQL Server features to pivot further.

> [!NOTE]
> Azure role-based access control (RBAC) and Microsoft Entra identities control management plane access (using Azure Resource Manager APIs), not NSGs. Network segmentation addresses data plane lateral movement—the direct connections between workloads inside your virtual network.

## Identify network segmentation gaps

When you assess a virtual network topology, you're looking for **attack surface**—network paths that exist but shouldn't. Every open port between tiers that isn't required for business functionality is a potential lateral movement path. To identify segmentation gaps, review the list:

- **Are workloads with different trust levels sharing a subnet?** Production and development VMs shouldn't coexist in the same subnet without controls. A compromised dev VM becomes a path to production resources.
- **Are NSGs attached at the subnet level or the network interface (NIC) level?** Resources without an associated NSG inherit the default-allow virtual network rules.
- **What are the effective security rules on each subnet?** Azure evaluates NSG rules in priority order. If no deny rules exist between tiers, the default-allow rules permit all traffic.
- **Are administrative ports open between tiers?** RDP (3389), SSH (22), and SQL Server (1433) are common targets. If these ports are accessible from workloads that don't need them, you created an attack path.
- **Are PaaS services exposed on public endpoints?** Azure SQL Database, Azure Storage, and Key Vault are accessible from the internet by default. If they're not protected by firewall rules or private endpoints, any resource with outbound internet access can reach them.

The goal is to enforce a **default-deny stance**: block all traffic between tiers unless you explicitly allow it. This approach minimizes attack surface and forces you to document every required network path. The alternative—a default-allow stance—means every new workload inherits broad access, and lateral movement paths grow without oversight.

**Network Watcher's effective security rules view** shows the aggregated NSG rules affecting a specific Network Interface Card (NIC), in priority order, so you can verify that deny rules are blocking unintended paths. You use this feature in depth in unit 6 when you validate your NSG configurations.

## Apply segmentation assessment to Contoso's environment

Contoso's security team conducted a network assessment and documented the findings in a topology map. The three-tier application (web, app, and database) runs entirely in one subnet called **AppSubnet**. No NSGs are attached at the subnet level. Each VM has a default NSG on its NIC, but those NSGs contain only the default rules—no custom deny rules between tiers.

The team also found development VMs in the same subnet as production workloads. Developers use these VMs to test code changes, but they don't follow the same hardening standards as production resources. A compromised dev VM creates a direct path to production databases.

The most critical gap is the database tier. The Azure SQL Server VM accepts connections on port 1433 from any source in the virtual network. The web-tier VM, the app-tier VM, and the dev VMs can all reach the database on this port. There's no service endpoint or private endpoint configured for Azure SQL Database. So the connection relies on a public endpoint that's accessible from the internet if the firewall rules allow it.

The team mapped the attack paths and assigned a risk level to each based on the potential issues:

| Attack path | Description | Risk level |
|------------|-------------|-----------|
| Web tier → Database tier (port 1433) | Direct SQL access bypasses app-tier business logic | **Critical** |
| Dev VMs → Production VMs (any port) | Less hardened dev systems can spread malware or credentials | **High** |
| App tier → Database tier (port 1433) | Legitimate path but lacks least-privilege controls | **Medium** |
| Web tier → App tier (application ports) | Required for functionality but needs monitoring | **Low** |

The critical-risk path is the web-to-database connection. An attacker who compromises the web tier can exfiltrate customer data, modify records, or use SQL Server stored procedures to execute code on the database server. The high-risk path is the shared subnet with dev VMs—those systems are attractive targets because they often have weaker security controls and elevated permissions for testing.

Contoso's team now has a prioritized list: close the web-to-database path first, isolate dev from production second, and implement least-privilege controls on the app-to-database path third. This assessment gives them the foundation to design NSG rules that enforce segmentation without breaking application functionality.

Now that you know how to identify lateral movement risk and prioritize segmentation gaps, the next step is configuring NSG rules to enforce least-privilege access between tiers.
