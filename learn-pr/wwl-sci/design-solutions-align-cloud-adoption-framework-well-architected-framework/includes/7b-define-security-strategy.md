The previous unit showed how to evaluate an existing security posture and design a strategy from the findings. But what if your organization lacks a formal security strategy altogether? Organizations adopting cloud for the first time, startups scaling beyond their initial infrastructure, and enterprises that historically relied on implicit security practices all face the same challenge—they need to design a security and governance strategy before they can evaluate against one.

This unit covers how to design a new strategy for security and governance based on the Cloud Adoption Framework (CAF) and the Well-Architected Framework (WAF). CAF provides the organizational and lifecycle structure—how to plan, adopt, govern, and manage security across your cloud estate. WAF provides the architectural quality standards—what security properties your workloads must exhibit. A comprehensive strategy draws on both: CAF shapes the strategic direction and governance model, while WAF defines the security requirements that workloads must satisfy.

## Recognize when you need a new strategy

Defining a new security strategy is appropriate when one or more of these conditions exist:

- **No documented security strategy**: Security decisions are made without a guiding framework.
- **On-premises-only strategy**: The existing strategy doesn't address cloud-specific threats, shared responsibility models, or identity-centric perimeters.
- **Major transformation**: The organization is undergoing a significant shift—such as a first cloud adoption, a merger, or a move to a new operating model—that invalidates prior assumptions.
- **Regulatory change**: New compliance requirements demand a fundamentally different security approach rather than incremental adjustments.

If a documented cloud security strategy already exists, use the evaluation approach from the previous unit instead. Defining a new strategy and evaluating an existing one are complementary activities—most organizations cycle between both as their environment evolves.

## Address organizational readiness

Cloud security requires a broader set of participants than traditional on-premises models. Before defining technical strategy components, address the organizational foundations:

**Evolve the security mindset.** In on-premises environments, the attack surface is primarily at the network perimeter. In cloud environments, every resource is a potential attack vector. Security teams need to shift from perimeter-focused defense to an identity-centric, data-aware model that assumes breach rather than prevention alone.

**Align teams and roles.** Cloud security involves specialized functions that may not exist in your current structure—cloud security architecture, DevSecOps, security posture management, and threat intelligence. Map existing skills to required functions and identify gaps early. The CAF Secure methodology provides guidance on [security teams, roles, and functions](/azure/cloud-adoption-framework/secure/teams-roles) to help structure these responsibilities.

**Secure executive sponsorship.** A security strategy without executive backing becomes a document that nobody follows. Ensure leadership understands the business rationale—risk reduction, compliance enablement, and business agility—and commits resources for implementation.

## Define strategy components

The CAF Secure methodology organizes security strategy into six components. Each addresses a distinct aspect of your security posture and together they form a comprehensive strategy. As you define each component, the WAF security pillar provides the architectural requirements that translate strategic intent into workload-level design decisions.

### Security posture modernization

Security posture modernization means continuously improving your defensive capabilities to keep pace with evolving threats. This component addresses:

- **Asset visibility**: You can't protect what you can't see. Establish a comprehensive inventory of identities, devices, applications, data, and infrastructure across cloud and on-premises environments.
- **Configuration baselines**: Define secure configuration standards for each asset category. Use the Microsoft Cloud Security Benchmark as a control framework to establish baseline requirements across 12 security domains—from network security and identity management to data protection and AI workload security. At the workload level, WAF checklist item SE:01 reinforces this by requiring a security baseline aligned to compliance requirements, industry standards, and platform recommendations.
- **Continuous assessment**: Implement automated tools that measure posture against your baselines. *Microsoft example: Microsoft Defender for Cloud provides cloud security posture management (CSPM) with secure score and regulatory compliance dashboards.*

#### Adopt Zero Trust as a strategic foundation

The CAF Secure methodology positions Zero Trust adoption as a core element of posture modernization. Rather than a product or technology, Zero Trust is a set of principles that guide every security decision:

- **Verify explicitly**: Authenticate and authorize every access request based on all available signals—identity, location, device health, service or workload, data classification, and anomalies.
- **Use least privilege**: Limit access with just-in-time and just-enough-access policies, risk-based adaptive controls, and data protection requirements tied to sensitivity levels.
- **Assume breach**: Minimize blast radius through segmentation. Verify end-to-end encryption. Use analytics to detect threats and improve defenses proactively.

These principles apply across all six pillars of a Zero Trust architecture: identities, devices, applications, data, infrastructure, and networks. When defining your strategy, map each principle to specific controls within each pillar rather than treating Zero Trust as an abstract goal. The WAF security design principle "plan your security readiness" explicitly requires accounting for Zero Trust and the CIA Triad when creating a workload-level security readiness plan.

### Incident preparedness

No security strategy eliminates all risk. Your strategy must account for how the organization responds when incidents occur:

