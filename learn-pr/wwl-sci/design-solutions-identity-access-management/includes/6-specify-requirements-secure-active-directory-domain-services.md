Many organizations maintain Active Directory Domain Services (AD DS) as their on-premises identity foundation, often synchronized with Microsoft Entra ID for hybrid scenarios. As a security architect, you specify requirements for hardening AD DS to reduce attack surface and protect against credential theft and lateral movement.

## Understanding AD DS security risks

Active Directory is a primary target for attackers because it controls access to organizational resources. Common attack patterns include:

| Attack category | Description |
|---|---|
| **Credential theft** | Extracting password hashes, Kerberos tickets, or cached credentials from domain-joined systems |
| **Privilege escalation** | Exploiting misconfigurations to gain higher privileges (DCSync, AdminSDHolder manipulation) |
| **Lateral movement** | Using stolen credentials to access other systems across the network |
| **Persistence** | Creating backdoors through group membership changes, service accounts, or Group Policy Objects (GPOs) |

Your hardening requirements should address each of these attack categories. These attacks are commonly enabled by organizational weaknesses: gaps in anti-malware coverage, incomplete patching (especially non-Windows systems), outdated applications or operating systems still in production, and misconfigurations such as disabled host firewalls or standardized local administrator passwords.

## Reducing the AD DS attack surface

### Administrative account protection

- **Minimize privileged accounts** - Strictly limit membership in the Administrators, Domain Admins, and Enterprise Admins groups to the smallest number of accounts necessary. These groups should be considered equally powerful because a member of any one can elevate to the others.
- **Use separate admin accounts** - Administrators should use dedicated accounts for privileged tasks, separate from daily use accounts to reduce attack exposure.
- **Prevent excessive privilege grants** - Audit accounts across Active Directory, member servers, workstations, applications, and data repositories to identify and remove unnecessary privileges.

### Domain controller security

If an attacker gains privileged access to a domain controller, they can modify, corrupt, or destroy the AD DS database. Domain controllers should be secured separately and more stringently than the general infrastructure:

- **Restrict logon access** - Only domain admins should be able to sign in to domain controllers.
- **Block internet access** - Configure perimeter firewalls to block outbound connections from domain controllers to the internet. Use AppLocker and Windows Firewall configuration to prevent web browsing.
- **Use Server Core** - Deploy domain controllers on Server Core installations to reduce attack surface.
- **Keep systems patched** - Apply security updates promptly. Become familiar with the domain controller operating system and use security configuration baselines enforced with GPOs.
- **Enable Credential Guard** - Protect credential hashes from extraction on Windows Server domain controllers.
- **Physical security** - Require TPM, BitLocker Drive Encryption on all DC volumes, and dedicated secure racks or cages. Run virtual DCs on separate physical hosts isolated from general-purpose virtual machines.
- **Branch office protection** - Deploy Read-Only Domain Controllers (RODCs) where physical security can't be fully guaranteed.

### Legacy protocol restrictions

- Restrict NTLM authentication and disable NTLMv1 where possible (prefer Kerberos)
- Require SMB signing and LDAP signing
- Disable DES and RC4 encryption for Kerberos
- Enable Kerberos Armoring and TLS 1.2 only mode

## Implementing least privilege with the enterprise access model

Microsoft's enterprise access model supersedes and replaces the legacy AD tier model. It spans on-premises, multiple clouds, and all access methods.

| Plane | Scope | Description |
|---|---|---|
| **Control plane** | Domain controllers, PKI, AD FS, identity infrastructure | Full control of identity - equivalent to legacy Tier 0, expanded to include networking access controls |
| **Management plane** | Member servers, enterprise IT management | Enterprise-wide IT management functions - split from legacy Tier 1 |
| **Data/Workload plane** | Applications, data | Per-workload management, often by business units |
| **User access** | Workstations, endpoints | B2B, B2C, and public access scenarios |

Credentials used at one plane should never be exposed on systems at a lower plane to prevent credential theft cascades.

### Secure administrative hosts and Privileged Access Workstations (PAWs)

Secure administrative hosts are dedicated computers used exclusively for administrative tasks. They must not run nonadministrative software such as email clients or web browsers, and should be hardened with restricted sign-in, limited network access, and enhanced monitoring.

Microsoft's Privileged Access Workstations (PAWs) provide a specific implementation framework for secure admin hosts, with three device security levels managed through Intune and Autopilot:

- **Enterprise** - Baseline managed security with endpoint detection and response (EDR)
- **Specialized** - Removes self-administration and restricts applications to those installed by authorized administrators
- **Privileged** - Highest security configuration with application control, Credential Guard, and web traffic restricted to approved destinations only. Designed for roles where account compromise would have significant organizational impact.

Use PAWs or equivalent secure admin hosts for all control plane and management plane administrative activities. Require multifactor authentication for all privileged sign-ins.

### Just-in-time access

