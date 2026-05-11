Unit 3 showed how Contoso consumes private connectivity to Azure platform as a service (PaaS) resources through private endpoints. Now the pattern reverses: Contoso becomes the **provider** that exposes an internal service to another organization's virtual network (virtual network) without a public IP address. Here, you identify when Azure Private Link Service is the right solution and what configuration components it requires.

| Scenario | Configuration requirement |
|---|---|
| Multitenant SaaS delivery | Standard SKU internal load balancer + NAT subnet + alias sharing |
| Cross-subscription internal services | Private Link Service in hub + consumer private endpoints in spoke subscriptions |
| Partner B2B integration with IP overlap | SNAT-enabled Private Link Service + connection approval workflow |
| Cross-tenant private access | Alias-based discovery + manual approval for each tenant subscription |

## The provider pattern

Private endpoints solve Contoso's consumption needs—connecting privately to Azure PaaS services like Storage and SQL Database. But what happens when Contoso builds its own service and needs to expose it to external consumers? Without Azure Private Link Service, you have only two options: Virtual network peering (which requires coordinating IP address spaces and exposes both VNets fully) or a public IP endpoint (which violates zero-trust principles).

Azure Private Link Service provides a third path. With this capability, Contoso exposes an internal service through a one-way, provider-controlled private connection. The consumer deploys a private endpoint in their own virtual network, and Azure routes traffic privately to Contoso's service—no virtual network peering, no public exposure, and no IP address conflicts.

Consider three scenarios where this pattern applies. Contoso's compliance team builds a regulatory reporting API and sells it as an SaaS offering to financial services customers. Each customer connects through a private endpoint in their own virtual network—the service never has a public IP address. Contoso's central IT team hosts a shared identity verification service in a hub subscription, and business unit teams in separate subscriptions need private access without peering every spoke virtual network. A manufacturing partner needs private access to Contoso's inventory API, but both organizations use overlapping 10.0.0.0/8 address ranges—traditional virtual network connectivity fails because of the IP conflict.

Each scenario shares a common constraint: the consumer and provider don't want to coordinate network topology, expose full VNets to each other, or use public IPs. Azure Private Link Service addresses all three requirements.

## How Azure Private Link Service works

Azure Private Link Service sits between the consumer's private endpoint and the provider's backend service, handling network address translation (NAT) and connection routing. The architecture requires four components working together.

The first component is a **Standard SKU internal load balancer**. Azure Private Link Service requires this load balancer as its front end—Basic SKU load balancers and public-facing load balancers aren't supported. The load balancer distributes incoming traffic across the backend service pool (virtual machines, containers, or other compute resources).

> [!NOTE]
> The Standard load balancer must be **internal** with no public frontend IP configuration. Azure Private Link Service doesn't support public-facing load balancers.

The second component is the **NAT IP configuration**. Azure Private Link Service performs source NAT (SNAT) on all incoming traffic. When a consumer's application sends a request to their private endpoint, Azure routes the traffic to the provider's Private Link Service. The service replaces the consumer's source IP address with a NAT IP from a dedicated subnet in the provider's virtual network. The translation means the provider's backend service never sees the consumer's actual IP—it sees only the NAT IP. The design isolates the consumer's network topology from the provider and eliminates IP address conflicts.

The third component is the **alias-based discovery mechanism**. Instead of sharing subscription IDs or resource IDs, the provider shares an alias (for example, `xyz.centralus.azure.privatelinkservice`). The consumer creates a private endpoint using this alias as the target resource. The alias functions as a routing identifier—it tells Azure which Private Link Service to connect to, but it doesn't grant access by itself.

