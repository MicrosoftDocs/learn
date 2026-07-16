A single-domain forest is the preferred design when one forest security boundary can meet an organization's requirements. It reduces administrative, trust, Group Policy, replication, and global catalog complexity while supporting users and resources across many physical and cloud locations.

In this module, you learned how to:

- Select a single-domain forest and distinguish the AD DS DNS name, user-facing UPN suffix, and legacy NetBIOS name
- Design AD-integrated DNS zones, resolver settings, forwarding, dynamic updates, aging, and scavenging
- Map IPv4 and IPv6 networks to AD DS sites so that DC Locator can direct clients to an appropriate domain controller
- Model site links, costs, schedules, convergence requirements, alternate paths, and SYSVOL replication from network behavior
- Place writable domain controllers, DNS servers, global catalogs, FSMO roles, and the authoritative time source across independent failure domains
- Validate the design with measurable acceptance criteria, configuration evidence, and tests for server, DNS, and WAN failures

A complete forest design records its requirements, assumptions, decisions, owners, and validation evidence. This record provides an operational baseline for deployment, maintenance, recovery, and future changes to the directory topology.

## Learn more

- [AD DS design requirements](/windows-server/identity/ad-ds/plan/ad-ds-design-requirements)
- [Understanding the Active Directory logical model](/windows-server/identity/ad-ds/plan/understanding-the-active-directory-logical-model)
- [Selecting the forest root domain](/windows-server/identity/ad-ds/plan/selecting-the-forest-root-domain)
- [Creating a DNS infrastructure design](/windows-server/identity/ad-ds/plan/creating-a-dns-infrastructure-design)
- [Designing the site topology](/windows-server/identity/ad-ds/plan/designing-the-site-topology)
- [Active Directory replication concepts](/windows-server/identity/ad-ds/get-started/replication/active-directory-replication-concepts)
- [Planning domain controller placement](/windows-server/identity/ad-ds/plan/planning-domain-controller-placement)
- [Flexible Single Master Operations roles in Active Directory Domain Services](/windows-server/identity/ad-ds/manage/understand-fsmo-roles)
- [Windows Server Inside Out (Microsoft Press)](https://aka.ms/WSInsideOut)
