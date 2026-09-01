Once you've decided that a domain or forest requires structural expansion, the next decisions are where the forest root sits, how domain trees are arranged, how directory and application partitions replicate, and how the global catalog scope changes as domains are added.

## Forest root domain

The first domain created in a forest becomes the forest root domain. The forest root has a durable identity and contains the forest-wide Enterprise Admins and Schema Admins groups. The first domain controller in a new forest receives the Schema Master and Domain Naming Master roles by default, so those forest-wide roles are commonly placed in the forest root domain initially; they aren't technically confined to that domain. During planned maintenance, transfer either role to another healthy, eligible writable domain controller anywhere in the forest. An RODC can't hold an operations-master role. Seize a role only during recovery when the previous role holder won't return to service. The forest-root decision still deserves explicit design attention because changing the forest root requires forest migration or recovery, even though FSMO role holders can be transferred.

```powershell
# Read-only inventory. Run with an account that can query the forest.
Get-ADForest |
    Select-Object RootDomain, SchemaMaster, DomainNamingMaster

# Planned transfer example. Run only through approved change control with
# sufficient rights on a healthy eligible writable DC in the forest.
Move-ADDirectoryServerOperationMasterRole `
    -Identity "FORESTDC02" `
    -OperationMasterRole SchemaMaster, DomainNamingMaster
```

> [!WARNING]
> Don't use `-Force` for routine maintenance. `-Force` signals seizure: it still attempts a graceful transfer first and seizes the role only if the transfer can't complete. Reserve it for recovery when the former role holder can't be returned to service safely.

Two common patterns:

- **Regional or organizational domain doubles as forest root.** Simpler to operate, but ties forest-wide administrative rights to a domain that also hosts production user and computer accounts.
- **Dedicated, empty forest root domain.** Hosts no end-user accounts or resources - only the forest-wide administrative groups and a small number of domain controllers. This isolates Enterprise Admins/Schema Admins membership from day-to-day domain administration in any child domain, at the cost of extra domain controllers to operate.

A dedicated empty root is a governance pattern, not a security boundary. Compromise of any domain in the forest can threaten the forest. Don't add an empty root by default. Use it only when a documented administrative model justifies the additional domain controllers, DNS, patching, backup, and recovery work.

## Domain trees and namespace

A domain tree is a set of domains that share a contiguous DNS namespace and an implicit two-way transitive trust with their parent domain. Domains in different trees within the same forest don't share a contiguous namespace, but they still share the schema, configuration partition, global catalog, and an implicit trust path through the forest root.

Use a new tree, rather than a child domain, when the organization owns a second DNS namespace that must coexist in the same forest - for example, after a merger where both `contoso.com` and `fabrikam.com` need to remain in production use under one forest. Use a child domain in the existing tree when the new domain is a natural subdivision of the existing namespace, such as `emea.corp.contoso.com` under `corp.contoso.com`.

Namespace coexistence considerations:

- Confirm that both namespaces are registered and don't conflict with any other organization's namespace if either will ever be exposed externally.
- Decide whether a single UPN suffix will be added for user logon consistency, independent of which domain or tree hosts the account.
- Plan DNS delegation and conditional forwarding between the namespaces, covered in the trusts and name-resolution unit.

## Directory partitions

Every domain controller stores the mandatory schema and configuration naming contexts and a full replica of its own domain naming context. A domain controller stores an application directory partition only when it has been enlisted as a replica for that optional partition.

| Partition | Replicates to | Contents and design consequence |
| --- | --- | --- |
| Schema | Every domain controller in the forest | Class and attribute definitions. Forest-wide; a single transferable Schema Master role exists per forest. |
| Configuration | Every domain controller in the forest | Sites, services, partition metadata, and forest-wide configuration data. |
| Domain | Every domain controller in that domain only | Domain-scoped users, computers, groups, OUs, and other objects. |
| Application | Only the domain controllers explicitly enlisted as replicas for that application partition | Optional application-specific data, such as AD-integrated DNS application partitions. Don't assume the partition is present on every domain controller or included in every domain controller backup. |

Because a domain naming context doesn't replicate as a full writable replica outside its own domain, adding a domain doesn't add full domain-object replication to unrelated domain controllers. It does add forest-wide schema and configuration activity, and every global catalog in the forest must hold a partial, read-only replica of the new domain naming context. Forest domains can't be selectively excluded from individual global catalogs. Capacity impact therefore depends on object counts, the partial attribute set, change rate, topology, and the number of global catalog servers—not on an optional per-domain inclusion setting.

## Application partitions and DNS

DNS-integrated zones are commonly stored in application partitions rather than the domain partition, which lets you control replication scope independent of domain boundaries:

- `ForestDNSZones` replicates to every domain controller running DNS in the forest that hosts the partition.
- `DomainDNSZones` replicates only within a single domain.

When you add a domain, confirm whether new DNS zones should replicate forest-wide (typical for a shared internal root or shared conditional-forwarder configuration) or stay domain-scoped. Use PowerShell to confirm current partition replication scope before making a change:

```powershell
Get-ADRootDSE | Select-Object namingContexts

$partitions = "CN=Partitions,$((Get-ADRootDSE).configurationNamingContext)"

Get-ADObject -SearchBase $partitions `
    -LDAPFilter "(objectClass=crossRef)" `
    -Properties nCName, msDS-NC-Replica-Locations |
    Select-Object Name, nCName, msDS-NC-Replica-Locations
```

For each application partition, record its distinguished name, owning application, writable and read-only replica locations, DNS dependencies, capacity impact, backup coverage, restore source, and the procedure for adding or removing a replica. Validate the recorded list against `msDS-NC-Replica-Locations`; a forest or domain inventory alone doesn't prove that a particular domain controller hosts the partition.

## Global catalog scope

Adding a domain changes what the global catalog has to represent. The global catalog holds a full replica of its own domain and a partial, read-only attribute set for every other domain in the forest. As domains are added, every global catalog server absorbs incremental replication for the new domain's partial attribute set. This is usually modest per domain, but it compounds in forests with many domains and many global catalog servers, and it directly affects the replication and capacity analysis later in this module.

Record, for each new domain: which existing sites will need a local global catalog server to avoid cross-site global catalog dependency for logon and Exchange-style address list lookups, and whether any attribute needs to be added to the partial attribute set for an application that queries the global catalog for cross-domain lookups. For background on structural decisions, see [Forest Design Models](/windows-server/identity/ad-ds/plan/forest-design-models) and [Identifying Forest Design Requirements](/windows-server/identity/ad-ds/plan/identifying-forest-design-requirements).

After adding a domain, validate replication and global-catalog advertising on representative global catalog servers in every site:

```powershell
Get-ADDomainController -Filter 'IsGlobalCatalog -eq $true' |
    Select-Object HostName, Site, Domain, IsGlobalCatalog

repadmin /showrepl *
```
