An AD DS site represents one or more IP networks with reliable, high-speed connectivity. Sites control client service location and intersite replication. They don't create authentication, administration, or security boundaries.

## Derive sites from network behavior

Create separate sites when networks need different:

- Domain controller affinity
- Replication cost or schedule
- WAN-failure behavior
- Application service location
- Operational ownership or maintenance sequencing

Don't create a site for every building or VLAN when those networks share the same domain controllers and replication behavior. One site can contain many subnet objects.

Use stable site names that describe locations or network regions. Avoid names tied to a temporary carrier, office lease, or project.

## Map every client network

Subnet objects map an IPv4 or IPv6 prefix to one site. A client determines its site from the most specific matching subnet. If no subnet matches, the client can locate a nonlocal domain controller and generate avoidable WAN traffic.

Include:

- Datacenter and campus address ranges
- Branch networks
- Azure virtual networks and other cloud networks
- VPN client address pools
- IPv6 prefixes
- Disaster-recovery networks

Coordinate subnet lifecycle with the network team. New address space shouldn't enter production before its site mapping exists.

The following example creates a site and maps two prefixes:

```powershell
New-ADReplicationSite -Name "Sydney-Hub"

New-ADReplicationSubnet `
    -Name "10.40.0.0/16" `
    -Site "Sydney-Hub"

New-ADReplicationSubnet `
    -Name "2001:db8:40::/48" `
    -Site "Sydney-Hub"
```

Treat creation commands as implementation steps after design approval. The design should first identify address ownership, overlap, routing, and failure behavior.

## Account for service-location behavior

DC Locator uses DNS SRV records and site information to find a domain controller. The client:

1. Resolves domain controller locator records.
1. Determines its site from its IP address.
1. Prefers a domain controller registered for that site.
1. Uses site coverage or another site when no local domain controller is available.

Use `nltest` to confirm the result:

```powershell
nltest /dsgetsite
nltest /dsgetdc:corp.contoso.com /force
```

Monitor Netlogon Event ID 5807 for clients that don't map to a configured subnet. A small number can indicate transient VPN or lab addresses. A sustained number indicates a topology defect.

## Define site coverage

Not every site requires a domain controller. For sites without one, document:

- The covering site
- WAN availability and latency
- Authentication and DNS behavior during WAN failure
- Whether cached sign-in is acceptable
- Which applications require live LDAP, Kerberos, or global catalog access

The site design is complete only when every production network has an intentional local or covering domain controller path.

For site concepts, see [Active Directory replication concepts](/windows-server/identity/ad-ds/get-started/replication/active-directory-replication-concepts).
