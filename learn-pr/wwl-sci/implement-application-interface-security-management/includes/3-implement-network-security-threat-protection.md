Authentication and authorization policies control who can call your APIs. Network security controls address a different risk—preventing excessive consumption, blocking requests from unauthorized locations, and reducing the attack surface of the gateway itself. These layers work alongside identity policies, not instead of them.

## Filter requests by IP address

The `ip-filter` policy allows or blocks requests based on the caller's source IP address or Classless Inter-Domain Routing (CIDR) range. It evaluates the request during inbound processing, before any routing or backend forwarding occurs.

Use an allow list when Contoso Retail's partners connect from known fixed IP ranges:

```xml
<inbound>
  <ip-filter action="allow">
    <address>203.0.113.0/24</address>
    <address>198.51.100.5</address>
  </ip-filter>
  <base />
</inbound>
```

With `action="allow"`, API Management accepts requests only from the listed addresses and CIDR ranges and rejects everything else with a `403 Forbidden` response. With `action="deny"`, requests from the listed addresses are blocked and all other source IPs are allowed.

For Contoso Retail's partner-facing product, an allow list of partner IP egress ranges restricts who can reach the gateway's inbound endpoint—even callers who have a valid subscription key are rejected if their source IP isn't in the list.

> [!NOTE]
> The `ip-filter` policy evaluates the IP address as seen by API Management. If callers reach the gateway through a proxy or NAT gateway, API Management sees the proxy's IP, not the originating client's IP. Account for this when defining your allow list—add the proxy's egress IP range rather than individual internal client addresses.

## Apply rate limiting and quota controls

Rate limiting and quota policies control how much callers can consume. Three complementary policies address different time horizons and counter key strategies.

**The `rate-limit` policy** restricts calls per subscription within a short time window:

```xml
<inbound>
  <rate-limit calls="100" renewal-period="60" />
  <base />
</inbound>
```

This example allows 100 calls per 60-second window per subscription. When a caller exceeds the limit, API Management returns `429 Too Many Requests`. The counter resets automatically at the end of each renewal period. Apply this policy at the product scope to enforce consistent limits across all subscribers in the product.

**The `rate-limit-by-key` policy** applies rate limiting based on a custom counter key—any expression that evaluates to a string identifying the caller:

```xml
<inbound>
  <rate-limit-by-key calls="30"
                     renewal-period="60"
                     counter-key="@(context.Request.IpAddress)" />
  <base />
</inbound>
```

Use `rate-limit-by-key` when callers don't use subscription keys, or when you want to apply a secondary throttle based on IP address, independent of subscription identity. You can derive the counter key from a JSON Web Token (JWT) claim, a header value, or any other request attribute accessible through the policy expression context.

**The `quota` policy** enforces total call count or bandwidth limits over a longer period:

```xml
<inbound>
  <quota calls="10000" bandwidth="40960" renewal-period="2592000" />
  <base />
</inbound>
```

This example limits each subscription to 10,000 calls or 40 MB of transferred data per 30-day period (2,592,000 seconds). When the quota is exhausted, callers receive a `403 Forbidden` response until the period renews.

The distinction between `rate-limit` and `quota` reflects two different consumption risks:

- `rate-limit` prevents spike abuse—a caller flooding the API in a short burst.
- `quota` enforces contractual usage limits—ensuring a subscriber doesn't exceed their monthly volume commitment.

For Contoso Retail, apply `rate-limit` at the product scope to protect backend systems from traffic spikes, and `quota` at the same scope to enforce per-subscription monthly allowances that align with partner contract tiers.

## Integrate API Management with Azure Virtual Network

IP filtering and rate limiting operate at the application layer on a publicly accessible gateway endpoint. Virtual network (virtual network) integration takes a more foundational approach—removing or restricting the public endpoint itself so that only callers on private networks can reach the gateway.

API Management supports two virtual network integration modes:

**External mode** deploys API Management in a virtual network subnet while maintaining a public-facing IP address. The gateway accepts requests from the internet and can also communicate with VNet-internal resources—such as backend APIs running on virtual machines, App Service Environments, or Azure Kubernetes Service clusters. Use External mode when partners must reach the API over the internet but your backend services should remain VNet-private, unreachable directly from outside the virtual network.

**Internal mode** deploys API Management fully inside the virtual network with no public endpoint. The gateway and management plane are accessible only from within the virtual network or from connected on-premises networks via VPN or Azure ExpressRoute. No public IP is exposed. Use Internal mode when both callers and backend services are on private networks and public internet access to the gateway is never required. Internal mode provides the strongest network isolation of the two options.

> [!IMPORTANT]
> Virtual network capabilities vary by tier. **VNet injection** (full isolation—no public IP on the gateway) is available only in the **Developer**, **Premium** (classic), and **Premium v2** tiers. **Standard v2** supports only **VNet integration** (outbound connectivity to private backends only; the gateway endpoint remains publicly accessible from the internet). **Private endpoints** (inbound isolation without full virtual network injection) are available across Developer, Basic, Standard, Standard v2, Premium, and Premium v2. Select a tier that matches your isolation requirements before deploying—changing tiers after initial deployment isn't a straightforward operation.

**Private endpoints** provide an alternative inbound access path for Premium tier instances. A private endpoint assigns the API Management gateway a private IP address within a virtual network without injecting the entire instance into the virtual network. Clients on the virtual network—or connected networks—reach the gateway over the Azure backbone using that private IP, while the API Management configuration otherwise remains unchanged. This is useful when you need private inbound access to an existing instance without migrating to a full virtual network deployment.

For Contoso Retail, the right model depends on who consumes the API:

- Partner-facing APIs that external partners must reach over the internet: External mode with IP filtering and rate limiting provides backend isolation while keeping the gateway publicly reachable.
- Internal AI workload APIs consumed only by Contoso's own services: Internal mode or a private endpoint eliminates public exposure entirely, so only applications on Contoso's private network can reach the gateway.

Network controls reduce the attack surface available to a potential attacker before identity policies even apply. Combined with authentication and authorization, they create a layered defense where callers must arrive from the right location, carry the right identity, and stay within consumption limits before any request reaches your backend.
