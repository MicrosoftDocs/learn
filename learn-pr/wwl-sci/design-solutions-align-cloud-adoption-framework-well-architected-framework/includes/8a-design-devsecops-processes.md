DevSecOps (Development, Security, and Operations) integrates security practices into every phase of the software development lifecycle. The Cloud Adoption Framework (CAF) Secure methodology provides structured guidance across six phases—strategy, plan, ready, adopt, govern, and manage—that maps directly to DevSecOps process design and aligns with the Microsoft Cloud Security Benchmark (MCSB) for specific technical controls. As a cybersecurity architect, you use these best practices to embed security from the earliest stages of development through deployment and operations.

## How the CAF Secure methodology supports DevSecOps

The CAF Secure methodology is organized around core security principles that each map to specific DevSecOps practices:

- **Security posture modernization**: The continuous elevation of defenses, detections, and resilience capabilities. This principle drives the shift-left approach and automated security controls in CI/CD pipelines.
- **Incident preparedness and response**: Proactive planning for detecting, containing, and recovering from security events. This principle shapes how you integrate threat detection and response into DevOps toolchains.
- **CIA Triad**: Confidentiality, integrity, and availability as foundational requirements. These principles guide access controls, code integrity checks, and deployment reliability.
- **Security sustainment**: The disciplined cycle of measuring, improving, and validating control efficacy. This principle ensures that DevSecOps processes include continuous improvement loops.

Each phase builds on the previous: strategy defines security objectives, planning translates them into actionable controls, readiness prepares the cloud foundation, adoption implements controls in development and platform practices, governance enforces them through policy, and management sustains them through continuous improvement.

The CAF also identifies DevSecOps as a component of **innovation security** within its landing zone security guidance, which complements the Secure methodology. This guidance describes a four-stage control model:

- **Secure the design**: Bring security into the planning phase through threat modeling, IDE security plugins, precommit hooks, and peer review.
- **Secure the code**: Implement vulnerability scanning in centralized repositories to discover risks and perform remediation.
- **Secure the pipeline**: Use build and release pipelines for automation and standardization to deploy secure code efficiently.
- **Secure operations**: Manage security in production using infrastructure scanning and penetration testing.

This four-stage model complements the Secure methodology and provides a comprehensive framework for embedding security into every aspect of DevSecOps.

:::image type="content" source="../media/development-security-operations-security.png" alt-text="Diagram that shows the four-stage model for designing a DevSecOps process that aligns with best practices of the CAF secure methodology." lightbox="../media/development-security-operations-security.png":::

## Align security strategy with DevSecOps goals

The Secure methodology's strategy guidance establishes the strategic direction for security across cloud adoption. Several strategic commitments directly shape how you design DevSecOps processes.

### Adopt Zero Trust as a strategic foundation

The strategy guidance recommends adopting Zero Trust as the overarching security strategy, founded on three principles that map directly to DevSecOps design decisions:

- **Verify explicitly**: Always authenticate and authorize based on all available data points. In DevSecOps, this means requiring identity verification for every pipeline action, code commit, and deployment.
- **Use least privilege**: Limit user and service access with just-in-time and just-enough-access policies. This principle drives how you scope developer permissions, service identities, and pipeline access controls.
- **Assume breach**: Minimize blast radius and segment access. This principle informs how you isolate pipeline environments, enforce code signing, and design containment procedures for compromised components.

By establishing these principles at the strategy level, you create a consistent framework that guides every subsequent DevSecOps design decision.

### Define integrity and automation commitments

The Secure methodology's integrity strategy emphasizes automation for policy management, data classification, infrastructure deployments, and update management. When you commit to automation as a strategic objective, you set the expectation that manual security gates are replaced by automated controls embedded in CI/CD pipelines—including automated code scanning, compliance checks, deployment validation, and incident response.

The security sustainment strategy establishes continuous improvement as an organizational commitment, ensuring that DevSecOps processes include feedback loops, metrics tracking, and regular posture reviews rather than treating security as a one-time implementation.

## Plan security into the development lifecycle

The Secure methodology's planning guidance translates strategic objectives into actionable security plans that shape DevSecOps process design.

### Plan for Zero Trust across technology pillars

The planning guidance structures Zero Trust adoption across seven technology pillars. Each pillar maps to specific DevSecOps controls that you should plan for before beginning adoption:

