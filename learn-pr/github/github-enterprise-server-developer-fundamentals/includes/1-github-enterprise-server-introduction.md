GitHub Enterprise Server is a self-hosted deployment of GitHub, designed for organizations that require full control over their source code, metadata, and development workflows. Unlike GitHub.com, which is delivered as a Software-as-a-Service (SaaS) offering, GHES runs entirely within infrastructure owned or controlled by the customer.

This infrastructure may be on-premises, in a private cloud, or hosted with a supported hypervisor. Regardless of where it runs, GHES places security, isolation, and control at the center of the platform.

### In this unit, you'll learn

- What GHES is and how it differs architecturally from GitHub.com

- Why enterprises choose self-hosted GitHub deployments

- What "self-managed" means for developers and platform teams

- How GHES fits into regulated and security-sensitive environments

### Core  characteristics of GHES

GitHub Enterprise Server provides:

- Complete data isolation
  
  All repositories, issues, pull requests, and metadata live entirely within your organization's environment.

- Self-managed operations
  
  Your organization controls installation, upgrades, backups, monitoring, and disaster recovery.

- Enterprise-grade security controls
  
  Features such as subdomain isolation, outbound web proxies, and network segmentation are built in.

- Near feature parity with GitHub Enterprise Cloud
  
  Most GitHub features are available, though often delayed due to release cadence.

> [!IMPORTANT]
> GHES does not automatically receive updates. Each upgrade is a deliberate operational event, typically planned and executed by a platform team.

### Why organizations use GHES

Organizations typically choose GHES when they need:

- Data residency guarantees
  
  Source code and metadata must remain within specific geographic or network boundaries.

- Regulatory compliance
  
  Industries such as finance, healthcare, defense, and government often require self-hosted systems.

- Custom security posture
  
  Network-level controls, outbound proxies, and strict access segmentation.

- Operational sovereignty
  
  Full control over uptime, maintenance windows, and system configuration.

Developer takeaway: GHES prioritizes control and predictability over speed of feature delivery.

### What "Self-Managed" means for developers and platform teams

In a self-managed GitHub Enterprise Server environment, responsibility for operating GitHub shifts from GitHub to the customer.

- Platform team ownership
  
  Platform teams manage installation, upgrades, security patching, backups, monitoring, and availability of the GHES instance.

- Developer dependencies on platform teams
  
  Developers rely on internal teams for enabling features, configuring integrations, and resolving infrastructure-related issues.

- Infrastructure-driven limitations
  
  Some capabilities-such as GitHub-hosted runners or cloud-native services-are unavailable, requiring developers to adapt workflows.

- Operational awareness
  
  Developers must be aware of system constraints, maintenance windows, and version differences that affect day-to-day work.

### How GHES fits into regulated and security-sensitive environments

GHES is designed for organizations with strict control, compliance, and security requirements.

- Data isolation
  
  All code, metadata, and logs remain within the organization's network or approved infrastructure.

- Regulatory alignment
  
  GHES supports compliance requirements common in regulated industries such as finance, healthcare, government, and defense.

- Controlled network access
  
  Organizations can enforce outbound proxies, restricted connectivity, and network segmentation.

- Auditability and traceability
  
  All user activity is recorded locally, supporting internal audits and compliance reporting.

Key takeaway: GHES provides a GitHub experience that feels familiar, but it is operated and secured like an enterprise platform-updates, availability, and features are managed by the organization, not delivered continuously by GitHub.

Now that you understand what GHES is and why organizations choose it, the next unit compares GHES with GitHub Enterprise Cloud so you can recognize which behaviors and assumptions change between platforms.