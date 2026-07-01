A replication topology rarely fails all at once. It degrades quietly: convergence stretches from minutes to hours, a branch authenticates against a DC three time zones away, or a functional-level upgrade stalls because one DC never received a change. This unit catalogs the topology anti-patterns that cause these symptoms, then shows how to validate DC Locator and replication behavior so the topology is ready for Windows Server 2025—where the safety net of NetBIOS-based discovery is gone by default.

## Common topology anti-patterns

Topology anti-patterns are recurring Active Directory site and replication design mistakes that look workable at first but create poor DC selection, slow convergence, and brittle failover behavior under real network conditions. 

### One site link that contains every site

The most common design flaw is leaving all sites in a single link—often the original `DEFAULTIPSITELINK`—with default cost and interval. This tells the Knowledge Consistency Checker (KCC) that every site is equally and directly connected to every other, so it builds an effectively meshed inter-site topology with no notion of hubs or least-cost paths. A hub-and-spoke WAN modeled this way produces connections that ignore the real network, route replication over expensive or unreliable links, and overload bridgeheads. **Fix:** model each physical link as its own two-site site link, and set costs so the least-cost path matches the physical topology.

### Default costs and intervals everywhere

Cost `100` and a `180`-minute interval on every link means no link is preferred over another and changes can take hours to converge—worse when a link is flaky, because a missed 180-minute cycle delays replication by another three hours. **Fix:** derive cost from bandwidth, latency, reliability, and circuit price; lower the interval (commonly to 15 minutes) so transient failures cost minutes, not hours.

### Missing, overlapping, or imprecise subnets

If a domain member's IP doesn't map to a subnet object, the DC can't determine the client's site and hands back an arbitrary—frequently remote—DC. Overlapping subnets are as bad, because site assignment becomes nondeterministic. **Fix:** map every routed subnet to exactly one site and audit Netlogon for `NO_CLIENT_SITE` entries.

### Sites with no DC but an expectation of local service

A site with subnets but no DC relies on **automatic site coverage**, where a DC in the next least-cost site registers site-specific SRV records on the empty site's behalf. That's by design, but it surprises teams who assume "a site" means "a local DC." If costs are wrong, an unexpected DC covers the site. **Fix:** verify which DC covers each DC-less site and confirm it's the intended least-cost neighbor.

### Manual connection objects and over-provisioned bridgeheads

Hand-built connection objects aren't managed by the KCC, so they rot as DCs change. Designating too many eligible bridgeheads in a hub creates a subtler problem: because the KCC doesn't test RPC connectivity before creating a connection, a branch bridgehead failing over an entire hub must iterate through each unavailable hub bridgehead, satisfying `IntersiteFailuresAllowed` and `MaxFailureTimeForIntersiteLink` for each one before it tries a transitive hub. With several eligible bridgeheads, that iteration can add *many hours* of delay before a working connection is built. **Fix:** prefer KCC-generated connections, keep bridgehead counts deliberate, and consider a dedicated logical hub site for backup bridgeheads.

### Disabling the KCC or pinning preferred bridgeheads carelessly

Disabling KCC topology generation hands you full responsibility for every connection object across the forest—almost never worth it. Designating preferred bridgeheads is risky too: if every preferred bridgehead for a domain in a site is unavailable, the ISTG won't pick a replacement and replication of that domain stops. **Fix:** leave the KCC enabled; if you must pin bridgeheads, pin more than one and monitor them.

### BASL enabled on a network that isn't fully routed

Bridge All Site Links assumes transitive connectivity. On a partially routed network—say, branches that reach their regional hub but can't route beyond it—the KCC may compute a transitive path that the network can't actually carry. **Fix:** disable BASL and create explicit site link bridges that mirror real routing.

> [!TIP]
> Use `repadmin /showism` and `repadmin /bridgeheads /verbose` to see how the ISTG actually evaluated the intersite topology and which DCs it chose as bridgeheads. When the chosen path surprises you, the cost or bridging configuration—not the engine—is usually the problem.

