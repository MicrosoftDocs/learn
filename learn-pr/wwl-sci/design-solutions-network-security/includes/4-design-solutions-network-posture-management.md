Network posture management is the ongoing practice of assessing, monitoring, and improving the security state of your network infrastructure. Unlike point-in-time audits, effective posture management provides continuous visibility into misconfigurations, drift from security baselines, and emerging risks. For a security architect, designing this capability means selecting the right combination of assessment, hardening, attack path analysis, and monitoring tools to maintain a strong security posture across cloud and hybrid environments.

## Assess network posture with Microsoft Defender for Cloud

Microsoft Defender for Cloud provides the foundation for network posture management through its Cloud Security Posture Management (CSPM) capabilities. Defender for Cloud continuously evaluates your network resources against the Microsoft Cloud Security Benchmark (MCSB) and generates actionable recommendations when it detects gaps.

### CSPM tiers and networking coverage

Defender for Cloud offers two CSPM tiers, each with different levels of network posture insight:

- **Foundational CSPM (free)** provides asset inventory, MCSB-based security recommendations, and a secure score that quantifies your overall posture. It covers core networking checks such as whether subnets have network security groups (NSGs), whether internet-facing virtual machines (VMs) are protected, and whether storage accounts restrict network access.

- **Defender CSPM (paid)** adds advanced capabilities including attack path analysis, risk prioritization, cloud security explorer, external attack surface management, internet exposure analysis, and governance rules. These features provide deeper insight into how network misconfigurations create exploitable paths to your critical assets.

### Key networking recommendations

Defender for Cloud evaluates your network resources and generates recommendations across several categories. The following table summarizes the most impactful areas.

| Category | Examples |
|---|---|
| **NSG hygiene** | All ports restricted on associated NSGs; internet-facing VMs protected with NSGs; subnets associated with an NSG |
| **DDoS protection** | Azure DDoS Protection enabled for virtual networks that host public-facing resources |
| **Access restriction** | Management ports closed on VMs; just-in-time (JIT) access configured for management ports |
| **Firewall protection** | Virtual networks protected by Azure Firewall; IP forwarding disabled on NICs unless required |
| **Storage and transfer** | Storage accounts restrict network access; secure transfer required for storage accounts |

Each recommendation includes a severity level, affected resources, and remediation steps. Recommendations contribute to your secure score, which provides a single metric for tracking network posture improvement over time.

### Asset inventory for network resources

The asset inventory in Defender for Cloud lets you query and filter across all connected network resources, including virtual networks, subnets, NSGs, load balancers, and public IP addresses across Azure, AWS, and GCP. You can filter by resource type, security state, and recommendation status to identify the resources that need attention. The inventory uses Azure Resource Graph for querying at scale, so you can also build custom queries with Kusto Query Language (KQL) for deeper analysis.

## Strengthen network defenses with adaptive hardening

Beyond static recommendations, Defender for Cloud provides capabilities that dynamically adapt to your environment.

**Adaptive network hardening** analyzes actual network traffic patterns and compares them against your current NSG configurations. It identifies rules that are overly permissive relative to observed traffic and recommends tighter restrictions. For example, if an NSG allows inbound traffic on a range of ports but your workloads only use ports 443 and 8080, adaptive hardening recommends narrowing the rule. This capability requires Defender for Servers and provides a practical approach to reducing attack surface without disrupting legitimate workloads.

**Just-in-time (JIT) VM access** addresses the risk of permanently open management ports. Instead of leaving ports such as RDP (3389) or SSH (22) exposed, JIT locks them by default and opens access only when an authorized user requests it, for a limited time, and from a specified source IP address. JIT reduces the window of exposure for brute-force and lateral-movement attacks. It's configured through Defender for Cloud and enforces access with NSG rules and Azure Firewall policies.

When you design your posture management solution, plan to enable adaptive hardening for workloads with variable traffic patterns and JIT for all VMs with management ports.

