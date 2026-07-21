Multi-domain and multi-forest environments depend on the global catalog for more than search. Universal group membership resolution, UPN logon across domains, and several application lookup patterns all require a reachable global catalog. A design that doesn't explicitly plan global catalog placement will eventually produce logon failures that look like intermittent authentication problems but are actually global catalog reachability problems.

## Universal group membership and the global catalog dependency

Universal group membership is stored in the group's domain partition and replicated to the global catalog. When a domain controller in a multi-domain forest processes a logon, it normally contacts a global catalog server to expand the user's universal group memberships. If no global catalog is reachable, logon behavior depends on cached credentials, universal group membership caching, and whether the account is exempt from the global catalog requirement.

Group scopes still have distinct rules in a single-domain forest, but the domain controller already holds all domain objects needed to evaluate membership. The remote global catalog dependency becomes a design constraint when a second domain is added.

## Global catalog placement

In a multidomain forest, evaluate global-catalog placement for every site that authenticates users—not only sites whose resident users come from multiple domains. Include:

- The number of users, WAN availability and latency, and acceptable logon behavior during an outage.
- Roaming users and UPN logons that can require global-catalog discovery.
- Forest-wide searches and applications that query global-catalog ports or perform poorly across a latent WAN.
- Redundancy, capacity, and whether an RODC global catalog is supported by each dependent application.

Prefer a local, redundant global-catalog service when logon or application requirements can't tolerate the WAN dependency. Universal group membership caching (UGMC) can support a small site that has no application requiring a global catalog and no large roaming-user population. UGMC is enabled per site and caches universal group membership on local domain controllers after a user is resolved through a reachable global catalog. It doesn't prepopulate every user and doesn't make applications that issue global-catalog queries independent of a global catalog.

By default, cached universal-group membership is refreshed every eight hours. A failed or delayed refresh can leave authorization based on stale membership, so document the approved refresh interval and the risk of delayed group additions or removals. Place a refresh global catalog no more than one replication hop from a UGMC-enabled domain controller. Test first logon before the cache exists, refresh behavior, WAN outage behavior, roaming users, UPN logon, and every application that directly uses ports 3268 or 3269.

```powershell
Get-ADDomainController -Filter * | Select-Object HostName, Site, IsGlobalCatalog

# List sites and whether universal group membership caching is enabled, per site
Get-ADReplicationSite -Filter * -Properties * |
    Select-Object Name, UniversalGroupCachingEnabled, UniversalGroupCachingRefreshSite
```

See [Planning Global Catalog Server Placement](/windows-server/identity/ad-ds/plan/planning-global-catalog-server-placement) for a full decision framework covering site link speed, user population, and application dependency.

## Infrastructure master nuances

The infrastructure master is responsible for updating references to objects in other domains. If the role is still required, don't place it on a global catalog server unless every domain controller in that domain is also a global catalog. A global catalog has no phantom objects to reconcile, so other non-global-catalog domain controllers can retain stale references.

The role has no practical work when every domain controller in the domain is a global catalog or when Active Directory Recycle Bin is enabled, but it should still have a healthy assigned owner to satisfy tooling and operational expectations.

```powershell
Get-ADDomain | Select-Object InfrastructureMaster
Get-ADDomainController -Identity (Get-ADDomain).InfrastructureMaster | Select-Object HostName, IsGlobalCatalog
```

For the full rationale, see [Planning Operations Master Role Placement](/windows-server/identity/ad-ds/plan/planning-operations-master-role-placement#requirements-for-infrastructure-master-placement) and [Phantoms, tombstones, and the infrastructure master](/troubleshoot/windows-server/active-directory/phantoms-tombstones-infrastructure-master).

## Authentication paths across domains and forests

Trace the authentication path explicitly for each domain and forest boundary in your design, rather than assuming Kerberos "just works" across any trust:

1. Confirm the client can resolve the target domain or forest's DNS records (see the trusts and name-resolution unit).
2. Confirm that the trusting resource domain or forest accepts identities from the trusted account domain or forest. Record both sides by name; don't rely on an arrow or the words inbound and outbound without defining the viewpoint.
3. Confirm the approved network path exists in both required directions for DNS, Kerberos, LDAP, global catalog, RPC endpoint mapping and dynamic RPC, and any scenario-dependent SMB, password-change, LDAPS, time, or ADWS traffic. ADWS TCP 9389 is relevant when remote ActiveDirectory PowerShell cmdlets or another ADWS client traverses the path, not for ordinary logon or trust traffic. Validate the actual endpoints from a representative client; don't infer reachability from the trust object.
4. In a multidomain forest, confirm that universal-group membership can be resolved through a reachable global catalog or a valid UGMC entry. Don't tie this check only to a request that appears to cross a domain boundary. Separately confirm that UPN logon, forest-wide search, and applications that query the global catalog have a reachable and supported global catalog.
5. Confirm selective authentication settings, if enabled, explicitly allow the target computer object.
6. Confirm Kerberos referral behavior - a domain controller that can't authenticate a principal directly refers the request along the trust path, and an unreachable domain controller anywhere in that path can turn into an authentication failure that looks unrelated to the actual broken hop.

Use separate tests for trust enumeration, a specific trust's secure channel, and domain-controller or global-catalog discovery. Run the commands from an elevated command prompt on a representative client or administrative workstation in each relevant site:

```cmd
:: Enumerate trust relationships.
nltest /domain_trusts /all_trusts /v

:: Verify the specific one-way trust from trusting resource side to trusted account side.
netdom trust apps.contoso.com /domain:accounts.fabrikam.com /verify

:: Test global-catalog discovery independently.
nltest /dsgetdc:contoso.com /gc
```

Use controlled test accounts and resources to validate actual Kerberos authentication and authorization after these infrastructure checks. A listed trust or discovered global catalog doesn't prove that selective authentication, name-suffix routing, SPNs, resource ACLs, or firewall paths are correct.

## Record the design

Document, per site: local global-catalog servers and redundancy; WAN path and topology distance to alternative global catalogs; user count and roaming-user assumptions; UPN logon dependency; each application that queries a global catalog; RODC global-catalog support; UGMC state, refresh site, approved refresh interval, and stale-membership risk; and evidence from first-logon, refresh, outage, and failover tests. Document, per domain, the infrastructure master's placement and confirmation that it isn't co-located with a global catalog unless every domain controller in the domain is a global catalog or the documented exception applies.

Record the DNS, Kerberos, LDAP, global catalog, RPC, SMB, password-change, and scenario-dependent ADWS paths used by each authentication or administration scenario, including monitored failover paths.

Use these validation commands from representative sites:

```powershell
Get-ADDomainController -Filter * |
    Select-Object HostName, Site, Domain, IsGlobalCatalog

Get-ADReplicationSite -Filter * -Properties * |
    Select-Object Name, UniversalGroupCachingEnabled,
        UniversalGroupCachingRefreshSite
```

```cmd
nltest /dsgetdc:contoso.com /gc
```
