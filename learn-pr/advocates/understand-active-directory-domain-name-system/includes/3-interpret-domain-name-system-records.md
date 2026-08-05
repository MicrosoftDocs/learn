Domain controllers register records that describe names, services, capabilities, domains, forests, and sites. Diagnosis requires knowing the exact query that a directory operation should issue.

## Distinguish the zones

:::image type="content" source="../media/directory-locator-records.svg" alt-text="Diagram that shows forest-wide, domain-wide, and site-specific locator zones for Contoso Research.":::

Text equivalent: `_msdcs.contoso.com` contains forest-wide global catalog records plus NTDS Settings object GUID-based CNAME records used in replication-partner resolution. `corp.contoso.com` contains domain host records. Locator branches beneath `_msdcs`, `_sites`, `_tcp`, and `_udp` identify domain-wide or site-specific services.

The separate `_msdcs.contoso.com` zone makes forest-wide locator data independently authoritative and commonly allows forest-wide replication scope. The `corp.contoso.com` zone holds host records and domain-specific branches. Zone placement matters: a correct record in the wrong zone doesn't answer the expected query.

## Interpret record types

Active Directory supporting DNS zones use the following DNS record types:

| Record | Directory relevance | Diagnostic use |
| --- | --- | --- |
| `A` | Maps a host name to an Internet Protocol version 4 address. | Confirm that a service target reaches an intended interface. |
| `AAAA` | Maps a host name to an Internet Protocol version 6 address. | Detect valid or unintended version 6 paths. |
| `SRV` | Advertises a service, protocol, port, priority, weight, and target. | Locate domain controllers by role, domain, forest, or site. |
| `CNAME` | Maps the GUID-based name of a domain controller's NTDS Settings object to the domain controller's current host name. This stable name is used when resolving replication partners. | Locate replication partners without binding the replication object to a mutable host name. |
| `SOA` | Identifies zone metadata, including serial and timing data, and the server named in the primary-server field. | Understand intended authority when diagnosing a zone. |
| `NS` | Identifies servers designated authoritative for a zone. | Validate intended delegation and authority paths. |
| `PTR` | Maps an address to a host name. | Supports some diagnostics. Reverse lookup isn't the core domain controller locator mechanism. |

A service location record has this logical form:

`_service._protocol.name time-to-live class SRV priority weight port target`

Example:

`_ldap._tcp.Brisbane._sites.dc._msdcs.corp.contoso.com 600 IN SRV 0 100 389 bne-dc1.corp.contoso.com`

- **Service:** `_ldap`
- **Protocol:** `_tcp`
- **Name:** site-specific domain controller locator path
- **Priority:** `0`; lower values are preferred
- **Weight:** `100`; influences distribution among equal-priority targets
- **Port:** `389`
- **Target:** `bne-dc1.corp.contoso.com`

Weight isn't a guarantee that every client selects targets in a fixed ratio. Locator also considers capability, site, response, and cache state.

## Map requirements to queries

In our scenario, the following DNS names map to domain controllers and services:

| Function | Representative DNS name |
| --- | --- |
| Writable domain controller for `corp.contoso.com` | `_ldap._tcp.dc._msdcs.corp.contoso.com` |
| Brisbane domain controller | `_ldap._tcp.Brisbane._sites.dc._msdcs.corp.contoso.com` |
| Key Distribution Center | `_kerberos._tcp.dc._msdcs.corp.contoso.com` |
| Global catalog for the forest | `_ldap._tcp.gc._msdcs.contoso.com` |
| Primary domain controller emulator | `_ldap._tcp.pdc._msdcs.corp.contoso.com` |
| Replication partner | `<ntds-settings-object-guid>._msdcs.contoso.com` |

You could run this query on `BNE-APP7` in PowerShell:

```powershell
Resolve-DnsName -Name "_ldap._tcp.Brisbane._sites.dc._msdcs.corp.contoso.com" -Type SRV -Server 10.20.0.10
```

Healthy result would be:

```text
NameTarget                    Port Priority Weight
----------                    ---- -------- ------
bne-dc1.corp.contoso.com      389  0        100
```

You can interpret the answer in two steps. First, the queried server can answer the exact site-specific locator name. Second, the returned target still requires an `A` or `AAAA` lookup plus a locator ping. A service response alone doesn't prove that the target is reachable or healthy.

A faulty result would look like:

```text
Resolve-DnsName: _ldap._tcp.Brisbane._sites.dc._msdcs.corp.contoso.com :
DNS name does not exist
```

An authoritative nonexistent-name response means the preferred server answered, so the client doesn't retry an alternate server merely because the answer is wrong. When troubleshooting, determine whether the queried server is authoritative, has a valid delegation path, or holds converged zone data.

## Understand registration ownership

Netlogon registers domain controller locator records. The DNS Client service registers host records. On a domain controller, `%SystemRoot%\System32\Config\Netlogon.dns` lists the locator records Netlogon expects to register and is a useful comparison source.

The NTDS Settings object GUID-based CNAME record commonly resembles:

```text
4f3c5e6a-2d31-4db1-a706-4b2f79017c01._msdcs.contoso.com
    CNAME bne-dc1.corp.contoso.com
```

A destination domain controller resolves this stable NTDS Settings object GUID-based name to the current host name, then resolves that host name to an address. A missing CNAME record, broken CNAME target, or stale host data can each break the chain.

`SOA` and `NS` responses describe intended authority and delegation. Neither record proves which server supplied a recursive, forwarded, or cached response, or that the requested data is current.

Use `SOA` and `NS` to understand intended authority and delegation. Record the actual query destination or responder, query relevant authoritative servers directly, and compare the requested record data before editing anything.
