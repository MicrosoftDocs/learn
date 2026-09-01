Every domain and forest boundary you add in this module's scope needs an explicit trust and DNS design. Trusts determine whether and how authentication can cross a boundary; DNS determines whether a client can even locate the resources on the other side.

## Trust types, direction, and transitivity

Use account-side and resource-side language for every directional trust:

- The **trusted account domain or forest** contains the users or services whose identities are accepted across the trust.
- The **trusting resource domain or forest** contains the resources that accept those identities and enforce authorization.

For example, if users in `accounts.fabrikam.com` need access to servers in `apps.contoso.com`, `accounts.fabrikam.com` is the trusted account side and `apps.contoso.com` is the trusting resource side. The one-way trust is created so that `apps.contoso.com` trusts `accounts.fabrikam.com`. A trust permits authentication; resource ACLs and, when enabled, selective authentication still determine access.

| Trust type | Transitivity | Typical use |
| --- | --- | --- |
| Parent-child | Transitive, two-way | Created automatically between a domain and its child domain in the same tree. |
| Tree-root | Transitive, two-way | Created automatically between the forest root and the root of a new tree in the same forest. |
| Forest trust | Transitive within each forest, two-way or one-way | Connects two forests; every domain in each forest can authenticate across the trust unless narrowed. |
| External trust | Nontransitive, one-way or two-way | Connects a specific domain to another specific domain, typically to a legacy NT4 domain or a single domain in an untrusted forest. |
| Shortcut trust | Transitive, one-way or two-way | Explicit trust between two domains in the same forest to shorten the authentication path across tree or domain boundaries. |
| Realm trust | Transitive or nontransitive, one-way or two-way | Connects an AD DS domain to a non-Windows Kerberos realm. |

Choose the minimum direction required. For every one-way trust, record the trusted account side, trusting resource side, where the users and resources reside, the intended authentication flow, and the direction shown by Active Directory Domains and Trusts, `Get-ADTrust`, and `netdom trust`. Use a two-way trust only when each side must accept identities from the other. Every additional direction increases attack surface, and a transitive forest trust can make identities from multiple domains routable unless name-suffix routing, selective authentication, SID filtering, and resource authorization narrow the result.

## Selective authentication

By default, a forest or external trust grants members of the trusted side the ability to authenticate to any resource in the trusting side that their permissions allow. **Selective authentication** narrows this: users from the trusted side can only authenticate to computers that have been explicitly granted the "Allowed to authenticate" permission. Use selective authentication whenever a trust crosses an organizational boundary where you can't fully vouch for account and workstation hygiene on the other side - this includes most merger, resource-forest, and third-party trust scenarios.

```powershell
# Read-only inventory. Run with the ActiveDirectory module in each forest.
Get-ADTrust -Filter * -Properties * |
    Select-Object Name, Source, Target, Direction, TrustType,
        SelectiveAuthentication, ForestTransitive,
        SIDFilteringQuarantined, SIDFilteringForestAware
```

## SID filtering and SIDHistory governance

SID filtering (also called quarantining) removes SIDs that aren't valid for the trusted namespace from authorization data as it crosses the trust. It's enabled by default on external and forest trusts. Preserve it. If a migration uses `SIDHistory`, enable only the specific trust behavior required by the migration tooling, time-box the exception, and restore the normal filtering posture after access has been translated.

`SIDHistory` itself is a legitimate mechanism used during domain and forest migrations to preserve access during a transition, but it's a liability if left in place indefinitely: it silently grants access based on a source-domain group membership that a reviewer looking only at the destination domain won't see. Govern it explicitly:

- Set an expiration date for any migration project that populates `SIDHistory`.
- Audit `SIDHistory` regularly and remove entries once the source domain or group has been decommissioned or the transition period has ended.
- Don't broadly disable SID filtering. Use migration-specific SIDHistory controls and remove the exception after resource access has been translated.

```powershell
Get-ADUser -LDAPFilter "(sIDHistory=*)" -Properties SIDHistory |
    Select-Object SamAccountName, @{N='SIDHistoryCount';E={$_.SIDHistory.Count}}
```

## Shortcut trusts and name-suffix routing

In a large multi-domain forest, authentication between two distant domains can traverse intermediate domains in the trust path. A shortcut trust creates a direct path and can reduce authentication latency. Add one only after trust enumeration, specific trust verification, and representative authentication measurements show a persistent path problem. Enumeration and verification are separate checks:

