A single-domain forest is the default AD DS design for most organizations. It minimizes service-administrator groups, trust paths, duplicated Group Policy, cross-domain object moves, and global catalog dependencies. Simplicity isn't the same as a small design. A single domain can span many sites, network failure domains, datacenters, and cloud networks. This module focuses on topology and service design for a single-domain Active Directory forest.

## Scenario

Contoso owns the public DNS name `contoso.com`. It needs a new AD DS forest for 18,000 users across Sydney, Singapore, Seattle, and two Azure virtual networks. The locations use routed private networks with different latency and outage characteristics. The design must:

- Use one forest and one domain unless evidence justifies more complexity
- Support the user-facing UPN suffix `contoso.com`
- Keep AD DS name resolution independent from public DNS availability
- Route clients to local or intentionally selected domain controllers
- Converge directory changes within documented time limits
- Continue authentication and DNS service during server or network failure

The deliverable is a design record, not a list of wizard selections. Every decision needs a requirement, a failure assumption, and a validation method.

## Learning objectives

After completing this module, you'll be able to:

- Select a durable single-domain forest and namespace
- Design AD-integrated DNS and resolver behavior
- Map networks to AD DS sites and subnets
- Design intersite replication
- Place domain controllers, global catalogs, FSMO roles, DNS, and time services
- Validate service location, convergence, and failure behavior

> [!IMPORTANT]
> A forest is an AD DS security boundary. A domain inside that forest isn't a boundary from forest-level administrators. If a requirement demands isolation from forest administrators, use a separate forest rather than another domain.
