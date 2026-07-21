Domain controller placement must satisfy authentication, DNS, LDAP, Group Policy, replication, maintenance, and recovery requirements. Server count alone doesn't provide resilience if all domain controllers share a host, storage system, rack, network path, cloud zone, or management plane.

## Establish domain-level resilience

Deploy at least two writable domain controllers for the domain. Place them in independent failure domains. Add local domain controllers where WAN dependency, application latency, or outage requirements justify them.

For each site, decide:

- Whether it needs local authentication and DNS during WAN failure
- Whether cached sign-in is sufficient
- Which applications require live LDAP or Kerberos
- Expected peak authentication and directory query load
- Whether maintenance can occur without losing local service
- Which remote site provides coverage

A small site with reliable low-latency connectivity might not need a domain controller. A site hosting identity-dependent production services usually should have a domain controller.

## Make every domain controller a DNS server and global catalog

In a single-domain forest, configure every domain controller as:

- A DNS server for the AD-integrated zones
- A global catalog server

Every domain controller already stores the full domain partition. Global catalog placement adds no partial replicas from other domains because no other domains exist. Enabling the global catalog consistently also supports applications that query port 3268.

For details, see [Planning global catalog server placement](/windows-server/identity/ad-ds/plan/planning-global-catalog-server-placement).

## Place FSMO roles intentionally

A single-domain forest has five Flexible Single Master Operations (FSMO) roles:

| Role | Scope | Key dependency |
| --- | --- | --- |
| Schema master | Forest | Schema updates |
| Domain naming master | Forest | Domains and application partitions |
| PDC emulator | Domain | Time, password-change priority, Group Policy, authentication compatibility |
| RID master | Domain | RID pool allocation |
| Infrastructure master | Domain | Cross-domain reference updates |

Colocating roles on a well-connected domain controller is valid. Spreading roles across servers doesn't by itself improve availability. Place roles where administrators can monitor, back up, and transfer them predictably.

In a single-domain forest, the infrastructure master can run on a global catalog because there aren't any cross-domain phantom references to update.

The PDC emulator needs the strongest availability. Configure the forest-root PDC emulator to use approved external time sources. Other domain members follow the domain hierarchy.

## Separate failure domains

For virtual domain controllers:

- Use VM-Generation ID-aware hypervisors
- Avoid memory and storage overcommit that causes paging or latency
- Place replicas on different hosts and storage paths
- Keep at least one authentication path available during cluster maintenance
- Don't use snapshots as an AD DS backup strategy

For cloud-hosted domain controllers, distribute replicas across availability zones or equivalent failure domains when the platform and requirements support it.

## Inventory the planned placement

```powershell
Get-ADDomainController -Filter * |
    Select-Object HostName, Site, OperatingSystem, IsGlobalCatalog, IPv4Address

Get-ADForest |
    Select-Object SchemaMaster, DomainNamingMaster

Get-ADDomain |
    Select-Object PDCEmulator, RIDMaster, InfrastructureMaster
```

The design should also record the preferred and alternate DNS server for each domain controller, site coverage, hypervisor placement, backup ownership, and FSMO transfer target.

For placement considerations, see [Planning domain controller placement](/windows-server/identity/ad-ds/plan/planning-domain-controller-placement) and [FSMO placement and optimization](/troubleshoot/windows-server/active-directory/fsmo-placement-and-optimization-on-ad-dcs).
