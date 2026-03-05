Previous units introduced the Cloud Adoption Framework, Azure landing zones, and the Well-Architected Framework as guidance for building a secure cloud environment. This unit brings those frameworks together as both evaluation instruments and strategy design tools—first measuring whether your current security posture aligns with framework standards, then translating findings into a comprehensive security strategy.

A sound security strategy starts with knowing where you stand. The first half of this unit covers structured approaches for assessing security posture at every scope—organizational, platform, and workload. The second half shows how to translate those findings into a security strategy with measurable objectives, clear ownership, and phased implementation.

## Microsoft Cloud Security Benchmark

The [Microsoft Cloud Security Benchmark (MCSB)](/security/benchmark/azure/overview) is the control framework that bridges CAF governance and WAF workload design. It provides prescriptive security recommendations organized into 12 security domains, each containing specific controls with implementation guidance. Each control includes a security principle, the risk it mitigates, MITRE ATT&CK technique mappings, implementation guidance, and a mapping to industry standards.

### How MCSB connects the frameworks

MCSB serves as the technical specification layer that ties the frameworks together:

- **CAF Govern phase**: The CAF references MCSB as the foundation for [security governance policies](/azure/cloud-adoption-framework/govern/enforce-cloud-governance-policies). Organizational security baselines derive from MCSB controls.
- **Azure landing zones**: The landing zone security design area implements MCSB recommendations through policy assignments. The MCSB policy initiative is enabled by default as part of cloud security posture management (CSPM).
- **WAF security pillar**: Service-level security baselines—used during workload design—are derived from MCSB controls. These baselines provide configuration guidance aligned with the benchmark for individual services.

When evaluating an existing environment, MCSB gives you a common control language across all three scopes. When designing a new strategy, MCSB provides the control catalog from which you select and prioritize requirements.

## WAF security design review checklist

The [WAF security design review checklist](/azure/well-architected/security/checklist) provides a structured evaluation for workload-level security. The checklist contains 12 security checks (SE:01 through SE:12) that map to the five design principles covered in the previous unit:

- **SE:01**: Establish a security baseline aligned to compliance, industry standards, and platform recommendations
- **SE:02**: Maintain a hardened, auditable software supply chain with threat modeling
- **SE:03**: Classify and label all workload data and systems by sensitivity
- **SE:04**: Create intentional segmentation in architecture, networks, roles, and identities
- **SE:05**: Implement strict, conditional, and auditable identity and access management
- **SE:06**: Isolate, filter, and control network traffic across ingress and egress flows
- **SE:07**: Encrypt data using modern standards; align scope with data classifications
- **SE:08**: Harden workload components by reducing surface area and tightening configurations
- **SE:09**: Protect application secrets with hardened storage, restricted access, and rotation
- **SE:10**: Implement holistic monitoring with modern threat detection mechanisms
- **SE:11**: Establish comprehensive security testing that validates prevention and detection
- **SE:12**: Define and test incident response procedures covering localized issues through disaster recovery

Use this checklist during design reviews for new workloads and as a periodic assessment instrument for existing ones. Each check includes detailed guidance articles and links to relevant design patterns, helping you translate evaluation findings into specific architectural improvements. When designing a new security strategy, these checks define the minimum security requirements your workload architectures must satisfy.

## Automated posture assessment

Manual evaluation doesn't scale. You need automated capabilities that continuously measure your security posture against framework requirements.

### Cloud security posture management

A CSPM solution provides the primary automated assessment capability. For framework-based evaluation, look for two key functions:

**Secure score** assigns a numerical score based on the number and risk level of open security recommendations across your environment. An effective secure score weights recommendations by asset criticality and risk factors such as internet exposure and data sensitivity, helping you prioritize remediation where it reduces the most risk. When the CSPM assesses resources against MCSB controls, your secure score directly reflects alignment with the benchmark.

**Regulatory compliance assessment** maps your resource configurations against industry standards such as NIST SP 800-53, PCI-DSS v4, CIS Foundations, ISO 27001, HITRUST, CMMC, and others. Each standard shows a compliance percentage broken down by control family, with specific recommendations for each noncompliant resource. Assigning multiple standards simultaneously lets you track compliance trends across regulatory frameworks over time.

### Well-Architected Review

The [Well-Architected Review](/assessments/?id=azure-architecture-review&mode=pre-assessment) is a self-assessment that evaluates individual workloads against all five WAF pillars, including security. The assessment asks targeted questions about your workload architecture and produces a prioritized list of recommendations mapped to checklist items. For AI workloads, a dedicated [AI workload assessment](/assessments/ea306cce-c7fa-4a2b-89a6-bfefba6a9cf4) addresses generative and discriminative AI scenarios.

### Resource-level recommendations

Beyond posture scores and compliance dashboards, your cloud platform provides resource-level recommendations categorized by WAF pillar—including security. These recommendations evaluate the configuration of running resources and complement the Well-Architected Review: where the Review evaluates architecture decisions, resource-level recommendations evaluate deployed configurations.

## Conducting a gap analysis

Use these evaluation methods together to assess your security posture across the three scopes established in previous units:

### Strategy scope (CAF)

