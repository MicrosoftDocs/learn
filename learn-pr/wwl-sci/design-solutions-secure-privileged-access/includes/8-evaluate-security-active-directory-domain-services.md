As a security architect, you need to evaluate whether your Active Directory Domain Services (AD DS) implementation can withstand modern attack techniques. Many organizations have AD DS environments that accumulated vulnerabilities over years of growth and legacy compatibility requirements. This unit covers attack patterns you should assess and design principles for building resilient AD DS architectures.

## Common attacks against AD DS

Understanding attack patterns helps you evaluate your current AD DS security posture and design appropriate defenses.

### Credential theft attacks

- **Pass-the-hash (PtH)**: Attackers extract password hashes from memory and use them to authenticate without knowing the actual password
- **Pass-the-ticket (PtT)**: Attackers steal Kerberos tickets and use them to impersonate users
- **Kerberoasting**: Attackers request service tickets for accounts with Service Principal Names (SPNs), then crack them offline to obtain service account passwords
- **DCSync**: Attackers with sufficient privileges replicate password hashes directly from domain controllers

### Privilege escalation attacks

- **Golden ticket**: Attackers create forged Kerberos tickets using the KRBTGT account hash, granting unlimited domain access
- **Silver ticket**: Attackers forge service tickets using service account hashes
- **AdminSDHolder abuse**: Attackers modify the AdminSDHolder object to grant themselves persistent privileged access

### Lateral movement

- **Unconstrained delegation abuse**: Attackers exploit servers with unconstrained delegation to capture credentials
- **Trust relationship abuse**: Attackers exploit trust relationships between domains or forests to move laterally

> [!IMPORTANT]
> If attackers obtain the KRBTGT account hash, they can create golden tickets that persist even after password resets for individual accounts. Resetting the KRBTGT password twice (to invalidate both current and previous hashes) is required to remediate this attack.

## Design principles for AD DS resilience

When designing or evaluating AD DS security, apply these principles:

**Assume legacy environments are compromised**: If your AD DS environment has existed for years with inconsistent security practices, design your remediation strategy assuming attackers may already have persistent access.

**Reduce the attack surface**: Remove unnecessary services, disable legacy protocols (NTLMv1, unencrypted LDAP), and limit the number of highly privileged accounts. Every additional privilege represents potential attack surface.

**Tier administrative access**: Separate administration into tiers—Tier 0 for identity systems (domain controllers, AD CS), Tier 1 for servers and applications, Tier 2 for workstations. Never use Tier 0 credentials on lower-tier systems.

**Protect credential exposure**: Deploy Credential Guard on domain-joined systems, configure Protected Users security group for sensitive accounts, and implement LAPS for local administrator passwords.

## Pristine forest architecture

Rather than attempting to remediate a deeply compromised environment, consider creating a pristine forest—a newly built Active Directory environment designed with current security practices. This approach creates a "secure cell" for your most critical assets.

### Design decisions for pristine forests

| Decision | Options | Considerations |
|----------|---------|----------------|
| **Forest purpose** | Administrative forest, VIP users, or full replacement | Administrative forests manage legacy environments securely; VIP forests protect sensitive users |
| **Trust direction** | Pristine trusts legacy, or no trust | Never configure pristine forest to trust legacy; one-way trust from legacy to pristine is acceptable |
| **Migration approach** | Traditional or nonmigratory | Nonmigratory avoids bringing compromised objects (security identifier (SID) history, group memberships) into pristine environment |
| **Scope** | Critical assets only or eventual full migration | Start with highest-value assets; expand based on risk assessment |

### Nonmigratory migration principles

Traditional migrations carry SID history and group memberships from the source environment—potentially including compromised objects. Nonmigratory approaches create fresh objects in the pristine forest:

- **User accounts**: Create new accounts; use metadirectory tools to map access rather than migrating SID history
- **Computers**: Freshly install servers and workstations; migrate data but not the systems themselves
- **Applications**: Install current, supported versions; migrate data from legacy instances

## Modernization strategies

For systems that can't migrate to a pristine forest, apply these strategies:

**Creative destruction**: Replace legacy applications with modern alternatives—preferably cloud-based services—rather than maintaining outdated systems. This reduces attack surface while improving functionality.

**Isolation**: Segregate legacy systems that can't be decommissioned into separate domains or forests. This limits the impact of their compromise and allows you to implement stronger security in the rest of your environment.

**Simplify for users**: Design security controls that are transparent to end users. VIPs and executives—often the most targeted users—have the least time for complex security procedures. Implement backend controls that enforce policy without requiring user action.

For more information, see [Best practices for securing Active Directory](/windows-server/identity/ad-ds/plan/security-best-practices/best-practices-for-securing-active-directory).