- **Detection capabilities**: Define monitoring coverage requirements for each environment—cloud workloads, identity systems, network traffic, and endpoint activity. Specify detection time targets for critical threat categories.
- **Response procedures**: Establish incident response plans that define roles, communication channels, escalation paths, and decision authority. Include procedures for both contained incidents (single-workload compromise) and broad-impact scenarios (identity provider compromise, supply chain attack). WAF checklist item SE:12 requires workload-specific incident response procedures covering localized issues through disaster recovery.
- **Recovery objectives**: Set recovery time objectives (RTO) and recovery point objectives (RPO) for security-related outages. Define what "recovered" means for each critical system—restored operations, confirmed absence of persistence mechanisms, and validated integrity of data.
- **Practice and refinement**: Conduct tabletop exercises and simulated attacks regularly. Update response procedures based on lessons learned and emerging threat intelligence.

### Confidentiality strategy

Confidentiality ensures that sensitive information is accessible only to authorized entities. WAF checklist items SE:03 (classify and label data by sensitivity) and SE:07 (encrypt data using modern standards aligned to classification) provide the workload-level implementation requirements for this component. Your strategy should define:

- **Data classification**: Establish classification levels (public, internal, confidential, highly confidential) and the criteria for assigning each level. Classification drives all downstream protection decisions.
- **Data protection controls**: Map specific protection mechanisms to each classification level—encryption at rest and in transit, access controls, data loss prevention policies, and information barriers.
- **Regulatory alignment**: Identify which data falls under regulatory requirements (HIPAA, PCI-DSS, industry-specific mandates) and ensure your classification and protection scheme satisfies those obligations.
- **Lifecycle management**: Define how data is handled from creation through disposal, including retention policies and secure deletion procedures.

### Integrity strategy

Integrity means that data, configurations, and systems remain trustworthy and unaltered by unauthorized activity. WAF checklist items SE:02 (maintain a hardened software supply chain) and SE:08 (harden workload components by reducing surface area) translate integrity principles into workload design requirements:

- **Configuration drift prevention**: Establish automated policy enforcement that detects and remediates configuration drift from approved baselines. *Microsoft example: Azure Policy continuously evaluates resource configurations against policy definitions and flags or autoremediates noncompliant resources.*
- **Change control**: Implement auditable change management processes for infrastructure and application code. Every change to security-relevant configurations should be traceable to an authorized request.
- **Supply chain security**: Verify the integrity of software components, container images, and infrastructure-as-code templates before deployment. Maintain a software bill of materials (SBOM) for critical workloads.
- **Data integrity verification**: Implement controls that detect unauthorized modification of data—checksums, digital signatures, and immutable storage where regulatory or business requirements demand it.

### Availability strategy

Availability ensures that systems and data remain accessible to authorized users when needed. While WAF addresses availability primarily through its reliability pillar, security-related availability threats—ransomware, denial of service, destructive attacks—require explicit treatment in your security strategy:

- **Criticality assessment**: Classify workloads by business criticality and assign availability targets accordingly. Not every system requires the same level of resilience investment.
- **Resilience design**: Define architectural patterns for each criticality tier—redundancy, failover, load distribution, and geographic distribution. Align resilience patterns with your availability targets.
- **Denial-of-service protection**: Include protection against volumetric and application-layer attacks as a baseline requirement for internet-facing workloads.
- **Backup and recovery**: Establish backup strategies that protect against both operational failures and security incidents such as ransomware. Ensure recovery procedures are tested and recovery times meet defined objectives.

### Sustainment

A security strategy fails if it only addresses today's environment. Sustainment ensures your strategy remains effective over time:

- **Continuous improvement cadence**: Define review cycles—quarterly for metrics and priorities, annually for full strategy review, and event-driven updates after significant incidents or organizational changes.
- **Threat landscape monitoring**: Assign responsibility for tracking emerging threats and technologies that could affect your security posture, including new attack techniques and evolving regulatory requirements.
- **Skill development**: Plan for ongoing training and skills investment as cloud services and threat tactics evolve. Security knowledge has a short half-life; build learning into your operating model.

## Structure the strategy document

Bring these components together into a documented strategy that maps CAF lifecycle phases to WAF quality requirements. The document should be something stakeholders can reference and act on:

1. **Business context**: State the business drivers, risk appetite, and compliance obligations that shape security priorities.
2. **Principles**: Define the security principles (Zero Trust, defense in depth, least privilege) that guide all decisions.
3. **Strategy components**: Document posture modernization, incident preparedness, confidentiality, integrity, availability, and sustainment objectives with measurable targets. Reference the specific MCSB controls and WAF checklist items (SE:01–SE:12) that each objective addresses.
4. **Scope mapping**: Assign each objective to the appropriate scope—strategy (CAF Secure methodology), platform (landing zones and MCSB), or workload (WAF security checklist)—so that the right teams own the right objectives. CAF-scope objectives address organizational direction and governance. Platform-scope objectives address infrastructure controls. Workload-scope objectives address the architectural requirements defined by WAF.
5. **Phased roadmap**: Sequence implementation based on risk, business impact, and dependencies. Use the prioritization criteria discussed in the previous unit's gap analysis.
6. **Success metrics**: Define how you measure progress—secure score targets, compliance percentages, mean time to detect, mean time to respond, and coverage metrics for each strategy component.

The strategy document doesn't need to be lengthy. Clarity and actionability matter more than comprehensiveness. A concise strategy that teams actually follow is more effective than a detailed document that sits unread.

With a security and governance strategy defined—whether from evaluation findings (previous unit) or from the ground up (this unit)—the next step is recommending specific solutions that implement each capability your strategy requires.
