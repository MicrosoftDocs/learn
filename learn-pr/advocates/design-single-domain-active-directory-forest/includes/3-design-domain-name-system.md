AD DS uses DNS to locate domain controllers, Kerberos services, global catalogs, LDAP endpoints, and replication partners. Resolver failure is therefore an identity outage, even when every domain controller is running.

## Use AD-integrated zones

Store the forest's DNS zones in AD DS unless a validated enterprise DNS integration requires another model. AD integration provides multimaster updates, secure dynamic updates, and directory replication instead of separate zone-transfer topology.

AD DS uses DNS application directory partitions:

- `DomainDnsZones` replicates to DNS servers in one domain
- `ForestDnsZones` replicates to DNS servers across the forest
- `_msdcs.<forest-root>` contains forest-wide locator records and should use forest-wide replication

In a single-domain forest, domain-wide and forest-wide scopes reach the same DNS servers. Keep the scopes explicit because they define ownership and future behavior if forest infrastructure changes.

Use secure dynamic updates. If DHCP registers records for clients, use dedicated DHCP credentials and ensure that ownership doesn't prevent later updates or scavenging.

## Integrate the namespace

If `contoso.com` already exists, delegate `corp.contoso.com` to the AD DS DNS servers. Don't make domain controllers depend on public recursive DNS to locate internal services.

Use:

- Standard forwarders for general recursive resolution
- Conditional forwarders for specific partner, management, or future trust namespaces
- Root hints only when they match the organization's egress and security model
- Reverse lookup zones for operational diagnostics and applications that require pointer records

Don't configure public resolvers on a domain controller's network adapter. Windows doesn't treat DNS server entries as a strict internal-then-external sequence. A public resolver can't answer AD DS service-location queries.

## Design domain controller resolver settings

During promotion, an additional domain controller should use an existing healthy AD DNS server. After DNS and directory replication converge, configure each domain controller to use another local or well-connected AD DNS server as its preferred resolver and itself as an alternate. A first and only domain controller must initially use itself, but the completed design shouldn't leave the domain with one resolver.

Use static IP addressing for domain controllers. Register each interface intentionally. Disable DNS registration on backup, storage, or management-only interfaces that clients mustn't use.

## Plan aging and scavenging

Aging and scavenging remove stale dynamically registered records. Poor configuration can also delete valid records or retain dead domain controllers indefinitely.

Align:

- DHCP lease duration
- DNS no-refresh interval
- DNS refresh interval
- Scavenging schedule
- Static-record exclusions

Enable scavenging only after record ownership, DHCP registration, and static records are understood. Monitor deletions during rollout.

## Validate DNS service

The following commands provide design and implementation evidence:

```powershell
Get-DnsServerZone |
    Select-Object ZoneName, ZoneType, IsDsIntegrated, ReplicationScope, DynamicUpdate

Resolve-DnsName -Type SRV "_ldap._tcp.dc._msdcs.corp.contoso.com"
Resolve-DnsName -Type SRV "_kerberos._tcp.corp.contoso.com"

dcdiag /e /test:dns
```

Validation should prove:

- Every expected DNS server hosts the correct application-partition replicas
- Secure dynamic registration succeeds
- `_msdcs` records identify only valid domain controllers
- Clients can resolve internal and external names without using public resolvers directly
- DNS continues during one domain controller or WAN failure

For DNS architecture guidance, see [Creating a DNS infrastructure design](/windows-server/identity/ad-ds/plan/creating-a-dns-infrastructure-design).
