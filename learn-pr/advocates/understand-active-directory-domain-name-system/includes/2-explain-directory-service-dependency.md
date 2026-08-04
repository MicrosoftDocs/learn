Active Directory Domain Services uses Domain Name System as its service-location system. A client normally finds a domain controller by querying service location records, not by guessing a server name.

Active Directory clients use DNS to locate:

- Domain controllers for their domain and site
- LDAP directory services
- Kerberos authentication and password-change services
- Global Catalog servers
- The PDC emulator
- The IP addresses of the discovered servers

These services are advertised primarily through DNS SRV records, with A and AAAA records resolving server names to IP addresses.

> [!NOTE]
> An SRV record identifies the servers that provide a particular network service, including their hostnames, ports, priority, and weighting. Active Directory uses SRV records to help clients locate services such as domain controllers, Kerberos, and LDAP.

## Contoso case study

To elaborate on concepts within this module, we use Contoso as a case study. Contoso Research runs the `contoso.com` forest. Its user domain is `corp.contoso.com`. Brisbane hosts `BNE-DC1`; Perth hosts `PER-DC1`. Both domain controllers run the Domain Name System Server service and host directory-integrated copies of `corp.contoso.com` plus `_msdcs.contoso.com`.

A Brisbane application server, `BNE-APP7`, now shows intermittent sign-in delay. Group Policy refresh fails. An administrator can resolve `www.contoso.com`, but even though a resolver can determine a public name, it might fail to run directory locator queries.

In this module, we trace DNS queries to directory operation. You learn how to interpret locator records, follow site-aware domain controller selection, examine directory-integrated zone convergence, establish a known-good baseline, then diagnose the case study Contoso incident.

## Understand the namespaces

Contoso uses these names:

| Name | Example | Purpose |
| --- | --- | --- |
| Forest root Domain Name System name | `contoso.com` | Identifies the forest root namespace. |
| User domain Domain Name System name | `corp.contoso.com` | Identifies the directory domain and its locator namespace. |
| Primary Domain Name System suffix | `corp.contoso.com` | Forms the computer's fully qualified domain name when aligned with the domain. |
| Domain zone | `corp.contoso.com` | Holds host records plus domain locator branches. |
| Forest locator zone | `_msdcs.contoso.com` | Holds forest-wide locator data plus NTDS Settings object GUID-based CNAME records used in replication-partner resolution. |
| Legacy domain name | `CORP` | Supports older name forms. It isn't the authoritative directory service discovery namespace. |

The names often align, but they describe different objects. A directory domain isn't a Domain Name System zone. A domain controller isn't necessarily a Domain Name System server. A computer's primary suffix can differ from its domain name in a disjoint namespace. Disjoint namespaces are supported, but they add suffix, registration, query, and troubleshooting paths.

## Active Directory domain zone

An **Active Directory domain zone** is the DNS forward lookup zone whose name matches an AD DS domain. For example, the domain `sales.contoso.com` normally has a corresponding DNS zone named `sales.contoso.com`. Although they share a name, they're different structures: the AD DS domain stores directory objects, while the DNS zone stores resource records used to resolve computers and locate domain services.

### Typical structure

```text
sales.contoso.com
├── Zone apex
│   ├── SOA and NS records
│   └── Domain-name A and AAAA records
├── <host-name>
│   ├── A and AAAA records
│   └── Optional CNAME records
├── _tcp
│   ├── _ldap
│   ├── _kerberos
│   └── _kpasswd
├── _udp
│   ├── _kerberos
│   └── _kpasswd
├── _sites
│   └── <site-name>
│       └── _tcp
│           ├── _ldap
│           └── _kerberos
├── _msdcs
│   ├── dc
│   └── pdc
└── DomainDnsZones
    ├── _tcp
    └── _sites
```

In the forest-root domain, `_msdcs` is normally delegated to the separate forest locator zone, such as `_msdcs.contoso.com`. Child domains commonly hold their domain-specific `_msdcs` records within their domain zones.

### Zone apex and host records

The zone apex contains the **start of authority (SOA)** record and **name server (NS)** records that identify the zone and its authoritative DNS servers.

The remainder of the zone contains standard DNS records, including:

- **A records**, which map names to IPv4 addresses
- **AAAA records**, which map names to IPv6 addresses
- **CNAME records**, which provide aliases
- Other records required by applications or services

Domain controllers and domain members normally register their A and AAAA records dynamically. Multiple “same as parent folder” address records might also map the domain name itself to domain controllers for compatibility with applications that don't understand SRV records. Modern Active Directory clients should use SRV records for service discovery.

