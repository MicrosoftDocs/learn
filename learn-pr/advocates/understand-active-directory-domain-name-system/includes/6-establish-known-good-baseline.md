A baseline states what should answer, from where, with which data, under normal or failed conditions. Without a baseline, an administrator can mistake any successful response for a correct response.

## Validate client configuration

Domain members and domain controllers should use reachable internal Domain Name System servers that are authoritative for, or can resolve, the Active Directory Domain Services namespace.

For Contoso:

- The `BNE-APP7` computer uses `10.20.0.10` then `10.40.0.10`.
- Both servers can resolve `corp.contoso.com` plus `_msdcs.contoso.com`.
- Internal servers resolve external names through forwarding or root hints.
- No domain member uses an internet service provider or public resolver directly.

Windows DNS clients don't query each configured server for every name. They switch when a server fails to respond. An authoritative but incorrect response doesn't cause automatic use of the alternate server. Therefore, two listed servers improve response availability only when both contain or can reach correct directory data.

Verify connection-specific suffixes and **Register this connection's addresses in DNS** settings. A suffix or registration mismatch can place data under an unintended name.

## Configure domain controllers deliberately

During promotion, an additional domain controller should be configured initially to use an existing authoritative Domain Name System server until inbound replication, outbound replication, zone availability, and record registration are verified. 

After you have validated convergence, you can configure a domain controller to prefer itself or another internal server for DNS:

| Preference | Benefit | Risk |
| --- | --- | --- |
| Self | Local query path; reduced network dependency | Stale local zone during prolonged replication failure; startup dependency |
| Remote internal server | Earlier visibility of records written elsewhere; central troubleshooting point | Network path dependency; remote-server dependency |

Neither pattern replaces replication monitoring or resilient alternate configuration.

A multihomed domain controller should register only addresses reachable by its intended clients. An unreachable management, backup, perimeter, or isolated-network address can produce intermittent failures when clients select it.

## Validate zones plus delegations

When troubleshooting you should confirm:

- The `corp.contoso.com` and `_msdcs.contoso.com` zones have intended authority.
- `SOA` and `NS` describe intended authority and delegation. Confirm the actual query destination or responder and inspect the requested data directly; authority records alone don't establish response provenance or data currency.
- Replication scope matches required server availability.
- Directory-integrated zones use **Secure only** updates.
- Record ownership plus permissions support the chosen registration model.
- Child domains have correct delegations.
- Existing or trusted namespaces have an explicit authoritative, delegation, stub, or conditional-forwarding path.
- Aging plus scavenging settings are consistent and monitored.

## Validate site behavior

Map every routed client subnet to the intended directory site. Confirm site-specific locator records. Review automatic site coverage for sites without local domain controllers. A closest-site result should reflect topology intent, not merely low network latency.

## Separate resolution from reachability

Required Domain Name System, Kerberos, Lightweight Directory Access Protocol, Server Message Block, Remote Procedure Call, global catalog, and replication traffic must be able to traverse host firewalls plus network controls.

In our scenario, we can test reachability from `BNE-APP7` using the commands:

```powershell
Resolve-DnsName bne-dc1.corp.contoso.com -Server 10.20.0.10
Test-NetConnection bne-dc1.corp.contoso.com -Port 389
```

The first command tests a name path. The second tests Transmission Control Protocol reachability for Lightweight Directory Access Protocol. Domain controller locator also uses a User Datagram Protocol locator ping, so combine evidence rather than treating one connection test as complete proof.

## Test resilience

Contoso's baseline requires directory discovery after either a server or a site link fails. As a part of a diagnosis of a server or site link failure, test:

- Direct service queries against each authoritative server.
- Expected site-specific selection during normal operation.
- Acceptable automatic coverage or remote selection during a site outage.
- Selected record answers on each relevant replica after an update and the expected replication interval. Matching answers are scoped evidence, not proof of partition-wide convergence.
- Original directory operations after a resolver or link failure.
