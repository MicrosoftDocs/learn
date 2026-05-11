The pen test revealed a critical gap: valid credentials granted access to Contoso's Azure platform as a service (PaaS) resources from outside the corporate network. Microsoft Entra authentication alone doesn't control where connections originate. Here, you identify the specific risks of public PaaS endpoint exposure and evaluate why service endpoints provide incomplete protection against data exfiltration.

| Exposure type | Security risk |
|---------------|---------------|
| Public endpoint with authentication | Any internet-connected client with valid credentials can access the resource |
| Service endpoint with virtual network restriction | Public endpoint remains accessible; attackers with credentials bypass virtual network controls from external locations |
| Compromised VM with service endpoint | Data exfiltration to attacker-controlled resources in other tenants remains possible |

## Understand default PaaS endpoint behavior

Every Azure PaaS resource receives a public endpoint by default. When you create an Azure SQL Database, Azure Blob Storage account, Azure Key Vault, or Azure OpenAI resource, Azure assigns a fully qualified domain name (FQDN) that resolves to a public IP address owned by Microsoft.

The public endpoint means any internet-connected client can attempt to connect. The service FQDN—such as `contoso.blob.core.windows.net` or `contoso.vault.azure.net`—resolves through public Domain Name System (DNS) to an IP address accessible from anywhere. Traffic flows over the public internet to reach that endpoint. Traffic flows even when both the client and the service run within Azure.

Network-level access controls on the PaaS resource can restrict connections by source IP address or by virtual network (virtual network), but these controls don't change the fundamental architecture: the endpoint itself remains on the public internet. Most services require Microsoft Entra authentication, but authentication answers "who are you?" rather than "from where are you connecting?" An attacker who obtains a valid token—through phishing, credential theft, or application compromise—gains access from any location.

## Recognize the gaps in service endpoint protection

Service endpoints extend a virtual network subnet's identity to Azure PaaS services. When you enable a service endpoint for Azure Storage on a subnet, traffic from virtual machines (VMs) in that subnet reaches the storage service over the Microsoft backbone network rather than traversing the public internet path.

When a service endpoint is configured, you can restrict the storage account to accept traffic only from specific VNets or subnets. The approach improves isolation for traffic originating from Azure VMs and reduces latency by keeping traffic on the Microsoft network.

However, service endpoints leave critical security gaps:

- **The public endpoint still exists**: The service FQDN continues to resolve to a public IP address. An attacker with valid credentials can connect from outside Azure without using the virtual network service endpoint at all. The virtual network restriction only applies to traffic that originates from within the configured VNets.
- **No private IP address**: Service endpoints don't create a private IP address in your virtual network address space. DNS resolution returns the public IP, so any client performing name resolution receives a publicly routable address.
- **Cross-tenant data exfiltration remains possible**: A compromised VM can exfiltrate data to an attacker-controlled storage account in a different Microsoft Entra tenant. Service endpoints don't enforce tenant boundaries—a VM in your virtual network can reach any Azure Storage account with the appropriate credentials, including accounts owned by attackers.
- **Network perimeter doesn't include the service**: The PaaS resource remains outside your virtual network perimeter. You improved the routing path for internal traffic, but you didn't bring the service inside your network boundary.

> [!IMPORTANT]
> Service endpoints improve routing and isolation for internal virtual network traffic but don't eliminate public endpoint risk. An attacker who obtains valid credentials can bypass virtual network service endpoint restrictions entirely by connecting from outside the virtual network through the public endpoint.

## Implement complete network isolation with private endpoints

A **private endpoint** fundamentally changes the network architecture. Rather than accessing the service through its public IP, you deploy a network interface card (NIC) into your virtual network with a private IP address from your address space. The NIC connects to a specific Azure PaaS resource or a **sub-resource** (the specific service component you want to reach).

When you create a private endpoint, Azure updates DNS configuration so the service FQDN resolves to the **private IP address** inside your virtual network instead of the public IP. Traffic from your virtual network to the PaaS service stays on the private IP path within the Microsoft network—it never reaches the public endpoint.

With private endpoints deployed, you can disable the public endpoint entirely. The PaaS resource rejects traffic from public IP addresses, leaving only the private endpoint path available. Private endpoints provide:

- **No routable public IP**: The service has no accessible public endpoint. External attackers receive no valid address from DNS or, if you retain the public endpoint for specific scenarios, connection attempts are rejected.
- **DNS returns private IP**: Clients inside your virtual network resolve the service FQDN to a private IP address. Clients outside your virtual network either receive no resolution (if you use Azure Private DNS zones) or receive a blocked public IP.
- **Targeted resource access**: Each private endpoint connects to a specific resource instance. A VM can reach the storage account or Structured Query Language (SQL) database connected through the private endpoint, but it can't reach other storage accounts in attacker-controlled tenants. The endpoint only routes traffic to the specific resource for which it was created.
- **Approval workflow**: The resource owner can configure the private endpoint to require explicit approval for each connection request, adding a human review step before access is granted.

> [!NOTE]
> Azure OpenAI is a Microsoft.CognitiveServices resource type. Private endpoint configuration for Azure OpenAI follows the same pattern as other PaaS services, using the `account` subresource.

## Assess Contoso's exposed resources

The pen test identified four categories of PaaS resources with public endpoint exposure. Each category presents distinct risks and requires private endpoint deployment with public access disabled.

| Resource type | Current exposure | Security risk | Recommended control |
|---------------|------------------|---------------|---------------------|
| Azure SQL Database | Public endpoint with IP firewall rules | Structured Query Language (SQL) injection combined with credential theft enables complete database dump from external location | Private endpoint (subresource: `sqlServer`) + disable public access |
| Azure Blob Storage | Public endpoint; some containers use shared access signature (SAS) tokens | Data exfiltration to external storage accounts; unauthorized download of blob containers | Private endpoint (subresource: `blob`) + disable public access |
| Azure Key Vault | Public endpoint with Microsoft Entra authentication | Credential and secret harvesting when application token is compromised | Private endpoint (subresource: `vault`) + disable public access |
| Azure OpenAI | Public endpoint with Microsoft Entra authentication | Unauthorized AI inference billing; prompt injection attacks from external sources | Private endpoint (subresource: `account`) + disable public access |

Each resource currently relies on authentication as the primary security control. Authentication alone doesn't prevent the attack path the pen tester demonstrated.

## Trace the data exfiltration path

The pen tester obtained a Microsoft Entra token through a phishing campaign that targeted application developers. With the stolen token, the attacker authenticated to `contoso.blob.core.windows.net` from a personal laptop outside the corporate network. The token granted access to blob containers containing customer data, and the attacker downloaded the complete contents.

Contoso's corporate firewall had no visibility into this exfiltration. The request went directly from the attacker's laptop to the Azure Storage public endpoint over the public internet. The connection never touched Contoso's network perimeter, and the storage account's IP-based firewall rules didn't apply because the attacker used valid Microsoft Entra credentials.

After you deploy private endpoints and disable public access, the same attack fails. The attacker uses the same stolen token from the same external laptop, but the connection is refused. The storage account FQDN no longer resolves to a routable public address from outside the virtual network. The only valid path to the storage account is through the private endpoint inside Contoso's virtual network, and the attacker has no network route to that private IP.

Now that you understand why public endpoints expose PaaS resources even with strong authentication, the next step is configuring private endpoints to bring those services inside the virtual network perimeter.
