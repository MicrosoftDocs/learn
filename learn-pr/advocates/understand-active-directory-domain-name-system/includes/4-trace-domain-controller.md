The domain controller locator selects a usable domain controller that meets requested criteria. The domain controller locator doesn't merely return the nearest address.

## Trace a site-aware lookup

The site-aware domain locator sequence uses the following steps:

1. An application asks local Netlogon for a domain controller.
1. Netlogon processes the request through `DsGetDcName`.
1. Netlogon queries the required service location record plus target host records.
1. Netlogon sends Lightweight Directory Access Protocol User Datagram Protocol pings to candidates.
1. A responding domain controller reports capabilities plus the client's site.
1. If needed, the client retries with a site-specific locator query.
1. Netlogon returns a suitable domain controller then caches the result.

:::image type="content" source="../media/site-aware-sequence.svg" alt-text="Diagram that shows site-aware domain controller discovery, selection, and caching.":::

A more detailed request path traces the following steps:

1. A Windows component requests a domain controller with criteria such as writable, global catalog, or Key Distribution Center capability.
1. Local Netlogon implements the locator application programming interface through `DsGetDcName`.
1. Netlogon constructs a service query such as `_ldap._tcp.dc._msdcs.corp.contoso.com`.
1. Domain Name System returns targets plus their host addresses.
1. Netlogon sends a locator ping as a Lightweight Directory Access Protocol search datagram over User Datagram Protocol.
1. Candidate domain controllers report availability, domain, forest, site, and capabilities.
1. The responding domain controller derives the client site from the client's address and directory subnet objects.
1. If the first response identifies Brisbane as a better site, the client can issue `_ldap._tcp.Brisbane._sites.dc._msdcs.corp.contoso.com`.
1. Netlogon returns a suitable result and caches it.

The first response can start the process without being the best long-term selection. Accurate subnet mappings let a domain controller identify the client site. Site-specific records let the client prefer local services. For example in our scenario, if `10.20.15.0/24` isn't mapped to Brisbane, `BNE-APP7` can select Perth even when Brisbane has a healthy domain controller.

## Account for automatic site coverage

A site without a local domain controller can still have site-specific records. Domain controllers evaluate uncovered sites and may register records for selected sites according to automatic site coverage behavior. This keeps directory services discoverable when a site has no local domain controller.

Don't assume that a target in a site's locator answer physically resides in that site. Compare:

- The site's domain controller inventory.
- Subnet-to-site mappings.
- Registered site-specific records.
- Intended site-link cost and coverage.
- The domain controller's reported site.

Automatic coverage should be intentional. Unexpected coverage can indicate missing local capacity, stale records, incorrect topology, or an incorrect expectation rather than a registration fault.

## Inspect locator output

`nltest /dsgetdc:corp.contoso.com /force` forces a fresh DC Locator search for a domain controller in `corp.contoso.com`, bypassing cached discovery information. It uses DNS SRV records, validates candidates, and displays the selected domain controller’s name, address, site, forest, and capabilities. This command is commonly used to test DNS-based domain controller discovery; it doesn't list every domain controller.

A healthy result looks like:

```text
           DC: \\BNE-DC1.corp.contoso.com
      Address: \\10.20.0.10
     Dom Guid: 741ad9df-4607-4f13-89ab-48d06b7ac263
     Dom Name: corp.contoso.com
  Forest Name: contoso.com
     Dc Site Name: Brisbane
  Our Site Name: Brisbane
        Flags: GC DS LDAP KDC TIMESERV WRITABLE DNS_DC DNS_DOMAIN
               DNS_FOREST CLOSE_SITE FULL_SECRET
The command completed successfully
```

You interpret the fields in the following manner:

- **DC** plus **Address** identify the selected target and resolved path.
- **Dom Name** plus **Forest Name** confirm naming context.
- **Dc Site Name** plus **Our Site Name** reveal locality.
- **Flags** show advertised capabilities. `CLOSE_SITE` supports the expected selection.

This output is locator evidence. It doesn't prove the health of authentication, replication, or the selected service.

`nltest /dsgetsite` isolates local site identification. A failed site lookup directs investigation toward address configuration, subnet objects, directory reachability, or cache state.

Cached locator data promotes a consistent directory view and avoids repeated discovery. It can also preserve an earlier choice during diagnosis. `nltest /dsgetdc:<domain> /force` bypasses the cached DC Locator result and reruns discovery. It doesn't guarantee that the DNS Client resolver cache was bypassed, that the answer came directly from an authoritative server, or that the returned DNS data is current. Use explicit direct-server DNS queries when response source and record currency matter. Don't treat cache clearing as a root-cause correction.

## Compare legacy discovery

Domain Name System discovery uses fully qualified domain names, service records, then locator pings. Legacy NetBIOS discovery uses Windows Internet Name Service or broadcast-based mechanisms after short-name handling.

Windows Server 2025 blocks NetBIOS-style domain controller location by default. Once you've migrated to a Windows Server 2025 Active Directory environment, keep the secure default. Use Domain Name System names and correct service records.

You can check whether NetBIOS based DC discovery is blocked using the following command:

```cmd
    reg query "HKLM\SOFTWARE\Policies\Microsoft\Netlogon\Parameters" /v BlockNetbiosDiscovery
```

You can interpret the results of this query as follows:

- `0x1`: NetBIOS-based DC discovery is blocked.
- `0x0`: It's allowed.
- Value absent: not explicitly configured; Windows Server 2025 blocks it by default.
