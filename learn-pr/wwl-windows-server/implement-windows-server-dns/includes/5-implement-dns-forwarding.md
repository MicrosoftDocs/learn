When a DNS server doesn't host a primary or secondary zone containing resource records in a DNS request, it needs a mechanism to find the required information. By default, each DNS server is configured with root hints that can be used to resolve DNS requests on the internet by finding the authoritative DNS servers. This works if the DNS server has access to the internet and the resource record being requested is available on the internet. Sometimes, both conditions aren't met. In those circumstances, you can enable forwarding.

:::image type="content" source="../media/m12-dns-3.png" alt-text="A screenshot of the SEA-DC1.Contoso.com Properties dialog. The administrator has selected the Forwarders tab. One forwarder is listed. Displayed behind this dialog box, the DNS Manager console. Displayed is the Conditional Forwarders node, with one domain record for Adatum.com.":::

## Forwarders

You can configure each DNS server with one or more forwarders. If a DNS server receives a request for a zone for which it isn't authoritative, and it isn't already cached by the server, the DNS server forwards that request to a forwarder. A DNS server uses a forwarder for all unknown zones.

Forwarders commonly are used for internet name resolution. The internal DNS servers forward requests to resolve internet names to a DNS server that's outside the corporate network. Your organization might configure the external DNS servers in a perimeter network, or use a DNS server provided by your internet service provider. This configuration limits external connectivity and increases security.

## Conditional forwarding

You can configure conditional forwarding for individual DNS domains. This is similar to configuring a forwarder, except that it applies only to a single DNS domain. Trusted AD DS forests and partner organizations often use this feature.

When you create a conditional forwarder, you can choose whether to store it locally on a single DNS server or in AD DS. If you store it in AD DS, it can be replicated to all DNS servers running on domain controllers in the domain or forest, depending on the option you select. It's easier to manage conditional forwarders across multiple DNS servers when you store them in AD DS.

### Stub zones

The purpose of a stub zone is to provide a list of name servers that can be used to resolve information for a domain without synchronizing all the records locally. To enable this, the following are synchronized:

- Name server records
- Corresponding host records for the name servers
- SOA record

> [!TIP]
> Typically, you would use stub zones when integrating with autonomous systems such as partner organizations.

## Comparing stub zones and conditional forwarders

To resolve DNS requests for zones for which the local DNS server isn't authoritative, you can use either stub zones or conditional forwarders. The difference between the two is how the remote servers are selected for querying:

- You configure a conditional forwarder with specific remote DNS servers that are authoritative for the domain.
- A stub zone replicates and uses all name server records configured in the zone.

If the authoritative DNS servers are likely to change over time, you might want to use a stub zone, which automatically updates the name server records and uses only valid name servers for the zone. However, if firewalls control communication, the updated name servers might be not reachable.
