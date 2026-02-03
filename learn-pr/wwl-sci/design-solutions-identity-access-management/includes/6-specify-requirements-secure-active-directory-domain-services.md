Many organizations maintain Active Directory Domain Services (AD DS) as their on-premises identity foundation, often synchronized with Microsoft Entra ID for hybrid scenarios. As a security architect, you provide guidance for hardening AD DS to reduce attack surface and protect against credential theft and lateral movement.

## Understanding AD DS security risks

Active Directory is a primary target for attackers because it controls access to organizational resources. Common attack patterns include:

| Attack Category | Description |
|-----------------|-------------|
| **Credential theft** | Extracting password hashes, Kerberos tickets, or cached credentials from domain-joined systems |
| **Privilege escalation** | Exploiting misconfigurations to gain higher privileges (DCSync, AdminSDHolder manipulation) |
| **Lateral movement** | Using stolen credentials to access additional systems |
| **Persistence** | Creating backdoors through group membership changes, service accounts, or Group Policy Objects |

Your hardening guidance should address each of these attack categories.

## Reducing attack surface

Limit the ways attackers can gain initial access or escalate privileges within AD DS.

### Administrative account protection

- **Minimize privileged accounts** - Reduce the number of accounts with domain admin, enterprise admin, and schema admin rights
- **Use separate admin accounts** - Administrators should use dedicated admin accounts for privileged tasks, separate from daily-use accounts
- **Implement tiered administration** - Prevent credentials from Tier 0 (domain controllers) from being exposed on lower-tier systems

### Domain controller security

Domain controllers are the most critical AD DS components. Apply these controls:

- **Restrict who can log on** - Only domain admins should be able to log on to domain controllers
- **Block internet access** - Domain controllers shouldn't have direct internet connectivity
- **Use Server Core** - Deploy domain controllers on Server Core installations to reduce attack surface
- **Keep systems patched** - Apply security updates promptly to prevent exploitation of known vulnerabilities
- **Enable Credential Guard** - Protect credential hashes from extraction on Windows Server domain controllers

### Legacy protocol restrictions

Disable or restrict older, less secure protocols:

- Disable NTLM where possible (prefer Kerberos)
- Block LAN Manager (LM) and NTLM v1 authentication
- Require SMB signing
- Disable DES and RC4 encryption for Kerberos

## Implementing least privilege

Apply the principle of least privilege throughout your AD DS environment.

### Administrative tiering model

Microsoft recommends a tiered administrative model:

| Tier | Assets | Administrative Scope |
|------|--------|---------------------|
| **Tier 0** | Domain controllers, PKI, AD FS | Full control of identity infrastructure |
| **Tier 1** | Member servers, applications | Control of enterprise applications and data |
| **Tier 2** | Workstations, devices | Control of user endpoints |

Credentials used at one tier should never be exposed on systems at a lower tier to prevent credential theft cascades.

### Privileged Access Workstations (PAWs)

Dedicated workstations for administrative tasks prevent credential exposure:

- Use for all Tier 0 and Tier 1 administrative activities
- Block internet access and limit to essential administrative tools
- Apply enhanced security configurations and monitoring
- Consider jump servers for additional isolation

### Just-in-time access

Reduce standing privileges through time-limited access:

- Use time-limited group memberships for administrative tasks
- Implement approval workflows for privileged access
- Automatically remove privileges after defined periods

## Monitoring for compromise

Assume attackers may already have access and implement detection capabilities.

### Security auditing

Enable comprehensive auditing for AD DS:

- Audit account logon events and privilege use
- Monitor changes to sensitive groups (Domain Admins, Enterprise Admins, Schema Admins)
- Track directory service access and changes
- Forward logs to a SIEM for correlation and alerting

### Specific indicators to monitor

Configure alerts for these high-risk activities:

- Addition of members to privileged groups
- Changes to AdminSDHolder or Default Domain Policy
- Kerberos ticket anomalies (golden ticket, silver ticket indicators)
- Replication traffic from non-domain controllers (DCSync detection)
- Unusual service account behavior

### Microsoft Defender for Identity

Deploy Microsoft Defender for Identity to detect AD DS threats:

- Reconnaissance detection (account enumeration, service discovery)
- Credential compromise detection (brute force, pass-the-hash, pass-the-ticket)
- Lateral movement detection (overpass-the-hash, remote execution)
- Domain dominance detection (DCSync, golden ticket, skeleton key)

## Planning for compromise

Design your AD DS environment assuming compromise will occur.

### Backup and recovery

- Maintain offline, protected backups of AD DS
- Test restoration procedures regularly
- Plan for forest-wide recovery scenarios

### Segmentation

- Use organizational units (OUs) and Group Policy to segment administration
- Apply delegation of control only where necessary
- Separate service accounts by function with minimal permissions

## Microsoft solutions for AD DS security

The following capabilities support AD DS hardening:

- **Microsoft Defender for Identity** - Threat detection for on-premises Active Directory
- **Microsoft Entra Connect Health** - Monitoring for directory synchronization
- **Microsoft Entra Password Protection** - Blocks weak passwords in on-premises AD
- **Credential Guard** - Hardware-based credential protection
- **Local Administrator Password Solution (LAPS)** - Manages local admin passwords
- **Azure Arc** - Extends cloud management to on-premises servers

## Design considerations for security architects

When providing AD DS hardening guidance:

- **Assess current state** - Evaluate existing configurations against security baselines
- **Prioritize by impact** - Focus first on protecting domain controllers and privileged accounts
- **Balance security with operations** - Ensure hardening doesn't break business-critical services
- **Plan for hybrid** - Coordinate AD DS security with Microsoft Entra ID security policies
- **Test changes thoroughly** - Use pilot groups and staged rollout for policy changes
- **Document exceptions** - Track any deviations from hardening standards with compensating controls
