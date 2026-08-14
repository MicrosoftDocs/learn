A directory-integrated zone stores Domain Name System data in Active Directory Domain Services. Directory replication replaces a separate primary-to-secondary zone transfer topology for that zone.

## Compare storage models

DNS can use the following storage models:

| Model | Write path | Distribution path | Operational consequence |
| --- | --- | --- | --- |
| File-backed primary plus secondary | Updates reach the primary server. | Zone transfer copies data to secondary servers. | Primary availability controls ordinary writes. |
| Directory-integrated | Any suitable writable Domain Name System server hosting the partition can accept an authorized update. | Active Directory replication distributes the change. | Multiple write points improve availability, but convergence depends on directory replication. |

Directory integration doesn't make every domain controller authoritative for a DNS zone. The server must run the Domain Name System Server service and hold a replica of the application directory partition that stores the zone.

Standard directory partitions include:

- The `ForestDnsZones` partition replicates to Domain Name System-enabled domain controllers in the forest replication scope.
- The `DomainDnsZones` partition replicates to Domain Name System-enabled domain controllers in a domain replication scope.

A custom application directory partition can target another server set, but it adds design and operational complexity. Use it only when the required replication boundary is explicit.

Contoso stores `_msdcs.contoso.com` in a forest-wide scope. It stores `corp.contoso.com` in the `corp.contoso.com` domain scope. In our example, `BNE-DC1` and `PER-DC1` can both accept authorized changes. Active Directory replication distributes each change to replicas in scope, subject to replication health and latency.

## Trace a secure update

The secure update sequence functions as follows:

1. `BNE-APP7` identifies an authoritative, writable Domain Name System server and can first send an unsigned dynamic-update attempt. A server requiring secure update can refuse the unsigned attempt.
1. `TKEY` token exchange establishes a Kerberos-authenticated security context. The client retries with a `TSIG`-authenticated update.
1. The server evaluates update policy, prerequisites, the authenticated identity, ownership, and access control lists (ACLs).
1. If accepted, the server persists the change in the zone's application directory partition. Active Directory replication then distributes it to replicas in scope; each replica can answer with the new data after it receives the change.

:::image type="content" source="../media/secure-update-replication.svg" alt-text="Diagram that shows secure DNS update authorization and Active Directory replication from BNE-DC1 to PER-DC1.":::

You should prefer **Secure only** updates for directory-integrated zones. Enabling nonsecure updates to make registration succeed removes identity-based authorization and allows unauthenticated overwrite attempts.

## Distinguish registration roles

The DNS Client service registers host `A` and, when applicable, `PTR` records. Netlogon registers domain controller locator records. Registration failure can therefore affect host records, locator records, or both.

Before forcing registration:

1. Identify the intended registrar: DNS Client service, Netlogon, Dynamic Host Configuration Protocol server, or another managed identity.
1. Identify an authoritative server that's writable for the relevant zone and partition.
1. Confirm the intended update mode, normally **Secure only** for a directory-integrated zone.
1. Confirm Domain Name System and network connectivity to that writable authority.
1. Compare the existing name or record owner and ACL with the intended registrar.
1. Test with the intended identity or a suitably scoped diagnostic.
1. Re-register only after establishing that registration is missing or stale and correcting the authorization or path fault.

On a DHCP-managed Windows client when the intended design is DHCP-managed registration, `ipconfig /registerdns` initiates direct host registration through the DNS Client service. 

For domain controller locator records, use `nltest /dsregdns` when a locator-only refresh is justified. Neither action corrects an unreachable authoritative server, denied permission, incorrect zone update mode, or failed directory replication. After a registration command succeeds, query explicitly for the expected record, then retest the dependent Active Directory Domain Services operation.

## Evaluate ownership

Suppose the Dynamic Host Configuration Protocol server registers `BNE-APP7.corp.contoso.com`. The resulting record can be owned by the service account used for registration. Later, the member attempts to update the same name after an address change. Secure update can reject the request because the computer account doesn't own the record and lacks write permission.

Before deleting the record, diagnose the ownership path:

- Identify which identity created the record.
- Inspect the record permissions.
- Confirm the intended registration model.
- Correct credentials, ownership, or access control at the owning layer.
- Reattempt registration.

Indiscriminate deletion can create a temporary success while preserving the design fault and you'll have to go through the process again in future.

## Relate timestamps to stale data

Dynamically registered records can carry timestamps used by aging and scavenging. A timestamp doesn't prove current reachability. A zero timestamp commonly identifies a static record. Scavenging can remove stale dynamic records after configured intervals, but it isn't a first-response repair action. Check zone aging settings and scavenging settings to ensure they don't remove valid locator data.

## Understand interdependence

Directory-integrated Domain Name System depends on Active Directory replication for convergence. Active Directory replication depends on Domain Name System to locate partners. This creates a diagnostic loop:

- A registration succeeds on `BNE-DC1`.
- Replication to `PER-DC1` fails.
- Clients querying `PER-DC1` receive stale data.
- A destination domain controller can't resolve a source alias.
- Replication continues to fail.

Break the loop by identifying the first failed dependency. Compare direct authoritative answers, verify the expected alias plus host record, test reachability, then inspect replication state.
