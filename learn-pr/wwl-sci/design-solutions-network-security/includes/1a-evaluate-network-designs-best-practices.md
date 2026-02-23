As a security architect, you evaluate whether network designs meet your organization's security requirements and align with industry best practices. Rather than building networks from scratch, you assess existing or proposed architectures to identify gaps, recommend improvements, and ensure alignment with frameworks like Zero Trust.

## Evaluate network designs against Zero Trust principles

Zero Trust is the foundational framework for evaluating modern network security designs. Traditional perimeter-based networks assume that all systems inside the boundary can be trusted. This assumption fails when employees access resources from anywhere and attackers who breach the perimeter can move laterally across the network.

When you evaluate a network design, assess whether it enforces these three Zero Trust principles:

- **Verify explicitly.** Does the design authenticate and authorize every access request based on all available signals, including user identity, device health, location, and workload context?
- **Use least privilege access.** Does the design limit access to only necessary resources, using just-in-time and just-enough-access approaches?
- **Assume breach.** Does the design minimize blast radius through segmentation and verify end-to-end encryption, with analytics for visibility and threat detection?

A network design that relies solely on perimeter firewalls and VPN access doesn't align with these principles. Instead, look for designs that incorporate identity-aware controls, microsegmentation, and continuous verification at every network boundary.

## Use Microsoft cloud security benchmark v2 as evaluation criteria

The [Microsoft cloud security benchmark (MCSB) v2](/security/benchmark/azure/overview) provides a structured set of controls you can use as evaluation criteria for network designs. The Network Security (NS) control family maps directly to the areas a security architect should assess:

| Control | Evaluation focus |
|---|---|
| **NS-1**: Establish network segmentation boundaries | virtual network segmentation, NSGs, ASGs, subnet isolation |
| **NS-2**: Secure cloud native services with network controls | Private endpoints, disabled public access, virtual network integration, Network Security Perimeter |
| **NS-3**: Deploy firewall at the edge of enterprise network | Azure Firewall, edge filtering, user-defined routes |
| **NS-4**: Deploy intrusion detection/intrusion prevention systems (IDS/IPS) | Azure Firewall Premium IDPS, host-based EDR |
| **NS-5**: Deploy DDoS protection | Azure DDoS Protection tiers on internet-facing virtual networks |
| **NS-6**: Deploy web application firewall | Azure WAF on Application Gateway or Front Door |
| **NS-7**: Manage network security centrally and effectively | Azure Virtual Network Manager Security Admin Rules, Firewall Manager, flow logs v2, Traffic Analytics |
| **NS-8**: Detect and disable insecure services and protocols | Microsoft Sentinel insecure protocol detection |
| **NS-9**: Connect on-premises or cloud network privately | ExpressRoute, VPN, virtual network peering |
| **NS-10**: Ensure Domain Name System (DNS) security | Azure Private DNS, Defender for DNS (included in Defender for Servers Plan) |

Each MCSB v2 control also maps to industry frameworks such as CIS Controls v8.1, NIST SP 800-53 r5, PCI-DSS v4, NIST CSF v2.0, ISO 27001:2022, and SOC 2, helping you align your evaluation to regulatory and compliance requirements. When you evaluate a network design, use these controls as a checklist to identify gaps and prioritize remediation.

## Evaluate segmentation and traffic control

Effective network segmentation aligns to MCSB v2 control NS-1. When evaluating a network design, determine whether it isolates workloads appropriately and controls traffic flow between segments. Key evaluation questions include:

- Does the design use **subscriptions, virtual networks, and subnets** to create layered isolation boundaries between environments and workloads?
- Are **network security groups (NSGs)** applied to subnets with least-privilege rules, and are **application security groups (ASGs)** used to simplify rule management?
- Does the network use a **hub-and-spoke topology** (or Azure Virtual WAN) with centralized security services in the hub and deny-by-default routing between spokes?
- Are **Security Admin Rules** in Azure Virtual Network Manager enforcing organizational guardrails that workload teams can't override?

The next unit covers how to design these segmentation patterns in detail, including topology selection, Azure Virtual Network Manager, and microsegmentation within workloads.

## Evaluate defense-in-depth controls

A strong network design applies defense-in-depth by layering multiple security controls. MCSB v2 controls NS-2 through NS-6 define the specific controls to evaluate. Assess whether the design includes:

- **[Azure Firewall](/azure/firewall/overview)** as the central egress and east-west filtering point, with Premium features (TLS inspection and IDPS) for environments that require deep packet inspection.
- **[Azure Web Application Firewall (WAF)](/azure/web-application-firewall/overview)** on Application Gateway or Azure Front Door for Layer 7 protection against OWASP top threats on web-facing applications.
- **[Azure DDoS Protection](/azure/ddos-protection/ddos-protection-overview)** on perimeter virtual networks with internet-facing endpoints. Choose DDoS IP Protection for targeted deployments or DDoS Network Protection for enterprise-wide coverage.
- **[Azure Private Link](/azure/private-link/private-link-overview)** to access PaaS services through private endpoints, removing public internet exposure and keeping traffic on the Azure backbone.
- **[Azure Bastion](/azure/bastion/bastion-overview)** for secure RDP/SSH access without exposing management ports, combined with just-in-time (JIT) VM access to limit when ports are open.
- **Azure ExpressRoute** for hybrid connectivity that keeps sensitive traffic off the public internet.

## Evaluate identity-aware network security with Global Secure Access

Microsoft's Security Service Edge (SSE) solution—[Global Secure Access](/entra/global-secure-access/overview-what-is-global-secure-access)—extends security controls beyond the traditional network perimeter by tying enforcement directly to identity. It comprises two components: Microsoft Entra Internet Access for outbound internet and Microsoft 365 traffic, and Microsoft Entra Private Access for Zero Trust Network Access to private resources.

When evaluating a design that includes Global Secure Access, assess whether:

- **Traffic forwarding profiles** route Microsoft 365 traffic, internet traffic, and private application traffic through the appropriate security controls.
- **Web content filtering** policies restrict access to risky or inappropriate web categories.
- **Conditional Access policies** are linked to security profiles to enforce identity-aware access decisions.
- **The compliant network check** is required for Microsoft Entra-integrated applications to mitigate token theft.
- **Private Access** replaces or complements VPN with identity-verified, per-application connectivity to on-premises resources.

Later units in this module cover Internet Access and Private Access evaluation in detail.

## Evaluate network monitoring and posture management

A network design is incomplete without continuous visibility. MCSB v2 controls NS-7 and NS-8 emphasize centralized network security management and detecting insecure protocols. Evaluate whether the design includes:

- **Microsoft Defender for Cloud** networking recommendations, attack path analysis, and adaptive network hardening for continuous posture assessment.
- **Virtual network flow logs** and **Traffic Analytics** for traffic pattern analysis across the environment.
- **Azure Firewall structured logs** with IDPS and threat intelligence logging enabled.
- **Centralized SIEM integration** that sends network logs to Microsoft Sentinel for cross-source correlation and incident detection.

Later units in this module cover posture management and monitoring design in detail.