Evaluate whether your security strategy addresses each phase of the CAF Secure methodology:

- **Strategy**: Are security objectives documented and aligned with business outcomes?
- **Plan**: Have you identified skills gaps and mapped compliance requirements?
- **Ready**: Does your cloud foundation implement security baselines?
- **Adopt**: Are security controls embedded in deployment processes?
- **Govern**: Do policies enforce security requirements automatically?
- **Manage**: Is security monitoring active with defined incident response procedures?

Gaps at this scope indicate strategic misalignment—areas where your organization lacks direction rather than specific controls.

### Platform scope (MCSB + CSPM)

Use your CSPM solution to assess your landing zone against MCSB controls:

1. Review your secure score to identify the highest-risk open recommendations
2. Check regulatory compliance assessments for any assigned standards with low compliance percentages
3. Focus on controls marked as "Must have" criticality in MCSB that show noncompliance
4. Examine cross-cutting controls (identity, network, data protection) that affect all workloads deployed in the landing zone

Gaps at this scope indicate platform-level controls that need remediation before workloads can inherit a strong security baseline.

### Workload scope (WAF checklist + Well-Architected Review)

Run the Well-Architected Review for each critical workload and evaluate results against the SE:01–SE:12 checklist:

1. Complete the self-assessment for your highest-priority workloads
2. Map findings to specific checklist items to identify which security areas need attention
3. Cross-reference with CSPM recommendations for the same workload resources
4. Review resource-level recommendations to identify configuration improvements

Gaps at this scope indicate workload-specific security weaknesses that the platform baseline doesn't address.

### Prioritize improvements

Not all gaps carry equal risk. Prioritize based on:

- **Risk level**: Address critical and high-risk findings before medium and low
- **Blast radius**: Prioritize platform-scope gaps that affect multiple workloads over single-workload issues
- **Compliance obligations**: Regulatory gaps may carry legal or financial consequences that override risk-based ordering
- **Quick wins**: Some findings require only configuration changes, while others require architectural redesign

Use these priorities as the direct input to your security strategy design.

## Design a security strategy from evaluation findings

Evaluation tells you where you stand. Strategy design determines where you need to go and how to get there. Use your gap analysis results as the primary input for designing or refining your security strategy.

### Define security objectives

Translate your highest-priority gaps into measurable security objectives. Effective objectives are:

- **Business-aligned**: Tie each objective to a business outcome or risk the organization cares about
- **Framework-referenced**: Map each objective to specific MCSB controls, WAF checklist items, or CAF phases so progress is measurable against established standards
- **Time-bound**: Set target dates for achieving specific posture improvements, such as reaching a target secure score or closing all critical-severity findings

For example, a platform-scope gap in network security might produce this objective: "Implement network segmentation controls aligned with MCSB NS-1 through NS-4 for all production landing zones within 90 days."

### Map actions to framework scopes

Structure your strategy so that each action targets the correct scope:

- **Strategy gaps → CAF Secure methodology**: Address missing security direction by documenting security principles, assigning executive sponsorship, and establishing a security strategy that covers all six CAF phases
- **Platform gaps → Landing zone controls**: Remediate infrastructure-level findings by implementing or strengthening controls in the landing zone security design area—identity, networking, governance, and monitoring
- **Workload gaps → WAF security patterns**: Address application-level findings using the design patterns referenced in the SE:01–SE:12 checklist guidance

This mapping prevents the common mistake of applying workload-level fixes to platform-level problems, or treating strategic gaps as purely technical issues.

### Establish governance structures

A security strategy requires clear ownership to execute:

- **Central security team**: Owns security strategy, defines policies, and monitors posture across scopes
- **Platform team**: Implements and maintains landing zone security controls based on MCSB requirements
- **Workload teams**: Design and operate secure workloads within the guardrails the platform provides

Document decision rights, escalation paths, and exception processes. Define how security exceptions are requested, reviewed, and tracked—exceptions without governance become permanent vulnerabilities.

### Phase the strategy

Don't attempt to close all gaps simultaneously. Phase your strategy based on the prioritization criteria from your gap analysis:

1. **Foundation phase**: Close critical platform-scope gaps that affect all workloads—identity, network segmentation, and security monitoring
2. **Compliance phase**: Address regulatory gaps that carry legal or financial consequences
3. **Workload phase**: Remediate workload-specific findings starting with the highest-risk applications
4. **Optimization phase**: Pursue medium and low-risk improvements, automate compliance monitoring, and establish continuous improvement cycles

Each phase should produce measurable posture improvement visible through your CSPM secure score and compliance dashboards.

### Operationalize continuous improvement

A security strategy isn't a one-time document. Build review cadences into the strategy itself:

- **Quarterly**: Review security metrics (secure score trends, compliance percentages, open findings by severity) and adjust priorities
- **After incidents**: Update controls and strategy based on lessons learned
- **Before major changes**: Assess security impact of new workloads, platform changes, or organizational shifts against framework baselines

The evaluation tools described earlier in this unit—CSPM, Well-Architected Review, and resource-level recommendations—become the instruments you use to measure whether your strategy is working and where to course-correct. With your strategy defined, the next step is recommending specific solutions that implement each capability your strategy requires.