Reduce standing privileges through time-limited access. Microsoft Entra PIM provides just-in-time role activation for Microsoft Entra ID and Azure resource roles, but doesn't directly manage on-premises AD DS group memberships. PIM can, however, protect roles that indirectly affect AD DS, such as the Hybrid Identity Administrator role (which manages synchronization settings) or Azure resource roles on Arc-enabled domain controllers. For AD DS privileged groups, use time-limited group memberships (a native AD DS capability at Windows Server 2016 forest functional level) to automatically expire membership in groups like Domain Admins after a defined period.

## Monitoring and detecting threats

### Security auditing

Research consistently shows that most breach victims had evidence of compromise in their event logs but failed to detect it. Require comprehensive auditing using Windows Advanced Audit Policy subcategories:

- Audit account sign-in events and privilege use
- Monitor changes to sensitive groups (Domain Admins, Enterprise Admins, Schema Admins)
- Track directory service access and changes
- Forward logs to a SIEM for correlation, alerting, and advanced hunting

### Microsoft Defender for Identity

Microsoft Defender for Identity is a cloud-based identity threat detection and response (ITDR) solution. It gathers signals from AD DS domain controllers and servers running AD FS and AD CS by installing sensors directly on those servers. Capabilities include:

- **Proactive security posture assessments** to prevent breaches
- **Real-time threat detection** for reconnaissance, credential compromise, lateral movement, and domain dominance attacks (including DCSync, golden ticket, and pass-the-hash)
- **Clear, actionable incident information** integrated with Microsoft Defender XDR for correlation across endpoints, identities, email, and applications
- **Automatic response** to compromised identities

Deploy Defender for Identity sensors on all domain controllers, AD FS servers, AD CS servers, and Microsoft Entra Connect servers for comprehensive coverage.

## Planning for compromise

Design your AD DS environment assuming compromise will occur:

- **Backup and recovery** - Maintain offline, protected backups of AD DS. Test restoration procedures regularly and plan for forest-wide recovery scenarios.
- **Segregation of critical assets** - Isolate the most critical users, systems, and data by segregating them into separate, more secure domains or forests. Decommission legacy systems where possible; where not feasible, segregate them into a separate domain or forest to limit the scope of compromise. Within each domain, use organizational units (OUs) to organize objects by role or function and link Group Policy Objects (GPOs) to enforce security baselines, restrict privileged account sign-in, and delegate administration with least privilege.
- **Business-centric security practices** - Assign business ownership to AD data, implement lifecycle management, and classify all AD DS data by criticality.
- **Pristine forest strategy** - For severely compromised environments, plan for building a new secure AD forest as a recovery baseline and migrating critical assets without carrying over compromised security principals.

## Microsoft solutions for AD DS security

The following capabilities support AD DS hardening:

| Solution | Security requirement addressed | Description |
|---|---|---|
| **Windows Server AD DS (Windows Server 2025)** | Attack surface reduction, least privilege, and segregation | Provides built-in security capabilities including organizational units (OUs) and Group Policy Objects (GPOs) for security baseline enforcement and delegated administration, Read-Only Domain Controllers (RODCs) for branch offices, Server Core installations, time-limited group memberships for JIT access, Windows Advanced Audit Policy, and Kerberos Armoring |
| **Microsoft Defender for Identity** | Monitoring and threat detection | Cloud-based ITDR solution with sensors on domain controllers for real-time detection of credential theft, lateral movement, and privilege escalation, plus proactive security posture assessments |
| **Microsoft Entra Password Protection** | Credential theft prevention | Extends cloud-based banned password lists to on-premises AD DS, blocking weak and commonly attacked passwords during password changes |
| **Windows LAPS** | Local admin account protection | Automatically manages and rotates local administrator passwords on domain-joined devices, eliminating standardized local admin passwords that enable lateral movement |
| **Credential Guard** | Credential theft prevention | Hardware-based (virtualization-based security) credential isolation that prevents extraction of NTLM hashes and Kerberos tickets from memory on domain controllers and workstations |
| **Microsoft Sentinel** | Security auditing and log analysis | Cloud-native SIEM for ingesting and correlating AD DS audit logs, security events, and Defender for Identity alerts with advanced hunting and automated response |
| **Azure Arc** | Domain controller security and monitoring | Extends cloud-based policy enforcement, monitoring, and security baselines to on-premises servers including domain controllers |

## Design considerations for security architects

When specifying AD DS hardening requirements:

- **Assess current state** - Evaluate existing configurations against Microsoft security baselines
- **Prioritize by impact** - Focus first on protecting domain controllers and privileged accounts
- **Balance security with operations** - Ensure hardening doesn't break business-critical services; test in pilot groups before staged rollout
- **Plan for hybrid** - Coordinate AD DS security with Microsoft Entra ID security policies and cloud-powered protections like Defender for Identity
- **Document exceptions** - Track any deviations from hardening standards with compensating controls
