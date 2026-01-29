As a security architect, one of your primary responsibilities is translating compliance requirements into implementable security controls. This process requires understanding the regulatory landscape, applying the shared responsibility model, and designing solutions that align with governance frameworks.

## Understand the shared responsibility model

Before designing compliance solutions, you must understand how responsibilities are divided between cloud providers and your organization. The [shared responsibility model](/azure/security/fundamentals/shared-responsibility) defines which security tasks Microsoft handles and which tasks you handle.

Responsibilities shift based on the cloud service model.

**Compliance implication:** Regardless of service model, you're always responsible for your data, endpoints, identity management, and access controls. When a regulation requires "data encryption at rest," you must determine which encryption controls Microsoft provides by default and which you must configure.

:::image type="content" source="../media/shared-responsibility.png" alt-text="Diagram showing the shared responsibility model." lightbox="../media/shared-responsibility.png":::

## Apply the Cloud Adoption Framework Govern methodology

The [Cloud Adoption Framework Govern methodology](/azure/cloud-adoption-framework/govern/) provides a structured process for translating compliance requirements into enforceable policies. 

:::image type="content" source="../media/cloud-adoption-framework-govern.png" alt-text="Diagram showing the Cloud Adoption Framework governance model." lightbox="../media/cloud-adoption-framework-govern.png":::

This four-step cycle ensures continuous alignment between regulatory requirements and technical controls:

#### Step 1: Assess compliance risks

The first step in translating compliance requirements is understanding which regulations create risk for your organization. Noncompliance can result in financial penalties, legal action, reputational damage, or loss of ability to operate in certain markets. To assess these risks, identify which regulations apply to your organization based on:

- **Geography** - Where you operate and where your customers are located
- **Industry** - Healthcare, financial services, government, or other regulated sectors
- **Data types** - Personal data, payment card data, protected health information

For each applicable regulation, document:

- Specific control requirements (for example, "encrypt data in transit using TLS 1.2 or higher")
- Audit and reporting obligations
- Penalties for noncompliance

#### Step 2: Document governance policies

Convert regulatory requirements into clear policy statements. Each policy should include:

- **Business risk** - The regulatory or business risk being addressed
- **Policy statement** - A clear requirement (for example, "All storage accounts must use customer-managed encryption keys")
- **Technical guidance** - How to implement the policy in Azure

#### Step 3: Enforce policies with technical controls

Implement policies using Azure governance tools:

- **Azure Policy** - Define and enforce configuration standards across resources
- **Management groups** - Apply policies consistently across subscriptions
- **Microsoft Defender for Cloud** - Monitor compliance posture against regulatory standards
- **Microsoft Purview** - Govern data across your entire data estate

#### Step 4: Monitor and refine

Establish continuous monitoring to track compliance status:

- Use Defender for Cloud's regulatory compliance dashboard to measure adherence
- Configure alerts for policy violations
- Review and update policies as regulations change

## Map Zero Trust principles to compliance controls

Zero Trust architecture provides a foundation for meeting regulatory requirements. Each principle aligns with common compliance controls:

| Zero Trust Principle | Compliance Application |
|---------------------|------------------------|
| **Verify explicitly** | Supports access control requirements (ISO 27001 A.9.2), user authentication mandates (NIST 800-53 IA controls) |
| **Use least privilege** | Addresses segregation of duties (SOX), role-based access (PCI-DSS 7.1), need-to-know principles |
| **Assume breach** | Supports incident detection (NIST 800-53 IR controls), logging requirements, breach notification obligations |

When designing solutions, map each regulatory control to the appropriate Zero Trust pillar:

- **Identity** - Authentication, access provisioning, privileged access management
- **Devices** - Endpoint compliance, device health verification
- **Network** - Segmentation, traffic inspection, perimeter controls
- **Applications** - Secure development, API security, application access
- **Data** - Classification, encryption, data loss prevention
- **Infrastructure** - Configuration management, vulnerability management

## Design considerations for compliance solutions

When translating requirements into solutions, consider:

#### Automation vs. manual controls

- **Preventive controls** (Azure Policy deny effects) block noncompliant configurations before deployment
- **Detective controls** (Defender for Cloud assessments) identify existing compliance gaps
- **Corrective controls** (Policy remediation tasks) automatically fix noncompliant resources

Automate where possible to reduce human error and enable consistent enforcement at scale.

#### Evidence collection for audits

Design your solution to automatically capture compliance evidence:

- Enable diagnostic logging on all resources
- Configure log retention to meet regulatory requirements
- Use Defender for Cloud export capabilities to generate compliance reports
- Maintain audit trails for access and configuration changes

#### Multicloud and hybrid considerations

If your organization operates across multiple clouds or maintains on-premises infrastructure:

- Use Microsoft Defender for Cloud's multicloud support to assess compliance across Azure, AWS, and GCP
- Apply consistent policies using tools that span environments
- Ensure your compliance monitoring provides a unified view across all platforms

#### Exception management

Not every resource can meet every policy. Design an exception process that:

- Requires documented business justification
- Includes compensating controls
- Has defined expiration dates
- Is tracked and audited

## Implement a compliance baseline

Start with a minimum viable governance baseline:

- **Assign regulatory compliance initiatives** - Enable built-in initiatives in Defender for Cloud that map to your required frameworks (MCSB, PCI-DSS, ISO 27001)
- **Create a management group hierarchy** - Organize subscriptions to enable consistent policy application
- **Apply foundational policies** - Implement policies for tagging, allowed regions, required encryption, and network security
- **Configure monitoring** - Set up compliance dashboards and alerts for policy violations

This baseline provides immediate visibility into your compliance posture and a foundation for continuous improvement.