## Validate DC Locator behavior

Topology is only correct if clients and DCs actually *locate* the right DC through it. DC Locator resolves a DC in two stages: a DNS SRV lookup for the domain, followed by a *site-specific* lookup that narrows the result to the caller's site. Validate both.

```cmd
:: Which DC and site does this client resolve, and is the result site-aware?
nltest /dsgetdc:contoso.com /force
nltest /dsgetdc:contoso.com /gc /force

:: What site does the directory believe this client/IP belongs to?
nltest /dsgetsite
nltest /dsaddresstosite:10.20.30.40
```

```powershell
# Confirm site-aware discovery returns a local DC
Get-ADDomainController -Discover -DomainName contoso.com -SiteName "Chicago"

# Health checks for SRV records and locator logic
dcdiag /test:DNS /DnsRecordRegistration /v
dcdiag /test:LocatorCheck
```

The site-specific records DC Locator depends on look like `_ldap._tcp.<SiteName>._sites.dc._msdcs.contoso.com`. If those records are missing, or the subnet-to-site mapping is wrong, clients fall through to a generic domain-wide look up and can land on a remote DC.

## Windows Server 2025 readiness: DNS is the only path

Historically, when DNS-based discovery failed, the DC Locator could fall back to **NetBIOS mailslot** discovery (broadcast or WINS). That fallback masked broken topology and missing SRV records. Windows Server 2025 changes the default:

- The Group Policy setting **Block NetBIOS-based discovery for domain controller location** (`BlockNetBIOSDiscovery`) defaults to **TRUE**. When explicitly configured, the backing registry value is `HKLM\Software\Policies\Microsoft\Netlogon\Parameters\BlockNetBIOSDiscovery` (`REG_DWORD`); `1` blocks NetBIOS-based discovery, `0` allows the legacy fallback if WINS or mailslot discovery is otherwise available. If the policy value is absent, Windows Server 2025 still uses the secure default and blocks NetBIOS-based discovery.
- With the block in effect, Netlogon uses **DNS-based discovery only**. There's no mailslot or broadcast fallback.
- Netlogon's NetBIOS mailslot functionality is **deprecated** in Windows Server 2025 and shouldn't be relied on going forward.

This change is a security and hygiene improvement, but it removes the cushion that hid topology defects. The practical consequence is **DNS-based site discovery becomes a hard dependency**: any subnet not mapped to a site, any missing site-specific SRV record, or any application that depended on NetBIOS-based DC discovery can now fail outright instead of falling back.

> [!IMPORTANT]
> Before you enforce `BlockNetBIOSDiscovery` (or deploy Windows Server 2025 DCs that block it by default), inventory **legacy DC Locator dependencies**: applications that call `DsGetDcName` with NetBIOS-style flags, single-label domain name lookups, WINS-dependent logon scripts, and appliances that locate DCs by browsing. Confirm each can resolve a DC via DNS SRV records first. Use `nltest /dsgetdc:contoso.com /force` from representative subnets to prove DNS-only discovery succeeds before removing the fallback.

### Validate topology before raising the functional level

Windows Server 2025 introduces new domain and forest functional levels. Raising a functional level is a forest- or domain-wide, one-way change that every DC must observe, so it depends on a healthy, fully converged topology. If a DC is unreachable or lagging when you raise the level, it can miss the change and behave inconsistently—or block the upgrade.

Treat topology and replication validation as a gate before any functional-level change:

```cmd
:: End-to-end replication and topology health across every DC
repadmin /replsummary
repadmin /showrepl * /csv > repl.csv
dcdiag /e /test:Replications /test:Intersite /test:KccEvent
```

Confirm there are no failing connections, no DCs absent from `/replsummary`, and no KCC errors before you proceed. The next unit gives you the metadata-level tools to *prove* convergence rather than infer it, and the unit after that turns these health checks into a repeatable failure-diagnosis workflow.
