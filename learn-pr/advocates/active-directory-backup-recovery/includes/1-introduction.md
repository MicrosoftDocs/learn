Active Directory Domain Services (AD DS) is the primary identity control plane of millions of organization's Windows environments. If Active Directory is unavailable, users, computers, services, applications, trusts, Group Policy, and administrative tools are also unavailable. If Active Directory is compromised, restoring availability without restoring trust can preserve an attacker's access.

In this module you learn data protection, recovery strategies, and techniques to address:

- Accidental deletion of an organizational unit.
- Loss of one domain controller.
- Corruption confined to one domain.
- Forest-wide logical corruption.
- Suspected privileged compromise.
- Recovery of virtualized domain controllers.

The module doesn't teach introductory directory concepts. It assumes that you understand Active Directory concepts including multimaster replication, update sequence numbers, invocation IDs, directory partitions, sites, operations master roles, global catalogs, DNS, Kerberos, trusts, SYSVOL, Directory Services Restore Mode (DSRM), and Volume Shadow Copy Service (VSS).

## Recovery principles

We use these principles throughout the module:

- Select the smallest supported recovery scope that resolves the incident.
- Prefer replication or clean promotion when healthy partners exist.
- Treat the AD DS database decision separately from the SYSVOL decision.
- Select a backup by evidence, not by recency alone.
- Isolate unsafe writable domain controllers before they can replicate.
- Treat every domain controller backup as Tier 0 identity material.
- Require technical, security, and business approval before reconnection.

> [!IMPORTANT]
> Forest recovery restores a selected trusted directory state. It doesn't prove attacker eviction or remediate every persistence mechanism.

## Learning objectives

After completing this module, you'll be able to:

- Design a protected Windows Server 2025 AD DS backup strategy from business recovery requirements.
- Validate backup usability by using technical, security, compatibility, and restore-test evidence.
- Select the smallest supported recovery scope for a failure or compromise.
- Plan AD DS database, SYSVOL, DNS, operations master, RID, trust, and credential recovery.
- Evaluate virtualized domain controller recovery safety.
- Define evidence-based return-to-service gates.
