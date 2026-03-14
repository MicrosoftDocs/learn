As a security architect, you specify the security requirements that guide how your organization protects servers across diverse environments. This includes servers running different operating systems, deployed on-premises, in Azure, or across multicloud environments. Your requirements must address the unique security characteristics of each platform while maintaining a consistent security posture.

## Framework for specifying server security requirements

When specifying server security requirements, organize them into categories that map to common security frameworks and regulatory standards. This approach ensures comprehensive coverage and simplifies compliance reporting.

**Core requirement categories**

- **Identity and access management**: Authentication methods, privileged access controls, service account management
- **Network security**: Traffic filtering, segmentation, exposure reduction
- **Data protection**: Encryption at rest and in transit, key management
- **Backup and recovery**: Immutable backups, tested restoration procedures, ransomware resilience
- **Vulnerability management**: Scanning, patching, remediation timelines
- **Security monitoring**: Logging, alerting, threat detection
- **Configuration management**: Hardening baselines, drift detection

For each category, specify requirements that are measurable and auditable. For example, instead of "servers should be patched regularly," specify "critical security patches must be applied within 14 days of release, with emergency patches applied within 48 hours."

### MCSB Endpoint Security controls

The [Microsoft Cloud Security Benchmark (MCSB) v2 (preview)](/security/benchmark/azure/overview) provides a structured framework for endpoint security requirements. It supersedes MCSB v1, expanding security domains to 12 (including Artificial Intelligence Security), adding risk and threat-based guidance with MITRE ATT&CK mappings, and updating compliance framework mappings to NIST SP 800-53 Rev.5, PCI-DSS v4, CIS Controls v8.1, NIST CSF v2.0, ISO 27001:2022, and SOC 2.

The Endpoint Security (ES) domain is organized into two pillars:

**Cloud endpoint threat protection—Deploy comprehensive threat detection and response capabilities for servers, including behavioral analysis and extended detection and response (XDR) integration:

| Control | Requirement | Implementation guidance |
| --- | --- | --- |
| ES-1 | Use Endpoint Detection and Response (EDR) | Deploy EDR solutions like Microsoft Defender for Endpoint to detect, investigate, and respond to advanced threats on servers. Includes subcontrols for EDR deployment (ES-1.1), XDR integration (ES-1.2), and EDR automation (ES-1.3). |
| ES-2 | Use modern anti-malware software | Require anti-malware solutions that provide real-time protection, behavior monitoring, and integration with cloud-based threat intelligence |

**Cloud endpoint security configuration—Enforce security baselines and hardening standards across all servers:

| Control | Requirement | Implementation guidance |
| --- | --- | --- |
| ES-3 | Ensure anti-malware software and signatures are updated | Configure automatic updates for anti-malware definitions and engines; specify maximum acceptable age for signatures |

These controls apply across Windows and Linux servers in Azure, AWS, GCP, and on-premises environments. Microsoft Defender for Servers implements ES-1 and ES-2 through its integration with Defender for Endpoint. For detailed implementation guidance, see [Endpoint security controls in MCSB v2](/security/benchmark/azure/mcsb-v2-endpoint-security).

## Platform-specific considerations

Different operating systems have distinct security models, and your requirements must account for these differences.

### Windows Server requirements

Windows Server environments require specific attention to:

- **Active Directory integration**: Specify requirements for domain membership, Group Policy application, and Kerberos authentication configuration
- **Windows Defender Antivirus**: Require real-time protection, cloud-delivered protection, and automatic sample submission for threat analysis
- **Local administrator accounts**: Mandate the use of Windows LAPS (Local Administrator Password Solution) for unique, rotating local admin passwords
- **SMB security**: Require SMB encryption and disable legacy SMB versions (SMBv1)
- **BitLocker**: Specify encryption requirements for OS and data volumes

### Linux server requirements

Linux security requirements vary by distribution but should address:

- **Microsoft Defender for Endpoint on Linux**: Require Defender for Endpoint for real-time anti-malware protection, EDR capabilities, and vulnerability assessment on supported Linux distributions
- **SSH hardening**: Require key-based authentication, disable root sign-in, and limit SSH access to specific users or groups
- **SELinux or AppArmor**: Specify mandatory access control requirements based on your distribution (SELinux for RHEL-based distributions, AppArmor for Ubuntu/SUSE)
- **Firewall configuration**: Require firewall or iptables rules that implement least-privilege network access
- **Package management**: Specify approved repositories and require signed packages
- **File system permissions**: Define requirements for sensitive file permissions and the use of access control lists (ACLs)

## Deployment environment requirements

Server security requirements vary based on where servers are deployed. Your specifications must address each environment in your organization's infrastructure.

### Azure virtual machines

For Azure-hosted servers, use platform capabilities in your requirements:

- **Microsoft Defender for Servers**: Require Defender for Servers on all Azure VMs, selecting Plan 1 or Plan 2 based on workload criticality. See [Defender for Servers plan selection](/azure/defender-for-cloud/plan-defender-for-servers-select-plan) for guidance on matching plan capabilities to your security requirements.
- **Trusted launch**: Require trusted launch with Secure Boot and vTPM enabled for Azure VMs to protect against boot-level attacks such as bootkits and rootkits
- **Network security groups**: Require NSGs on all subnets with rules that follow least-privilege principles
- **Azure Bastion**: Require Azure Bastion for administrative access instead of exposing RDP/SSH ports
- **Managed identities**: Require managed identities for Azure resource access instead of stored credentials
- **Disk encryption**: Require Azure Disk Encryption, server-side encryption with customer-managed keys, or encryption at host based on workload requirements
- **Confidential VMs**: For workloads processing highly sensitive data, consider Azure Confidential VMs that provide hardware-based memory encryption