```cmd
:: Run from an elevated command prompt with AD DS or RSAT tools installed.
:: Enumerate trusts visible from the current computer's domain.
nltest /domain_trusts /all_trusts /v

:: Verify one specific trust. The first name is the trusting resource domain;
:: /domain names the trusted account domain.
netdom trust apps.contoso.com /domain:accounts.fabrikam.com /verify
```

The `netdom trust` verification uses the current credentials. If the current account doesn't have sufficient rights on both sides, use `/usero`, `/passwordo:*`, `/userd`, and `/passwordd:*` so passwords are prompted for rather than placed on the command line. Don't create a shortcut trust until the existing path, DNS, firewall, and domain-controller health have been validated.

**Name-suffix routing** controls which UPN suffixes and SPN routes are honored across a forest trust, which matters when two forests share overlapping or ambiguous namespaces (for example, both forests independently register users with the same UPN suffix). Use name-suffix routing to explicitly include the suffixes that should route across the trust and exclude any that'd create an ambiguous route or an unintended authentication path.

## Cross-forest and split-brain DNS

A trust doesn't resolve names by itself - clients still need DNS to locate domain controllers and resources across the boundary. Design DNS resolution alongside the trust:

| Mechanism | Authority and stored data | Resolution and update behavior | Use and security boundary |
| --- | --- | --- | --- |
| Delegation | The parent zone stores NS records and required glue records that identify servers authoritative for the delegated child. The parent doesn't store a copy of the child zone. | Resolvers follow the DNS hierarchy to the child zone's authoritative servers. Changes to the child zone remain owned by the child-zone administrators. | Use for a true child namespace such as `emea.corp.contoso.com`. Keep NS and glue records current and provide redundant authoritative servers. |
| Conditional forwarder | The DNS server stores a namespace-to-forwarder mapping, not an authoritative copy of the target zone. | Matching queries are sent to the configured target DNS servers. If stored in AD DS, the forwarder configuration can replicate within its selected scope. | Use for cross-forest or partner namespaces when the forwarding endpoints and ownership are known. Restrict traffic to approved DNS servers and monitor forwarding failure. |
| Stub zone | The DNS server stores the target zone's SOA, NS, and required glue records rather than its complete host data. | The stub refreshes its authoritative-server information from a primary server and uses that information to locate the current authoritative servers. | Use when authoritative-server discovery must follow NS changes. Authorize and monitor the limited zone-transfer traffic required to refresh the stub. |
| Secondary zone | The DNS server hosts an authoritative, read-only copy of the full zone obtained through zone transfer. It isn't a forwarding mechanism. | The secondary refreshes from an approved primary or other authoritative server according to SOA and transfer settings and can answer authoritatively from its local copy. | Use only when an authoritative replica and zone-transfer operating model are required. Restrict zone transfers to named servers, protect the transferred data, and define stale-zone and transfer-failure handling. |

- **Split-brain (split-horizon) DNS** - where an internal AD-integrated zone and an externally published zone share the same domain name but return different records - needs explicit governance so that internal clients never accidentally receive external, differently scoped answers, and vice versa. Document which records exist only internally (such as domain controller SRV records) and confirm they're never replicated to the external-facing zone.
- **Hybrid namespace integration**—Microsoft Entra ID and Microsoft 365 commonly require users to have a routable UPN suffix that the organization owns and can verify publicly. This doesn't normally require renaming an existing internal or nonroutable AD DS DNS domain. Add an approved alternative UPN suffix to the forest and update a controlled pilot set of users after validating synchronization, federation, certificate, application, and sign-in dependencies. Treat an AD DS domain rename as a separate, high-impact project, not as the default fix for a nonroutable user sign-in suffix.

Record which servers are authoritative for each zone and confirm the selected mechanism:

```powershell
Get-DnsServerZone |
    Select-Object ZoneName, ZoneType, IsDsIntegrated, IsReverseLookupZone

Get-DnsServerForwarder

Resolve-DnsName "corp.contoso.com" -Type SOA
Resolve-DnsName "corp.contoso.com" -Type NS
```

```powershell
# Inventory only. Run with the ActiveDirectory module.
Get-ADForest | Select-Object Name, UPNSuffixes

Get-ADUser -Filter * -Properties UserPrincipalName |
    Group-Object { ($_.UserPrincipalName -split "@")[-1] } |
    Select-Object Name, Count

# Approved change example. Replace the forest and suffix with verified values.
# Run with Enterprise Admin-equivalent or explicitly delegated forest rights.
Set-ADForest -Identity "corp.contoso.local" `
    -UPNSuffixes @{ Add = "contoso.com" }

# Pilot one approved user; don't bulk-change users until sign-in and sync tests pass.
Set-ADUser -Identity "jsmith" `
    -UserPrincipalName "jsmith@contoso.com"
```

