Azure landing zones provide a standardized, scalable foundation that security architects use to implement security controls across an organization's entire cloud estate. Rather than securing each workload individually, you design security *with* the landing zone architecture—using its management group hierarchy, policy engine, and built-in tooling to ensure every subscription and workload inherits consistent protection.

## The security design area

Security is one of eight design areas that define your landing zone architecture. The security design area creates a foundation for security across your Azure, hybrid, and multicloud environments. You can enhance this foundation later with security guidance from the Secure methodology of the Cloud Adoption Framework.

The security design area intersects with other design areas:

| Design area | Security intersection |
|-------------|----------------------|
| **Azure billing and Microsoft Entra tenant** | Tenant creation, enrollment, identity foundation |
| **Identity and access management** | Authentication, privileged access management, role definitions, Zero Trust identity controls |
| **Resource organization** | Management group hierarchy, policy scope, compliance boundaries, subscription segmentation |
| **Network topology and connectivity** | Segmentation boundaries, traffic inspection points, perimeter controls, encryption in transit |
| **Governance** | Policy enforcement, compliance monitoring, drift detection |
| **Management** | Security monitoring, log aggregation, patching, configuration management |
| **Platform automation and DevOps** | Secure deployment pipelines, infrastructure as code, automation of security controls |

Effective security architecture requires collaboration across these areas. Decisions made in network topology affect your ability to implement Zero Trust segmentation. Identity choices determine how you enforce least-privilege access. Resource organization defines where policies apply and how you aggregate security telemetry.

## Security in the landing zone reference architecture

The Azure landing zone reference architecture includes security tools and policies that provide organizations with an immediate security baseline. Understanding what the landing zone deploys helps you design security *with* the architecture rather than layering it on afterward.

**Security tools deployed in the reference architecture:**

- Microsoft Defender for Cloud (standard or free tier)
- Microsoft Sentinel
- Azure DDoS Network Protection (optional)
- Azure Firewall
- Web Application Firewall (WAF)
- Microsoft Entra Privileged Identity Management (PIM)

**Default policies for online and corporate-connected landing zones:**

- Enforce secure access (HTTPS) to storage accounts
- Enforce auditing for Azure SQL Database
- Enforce encryption for Azure SQL Database
- Prevent IP forwarding
- Prevent inbound Remote Desktop Protocol (RDP) from internet
- Ensure subnets are associated with network security groups (NSGs)

As a security architect, you apply these built-in capabilities as starting points and extend them based on your organization's requirements.

### Microsoft cloud security benchmark

The Microsoft cloud security benchmark (MCSB) provides high-impact security recommendations applicable to most Azure services, categorized by vendor-agnostic security controls such as network security and data protection. The landing zone reference architecture aligns with the MCSB, and you should use it as the baseline when designing security controls for your environment.

### Policy-driven security baseline

The landing zone enforces security through Azure Policy, organized across the management group hierarchy. Platform-wide policies apply at higher management group levels, while workload-specific policies apply closer to application landing zones. Design your policy strategy to:

- **Prevent insecure configurations**: Deny policies block noncompliant resource deployments before they occur.
- **Enforce security standards**: Require specific configurations such as encryption, network controls, or diagnostic settings.
- **Enable visibility**: Audit policies identify resources that don't meet requirements without blocking deployment.
- **Auto-remediate drift**: Deploy-if-not-exists policies automatically apply required configurations.

## Key security design considerations

When designing security with landing zones, an organization must have visibility into what's happening within their technical cloud estate. Security monitoring and audit logging of Azure platform services is a key component of a scalable framework. Address these architectural considerations:

### Security operations

- **Security alerts**: Which teams require notifications? Are there groups of services that require routing alerts to different teams? What are the business requirements for real-time monitoring and alerting?
- **SIEM integration**: How do you integrate security information and event management with Microsoft Defender for Cloud and Microsoft Sentinel?
- **Security logs**: What are the data retention periods for audit data? Microsoft Entra ID P1 or P2 reports have a 30-day retention period. How do you handle long-term archiving of Azure activity logs, VM logs, and PaaS logs?
- **Security controls**: What is the baseline security configuration via Azure in-guest VM policy? How do security controls align with governance guardrails?
- **Vulnerability management**: How do you handle emergency patching for critical vulnerabilities? What about patching for VMs that are offline for extended periods? How do you perform vulnerability assessment of VMs?
- **Shared responsibility**: Where are the handoffs for team responsibilities when monitoring or responding to security events?
- **Encryption and keys**: Who requires access to keys in the environment? Who manages key lifecycle?

### Access control

Modern security boundaries are more complex than traditional datacenter perimeters. In the cloud, your perimeter is composed of two parts: network security controls and Zero Trust access controls.

**Advanced network security** decisions include:

- **Inbound and outbound internet connectivity**: What connectivity models do you need for traffic to and from the public internet?
- **Landing zone network segmentation**: How do you deliver highly secure internal network segmentation within a landing zone to drive network Zero Trust implementation?
- **Network encryption requirements**: Where do you require encryption between on-premises and Azure, and across Azure regions?
- **Traffic inspection**: Where do you mirror or tap traffic for inspection within Azure Virtual Networks?

**Zero Trust access** decisions include:

- Which teams or individuals require access to services within the landing zone, and what roles do they perform?
- Who authorizes access requests?
- Who receives notifications when privileged roles are activated?
- Who has access to the audit history?

