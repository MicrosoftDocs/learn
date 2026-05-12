Not every workload requires centralized traffic inspection, but certain threat classes lie beyond the reach of network security groups (NSGs). Contoso's security team must present a business case to the Security Officer explaining why Azure Firewall is necessary for their environment. They need to focus on protecting AI agents that communicate with Azure OpenAI endpoints. Here, you learn which threats NSGs can't address and how to determine when Azure Firewall becomes essential.

| Control type | Best for | Limitation |
|---|---|---|
| NSG alone | Simple port/IP filtering within a subnet | No fully qualified domain name (FQDN) filtering, no threat intelligence, no content inspection |
| NSG + Azure Firewall | Enterprise environments with internet-bound traffic, data exfiltration risks, or AI workloads | Higher cost, more complexity |

## What NSGs can and can't do

NSGs evaluate traffic based on source IP, destination IP, protocol, and port number. They operate at Layer 3 and Layer 4 of the network stack and apply rules in a stateless manner to each packet.

NSGs excel at basic network segmentation. You can block or allow specific ports and IP ranges, use service tags to represent Azure services without memorizing IP addresses, and group virtual machines with application security groups (ASGs) for dynamic rule management. An NSG rule can permit HTTPS traffic from your web tier to your database tier while blocking all other protocols.

However, NSGs operate without awareness of domain names, application protocols, or threat context. An NSG can't distinguish between legitimate HTTPS traffic to `api.github.com` and malicious traffic to a command-and-control server on port 443. Because NSGs only see IP addresses, they can't block traffic to `evil.example.com` unless you manually add every IP that domain might resolve to. NSGs also lack integration with threat intelligence feeds, so they can't automatically block traffic to known malicious infrastructure. For workloads that need FQDN-based filtering, content inspection, or threat-aware controls, NSGs alone fall short.

## Threat classes that require centralized inspection

Five threat classes drive the need for Azure Firewall in enterprise environments. Each exploits a gap in NSG capabilities.

| Threat class | Why NSGs can't address it | Azure Firewall capability |
|---|---|---|
| Malware C2 communication | NSGs block IPs, not malicious domain names; C2 infrastructure rotates IPs frequently | Threat intelligence-based filtering blocks known malicious IPs and Fully Qualified Domain Names (FQDNs) |
| Data exfiltration to arbitrary cloud services | All HTTPS on port 443 looks identical to NSGs | FQDN application rules allow only approved FQDNs on 443 |
| Unauthorized AI API calls | AI service endpoints use shared Azure infrastructure with dynamic IPs | FQDN allow-listing permits only approved Azure OpenAI endpoints |
| Protocol abuse (tunneling over DNS/HTTP) | NSGs can't inspect packet content or detect protocol violations | Transport Layer Security (TLS) inspection and IDPS (intrusion detection and prevention system) in Azure Firewall Premium |
| Internet-bound traffic from internal VMs | NSGs are per-subnet; no single enforcement point | Forced tunneling routes all traffic through centralized Azure Firewall in hub virtual network (virtual network) |

Consider Contoso's AI agents. These agents call Azure OpenAI endpoints to process customer requests, but the endpoint IP's change as Azure scales its infrastructure. An NSG rule permitting outbound HTTPS doesn't distinguish between approved Azure OpenAI endpoints and an attacker-controlled API endpoint on the same port. With Azure Firewall application rules, you create an FQDN allow-list that permits `contoso-openai.openai.azure.com` while blocking all other destinations on port 443.

Malware command-and-control (C2) communication presents a similar challenge. Threat actors rotate C2 infrastructure rapidly, often using legitimate cloud services, or compromised websites. NSGs can't keep pace with these changes because they require manual IP updates. Azure Firewall's threat intelligence-based filtering receives continuous updates from Microsoft Threat Intelligence, automatically blocking traffic to domains and IPs associated with known malicious activity.

> [!TIP]
> Enable threat intelligence-based filtering in **Alert and deny** mode for production environments. **Alert** mode logs suspicious traffic without blocking it, which is useful during initial deployment but leaves your environment exposed.

## Azure Firewall capabilities

Azure Firewall provides four types of rules, each addressing different threat scenarios. Understanding which types of rule to use for each threat determines your policy's effectiveness.