The fourth component is the **connection approval workflow**. By default, every consumer connection request requires explicit approval from the provider. When a consumer creates a private endpoint using the alias, the request appears in the provider's Private Link Service connection list with a "Pending" status. The provider reviews the consumer's subscription ID and approves or denies the request. For trusted subscriptions (such as the provider's own dev/test environments), the provider can configure autoapproval based on subscription ID.

Here's how traffic flows through these components. The consumer's application sends a request to the private endpoint network interface card (NIC)—a private IP in the consumer's virtual network. Azure routes the request over the Microsoft backbone network to the provider's Private Link Service front end. The Private Link Service performs SNAT, replacing the consumer's source IP with a NAT IP from the provider's dedicated NAT subnet. The translated request arrives at the provider's Standard internal load balancer, which distributes it to a backend virtual machine based on the configured load balancing rule. The backend VM processes the request and sends the response back through the same path—the load balancer forwards it to the Private Link Service, which translates the NAT IP back to the consumer's private endpoint IP.

One regional constraint applies to the **provider side**: the Private Link Service must be deployed in the same region as its Standard Load Balancer and the virtual network that hosts it. On the **consumer side**, there's no regional restriction—a private endpoint in any Azure public region can connect to the Private Link Service, including from globally peered virtual networks and from on-premises via VPN or ExpressRoute. A single Private Link Service can serve consumers across multiple regions and tenants.

## Configuration steps—create a Private Link Service

Creating a Private Link Service in the Azure portal follows a five-step workflow. Before you begin, deploy a Standard SKU internal load balancer in front of your backend service and configure a load balancing rule with a health probe.

In the Azure portal, search for **Private Link** and select **Private Link services**. Select **+ Create**. On the **Basics** tab, choose the subscription, resource group, name, and region for the Private Link Service. The region must match the load balancer's region.

On the **Outbound settings** tab, select the Standard internal load balancer and choose the frontend IP configuration to expose. Under **NAT subnet**, select or create a subnet for NAT IP addresses. The subnet must have the `privateLinkServiceNetworkPolicies` setting disabled—Azure disables the setting automatically when you create the subnet through the Private Link Service wizard. A dedicated subnet isn't required, but Microsoft recommends one to simplify traffic auditing and avoid unintended network security group (NSG) conflicts with other workloads in the subnet.

On the **Access security** tab, configure the approval workflow. Select **Restricted by subscription** to require manual approval for every connection request, or select **Role-based access control only** to allow any subscription with the correct Azure role assignment to connect automatically. For production scenarios, restrict access and configure autoapproval only for specific subscription IDs you control.

Complete the wizard and deploy the Private Link Service. After deployment completes, navigate to the **Overview** screen and copy the **Alias**. Share this alias with consumers.

On the consumer side, the process differs slightly from creating a standard private endpoint. The consumer navigates to **Private Link** > **Private endpoints** > **+ Create**, but instead of selecting an Azure PaaS resource, they choose **Connect to an Azure resource by resource ID or alias**. They paste the alias you provided and complete the wizard. The connection request appears in your Private Link Service with a "Pending" status. You approve it, and the connection becomes active.

One DNS consideration applies. Azure PaaS services have standard fully qualified domain names (FQDNs) like `storageaccount.blob.core.windows.net`, and Azure automatically manages private DNS zones for them. Private Link Service exposes a custom service, so there's no automatic DNS integration. The consumer must manually create a private DNS A record for whatever FQDN they use to call your service, pointing it to their private endpoint's IP address.

## When to use Private Link Service vs. virtual network peering

Both Azure Private Link Service and virtual network peering enable private connectivity between VNets, but they serve different scenarios. The following comparison helps you choose the right approach.

| Scenario | Virtual network peering | Azure Private Link Service |
|---|---|---|
| Both VNets in the same organization | Simpler—full network connectivity | Possible but unnecessary |
| Cross-tenant (different Microsoft Entra directory) |  Not supported |  Designed to support |
| Overlapping IP address spaces | Requires nonoverlapping classless inter-domain routing (CIDR) ranges | NAT eliminates IP conflicts |
| Provider controls which resources consumers can reach | Peering exposes the full virtual network | Only the load balancer frontend is reachable |
| Consumer doesn't want to expose their virtual network topology | Works but full mutual visibility | Consumer virtual network remains opaque to provider |

Virtual network peering establishes full network connectivity between two virtual networks—every resource in one virtual network can reach every resource in the other (subject to network security group rules and firewalls). The approach works well when both VNets belong to the same organization, have nonoverlapping IP address ranges, and you want simple, bidirectional connectivity.

Azure Private Link Service enforces service-level isolation. The consumer can reach only the specific service exposed through the Private Link Service (the load balancer frontend)—they can't reach other resources in the provider's virtual network. The connection is unidirectional—the consumer initiates connections to the provider, but the provider can't initiate connections back to the consumer's virtual network. The design reduces the attack surface and limits the blast radius if either party's network is compromised.

> [!TIP]
> If both VNets are in the same organization and have no IP overlap, virtual network peering is simpler and provides lower latency. Use Azure Private Link Service when you need cross-tenant isolation, IP address overlap tolerance, or granular service-level access control.

## Security considerations for Private Link Service providers

Four security controls protect both the provider and consumer when using Azure Private Link Service.

First, use a dedicated subnet for the NAT IPs where practical. While not required, a dedicated NAT subnet prevents accidental network security group (NSG) rule conflicts and makes it easier to audit which traffic originated from Private Link Service connections versus other internal sources.

Second, always review and approve each consumer connection request. Azure Private Link Service connections are unidirectional—the consumer's virtual network traffic flows into your service, but you can't initiate connections back to the consumer. Treat each approval as a trust decision. Verify the consumer's subscription ID and confirm you intended to grant access to that specific consumer before approving.

Third, configure diagnostic settings on the Standard load balancer to log connection health and traffic metrics. The backend VMs see the NAT IP as the source IP address for all incoming requests—they don't see the consumer's actual IP. To correlate NAT IPs back to specific consumer connections, cross-reference the NAT IP in your backend logs with the connection list in the Private Link Service. Each connection entry shows which NAT IP serves which consumer.

Fourth, understand that the alias itself isn't a secret—it's a routing identifier, not an authentication credential. Sharing the alias doesn't grant access; Azure enforces access control through the approval workflow. However, share the alias only with known consumers to avoid processing approval requests from unknown parties.

Now that you understand both sides of the Private Link pattern—consumer and provider—the next step is ensuring adoption across Contoso's entire Azure estate. Organizations deploy private endpoints for known resources, but as the estate grows, new services provisioned without private endpoints reintroduce public exposure. The next unit covers enforcing and auditing private endpoint adoption with Azure Policy.
