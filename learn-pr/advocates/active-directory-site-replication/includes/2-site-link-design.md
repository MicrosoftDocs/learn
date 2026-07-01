Site topology is the bridge between your physical network and the logical Active Directory Domain Services (AD DS) directory. You describe the network to AD DS with a small set of configuration objects—sites, subnets, site links, and (optionally) site link bridges—and the directory's automatic topology engine turns that description into a concrete graph of replication connections between domain controllers. This unit explains those building blocks and the components that consume them: the Knowledge Consistency Checker (KCC), the Inter-Site Topology Generator (ISTG), bridgehead servers, and connection objects.

Everything in this unit lives in the **Configuration** naming context (NC), so it replicates to every DC in the forest. A design mistake in one site is visible forest-wide.

## Sites and subnets

A **site** represents a set of well-connected IP subnets—typically a LAN or a group of segments joined by high-bandwidth, low-latency links. Sites serve two purposes that are easy to conflate but worth separating:

- **Replication boundary.** Within a site, replication is near-immediate and uncompressed. Between sites, replication is scheduled and compressed to conserve WAN bandwidth.
- **Service location boundary.** Clients use site membership to find the *closest* DC, Distributed File System (DFS) target, and other site-aware services. This is the DC Locator path you validate later in the module.

A **subnet** object maps an IP range to a site. Subnet-to-site mapping is what lets a DC tell a client which site it belongs to, so missing or overlapping subnets are one of the most common—and most disruptive—topology defects. On Windows Server 2025, where NetBIOS-based DC discovery is blocked by default, accurate subnet coverage is no longer optional: it's the only mechanism that keeps clients on a local DC.

> [!IMPORTANT]
> Every routed subnet that hosts domain members should map to exactly one site. A client whose source IP doesn't match any subnet object is logged on the DC's Netlogon as a "no-client-site" event and is given an arbitrary (often remote) DC. Audit `%SystemRoot%\debug\netlogon.log` for `NO_CLIENT_SITE` entries to find unmapped subnets.

```powershell
# Inventory the topology objects in the Configuration NC
Get-ADReplicationSite -Filter * | Sort-Object Name
Get-ADReplicationSubnet -Filter * | Select-Object Name, Site | Sort-Object Site
Get-ADReplicationSiteLink -Filter * |
    Select-Object Name, Cost, ReplicationFrequencyInMinutes, SitesIncluded
```

## Site links, cost, interval, and schedule

A **site link** is an administrator-defined object that declares a *potential* replication route between two or more sites and assigns three properties the topology engine uses:

| Property | Meaning | Default | Design guidance |
| --- | --- | --- | --- |
| **Cost** | Relative preference of the route. Lower cost is preferred. | 100 | Derive from bandwidth/latency/reliability so the least-cost path mirrors the real network. |
| **Replication interval** | How often replication polls during the open schedule. | 180 minutes | 15 minutes suits most modern WANs. A lower interval doesn't move *more* data—it moves the same changes *sooner* and recovers from transient failures faster. |
| **Schedule** | The window during which the link is open. | 24×7 | Constrain only when a bridgehead is overloaded or a link must be reserved for business hours. |

A new forest ships with a single link, `DEFAULTIPSITELINK`, in the IP (RPC over IP) transport. As a rule, **a site link should contain exactly two sites**. A link that contains three or more sites tells the KCC that every site in that link is equally well connected to every other, which produces a full-mesh assumption that rarely matches reality.

> [!IMPORTANT]
> AD DS historically offered two inter-site transports, but on Windows Server 2025 only one is viable. **IP (RPC over IP)** is synchronous, supports change notification, secures traffic with Kerberos and encryption, and carries every naming context—it's the only supported transport for both intra- and inter-site replication. **SMTP** replication is a legacy transport: asynchronous, intersite-only, able to replicate only the schema, configuration, and application partitions (never the domain NC), with no change notification, and it required an enterprise certificate authority (CA). The underlying **SMTP Server feature is removed in Windows Server 2025**, and Microsoft states SMTP replication won't be supported in future AD DS versions, so creating site links in the SMTP container isn't recommended. Treat SMTP as compatibility context only and design every site link on RPC over IP.

### How costs combine across a path

When sites aren't directly linked, the KCC computes a transitive path and combines the link properties along it:

- **Costs are added.** The route New York → Chicago → Denver costs the sum of both links.
- **The replication interval is the maximum** of the intervals along the path.
- **Options are combined with a bitwise AND.** A behavior such as inter-site change notification is only in effect end to end if every link on the path enables it.
- **The schedule is the overlap** of the per-link schedules. If the windows don't overlap, the path can't be used.

### Bridging and Bridge All Site Links

