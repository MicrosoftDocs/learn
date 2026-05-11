Contoso's security team is ready to deploy Azure Firewall in the hub virtual network to enforce the Security Officer's traffic inspection mandate. They need to configure the firewall to allow outbound HTTPS to approved Microsoft services, block unauthorized internet traffic by default, and prevent Azure AI agents from reaching unapproved external APIs. Here, you learn how to deploy Azure Firewall using Firewall Policy, create rule collections to control network and application traffic, and enable threat-intelligence-based blocking.

| Component | Configuration step |
|-----------|-------------------|
| **Azure Firewall subnet** | Create `AzureFirewallSubnet` in hub virtual network (minimum /26) |
| **Firewall Policy** | Create policy resource with rule collection groups |
| **Threat intelligence** | Enable Deny mode for automatic threat blocking |
| **DNS proxy** | Enable DNS proxy to support FQDN-based application rules |
| **Rule collections** | Configure destination network address translation (DNAT), network, and application rules by priority |
| **User-defined routes** | Route spoke traffic (0.0.0.0/0) to firewall private IP |

## Deploy Azure Firewall in hub-spoke architecture

Azure Firewall operates as a centralized enforcement point in a hub-spoke network topology. The firewall sits in a dedicated subnet within the hub virtual network (virtual network) and inspects traffic flowing between spokes, from spokes to the internet, and from the internet to spoke workloads.

The deployment requires a subnet named `AzureFirewallSubnet` in the hub virtual network. This subnet must be at least /26 in size, though Microsoft recommends /24 to accommodate future scaling. The firewall receives a private IP address from this subnet, which becomes the next-hop target for **user-defined routes (UDRs)** applied to spoke subnets.

With this hub-spoke pattern, you configure UDRs on each spoke subnet to route all internet-bound traffic (0.0.0.0/0) to the firewall's private IP address. Traffic from spoke workloads flows to the hub firewall, where Firewall Policy rules inspect and either allow or deny the connection. East-west traffic between spokes can also route through the hub firewall if you configure spoke-to-spoke UDRs for that purpose.

This architecture provides a single choke point for policy enforcement. Without the firewall, spoke virtual networks (VNets) would route directly to the internet through Azure's default system routes, bypassing centralized inspection and logging.

## Understand Firewall Policy hierarchy

Azure Firewall supports two configuration methods: classic rules and **Firewall Policy**. Classic rules are stored directly on the firewall resource and can't be shared across multiple firewalls. Firewall Policy is a standalone Azure resource that supports rule reuse, policy inheritance, and integration with Azure Firewall Manager for centralized governance.

> [!IMPORTANT]
> Always use Firewall Policy for new deployments. Classic rules are a legacy option and don't support advanced features like rule collection groups, parent-child policy inheritance, or global policy management.

Firewall Policy organizes rules into a four-level hierarchy:

- **Policy**: The top-level resource (for example, `policy-contoso-security`)
- **Rule collection group**: A container with a priority value (100, 200, 300, and so on). Lower numbers are evaluated first.
- **Rule collection**: A set of rules with a shared action (Allow or Deny) and priority within the group
- **Rules**: Individual traffic-matching criteria (source IP, destination FQDN, port, protocol)

Firewall Policy supports three rule collection types, and Azure Firewall evaluates all traffic in a fixed priority order:

1. **Threat intelligence rules**: highest priority, evaluated before all custom rules. When enabled in Alert and deny mode, threat intelligence can block traffic before any DNAT, network, or application rule is evaluated.
2. **Destination network address translation (DNAT) rule collection**: Translates inbound public IP addresses to private IP addresses for workloads behind the firewall
3. **Network rule collection**: Filters traffic by IP address, protocol, and port (stateful inspection)
4. **Application rule collection**: Filters outbound traffic by **fully qualified domain name (FQDN)** using HTTP/HTTPS inspection

The processing sequence matters. Threat intelligence always evaluates first—it can block a connection to a known malicious destination even if an application rule would otherwise allow that FQDN. After threat intelligence, Azure Firewall evaluates DNAT rules, then network rules, and finally application rules. Within each type, rules are evaluated by rule collection priority (lowest number first). If a rule matches and the action is Allow, the firewall permits the traffic and stops evaluation. If the action is Deny, the firewall blocks the traffic immediately.

## Configure rule collections for traffic control

Contoso's security requirements translate into specific rule collections. The team needs to allow outbound HTTPS to Microsoft 365 and Azure OpenAI, deny inbound management ports, and block all other internet traffic by default.

