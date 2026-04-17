Your security strategy identifies gaps and defines objectives. This unit translates those objectives into solution recommendations—organized by capability area and mapped to CAF governance requirements, MCSB control domains, and WAF security checklist items. Each section describes the capabilities your solutions must provide, followed by a brief example of Microsoft solutions that address the requirement.

## From strategy to solutions

Each gap in your security strategy implies a capability requirement. As a cybersecurity architect, you translate requirements into solution recommendations by:

1. Identifying the capability each gap requires
2. Defining evaluation criteria based on framework controls
3. Recommending solutions that meet those criteria within your organization's constraints

The sections below organize recommendations by capability area. Use them as a reference when building your solution portfolio.

## Identity and access management

**Framework drivers**: CAF Ready phase (identity design area); MCSB Identity Management (IM) and Privileged Access (PA) domains; WAF checklist SE:05

A comprehensive identity solution should provide:

- Centralized identity provider with single sign-on across cloud and on-premises resources
- Risk-based conditional access that evaluates context (location, device health, user risk) before granting access
- Privileged access management with just-in-time elevation and approval workflows
- Workload identity management for service-to-service authentication without stored credentials

**Microsoft example**: Entra ID provides centralized identity, conditional access policies, and Privileged Identity Management (PIM) for just-in-time privileged access. Workload identity federation eliminates secrets for automated deployments.

## Network security

**Framework drivers**: CAF Ready phase (network topology design area); MCSB Network Security (NS) domain; WAF checklist SE:04, SE:06

Your network security solution should provide:

- Network segmentation that isolates workloads by sensitivity and function
- Traffic inspection and filtering at network boundaries
- Web application firewall protection for internet-facing applications
- Distributed denial-of-service (DDoS) mitigation for public endpoints
- Private connectivity for platform services to eliminate public internet exposure

**Microsoft example**: Azure Virtual Network with network security groups provides segmentation. Azure Firewall inspects cross-zone traffic. Azure Private Link enables private connectivity to platform services.

## Data protection

**Framework drivers**: MCSB Data Protection (DP) domain; WAF checklist SE:03, SE:07, SE:09

Your data protection solution should provide:

- Data classification and labeling across structured and unstructured data stores
- Encryption at rest and in transit using current cryptographic standards
- Key management with hardware security module (HSM) backing for high-sensitivity keys
- Data loss prevention (DLP) controls to detect and block unauthorized data movement
- Backup and recovery with immutable storage to protect against ransomware

**Microsoft example**: Microsoft Purview provides classification, labeling, and DLP. Azure Key Vault manages encryption keys with HSM support. Azure Backup with immutable vaults protects recovery points.

## Security monitoring and threat detection

**Framework drivers**: CAF Manage phase (security monitoring); MCSB Logging and Threat Detection (LT) domain; WAF checklist SE:10, SE:12

Your monitoring solution should provide:

- Security information and event management (SIEM) with centralized log aggregation and correlation
- Extended detection and response (XDR) covering endpoints, identities, email, and cloud workloads
- User and entity behavior analytics (UEBA) to detect anomalous activity patterns
- Security orchestration, automation, and response (SOAR) for automated playbook execution
- Incident response workflow management with case tracking and evidence preservation

**Microsoft example**: Microsoft Sentinel provides SIEM, UEBA, and SOAR capabilities. Microsoft Defender XDR covers endpoint, identity, and application threat detection with automated investigation and response.

## Cloud security posture management

**Framework drivers**: CAF Govern phase (security baseline); MCSB Posture and Vulnerability Management (PV) domain; WAF checklist SE:01, SE:08

Your posture management solution should provide:

- Continuous assessment of resource configurations against security benchmarks
- Secure score that quantifies posture and prioritizes remediation by risk
- Regulatory compliance dashboards mapping configurations to industry standards
- Vulnerability assessment for compute resources, containers, and databases
- Attack path analysis that identifies exploitable chains of misconfiguration

**Microsoft example**: Microsoft Defender for Cloud provides CSPM with secure score, regulatory compliance assessment, and attack path analysis. Defender Vulnerability Management assesses compute and container vulnerabilities.

## Governance and policy enforcement

**Framework drivers**: CAF Govern phase; WAF checklist SE:01

Your governance solution should provide:

- Policy-as-code engine that evaluates resource configurations at deployment time and continuously
- Deny, audit, and auto-remediate enforcement modes
- Compliance reporting across subscriptions and management groups
- Resource organization through tagging standards and hierarchy enforcement
- Drift detection when resource configurations change after deployment

**Microsoft example**: Azure Policy provides policy-as-code enforcement with built-in MCSB initiative assignments. Management groups organize subscriptions into governed hierarchies. Azure Resource Graph enables cross-subscription compliance queries.

## Application security

**Framework drivers**: CAF Adopt phase (innovation security); MCSB DevOps Security (DS) domain; WAF checklist SE:02, SE:08, SE:09, SE:11

Your application security solution should provide:

- Static application security testing (SAST) integrated into CI/CD pipelines
- Software composition analysis (SCA) for dependency vulnerability tracking
- Secret scanning to detect credentials committed to source code
- Secrets management with centralized, audited storage and automated rotation
- Container image scanning and runtime protection

**Microsoft example**: GitHub Advanced Security provides SAST (CodeQL), SCA (Dependabot), and secret scanning. Azure Key Vault manages application secrets with rotation support. Microsoft Defender for Containers secures container workloads from build through runtime.

## AI workload security

**Framework drivers**: MCSB controls extended by AI-specific frameworks (MITRE ATLAS, OWASP Top 10 for GenAI, NIST AI RMF); WAF AI workload assessment

Your AI security solution should provide:

- Content filtering for inputs (prompt injection defense) and outputs (data leakage prevention)
- Model access controls with authentication, authorization, and rate limiting
- AI-specific monitoring for anomalous query patterns and data extraction attempts
- Red teaming tools for adversarial testing of AI systems
- Responsible AI governance including fairness, transparency, and accountability controls

**Microsoft example**: Azure AI Content Safety provides input and output filtering. Azure AI services include built-in authentication and rate limiting. PyRIT (Python Risk Identification Toolkit) supports AI red teaming.

## Build a solution roadmap

After identifying solutions for each capability area, build a phased deployment roadmap aligned with your security strategy:

**Phase 1—Foundation**: Deploy platform-wide capabilities first—identity provider with conditional access, network segmentation, CSPM, centralized SIEM, and governance policy engine. These correspond to your platform-scope strategy and must be operational before workloads can inherit a secure baseline.

**Phase 2—Workload protection**: Extend protection to individual workloads by priority—data classification and encryption for sensitive data, application security tooling in development pipelines, workload-specific threat detection, and secrets management.

**Phase 3—Advanced capabilities**: Add capabilities that mature your posture—attack path analysis, AI workload security controls, automated compliance reporting across multiple regulatory standards, and SOAR playbooks for common incident scenarios.

### Evaluate solution fit

When recommending specific solutions, evaluate each against these criteria:

- **Framework alignment**: Does the solution map directly to MCSB controls or WAF checklist items?
- **Integration**: Does it connect with your existing identity, monitoring, and governance solutions?
- **Automation**: Does it support automated assessment and remediation, or require manual operation?
- **Multi-cloud coverage**: If your strategy spans multiple cloud providers, does the solution provide consistent visibility?
- **Scalability**: Can it grow with your environment without requiring architectural redesign?

The solution recommendations in this unit complement the security strategy designed in the previous unit. Together, they provide an end-to-end approach: evaluate your posture, design your strategy, and recommend the solutions that implement it.
