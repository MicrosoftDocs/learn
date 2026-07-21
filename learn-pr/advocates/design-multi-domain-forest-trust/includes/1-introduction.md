A single-domain, single-forest design minimizes trust management, simplifies the global catalog, and reduces the number of administrative boundaries an organization has to defend. This model isn't appropriate for all organizations. In this module, you learn about multi-domain and multi-forest environments are appropriate. Reasons for a multi-domain or multi-forest architecture can include: 

- Regulatory separation
- Merger and acquisition activity
- Administrative autonomy
- Security isolation 
- Replication constraints

Multi-domain and multi-forest designs multiply the number of decisions you need to get right:

- Which forest owns the schema and configuration?
- How do trusts route authentication?
- Where do global catalog servers needs to be reachable?
- How should replication behave across slow or unreliable links?
- Do specific locations need a read-only domain controller (RODC) instead of a writable one?

Getting these decisions wrong can cause authentication outages, replication backlogs, and privilege-escalation paths that are difficult to detect after the fact.

## What this module covers

By the end of this module, you should be able to produce design decisions and supporting evidence for:

- Whether a requirement is better solved with an additional domain, an additional tree, an additional forest, or no structural change at all.
- Forest root, domain tree, directory partition, and application partition placement, including namespace coexistence with non-AD DNS.
- Organizational unit (OU) structure, delegation, Group Policy Object (GPO) scope and inheritance, protected objects, and schema change governance.
- Trust direction, transitivity, selective authentication, Security IDentifier (SID) filtering, SIDHistory governance, shortcut trusts, and cross-forest name resolution.
- Universal group membership, global catalog placement, and authentication paths in multi-domain and multi-forest topologies.
- Advanced replication risks - urgent replication, stale domain controllers, tombstone lifetime, lingering objects, disconnected sites, and manual bridgehead configuration - plus domain controller capacity planning.
- RODC branch deployment design, including the Password Replication Policy (PRP), the filtered attribute set, and delegated local administration.