By default, **Bridge All Site Links (BASL)** is enabled, which makes all site links in a transport transitive: the KCC can build a least-cost path through intermediate sites without an explicit **site link bridge** object. Leave BASL enabled for fully routed networks. Disable it—and create explicit site link bridges—only when the network isn't fully routed (for example, a branch that can reach its hub but not beyond it). When you disable BASL, you become responsible for ensuring every naming context replica has a connected path; the KCC will no longer invent transitive routes for you.

## The components that build the topology

You describe intent with sites and links; these components turn it into connections.

### Knowledge Consistency Checker (KCC)

The **KCC** is a process on every DC that runs every 15 minutes and automatically generates the **inbound** replication topology—both intra-site and inter-site—by creating and maintaining **connection objects**. You can let it run unattended in almost all cases. It builds redundant intra-site rings, fails connections over when a partner is unresponsive, and recalculates after topology changes.

The KCC declares a partner unavailable only after two thresholds are crossed, which is why failover isn't instantaneous:

| Setting | Default | Applies to |
| --- | --- | --- |
| `IntersiteFailuresAllowed` | 1 attempt | Inter-site connections |
| `MaxFailureTimeForIntersiteLink` | 7,200 sec (2 hours) | Inter-site connections |
| `CriticalLinkFailuresAllowed` | 0 attempts | Intra-site immediate neighbors |
| `MaxFailureTimeForCriticalLink` | 7,200 sec (2 hours) | Intra-site immediate neighbors |

### Inter-Site Topology Generator (ISTG)

Each site that contains at least one DC elects a single **ISTG**: the DC responsible for calculating the inter-site connection objects that land on the site's bridgehead servers. The ISTG identity is stored in the `interSiteTopologyGenerator` attribute of the site's NTDS Site Settings object.

> [!TIP]
> The `interSiteTopologyGenerator` value isn't cleared when the last DC leaves a site, so an empty site can still display a stale ISTG—sometimes as a `DEL:<GUID>` value. That's expected and harmless; the value is ignored once no DC remains in the site.

### Bridgehead servers and connection objects

A **bridgehead server** is the DC that actually sends or receives a naming context across a site boundary. Any DC with a connection object whose "from" server is in another site is acting as a destination bridgehead; the partner it pulls from is the source bridgehead. The ISTG selects bridgeheads automatically, balancing partitions across eligible DCs.

A **connection object** is a one-way, inbound replication agreement stored under a DC's NTDS Settings. KCC-generated connections are owned by the KCC and will be repaired or removed as topology changes. You *can* create manual connection objects, but the KCC won't manage them—so they become stale when DCs are added, removed, or fail.

> [!WARNING]
> Be cautious with **preferred bridgehead servers**. If you designate preferred bridgeheads for a domain and *all* of them become unavailable in a site, the ISTG will **not** select a replacement, and replication of that domain to and from the site stops. If you designate none, the ISTG chooses automatically and recovers on its own. Designate preferred bridgeheads only when you have a hard requirement (such as firewall constraints) and always designate more than one.

## Intra-site versus inter-site replication

The two scopes behave differently by design.

**Intra-site** replication is optimized for speed and freshness:

- The KCC arranges DCs in a bidirectional **ring** and adds optimizing chords so that no DC is more than **three hops** from any other (the "three-hop rule").
- Replication is triggered by **change notification**, not a schedule. After a change, the source DC waits a short *initial notification delay* (15 seconds by default on modern DCs) before notifying its first partner, then a shorter *subsequent delay* (3 seconds) for each additional partner.
- Traffic is **not compressed**, trading bandwidth for lower CPU and latency on a fast LAN.

**Inter-site** replication is optimized for WAN efficiency:

- It follows the site link **schedule and interval** rather than immediate notification.
- Traffic is **compressed** to reduce bytes on the wire (at a CPU cost on the bridgeheads).
- You can enable **inter-site change notification** on a site link to get near-intra-site latency over a fast WAN by setting the link's `options` attribute to include the change-notification bit (value `1`). Use it only on links with ample bandwidth.

```powershell
# Enable inter-site change notification on a fast WAN link (options bit 1 = USE_NOTIFY)
Set-ADReplicationSiteLink -Identity "NY-CHI" -Replace @{ options = 1 }

# Inspect connection objects, bridgeheads, and the ISTG from any DC
repadmin /showconn
repadmin /bridgeheads /verbose
repadmin /istg
```

## Bringing the design together

A healthy design follows a few durable principles: map every routed subnet to a site; keep two sites per link; set costs so the least-cost path matches the physical network; choose intervals (and notification) to meet convergence targets without overloading bridgeheads; and let the KCC and ISTG own the connection objects unless you have a specific, documented reason to intervene. With that foundation in place, the next unit examines the design mistakes that violate these principles—and how they surface as DC Locator and replication failures on Windows Server 2025.
