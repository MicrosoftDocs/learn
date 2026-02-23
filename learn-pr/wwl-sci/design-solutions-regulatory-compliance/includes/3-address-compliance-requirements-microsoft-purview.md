Microsoft Purview provides a unified platform for data security, governance, and compliance. As a security architect, you design how Purview solutions work together to address the compliance requirements identified in your governance process—from data protection and privacy to AI governance and audit readiness.

## The Microsoft Purview portfolio

Microsoft Purview combines multiple solution areas to address compliance requirements across your organization's data estate:

| Solution Area | Purpose | Key Solutions |
|--------------|---------|---------------|
| **Data security** | Protect sensitive data across its lifecycle | Information Protection, Data Loss Prevention, Insider Risk Management |
| **Data governance** | Manage and catalog data across your estate | Data Map, Unified Catalog |
| **Data compliance** | Meet regulatory requirements and prepare for audits | Compliance Manager, Audit, eDiscovery, Records Management |

Understanding how these solutions map to specific compliance requirements helps you design an integrated architecture rather than deploying isolated tools.

:::image type="content" source="../media/purview-compliance-dashboard.png" alt-text="Screenshot of the Microsoft Purview dashboard on the home page." lightbox="../media/purview-compliance-dashboard.png":::


## Addressing data protection requirements

Most compliance frameworks require organizations to identify, classify, and protect sensitive data. Purview Information Protection provides the foundation for these requirements.

**Sensitive information types** identify regulated data like payment card numbers, health records, or personal identifiers using built-in patterns or custom definitions. **Trainable classifiers** extend this capability by learning to recognize sensitive content based on examples you provide—useful for organization-specific data like internal financial reports or proprietary designs.

**Sensitivity labels** apply protection based on classification:

- Encryption that travels with the document regardless of location
- Access restrictions limiting who can view or edit content
- Visual markings that remind users of data sensitivity
- Automatic application based on detected sensitive content

When designing your labeling strategy, consider:

- **Label taxonomy** - Design labels that align with your data classification policy and regulatory requirements
- **Automatic vs. manual labeling** - Balance user autonomy with consistent protection for high-sensitivity data
- **Scope and inheritance** - Define how labels apply across files, emails, containers, and schematized data

## Preventing unauthorized data sharing

Regulations often require controls to prevent unauthorized disclosure of sensitive information. **Microsoft Purview Data Loss Prevention (DLP)** monitors and controls how sensitive data is shared across Microsoft 365 services, endpoints, and cloud apps.

Design your DLP policies to address specific regulatory requirements:

- **Policy conditions** - Define what sensitive data to protect based on sensitive information types, labels, or content patterns
- **Policy locations** - Specify where monitoring occurs (Exchange, SharePoint, OneDrive, Teams, endpoints, Defender for Cloud Apps)
- **Policy actions** - Configure responses from audit-only monitoring to blocking with user override to complete restriction

DLP integrates with your sensitivity labels, so protection can follow content based on its classification. This integration is particularly valuable for requirements that mandate different handling based on data sensitivity levels.

## Supporting audit and investigation requirements

Compliance frameworks require organizations to maintain audit trails and respond to legal or regulatory inquiries. Purview provides several solutions for these requirements:

**Microsoft Purview Audit** captures user and admin activities across Microsoft 365 services. Design your audit strategy to:

- Enable appropriate audit logging levels based on regulatory requirements
- Configure retention periods that meet legal hold obligations
- Establish processes for searching and exporting audit data for investigations

**Microsoft Purview eDiscovery** helps you identify, preserve, collect, and export content for legal matters. For compliance purposes, design workflows that:

- Create legal holds to preserve relevant content
- Define search criteria that capture required data without over-collection
- Export content in formats suitable for regulatory review

**Microsoft Purview Records Management** applies retention and deletion policies to meet recordkeeping requirements. Consider how file plans, retention labels, and disposition reviews align with your regulatory obligations.

## Managing insider risk

Some regulations require controls to detect and respond to insider threats. **Microsoft Purview Insider Risk Management** uses signals from across Microsoft 365 and third-party systems to identify risky user activities.

Design your insider risk program to:

- Define policies aligned with your compliance objectives (data theft, security violations, policy violations)
- Configure appropriate thresholds that balance detection sensitivity with investigation capacity
- Integrate with your incident response processes for timely remediation

## Addressing AI compliance requirements

As discussed in the AI compliance considerations unit, organizations deploying AI face specific regulatory requirements around data protection, transparency, and governance. Purview provides capabilities specifically designed for AI scenarios:

**Data Security Posture Management (DSPM)** provides visibility and control for both traditional applications and AI apps. Use DSPM to:

- Discover sensitive data that may be exposed to AI applications
- Monitor how AI apps access and process organizational data
- Identify and remediate data security risks before they become compliance issues

**Microsoft Purview for AI** extends data security protections to generative AI experiences:

- Protect data used by Copilot experiences and custom AI agents
- Apply sensitivity labels to AI-generated content
- Prevent sensitive data from being shared inappropriately through AI interactions

For organizations subject to AI-specific regulations like the EU AI Act or ISO 42001, **Compliance Manager** provides assessment templates that map Purview controls to these requirements.

## Multicloud compliance with Compliance Manager

Compliance Manager serves as the orchestration layer that brings together compliance data from across your environment. It integrates with Microsoft Defender for Cloud to assess compliance across Azure, AWS, and GCP.

When designing your Compliance Manager implementation:

- **Select relevant regulations** - Choose from over 360 templates including industry standards (PCI-DSS, HIPAA), regional requirements (CCPA, LGPD), and AI governance frameworks (EU AI Act, ISO 42001)
- **Map controls to solutions** - Identify which Purview solutions address each control requirement
- **Track improvement actions** - Assign and monitor remediation tasks across your compliance team
- **Generate evidence** - Use automated assessments and manual documentation to build audit-ready compliance records

## Design considerations for security architects

When designing your Purview implementation for compliance:

- **Start with requirements** - Map regulatory requirements to specific Purview capabilities before deploying solutions
- **Design for integration** - Plan how Purview solutions work together (labels driving DLP, classification enabling records management)
- **Automate where possible** - Use automatic classification, policy enforcement, and Defender for Cloud integration to reduce manual effort
- **Plan for AI** - Include AI data protection in your architecture even if current AI adoption is limited
- **Enable continuous monitoring** - Configure dashboards and alerts to detect compliance drift early
