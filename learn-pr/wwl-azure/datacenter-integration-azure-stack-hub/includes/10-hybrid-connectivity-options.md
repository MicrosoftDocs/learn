For hybrid connectivity, it's important to consider what kind of deployment you want to offer and where it will be deployed. You'll need to consider whether you need to isolate network traffic per tenant, and whether you'll have an intranet or internet deployment.

 -  **Single-tenant Azure Stack Hub**: An Azure Stack Hub deployment that looks, at least from a networking perspective, as if it's one tenant. There can be many tenant subscriptions, but like any intranet service, all traffic travels over the same networks. Network traffic from one subscription travels over the same network connection as another subscription and doesn't need to be isolated via an encrypted tunnel.
 -  **Multi-tenant Azure Stack Hub**: An Azure Stack Hub deployment where each tenant subscription's traffic that's bound for networks that are external to Azure Stack Hub must be isolated from other tenants' network traffic.
 -  **Intranet deployment**: An Azure Stack Hub deployment that sits on a corporate intranet, typically on private IP address space and behind one or more firewalls. The public IP addresses aren't truly public because they can't be routed directly over the public internet.
 -  **Internet deployment**: An Azure Stack Hub deployment that's connected to the public internet and uses internet-routable public IP addresses for the public VIP range. The deployment can still sit behind a firewall, but the public VIP range is directly reachable from the public internet and Azure.

The following table summarizes the hybrid connectivity scenarios with the pros, cons, and use cases.

:::row:::
  :::column:::
    **Scenario**
  :::column-end:::
  :::column:::
    **Connectivity Method**
  :::column-end:::
  :::column:::
    **Pros**
  :::column-end:::
  :::column:::
    **Cons**
  :::column-end:::
  :::column:::
    **Good For**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Single tenant Azure Stack Hub, intranet deployment
  :::column-end:::
  :::column:::
    Outbound Network Address Translation (NAT)
  :::column-end:::
  :::column:::
    Better bandwidth for faster transfers. Simple to implement; no gateways required.
  :::column-end:::
  :::column:::
    Traffic not encrypted; no isolation or encryption outside the stack.
  :::column-end:::
  :::column:::
    Enterprise deployments where all tenants are equally trusted.

Enterprises that have an Azure ExpressRoute circuit to Azure.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Multi-tenant Azure Stack Hub, intranet deployment
  :::column-end:::
  :::column:::
    Site-to-site VPN
  :::column-end:::
  :::column:::
    Traffic from the tenant VNet to destination is secure.
  :::column-end:::
  :::column:::
    Bandwidth is limited by site-to-site VPN tunnel.

Requires a gateway in the virtual network and a VPN device on the destination network.
  :::column-end:::
  :::column:::
    Enterprise deployments where some tenant traffic must be secured from other tenants.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Single tenant Azure Stack Hub, internet deployment
  :::column-end:::
  :::column:::
    Outbound NAT
  :::column-end:::
  :::column:::
    Better bandwidth for faster transfers.
  :::column-end:::
  :::column:::
    Traffic not encrypted; no isolation or encryption outside the stack.
  :::column-end:::
  :::column:::
    Hosting scenarios where the tenant gets their own Azure Stack Hub deployment and a dedicated circuit to the Azure Stack Hub environment. For example, ExpressRoute and Multiprotocol Label Switching (MPLS).
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Multi-tenant Azure Stack Hub, internet deployment
  :::column-end:::
  :::column:::
    Site-to-site VPN
  :::column-end:::
  :::column:::
    Traffic from the tenant VNet to destination is secure.
  :::column-end:::
  :::column:::
    Bandwidth is limited by site-to-site VPN tunnel.

Requires a gateway in the virtual network and a VPN device on the destination network.
  :::column-end:::
  :::column:::
    Hosting scenarios where the provider wants to offer a multi-tenant cloud, where the tenants don't trust each other and traffic must be encrypted.
  :::column-end:::
:::row-end:::