### Generic service records

The `_tcp` and `_udp` branches contain SRV records that advertise domain-wide services. Common examples include:

| Record | Function |
|---|---|
| `_ldap._tcp.sales.contoso.com` | Locates LDAP services in the domain. |
| `_kerberos._tcp.sales.contoso.com` | Locates Kerberos Key Distribution Centers using TCP. |
| `_kerberos._udp.sales.contoso.com` | Locates Kerberos services using UDP. |
| `_kpasswd._tcp.sales.contoso.com` | Locates Kerberos password-change services. |
| `_kpasswd._udp.sales.contoso.com` | Locates password-change services using UDP. |

Each SRV record identifies a target server, service port, priority, and weight. The client resolves the target server’s A or AAAA record after receiving the SRV response.

### Site-specific records

The `_sites` branch organizes locator records according to Active Directory site. For example:

```text
_ldap._tcp.Sydney._sites.sales.contoso.com
```

This record identifies LDAP servers for the `sales.contoso.com` domain that are registered in the Sydney site. Kerberos services have corresponding site-specific records.

Site-specific records help clients select nearby domain controllers instead of communicating across slower or more expensive WAN connections. DNS supplies the candidate servers, while DC Locator validates them through an LDAP UDP ping and confirms the client’s site.

### DNS application-partition records

The domain zone also contains locator records for DNS application directory partitions. For example:

```text
_ldap._tcp.DomainDnsZones.sales.contoso.com
```

These records identify domain controllers that host the `DomainDnsZones` application partition. Site-specific versions allow a DNS server to locate a nearby replica.

The forest-root domain zone also contains comparable `ForestDnsZones` locator records. The DNS names `DomainDnsZones` and `ForestDnsZones` advertise partition replicas; they shouldn't be confused with the Active Directory application partitions that store DNS data.

### Registration and replication

The **Netlogon service** on each domain controller registers its LDAP, Kerberos, PDC, and other locator records. The **DNS Client service** registers the server’s A and AAAA records. Domain members also register their address records, or DHCP can register them on their behalf.

The domain zone is normally:

- Stored as an Active Directory–integrated zone
- Configured to allow secure dynamic updates
- Replicated through the domain’s `DomainDnsZones` application partition
- Available on DNS servers running on domain controllers in that domain

This produces a multi-master DNS infrastructure. Updates can be accepted by any authoritative writable DNS server and are distributed through Active Directory replication rather than conventional DNS zone transfers.

### How clients use the zone

When a client needs a domain controller, Netlogon queries an appropriate SRV name. DNS returns one or more candidate servers, and the client resolves their host names to IP addresses. DC Locator then contacts the candidates, evaluates their capabilities and site information, selects a suitable domain controller, and caches the result.

> [!IMPORTANT]
> Missing SRV records can prevent domain controller discovery, while missing A or AAAA records can leave clients unable to contact a server that DNS successfully discovered. Incorrect site records, stale registrations, broken delegations, or incomplete DNS replication can produce intermittent authentication failures or cause clients to select distant domain controllers.

## Forest locator zone

The **forest locator zone** is the Active Directory–specific DNS zone named `_msdcs.<forest-root-domain>`. For a forest named `contoso.com`, the zone is `_msdcs.contoso.com`. It provides forest-wide service-location information rather than ordinary host-name resolution.

### Structure

A typical zone contains the following hierarchy:

```text
_msdcs.contoso.com
├── <DSA-GUID>                         CNAME → domain controller FQDN
├── gc
│   ├── _tcp                           Forest-wide Global Catalog records
│   └── _sites\<site>\_tcp             Site-specific Global Catalog records
├── domains\<domain-GUID>
│   ├── _tcp                           Domain controllers identified by domain GUID
│   └── _sites\<site>\_tcp             Site-specific domain GUID records
├── dc                                 Forest-root domain controller records
└── pdc                                Forest-root PDC emulator record
```

Its principal records include:

| Record example | Function |
|---|---|
| `_ldap._tcp.gc._msdcs.contoso.com` | Locates Global Catalog servers anywhere in the forest. |
| `_ldap._tcp.Sydney._sites.gc._msdcs.contoso.com` | Locates Global Catalog servers in the Sydney site. |
| `_ldap._tcp.<domain-guid>.domains._msdcs.contoso.com` | Locates domain controllers using a domain’s permanent GUID rather than its DNS name. |
| `<dsa-guid>._msdcs.contoso.com` | CNAME record mapping a domain controller’s NTDS Settings object GUID to its host name. |
| `_ldap._tcp.dc._msdcs.contoso.com` | Locates domain controllers in the forest-root domain. |
| `_ldap._tcp.pdc._msdcs.contoso.com` | Locates the PDC emulator for the forest-root domain. |

