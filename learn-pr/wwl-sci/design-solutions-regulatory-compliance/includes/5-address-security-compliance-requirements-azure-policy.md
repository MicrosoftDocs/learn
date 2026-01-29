Azure Policy enables you to enforce organizational standards and assess compliance at scale across your Azure environment. As a security architect, you design policy solutions that translate compliance requirements into automated controls, preventing noncompliant configurations and providing continuous compliance visibility.

## Azure Policy for compliance enforcement

Azure Policy evaluates resources against business rules defined in JSON format. These rules determine whether resource configurations meet your compliance requirements. When designing your policy architecture, understand the key components:

| Component | Purpose | Design Consideration |
|-----------|---------|---------------------|
| **Policy definitions** | Define individual compliance rules | Map each regulatory control to specific resource properties |
| **Initiative definitions** | Group related policies together | Align initiatives with compliance frameworks or security domains |
| **Assignments** | Apply policies to specific scopes | Design scope hierarchy for consistent enforcement with appropriate exceptions |
| **Exemptions** | Exclude specific resources from policy evaluation | Establish governance for time-limited exemptions with proper documentation |

Understanding how these components work together helps you build a policy architecture that enforces compliance requirements consistently across your environment.

:::image type="content" source="../media/policy-overview.png" alt-text="Screenshot of the Azure Policy dashboard on the overview page." lightbox="../media/azure-policy.png":::


## Designing policy enforcement strategies

Azure Policy provides multiple effects that determine how the platform responds when a resource violates a policy. Choose effects based on your compliance enforcement needs:

### Preventive controls

Preventive effects block noncompliant configurations before they're deployed:

- **Deny** - Prevents resource creation or updates that violate the policy
- **DenyAction** - Blocks specific actions on resources regardless of configuration

Design preventive controls for requirements where noncompliance creates immediate risk, such as:

- Preventing public network access on storage accounts
- Blocking deployment of prohibited VM sizes
- Requiring encryption on database resources

### Detective controls

Detective effects identify noncompliant resources without blocking operations:

- **Audit** - Creates a warning event in the activity log for noncompliant resources
- **AuditIfNotExists** - Audits when a related resource doesn't exist (for example, missing diagnostic settings)

Use detective controls when you need visibility into compliance status before enforcing restrictions, or when business processes require flexibility with oversight.

### Corrective controls

Corrective effects automatically remediate noncompliant configurations:

- **Modify** - Adds, updates, or removes resource properties (for example, adding required tags)
- **DeployIfNotExists** - Deploys related resources when they don't exist (for example, deploying diagnostic settings)
- **Append** - Adds properties to resources during creation or update

Design corrective controls to reduce manual remediation effort and ensure consistent configuration across resources.

## Aligning policies with compliance frameworks

Azure Policy includes built-in regulatory compliance initiatives that map directly to compliance framework requirements. The Microsoft cloud security benchmark (MCSB) provides a foundation that aligns with multiple frameworks:

- CIS Controls
- NIST SP 800-53
- PCI-DSS
- ISO 27001

When designing your policy architecture:

### Start with built-in initiatives

Azure provides regulatory compliance initiatives for common frameworks. Assess these initiatives against your requirements before creating custom policies. Built-in initiatives:

- Map to specific compliance controls with documented coverage
- Receive updates as frameworks evolve
- Integrate with Microsoft Defender for Cloud for centralized reporting

### Extend with custom policies

Create custom policies when built-in definitions don't address your specific requirements. Common scenarios include:

- Organization-specific naming conventions or tagging requirements
- Industry-specific controls not covered by standard frameworks
- Custom resource configurations unique to your environment

### Group policies into initiatives

Design initiatives that align with your compliance structure:

- **Framework-aligned initiatives** - Group all policies for a specific regulation (for example, HIPAA, PCI-DSS)
- **Domain-aligned initiatives** - Group policies by security domain (for example, network security, identity, encryption)
- **Environment-aligned initiatives** - Group policies by environment tier (for example, production, development)

## Designing scope and assignment strategies

Policy scope determines which resources are evaluated. Design your scope strategy to balance consistent enforcement with operational flexibility:

### Management group hierarchy

Design your management group structure to support policy inheritance:

- Assign broad security policies at higher levels (root or platform management groups)
- Assign workload-specific policies at lower levels (landing zone or application management groups)
- Use exclusions sparingly and with documented justification

### Assignment considerations

When assigning policies:

- **Scope appropriately** - Assign at the highest level where the policy applies universally, then use exclusions for exceptions
- **Use parameters** - Design policies with parameters to enable reuse across different scopes with varying requirements
- **Plan for exemptions** - Establish governance processes for policy exemptions including approval workflows, time limits, and documentation requirements

## Evaluating and monitoring compliance

Azure Policy continuously evaluates resources against assigned policies. Design your monitoring approach to provide compliance visibility:

### Compliance evaluation timing

Understand when evaluation occurs to set appropriate expectations:

- New policy assignments evaluate within approximately 5 minutes
- Resource changes evaluate within approximately 15 minutes
- Full compliance scans run every 24 hours

### Compliance states

Resources can be in several compliance states:

- **Compliant** - Resource meets policy requirements
- **Non-compliant** - Resource violates policy conditions
- **Exempt** - Resource is explicitly excluded from evaluation
- **Conflicting** - Multiple policies have incompatible requirements

Design dashboards and alerts based on these states to track compliance posture over time.

## Remediating noncompliant resources

Policies with **DeployIfNotExists** or **Modify** effects can automatically remediate existing noncompliant resources through remediation tasks.

Design your remediation strategy to:

- Prioritize remediation based on risk and compliance impact
- Use managed identities with appropriate permissions for remediation tasks
- Test remediation in nonproduction environments before applying broadly
- Monitor remediation task progress and address failures promptly

## Governing AI workloads with policy

As organizations deploy AI services, Azure Policy enables governance controls specific to these workloads:

- **Network isolation** - Require private endpoints for Azure AI Services
- **Authentication controls** - Disable local authentication in favor of Microsoft Entra ID
- **Encryption requirements** - Enforce customer-managed keys for sensitive AI workloads
- **Service restrictions** - Control which AI service SKUs can be deployed

Use regulatory compliance initiatives such as the EU AI Act initiative to assess compliance status for AI-specific requirements.

## Design considerations for security architects

When designing your Azure Policy implementation:

- **Map requirements to effects** - Choose appropriate effects (deny, audit, modify) based on the criticality of each compliance requirement
- **Design for inheritance** - Structure management groups to enable policy inheritance while supporting necessary exceptions
- **Balance enforcement with agility** - Use audit mode initially to assess impact before enabling deny effects
- **Plan exemption governance** - Establish approval workflows and time limits for policy exemptions
- **Integrate with Defender for Cloud** - Use the regulatory compliance dashboard for centralized visibility across your compliance initiatives
- **Version control policies** - Store custom policy definitions in source control and deploy through CI/CD pipelines