### Multicloud environments (AWS and GCP)

For servers in AWS or GCP, specify how to integrate with your security management:

- **Azure Arc onboarding**: Require all non-Azure servers to connect through Azure Arc for centralized management. The Defender for Cloud multicloud connectors for AWS and GCP can autodiscover EC2 instances and GCP VMs and install the Azure Connected Machine agent at scale.
- **Connector configuration**: Specify whether to connect at the organization/account level or individual project/account level
- **Defender for Servers coverage**: Extend Microsoft Defender for Servers protection to EC2 instances and Compute Engine VMs
- **Compliance standards**: Apply consistent standards across clouds—AWS Foundational Security Best Practices, GCP CIS benchmarks, and MCSB all map to common controls

### On-premises and hybrid servers

On-premises servers require additional considerations:

- **Azure Arc deployment**: Require the Azure Connected Machine agent on all servers to enable cloud-based management and full Plan 2 functionality
- **Direct Defender for Endpoint onboarding**: For servers where Azure Arc isn't feasible, you can onboard directly with the Defender for Endpoint agent. With Plan 1, direct onboarding provides all Plan 1 features. With Plan 2, directly onboarded servers get Plan 1 features plus premium Defender Vulnerability Management capabilities, but don't get agentless scanning, file integrity monitoring, JIT VM access, or OS configuration assessment—those capabilities require Azure Arc
- **Network connectivity**: Specify required endpoints for Azure Arc, Defender for Cloud, and any extensions
- **Proxy configuration**: Define proxy requirements for servers without direct internet access
- **Update management**: Integrate with Azure Update Manager for centralized patching across hybrid environments

## Specifying threat protection requirements

Beyond baseline security, specify requirements for active threat protection:

**Endpoint detection and response (EDR)**

Require Microsoft Defender for Endpoint on all servers. Specify that alerts above a defined severity level must be investigated within a specific timeframe.

**Vulnerability scanning**

Specify scanning frequency and remediation timelines:

- Critical vulnerabilities: Remediate within seven days
- High vulnerabilities: Remediate within 30 days
- Medium vulnerabilities: Remediate within 90 days

**File integrity monitoring**

For servers processing sensitive data, require monitoring of critical system files and configuration files with alerts on unauthorized changes. File integrity monitoring in Defender for Servers Plan 2 uses both the Defender for Endpoint agent (near real-time change detection) and agentless scanning (24-hour cadence), replacing the previous Log Analytics agent-based approach.

**Backup and recovery**

Require immutable or offline backups for critical servers to protect against ransomware. Specify backup frequency, retention periods, and regular restoration testing. MCSB includes a dedicated Backup and Recovery (BR) domain with controls for backup configuration, protection, and validation.

**Security alerts**

Define requirements for alert routing, escalation procedures, and integration with your security operations center (SOC) or SIEM solution.

## Compliance and regulatory requirements

Your server security requirements must address applicable regulations:

| Regulation | Key server requirements |
| --- | --- |
| **PCI-DSS** | Quarterly vulnerability scans, file integrity monitoring, strong cryptography, audit logging |
| **HIPAA** | Access controls, audit controls, encryption, automatic sign out |
| **SOC 2** | Logical access controls, system monitoring, change management, encryption |
| **ISO 27001** | Asset management, access control, cryptography, operations security |

Map your specific requirements to control frameworks to demonstrate compliance. The Microsoft Cloud Security Benchmark provides mappings to these common standards that simplify this alignment.

## Design decision: Defender for Servers plan selection

When specifying Defender for Servers requirements, focus on the security capabilities your workloads require rather than individual product features. Both plans include EDR through Defender for Endpoint, agent-based vulnerability assessment, and compliance assessment against regulatory standards. The decision between plans hinges on whether your requirements include capabilities that only Plan 2 provides.

**Specify Plan 1** as the baseline for all servers when your requirements include:

- Endpoint detection and response (EDR)
- Agent-based vulnerability assessment
- Compliance assessment against regulatory standards

**Specify Plan 2** for servers where your requirements also include:

- Agentless scanning for vulnerabilities, secrets, and malware (no agent installation required)
- File integrity monitoring (via Defender for Endpoint agent and agentless scanning)
- Just-in-time VM access to reduce attack surface (Azure and AWS only, not available on GCP)
- OS configuration assessment against MCSB compute security baselines
- OS system updates assessment integrated with Azure Update Manager
- Premium Defender Vulnerability Management (security baselines, block vulnerable apps; available only in the Defender portal)
- 500 MB/day free data ingestion for security data types (requires Azure Monitor Agent)

For most organizations, specify Plan 1 as the baseline requirement for all servers, with Plan 2 required for servers that process sensitive data, are internet-facing, or are otherwise classified as critical. This requirements-based approach lets you align plan selection to workload criticality tiers without overprovisioning protection for standard workloads.

For a complete comparison of plan features and cloud availability, see [Defender for Servers plan features](/azure/defender-for-cloud/defender-for-servers-overview#plan-protection-features).

## Documentation requirements

Your server security specification should include:

- **Scope definition**: Which servers are covered, organized by criticality tier
- **Requirement statements**: Clear, measurable requirements for each security category
- **Exception process**: How to request and document exceptions with compensating controls
- **Verification methods**: How compliance with each requirement will be assessed
- **Review cadence**: How often requirements are reviewed and updated (recommend annually or after significant changes)

This structured approach ensures your server security requirements are comprehensive, actionable, and aligned with your organization's risk tolerance and regulatory obligations.