Use Microsoft Entra Privileged Identity Management to address these questions. Consider whether your organization needs Zero Trust practices across multiple pillars—infrastructure, data, and networking—not just identity and access management.

## Design recommendations

### Security operations

- **Generate access control audit reports** from your identity provider to track who accessed what, when, and from where. *Microsoft example: Microsoft Entra ID reporting capabilities.*
- **Export platform activity logs** to a centralized log analytics solution for long-term retention. For retention beyond two years, archive to immutable storage. *Microsoft example: Azure Monitor Logs for analysis, Azure Storage for long-term archival.*
- **Enable cloud security posture management** across all subscriptions and enforce compliance through policy. *Microsoft example: Microsoft Defender for Cloud standard tier with Azure Policy.*
- **Monitor operating system patching drift** using centralized log analytics and posture management tools. *Microsoft example: Azure Monitor Logs and Microsoft Defender for Cloud.*
- **Monitor virtual machine security configuration drift** through policy to detect when deployed VMs deviate from your baseline. *Microsoft example: Azure Policy compliance reporting.*
- **Automate software configuration deployment** through policy-driven extensions to enforce compliant baseline configurations on virtual machines. *Microsoft example: Azure Policy with VM extensions.*
- **Centralize resource diagnostic data** by connecting default resource configurations to a single log analytics workspace. *Microsoft example: Azure Monitor Log Analytics workspace.*
- **Implement event-driven, real-time alerting** for log-oriented security events. *Microsoft example: Azure Event Grid.*
- **Deploy centralized SIEM/SOAR capabilities** as part of your landing zone to aggregate security telemetry and automate response. *Microsoft example: Microsoft Sentinel.*
- **Use platform attestation** to verify the integrity of your VM boot chain, secure the release of confidential disk encryption keys, and attest that workloads run in trusted execution environments. *Microsoft example: Azure Attestation with Trusted Launch and confidential VMs.*

### Access control

- **Develop a security allowlist plan** to evaluate each required service's security configuration, monitoring, and alerting capabilities. If you plan to use customer-managed keys, verify support across all services and implement mitigations for any gaps. *Microsoft example: Azure Key Vault with customer-managed key support per service.*
- **Define an incident response plan** for cloud services before moving workloads into production, including detection, investigation, and remediation procedures.
- **Align security requirements with platform roadmaps** to stay current with newly released security controls and incorporate them into your landing zone as they become available.
- **Implement a Zero Trust approach** for access to the cloud platform, applying least-privilege and verify-explicitly principles where appropriate.

## Platform versus workload security responsibilities

Landing zones separate security responsibilities between platform teams and workload teams. As a security architect, you need to define where that boundary sits. Unclear boundaries create gaps where no team owns a control, or overlaps where conflicting configurations weaken security.

Design decisions to address:

- **Identity infrastructure ownership**: Does the platform team manage all identity providers, conditional access policies, and privileged access, or do workload teams define their own application-level access controls within platform guardrails?
- **Network security boundary**: Which segmentation and perimeter controls does the platform enforce centrally (hub firewalls, DNS, DDoS protection), and which controls do workload teams manage within their landing zones (NSGs, application gateways, private endpoints)?
- **Security monitoring scope**: Does the platform team aggregate all security telemetry into a central SIEM, or do workload teams maintain their own monitoring with platform-defined forwarding rules? Who triages alerts for workload-specific resources?
- **Policy enforcement versus flexibility**: Which security policies are non-negotiable platform-wide (deny rules at high management group levels), and where do workload teams get flexibility to apply their own policies (audit rules, workload-specific compliance)?
- **Incident response handoffs**: Who detects, who investigates, and who remediates? Define escalation paths between platform security operations and workload teams so incidents don't stall at team boundaries.

Document these boundaries explicitly. When responsibilities are ambiguous, security gaps follow.

## Greenfield versus brownfield considerations

Your approach differs based on whether you're building a new environment or securing an existing one.

**Greenfield (new environment)**:

- Embed security controls into the reference architecture from the start rather than retrofitting them later
- Deploy security infrastructure—identity, monitoring, network perimeter—before workloads
- Establish policy guardrails before teams begin deploying resources
- Define your target security posture and use infrastructure as code to codify it from day one

**Brownfield (existing environment)**:

- Establish hybrid identity synchronization with single sign-on, multifactor authentication, and password protection policies
- Implement conditional access policies that enforce context-aware authentication for cloud apps and platform resources
- Adopt a privileged access management solution with just-in-time elevation, least-privilege enforcement, and recurring access reviews
- Deploy centralized cloud security posture management and integrate it with a SIEM/SOAR platform for unified threat detection and response
- Roll out policies in audit mode first to understand their impact before enforcing
- Prioritize remediation based on risk—exposed privileges, missing encryption, unmonitored assets
- Plan remediation in phases to avoid business disruption

Both approaches benefit from infrastructure as code. Codified landing zones ensure security controls are consistently applied, version-controlled, and testable.

## Designing for security sustainment

Security isn't complete at deployment. Design your landing zone to support ongoing security operations:

- **Continuous posture assessment**: Integrate security scoring and recommendations into operational workflows
- **Automated compliance reporting**: Generate compliance evidence without manual effort
- **Drift detection**: Alert when resources deviate from security baselines
- **Update management**: Design for security patching across your cloud estate

Build feedback loops that connect security findings to landing zone improvements. Incident learnings should drive policy updates. Vulnerability trends should inform baseline changes.