The first step is to enable the **DNS proxy** on the Firewall Policy. Application rules rely on FQDN filtering, which requires the firewall and clients to resolve domain names to the same IP address. When DNS proxy is enabled, the firewall intercepts DNS queries from spoke workloads and ensures consistent name resolution. Without DNS proxy, clients and the firewall can resolve the same FQDN to different IP addresses—particularly when Azure infrastructure IPs rotate—causing FQDN-based rules to fail intermittently. Enable DNS proxy to guarantee reliable FQDN filtering.

To configure Firewall Policy and rule collections in the Azure portal:

1. Deploy Azure Firewall by selecting the hub virtual network, creating the `AzureFirewallSubnet` (minimum /26), choosing **Firewall Policy** (create new: `policy-contoso-security`), and selecting the appropriate **SKU** (Standard for most scenarios, Premium for Transport Layer Security (TLS) inspection and intrusion detection).

2. Open the Firewall Policy resource (`policy-contoso-security`) and navigate to **DNS Settings**. Enable **DNS Proxy** and configure custom DNS servers if your environment uses private DNS zones.

3. Create an application rule collection to allow approved outbound HTTPS traffic:
   - **Collection name**: `allow-approved-outbound`
   - **Priority**: 200
   - **Action**: Allow
   - **Rule 1 (Microsoft 365 access)**: Source = spoke virtual network CIDR ranges, destination FQDNs = use the `WindowsVirtualDesktop` FQDN tag or list specific Microsoft 365 endpoints, protocol = HTTPS:443
   - **Rule 2 (Azure OpenAI access for AI agents)**: Source = AI agent subnet CIDR, destination FQDN = `*.openai.azure.com`, protocol = HTTPS:443

4. Create a network rule collection to block inbound management ports:
   - **Collection name**: `deny-mgmt-ports-inbound`
   - **Priority**: 100
   - **Action**: Deny
   - **Rule**: Source = Any, destination = spoke virtual network ranges, protocol = TCP, destination ports = 3389, 22

5. Verify that UDRs on spoke subnets route the default route (0.0.0.0/0) to the firewall's private IP address. Without this routing configuration, traffic bypasses the firewall entirely.

> [!TIP]
> Azure AI agents running in spoke VNets make outbound HTTPS calls to model endpoints. **Network security groups (NSGs)** see these requests as ordinary port 443 traffic and can't distinguish between approved and unapproved AI services. Firewall application rules solve this problem by filtering on FQDN. Configure an application rule that allows only `*.openai.azure.com` from the AI agent subnet. The firewall's default-deny stance blocks any AI endpoint not explicitly listed, preventing agents from calling unauthorized external APIs or exfiltrating data through model interactions.

This rule configuration creates a layered defense. Network rules block high-risk inbound management ports even if Azure Virtual Network Manager (AVNM) policies fail. Application rules allow only approved FQDNs for outbound HTTPS, and the stance to deny by default blocks everything else.

## Enable threat intelligence filtering

Azure Firewall integrates with Microsoft's threat intelligence feed to automatically block traffic to and from known malicious IP addresses and FQDNs. This feature operates independently of your custom rule collections and takes precedence over all other rules when enabled in Deny mode.

To enable threat intelligence filtering, open the Firewall Policy resource, navigate to **Threat Intelligence**, and set the mode to **Alert and deny**. The firewall now blocks any connection to or from an IP address or FQDN on Microsoft's threat intelligence list, even if your application rules would otherwise allow it. The firewall logs these blocks separately for visibility.

Threat intelligence supports three modes:

- **Off**: Disables threat intelligence filtering entirely. Use this mode only when you need a baseline traffic view during initial deployment.
- **Alert only**: Logs suspicious connections but doesn't block them. Use this mode when testing to understand potential false positives before enforcing.
- **Alert and deny**: Blocks and logs suspicious connections. Use this mode in production environments.

With threat intelligence in Deny mode, Contoso gains automatic protection against emerging threats without manual rule updates. If a botnet command-and-control server's IP address appears in the threat feed, the firewall blocks connections immediately, regardless of any allow rules in the policy.

This centralized, threat-aware filtering adds a critical layer to Contoso's defense-in-depth strategy. The firewall enforces both explicit organizational policy (through custom rules) and dynamic threat protection (through threat intelligence) from a single enforcement point.

This hub-spoke deployment works well for VNet-connected workloads, but Contoso also has branch offices connected through Azure Virtual WAN. In the next unit, you extend centralized inspection to Virtual WAN by converting a standard hub to a Secured Virtual Hub with Azure Firewall.