## Identify network-exposed attack paths

A network misconfiguration in isolation might seem low risk, but it can become critical when it forms part of a chain that leads to a sensitive asset. Defender CSPM addresses this through **attack path analysis**, which uses a graph-based algorithm to map the relationships between your resources and identify sequences of vulnerabilities that an attacker could exploit from outside your organization.

For network posture specifically, attack path analysis identifies scenarios such as:

- An internet-exposed VM with an unpatched vulnerability that has network access to a database storing sensitive data
- A subnet with a permissive NSG that allows lateral movement from a compromised workload to a management interface
- A public IP address associated with a service that has excessive permissions to key vaults or storage accounts

Each attack path includes a risk level (High, Medium, or Low) determined by context-aware prioritization that considers data sensitivity, internet exposure, and lateral movement potential. The analysis highlights **choke points** where multiple attack paths converge, helping you prioritize remediation where it has the greatest impact.

The **cloud security explorer** complements attack path analysis by letting you build custom queries across your cloud security graph. You can query for specific network conditions, such as "show all internet-facing VMs without endpoint protection, that have network access to databases containing sensitive data."

## Verify reachability with network verifier

Network verifier is a feature of Azure Virtual Network Manager that lets you check whether your network policies allow or block traffic between Azure network resources. You create a verifier workspace within your network manager instance, define reachability analysis intents that specify source, destination, ports, and protocol, and then run a static analysis. The analysis evaluates NSG rules, ASG rules, Security Admin Rules, virtual network peering, route tables, service endpoints, private endpoints, Virtual WAN configurations, and Azure Firewall rules (static Layer 4) to determine whether packets can reach the destination.

Network verifier is useful during both the design and post-deployment phases of your network setup. When you encounter unexpected traffic allowances or blocks, the reachability analysis results reconstruct the source-to-destination path and show where the misconfiguration lies. Use this capability to validate segmentation intent, prove compliance with security requirements, and catch misconfigurations before or after they reach production.

## Validate posture with Network Watcher diagnostics

Azure Network Watcher provides a suite of monitoring, diagnostic, and traffic analysis tools for Azure IaaS network resources. Network Watcher diagnostics capabilities are especially relevant for posture validation (Azure Network Watcher tools that support network monitoring and traffic analysis are covered in the next unit).

- **IP flow verify** and **NSG diagnostics** check whether specific traffic is allowed or denied by evaluating the effective security rules at the VM or subnet level. Use these tools to confirm that your NSG configurations enforce the traffic-filtering policies you designed, without waiting for actual traffic to trigger a flow log entry.

- **Topology** provides a visualization of your network resources and their relationships across subscriptions, resource groups, and regions. Use it to verify that your network architecture matches your intended segmentation design and that no unintended connections exist.

These diagnostic tools complement Defender for Cloud's posture assessment by giving you on-demand verification of individual configurations, while Defender for Cloud provides continuous, automated evaluation across your entire environment.

## Govern and enforce network compliance

Designing a posture management solution also requires governance mechanisms that prevent posture drift and enforce organizational standards.

**Regulatory compliance** in Defender for Cloud maps your network security recommendations to industry frameworks such as MCSB, PCI-DSS, NIST SP 800-53, and ISO 27001. The compliance dashboard shows your adherence to each control, helping you identify gaps and report posture to stakeholders.

**Governance rules** in Defender CSPM let you assign remediation owners and set due dates for unresolved recommendations. For example, you can create a governance rule that assigns all critical networking recommendations to the network security team with a seven-day remediation window. This ensures accountability and prevents recommendations from lingering unresolved.

**Azure Policy** provides the enforcement layer. Use built-in or custom policy definitions to deny the creation of resources that violate your network standards, such as subnets without NSGs, virtual networks without DDoS protection, or VMs with public IP addresses in production subscriptions. Combine policy with Defender for Cloud recommendations to create a closed loop of detection and prevention.

