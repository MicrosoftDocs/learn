Microsoft Defender for Cloud provides continuous compliance assessment across your multicloud environment. As a security architect, you design how Defender for Cloud monitors compliance posture, identifies gaps, and integrates with your broader compliance architecture to provide evidence for audits and regulatory inquiries.

## Defender for Cloud compliance capabilities

Defender for Cloud offers several capabilities that support compliance evaluation and monitoring:

| Capability | Purpose | Design Consideration |
|-----------|---------|---------------------|
| **Regulatory compliance dashboard** | Visualize compliance status against selected standards | Choose standards that align with your regulatory obligations |
| **Security recommendations** | Identify configuration gaps that affect compliance | Prioritize recommendations by compliance impact |
| **Secure score** | Quantify overall security posture | Track score trends to measure compliance improvement |
| **Continuous export** | Send compliance data to external systems | Design integration with SIEM and reporting tools |
| **Workflow automation** | Trigger responses to compliance changes | Automate notification and remediation workflows |

Understanding these capabilities helps you design a compliance monitoring architecture that provides visibility across your entire infrastructure.

:::image type="content" source="../media/defender-cloud-regulatory-compliance.png" alt-text="Screenshot of the Microsoft Defender for Cloud regulatory compliance card on the home page." lightbox="../media/defender-cloud-regulatory-compliance.png":::

## Designing your compliance assessment strategy

When you enable Defender for Cloud, the Microsoft cloud security benchmark (MCSB) v2 is automatically assigned as the default security initiative. MCSB v2 organizes security controls into 12 domains—including Network Security, Identity Management, Data Protection, and the new Artificial Intelligence Security domain—that Defender for Cloud evaluates automatically against your resources. This benchmark maps to common compliance frameworks including NIST SP 800-53, PCI-DSS, CIS Controls, and ISO 27001, providing a foundation for your compliance assessment.

Because MCSB v2 is applied by default, you get immediate visibility into your security posture without additional configuration. As you address recommendations, your compliance percentage improves across all mapped frameworks simultaneously.

### Selecting additional regulatory standards

Defender for Cloud supports multiple regulatory compliance standards beyond MCSB. Design your standard selection based on:

- **Regulatory obligations** - Standards required by law or contract (for example, PCI-DSS for payment processing, HIPAA for healthcare)
- **Industry frameworks** - Voluntary standards that demonstrate security maturity (for example, ISO 27001, SOC 2)
- **Internal policies** - Custom initiatives that reflect organizational security requirements

Add standards to your subscriptions based on which regulations apply to specific workloads. Not all subscriptions need the same standards—production environments handling sensitive data may require more stringent compliance monitoring than development environments.

### Understanding compliance assessments

Each standard contains controls, and each control maps to one or more security assessments. Defender for Cloud evaluates your resources against these assessments and reports:

- **Automated assessments** - Defender for Cloud continuously evaluates resource configurations and reports compliance status automatically
- **Manual assessments** - Some controls require evidence that can't be automated, such as documented procedures or attestations

Design processes to address both assessment types. Automated assessments provide real-time visibility, while manual assessments require periodic review and documentation.

## Multicloud compliance evaluation

Defender for Cloud extends compliance assessment beyond Azure to AWS and GCP environments, providing unified visibility across your multicloud infrastructure.

### Designing multicloud coverage

When designing multicloud compliance monitoring:

- **Connect cloud accounts** - Onboard AWS accounts and GCP projects to Defender for Cloud using native connectors
- **Apply consistent standards** - Assign the same regulatory standards across cloud providers for unified reporting
- **Understand coverage differences** - Some assessments may have different implementations or coverage across cloud providers

This unified approach enables you to evaluate compliance posture across your entire infrastructure from a single dashboard, supporting the multicloud scenario described in this module's introduction.

## Integrating with your compliance architecture

Defender for Cloud serves as a compliance data source that feeds into your broader compliance program. Design integrations that connect Defender for Cloud with other compliance tools:

### Integration with Purview Compliance Manager

Defender for Cloud compliance data flows into Microsoft Purview Compliance Manager, providing a unified view of compliance across:

- Infrastructure compliance (from Defender for Cloud)
- Data compliance (from Microsoft Purview)
- Application compliance (from Microsoft 365)

This integration enables centralized compliance tracking and improvement action management as discussed in the Microsoft Purview unit.

### Export for external reporting

Configure continuous export to send compliance data to external systems:

- **Log Analytics workspace** - Store compliance data for custom reporting and long-term analysis
- **Event Hubs** - Stream compliance events to SIEM solutions or custom monitoring tools

Design your export strategy to support audit requirements and integrate with existing security operations workflows.

## Generating compliance evidence

Regulatory audits require documentation of your compliance status. Defender for Cloud provides several mechanisms for generating evidence:

### Compliance reports

Generate PDF reports that summarize compliance status for specific standards. These reports:

- Provide point-in-time compliance snapshots
- Organize findings by control for auditor review
- Document which assessments pass, fail, or require manual attestation

Design a process for generating and archiving these reports at regular intervals and before audit periods.

### Historical compliance data

Use Log Analytics to maintain historical compliance data that demonstrates:

- Compliance posture over time
- Remediation of identified issues
- Continuous monitoring and improvement

This historical record supports audit inquiries about your compliance program's effectiveness.

## Automating compliance responses

Defender for Cloud's workflow automation enables you to respond automatically to compliance changes:

### Notification workflows

Design workflows that alert appropriate stakeholders when:

- Compliance status changes for critical controls
- New noncompliant resources are detected
- Compliance score drops below defined thresholds

### Remediation workflows

Integrate with Azure Logic Apps to trigger remediation actions:

- Create tickets in your ITSM system for compliance issues
- Invoke Azure Automation runbooks to remediate common misconfigurations
- Notify resource owners to address compliance gaps

## Aligning with Zero Trust principles

Defender for Cloud supports Zero Trust implementation through compliance-focused capabilities:

| Zero Trust Principle | Defender for Cloud Alignment |
|---------------------|------------------------------|
| **Verify explicitly** | Continuous assessment validates resource configurations against security baselines |
| **Use least privilege** | Recommendations identify overly permissive access and suggest restrictions |
| **Assume breach** | Threat protection capabilities detect anomalies and potential compromises |

Design your compliance monitoring to reinforce Zero Trust controls, using Defender for Cloud to validate that your Zero Trust implementation meets regulatory requirements.

## Design considerations for security architects

When designing your Defender for Cloud compliance implementation:

- **Prioritize by risk** - Focus on standards and controls with the highest regulatory and business impact
- **Design for multicloud** - Extend compliance monitoring to all cloud environments for unified visibility
- **Automate evidence collection** - Configure continuous export and regular report generation to support audit readiness
- **Integrate with governance** - Connect Defender for Cloud findings to Compliance Manager for centralized compliance tracking
- **Establish remediation workflows** - Define processes for addressing both automated and manual assessment findings
- **Track trends over time** - Use secure score and compliance percentage trends to demonstrate continuous improvement