Validate the custom domain in Microsoft Entra ID before changing production users. Test sign-in, directory synchronization, federation if used, certificate mappings, scripts, applications, and service integrations that consume UPNs. Keep a user-to-old-UPN mapping and rollback procedure for the pilot.

## Firewall and network paths

A DNS configuration and trust object aren't sufficient unless the required clients, domain controllers, global catalogs, DNS servers, and administration hosts can communicate. Build a per-direction, per-site matrix for the actual authentication and management scenarios. Don't use a generic "allow Active Directory" rule or expose these ports to untrusted networks.

| Service | Default port or range | Include when |
| --- | --- | --- |
| DNS | TCP and UDP 53 | Clients, domain controllers, and DNS servers must resolve the other namespace and AD DS locator records. TCP is also required for responses that don't fit in UDP and for approved zone transfers. |
| Kerberos | TCP and UDP 88 | Kerberos authentication or referrals cross the path. |
| LDAP | TCP and UDP 389 | LDAP, DC Locator LDAP ping, or directory referrals cross the path. |
| LDAPS | TCP 636 | An application explicitly uses LDAP over TLS. Opening 636 doesn't replace certificate and name validation. |
| Global catalog | TCP 3268; TCP 3269 for TLS | Forest-wide search, UPN resolution, universal-group processing, or an application queries a global catalog across the path. |
| RPC endpoint mapper | TCP 135 | AD DS operations negotiate RPC endpoints. |
| Dynamic RPC | TCP 49152-65535 by default on current Windows Server versions, or the approved constrained range | Trust, replication, administration, or other RPC-based AD DS operations require dynamically assigned endpoints. Document any constrained range on both the host and firewall. |
| Active Directory Web Services | TCP 9389 | A remote administration host uses ActiveDirectory PowerShell cmdlets or another ADWS client across the path. This isn't required for ordinary domain logon or trust traffic. |
| SMB | TCP 445 | SYSVOL, Group Policy, Netlogon, or administrative operations require SMB. |
| Kerberos password change | TCP and UDP 464 | Password-change scenarios cross the boundary. |
| Time | UDP 123 | The design requires Windows Time synchronization across the path. Kerberos still requires clocks within the allowed skew. |

The matrix must name source subnets or hosts, destination DNS servers and domain controllers, direction, protocol, port, business scenario, owner, monitoring rule, expiry date for temporary access, and the approved dynamic RPC range. Restrict rules to known endpoints and paths; don't open the complete range between all forest hosts without a documented requirement.

Use representative tests from each source site. `Test-NetConnection` validates TCP only; use DNS and application-level tests for UDP and end-to-end behavior:

```powershell
$targetDc = "dc01.accounts.fabrikam.com"

Resolve-DnsName "_kerberos._tcp.dc._msdcs.accounts.fabrikam.com" -Type SRV
Test-NetConnection -ComputerName $targetDc -Port 88
Test-NetConnection -ComputerName $targetDc -Port 389
Test-NetConnection -ComputerName $targetDc -Port 445
Test-NetConnection -ComputerName $targetDc -Port 3268
Test-NetConnection -ComputerName $targetDc -Port 135

# Scenario-dependent: validate only when remote ActiveDirectory PowerShell
# cmdlets or another ADWS client must traverse this path.
Test-NetConnection -ComputerName $targetDc -Port 9389
```

After firewall changes, repeat trust verification and a controlled user-to-resource authentication. Monitor denied connections and AD DS, Kerberos, Netlogon, DNS, and RPC errors. A successful TCP probe doesn't prove that the complete RPC negotiation or authentication flow succeeds.

## Record the design

For every trust in scope, record the trusted account side, trusting resource side, trust type, direction, transitivity, selective-authentication state, `SIDFilteringQuarantined`, `SIDFilteringForestAware`, name-suffix routing, and the DNS and firewall paths that make the trust usable. Correlate SID-filtering values with the trust type and the approved migration design. For any temporary SIDHistory-related exception, record the exact setting changed, owner, approval, start and expiry dates, affected identities and resources, compensating monitoring, rollback command or procedure, and post-rollback verification. Re-run the trust inventory after each change and at the expiry date.

Attach the approved firewall matrix and validation evidence for every source site, destination forest, and authentication or administration scenario. For deeper trust security guidance, see [Forest Design Models](/windows-server/identity/ad-ds/plan/forest-design-models) and [Securing Domain Controllers Against Attack](/windows-server/identity/ad-ds/plan/security-best-practices/securing-domain-controllers-against-attack).
