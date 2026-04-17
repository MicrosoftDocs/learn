Microsoft Defender for Cloud serves as the primary tool for evaluating security posture across cloud environments. At the core of this evaluation is the Microsoft cloud security benchmark (MCSB), which defines the security standards against which your resources are assessed.

## Understanding the Microsoft cloud security benchmark

MCSB is a comprehensive set of security best practices organized into security domains. Each domain groups related security recommendations that address a specific area of concern. The following table shows the 12 security domains defined in MCSB v2:

| Security domain | Focus area |
|---|---|
| Network security (NS) | Virtual network security, private connections, external attack prevention, DNS security |
| Identity management (IM) | SSO, strong authentication, managed identities, conditional access |
| Privileged access (PA) | Privileged account protection, just-in-time access, administrative model security |
| Data protection (DP) | Encryption at rest and in transit, access controls, key and certificate management |
| Asset management (AM) | Asset inventory, approved service usage, security visibility |
| Logging and threat detection (LT) | Audit logging, detection capabilities, SIEM integration |
| Incident response (IR) | Preparation, detection, analysis, containment, post-incident activities |
| Posture and vulnerability management (PV) | Security baselines, vulnerability scanning, configuration tracking |
| Endpoint security (ES) | Endpoint detection and response, anti-malware |
| Backup and recovery (BR) | Backup configuration, protection, validation |
| DevOps security (DS) | Code security, pipeline integrity, supply chain security |
| Artificial intelligence security (AI) | AI platform security, AI application security, AI security monitoring |

Each security domain contains security controls and security subcontrols that provide granular, actionable implementation guidance. Controls include a control ID, description, and platform-specific guidance for Azure, AWS, and GCP. MCSB also maps each control to industry frameworks including NIST SP 800-53, CIS Controls, and PCI-DSS, making it suitable as a unified standard for organizations operating across multiple cloud providers.

> [!NOTE]
> MCSB v2 (preview) includes over 420 Azure Policy built-in definitions for automated compliance monitoring and introduces risk and threat-based guidance with detailed technical implementation examples.

## How Defender for Cloud implements MCSB

When you enable Microsoft Defender for Cloud on an Azure subscription, MCSB is automatically assigned as the default security initiative. Defender for Cloud then continuously assesses your resources and generates security recommendations when configurations don't meet the benchmark requirements.

:::image type="content" source="../media/defender-for-cloud-security-domains-v2.png" alt-text="Screenshot of the Microsoft Defender for Cloud overview page showing secure score, workload protections, and regulatory compliance." lightbox="../media/defender-for-cloud-security-domains-v2.png":::

The assessment process works as follows:

1. **Resource discovery**: Defender for Cloud identifies resources across connected Azure subscriptions, AWS accounts, and GCP projects.
2. **Policy evaluation**: Each resource is evaluated against Azure Policy definitions that implement MCSB controls. The MCSB initiative contains hundreds of policy definitions covering all control domains.
3. **Recommendation generation**: When a resource doesn't meet a control requirement, Defender for Cloud creates a security recommendation with remediation guidance specific to the cloud platform.
4. **Score calculation**: Recommendations aggregate into a secure score that quantifies overall posture.

For AWS and GCP resources, Defender for Cloud uses native cloud connectors to assess configurations against platform-specific MCSB controls. This provides a unified view of multicloud compliance against a single benchmark.

## Security baselines for Azure services

MCSB serves as the foundation for Azure service security baselines. Each Azure service—such as Azure Storage, Azure SQL Database, or Azure Kubernetes Service—has a security baseline that maps MCSB controls to service-specific configuration recommendations.

Security baselines help you:

- Identify which MCSB controls apply to each service type
- Find service-specific settings needed for compliance
- Define expected configurations for use in deployment templates
- Automate ongoing validation through Defender for Cloud assessments

When designing your posture management solution, use security baselines to define the expected configuration for each resource type. Defender for Cloud then automates the ongoing assessment against these expectations.

## Evaluating posture against MCSB

Use the following approach to evaluate your security posture against MCSB:

- **Assess control coverage**: Review each MCSB control domain and determine which controls apply to your environment. Not every control applies to every organization—document which controls are applicable based on your workload types and cloud platforms.

- **Review recommendations by domain**: In Defender for Cloud, filter security recommendations by MCSB control domain to identify where your resources meet the benchmark and where gaps exist. Focus attention on controls in domains most relevant to your risk profile, such as data protection for environments handling sensitive information, or network security for internet-facing workloads.

- **Map regulatory requirements**: If your organization must comply with standards like NIST SP 800-53, PCI-DSS, or ISO 27001, use MCSB's framework mapping to identify which controls satisfy your regulatory requirements and where extra controls are needed.

- **Design an exception process**: For controls that don't apply to specific workloads, create documented exceptions that include the specific control and reasoning, any compensating controls in place, a review cadence for reevaluation, and approval from the appropriate stakeholder.

## Extending beyond MCSB

While MCSB is the default standard, Defender for Cloud supports other security standards for organizations with specific compliance requirements. Through the regulatory compliance dashboard, you can add standards such as PCI-DSS, ISO 27001, SOC 2, and NIST SP 800-53.

You can also create custom security initiatives using Azure Policy definitions to address organization-specific requirements. Custom policies appear alongside MCSB recommendations in Defender for Cloud, providing a unified view of compliance across all your security standards.

**Design consideration**: Use MCSB as your operational baseline and add regulatory standards as needed for compliance reporting. This layered approach avoids duplicating assessment effort while meeting all required standards.

The next unit explores how to use Defender for Cloud's secure score to measure and track the progress of your security posture against MCSB and other enabled standards.