- **Identity**: Plan for strong authentication and least-privilege access in DevOps platforms and CI/CD systems.
- **Endpoints**: Plan for securing developer workstations and build agents that interact with code and deployment environments.
- **Data**: Plan for protecting sensitive data in repositories, configuration files, and deployment artifacts.
- **Apps**: Plan for securing the applications and services produced by development teams.
- **Infrastructure**: Plan for securing cloud infrastructure through infrastructure as code (IaC) standards and deployment policies.
- **Network**: Plan for network segmentation, traffic inspection, and encryption across development and production environments.
- **Visibility, automation, and orchestration**: Plan for operational policies that enforce Zero Trust principles through automated monitoring and response.

### Standardize development and operational practices

The planning guidance recommends standardizing development tools and practices to ensure deployments adhere to the CIA Triad and incorporate safe deployment practices. For DevSecOps, this means defining enforceable standards for:

- Source control workflows and branching strategies
- Build and release pipeline configurations
- Testing requirements and quality gates
- Deployment patterns and rollback procedures

Standardization reduces configuration drift and ensures that security controls are applied consistently across all projects and teams. The plan phase also recommends standardizing operational tools and practices so that operators maintain confidentiality, integrity, and availability consistently across environments.

### Establish a security baseline

Before adopting new DevSecOps controls, the Secure methodology recommends understanding your current security posture. Use automated tools like Microsoft Secure Score to establish a measurable baseline. This baseline provides a reference point for tracking improvement, prioritizing which DevSecOps controls to implement first, and measuring the impact of each improvement.

## Ready the cloud foundation for secure development

The Secure methodology's Ready guidance centers on building your cloud foundation through Azure landing zones—the secure, scalable, modular design pattern that serves as the starting point for implementation. This phase bridges planning and adoption by establishing the foundational infrastructure, identity, and integrity mechanisms that DevSecOps controls depend on.

### Build the foundation with Azure landing zones

The Ready guidance positions Azure landing zones as the primary mechanism for preparing your secure cloud estate:

- **Standardized architecture**: Landing zones separate domains—such as development, staging, and production—into governed environments with consistent security controls, ensuring that build agents, deployment pipelines, and developer workstations operate with appropriate isolation.
- **Infrastructure as code deployment**: Deploy landing zones through IaC in CI/CD pipelines, applying the same safe deployment practices used for software deployments.
- **Landing zone accelerators**: Use prepackaged, workload-specific deployments for services like Azure Kubernetes Service (AKS) and Azure API Management as security-compliant starting points.
- **Design area coverage**: Even if you don't adopt a full enterprise landing zone, understand the design areas (identity, networking, governance, security, and others) and implement controls for each area.

### Establish identity and network readiness

Implement Zero Trust identity controls as part of your landing zone foundation before workload deployment begins:

- **Identity controls**: Configure RBAC, multifactor authentication (MFA), and Conditional Access policies for developer accounts, build agents, and pipeline service identities.
- **Network segmentation**: Design network architecture using virtual networks, subnets, and network security groups to separate development, build, and production environments, minimizing blast radius if a pipeline component is compromised.

### Prepare for system integrity and monitoring

Prepare your landing zone design with automated management and monitoring:

- **Configuration and patch management**: Automate configuration management and codify update management policies.
- **Security monitoring**: Select SIEM and threat detection tooling for centralized visibility.
- **Data classification**: Establish data classification frameworks for handling secrets in repositories.

## Adopt secure development and platform practices

Adoption is the broadest phase for DevSecOps. The Secure methodology's adoption guidance addresses how you implement security controls across development workflows, platform infrastructure, CI/CD pipelines, and incident response.

### Posture modernization

Security posture modernization starts with establishing baselines and automating controls:

- **Operationalize your security baseline**: Apply the baseline established during planning as the standard against which all development environments and pipeline configurations are measured. Use security posture scoring tools to track progress and generate actionable recommendations.
- **Embrace automation**: Use IaC tools with declarative templates integrated into CI/CD pipelines for infrastructure deployments, testing, monitoring, and scaling. Automation reduces the risk of human error and improves consistency across environments.

### Shift-left security

The shift-left approach moves security from end-of-development auditing to continuous integration throughout the lifecycle:

| Traditional approach | Shift-left approach |
| --- | --- |
| Security review at release | Threat modeling during planning |
| Manual security testing | Automated security scanning in CI |
| Remediation in production | Vulnerability fixes during development |
| Security as a gate | Security as continuous feedback |

Shifting left produces more robust code and resolves problems early when they're easier and less expensive to fix.