**Network rules** filter traffic based on IP address, port, and protocol, similar to NSGs but with two advantages: they're stateful (tracking connection state reduces rule complexity), and they're managed centrally through Azure Firewall Policy. A network rule permitting outbound DNS on port 53 automatically allows return traffic without a separate inbound rule.

**Application rules** filter outbound HTTP and HTTPS traffic by fully qualified domain name (FQDN). These rules require the **DNS proxy** feature, which allows Azure Firewall to intercept DNS queries and resolve FQDNs before applying rules. An application rule can permit traffic to `github.com` and `*.nuget.org` while blocking all other outbound HTTPS, even though all destinations share port 443.

**DNAT rules** (destination network address translation) translate inbound traffic from a public IP to an internal resource. Unlike network and application rules that focus on outbound and east-west traffic, DNAT rules handle internet-to-resource scenarios. A DNAT rule can map your firewall's public IP on port 443 to an internal web server at `10.1.2.5:443`.

**Threat intelligence-based filtering** blocks traffic to or from IP addresses and FQDNs associated with known malicious activity. This capability draws from Microsoft's Intelligent Security Graph, which aggregates threat signals from across Microsoft's global infrastructure. Threat intelligence operates in three modes: **Off** (disabled), **Alert** (log only), or **Alert and deny** (block and log). Unlike custom network or application rules that require manual updates, threat intelligence filtering updates automatically as Microsoft identifies new threats.

Azure Firewall also complements Azure Web Application Firewall (WAF), which protects inbound HTTP/S traffic against layer 7 threats like SQL injection and cross-site scripting. WAF sits at the ingress point on Application Gateway or Azure Front Door, while Azure Firewall controls outbound and east-west traffic. These controls work together: WAF defends public-facing applications, and Azure Firewall prevents compromised workloads from exfiltrating data or communicating with C2 infrastructure.

## Choose the right Azure Firewall SKU

Azure Firewall offers three SKUs: Basic, Standard, and Premium. All three provide stateful network filtering, but they differ significantly in threat intelligence enforcement capability and advanced inspection features. For enterprise environments that require blocking malicious destinations, enforcing FQDN allow-lists, and centralized inspection, Standard and Premium are the appropriate choices.

| Capability | Basic | Standard | Premium |
|---|---|---|---|
| Network and application rules | ✓ | ✓ | ✓ |
| Threat intelligence filtering | Alert only (can't deny) | Alert and deny | Alert and deny |
| DNS proxy + FQDN filtering | ✗ | ✓ | ✓ |
| TLS inspection | ✗ | ✗ | ✓ |
| IDPS | ✗ | ✗ | ✓ |
| URL filtering (beyond FQDN) | ✗ | ✗ | ✓ |

Basic supports threat intelligence in alert-only mode—it logs suspicious traffic but can't block it. Standard and Premium can enforce threat intelligence in **Alert and deny** mode, actively blocking connections to known malicious IPs and domains. For production environments where blocking is required, Basic isn't a suitable choice.

**Transport Layer Security (TLS) inspection** decrypts outbound HTTPS traffic, inspects the content, and re-encrypts it before forwarding. This capability addresses threats hidden in encrypted traffic, such as malware downloads over HTTPS or data exfiltration to legitimate cloud services. Regulated industries often require TLS inspection to meet compliance mandates, but it introduces certificate management complexity and potential privacy concerns.

**IDPS** analyzes network traffic patterns to detect and block exploits, malware propagation, and protocol violations. Unlike threat intelligence filtering, which relies on known-bad indicators, IDPS uses signature-based and anomaly based detection to identify suspicious behavior. IDPS operates in three modes: Off, Alert, or Alert and deny.

**URL filtering** extends application rules by inspecting the full URL path, not just the FQDN. Standard tier application rules permit or deny `example.com` entirely, but Premium URL filtering can allow `example.com/api/*` while blocking `example.com/admin/*`.

For most enterprise environments, Standard tier addresses the core threat classes outlined earlier. Premium tier becomes necessary when regulatory requirements mandate TLS inspection, when advanced threat detection justifies the extra cost, or when granular URL-level control is required.

Now that you know when Azure Firewall is required and which capabilities address each threat class, the next step is deploying and configuring it—creating rule collections, building Azure Firewall Policy, and setting up threat intelligence filtering.
