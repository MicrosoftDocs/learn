Active Directory Domain Services uses Domain Name System for service discovery and replication prerequisites. Clients query service location records, resolve the returned targets, confirm candidates through locator pings, apply site information, and cache a selected domain controller. The domain zone, forest-wide `_msdcs` zone, host records, service location records, and NTDS Settings object GUID-based CNAME records each support a distinct part of this lookup chain.

Directory-integrated zones support multimaster authorized updates, while application directory partitions define replication scope. Secure updates depend on authentication, record ownership, permissions, a writable authoritative server, and healthy directory replication. `SOA` and `NS` records describe intended authority and delegation, but effective diagnosis also identifies the actual query destination and evaluates the requested record data.

A reliable investigation begins on the affected computer. Record its suffixes, addresses, resolver configuration, and site; identify and test the exact service query; validate returned targets and connectivity; inspect registration only when records are absent or stale; and investigate replication when authoritative answers differ. Correct the owning layer with the least disruptive change, then verify DNS resolution, Domain Controller Locator, the original directory operation, and affected-record convergence when relevant.

## Learn more

- [DNS and Active Directory Domain Services](/windows-server/identity/ad-ds/plan/dns-and-ad-ds)
- [Locating domain controllers in Windows and Windows Server](/windows-server/identity/ad-ds/manage/dc-locator)
- [Active Directory-Integrated DNS Zones](/windows-server/identity/ad-ds/plan/active-directory-integrated-dns-zones)
- [Dynamic update](/windows-server/networking/dns/dynamic-update)
- [Troubleshooting DNS dynamic update issues](/troubleshoot/windows-client/networking/troubleshooting-dns-dynamic-update-issues)
- [Best practices for Domain Name System client settings in Windows Server](/troubleshoot/windows-server/networking/best-practices-for-dns-client-settings)
- [Verify Domain Name System functionality to support directory replication](/windows-server/identity/ad-ds/manage/troubleshoot/verify-dns-functionality-to-support-directory-replication)
- [DCDiag](/windows-server/administration/windows-commands/dcdiag)
- [Troubleshoot domain controller location issues in Windows](/troubleshoot/windows-server/windows-security/troubleshoot-domain-controller-location-issues)
- [Active Directory replication error 8524](/troubleshoot/windows-server/active-directory/replication-error-8524)
- [Directory Service event 2087](/troubleshoot/windows-server/active-directory/active-directory-replication-event-id-2087)
- [Directory Service event 2088](/windows-server/identity/ad-ds/manage/component-updates/event-id-2088--dns-lookup-failure-occurred-with-replication-success)
- [Windows Server Inside Out (Microsoft Press)](https://aka.ms/WSInsideOut)