### Secure the DevOps platform

A compromised DevOps platform undermines all other security controls, so platform hardening is a critical part of adoption.

- **Apply least-privilege access**: Use RBAC through a centralized identity provider, entitlement management for time-bound developer access, and just-in-time privileged access for platform administrator roles. Manage platform role assignments through centralized identity group memberships.
- **Protect code and environments**: Restrict repository access with security groups, set branch permissions, and require code reviews from security-aware reviewers before merging to protected branches. Consider disabling permission inheritance to prevent unintended access escalation.
- **Use workload identity federation for automated deployments**: Never use user accounts. Create separate identities per application and environment, scope permissions to only the required cloud subscriptions or resource groups, and store all secrets in a dedicated management solution. Deploy identities and federated credentials through IaC in a secure subscription vending process.

### Implement CI/CD pipeline security controls

The Microsoft Cloud Security Benchmark (MCSB) defines security controls for CI/CD pipelines. Design your pipelines to implement these controls at each stage:

- **Static application security testing (SAST)**: Integrate source code analysis, binary analysis, and credential scanning tools as gating controls that prevent vulnerable packages from committing, building, or deploying.
- **Dynamic application security testing (DAST)**: Integrate runtime application testing and automated penetration testing into your CI/CD workflow.
- **Software supply chain security**: Use dependency scanning tools to inventory vulnerabilities, automated update tools to upgrade dependencies, and cloud security posture management (CSPM) solutions to identify vulnerable container images.
- **Infrastructure as code security**: Colocate IaC assets with application code, use CSPM to discover misconfigurations in templates, and configure managed deployment environments with curated, security-compliant templates.

Use deployment management features to manage cloud resources as a single cohesive unit, and use deny settings to prevent unauthorized modifications.

### Prepare for incidents

A well-designed DevSecOps process includes built-in capabilities for detecting, responding to, and recovering from security incidents:

- **Threat detection**: Implement extended detection and response (XDR) and SIEM solutions integrated with your DevOps toolchain. XDR solutions provide automated investigation and response functionality that reduces response time.
- **Vulnerability management**: Use the patch management and monitoring tools established during readiness for risk-based assessment, prioritization, and remediation.
- **Incident response**: Develop and maintain an incident response plan that includes detection, analysis, and remediation steps. Automate containment actions through orchestrated workflows.
- **Recovery procedures**: Design pipelines that can rapidly deploy secure, validated code to recover from incidents. Automate recovery activities as much as possible to reduce mean time to recovery.

## Govern DevSecOps with policy enforcement

The Secure methodology's governance guidance emphasizes policy-driven governance as essential to sustaining security across DevSecOps processes. Governance ensures consistent implementation by defining policies once and applying them automatically.

### Policy-as-code

Design DevSecOps processes that enforce governance through automation:

- Use cloud policy enforcement tools to enforce organizational standards and assess compliance at scale across deployments.
- Use CSPM security policies to automate compliance with security standards.
- Define policies that block noncompliant infrastructure from deploying. This ensures that security requirements are enforced at the point of deployment rather than discovered after the fact.
- Automate governance for infrastructure deployments, hardening measures, data protection, and identity management standards.

### Continuous compliance monitoring

The governance guidance also recommends automated compliance monitoring that provides real-time insights and alerts:

- Track secure score controls in your CSPM solution to quantify gaps.
- Automate drift detection through policy, configuration baselines, and deployment pipelines.
- Review audit logs regularly. Stream DevOps platform audit logs to a centralized SIEM solution for long-term storage and correlation.

## Sustain security across DevSecOps operations

The Secure methodology's management guidance ensures that the security controls adopted and governed in earlier phases remain effective over time. Design DevSecOps processes that support ongoing improvement. Examples include:

- **Vulnerability management**: Integrate vulnerability findings directly into development backlogs so that remediation follows standard sprint workflows and risk scores are continuously tracked.
- **Threat intelligence integration**: Use the MITRE ATT&CK knowledge base to develop threat models and inform security testing. Feed incident retrospectives and threat intelligence into backlog refinement so that posture changes align with live adversary behaviors.
- **Security metrics**: Track metrics like mean time to detect (MTTD), secure score trends, and security coverage. Use these metrics to drive backlog prioritization and demonstrate security improvement to stakeholders.
- **System integrity monitoring**: Enforce infrastructure changes only through IaC and approved deployment protocols. Investigate changes outside approved protocols immediately.