The `dc` and `pdc` branches in this zone apply to the **forest-root domain**. Child domains publish equivalent domain-specific records beneath `_msdcs.<child-domain-name>`.

### Primary functions

The forest locator zone supports two especially important operations:

- **Global Catalog discovery:** Clients and applications query its SRV records to locate Global Catalog servers, including servers in a particular Active Directory site.
- **Directory replication:** Domain controllers use the DSA GUID CNAME records to resolve replication partners. Because the GUID belongs to the domain controller’s NTDS Settings object, it provides a stable identity even if the server or domain is renamed.

Domain GUID records similarly allow a domain to be located by its permanent identifier rather than by a potentially changeable DNS name.

An SRV query returns candidate servers together with their priority, weight, port, and target host name. The target is then resolved through an A or AAAA record. Netlogon can test the candidates with an LDAP UDP ping, select an appropriate server, and cache the result.

### Storage and replication

The forest locator zone is normally:

- Stored as an **Active Directory–integrated DNS zone**
- Configured for **secure dynamic updates**
- Replicated through the forest-wide `ForestDnsZones` application directory partition
- Available to DNS servers running on domain controllers throughout the forest

`_msdcs.contoso.com` is the DNS zone name, whereas `ForestDnsZones` is the Active Directory partition that stores and replicates the zone data.

The parent zone, such as `contoso.com`, normally contains a delegation to `_msdcs.contoso.com`. Netlogon registers and refreshes the locator records, while the DNS Client service registers the corresponding host address records.

Missing or stale records can prevent Global Catalog discovery, delay authentication, or cause Active Directory replication failures even when the domain controllers themselves are operational.

## Follow the dependency map

The following map shows how queries function in our example environment:

:::image type="content" source="../media/directory-service-dependency.svg" alt-text="Diagram that shows client DNS queries, domain controller selection, and replication partner lookup.":::

The diagram represents the process of `BNE-APP7` sending host and service queries to an internal resolver. The resolver answers from the directory zones. The client sends a locator ping to candidate domain controllers, selects one, then starts Kerberos, Lightweight Directory Access Protocol, Group Policy, or secure-channel traffic. Each domain controller also resolves its replication partner's NTDS Settings object GUID-based CNAME record and then the target host name before directory replication can connect.

Before sign-in, domain join, Group Policy processing, or a directory query, a client usually needs a suitable domain controller. Domain controllers use the same discovery model for services such as the primary domain controller emulator and global catalog. Directory replication also depends on name resolution for replication partners.

Faults can therefore surface as:

- Domain join failure because the client can't find a writable domain controller.
- Sign-in delay because locator queries time out or select a remote domain controller.
- Kerberos failure because the Key Distribution Center service can't be located or reached.
- Group Policy failure because domain controller discovery or later Server Message Block access fails.
- Global catalog lookup failure because forest-wide locator records are unavailable.
- Replication error because a destination domain controller can't resolve its source partner.
- Trust failure because the required domain or forest locator path fails.

## Separate the layers

Similar symptoms can have different owners.

| Layer | Question | Evidence |
| --- | --- | --- |
| Host resolution | Does the target name resolve to the intended address? | `A`, `AAAA`, or `CNAME` response |
| Service location | Does the required service query return suitable targets? | Service location response |
| Connectivity | Can the computer reach the target protocol and port? | Connection test |
| Service availability | Is the target service listening and responsive? | Locator ping, service state, event data |
| Authentication | Can credentials obtain and use the required ticket or token? | Kerberos, security, secure-channel evidence |
| Directory health | Can the domain controller read current directory data? | Directory diagnostics |
| Replication health | Can directory changes converge between partners? | Replication summary, partner status |

Resolving `BNE-DC1.corp.contoso.com` proves only a host lookup. It doesn't prove that `_ldap._tcp.dc._msdcs.corp.contoso.com` exists, that `BNE-DC1` answers a locator ping, that port 389 is reachable, or that directory replication is healthy.

Conversely, not every authentication or replication failure is a Domain Name System failure. Use Domain Name System evidence to establish causality rather than infer it from the symptom.
