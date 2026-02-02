Azure landing zones provide the foundation for implementing security at scale. As a security architect, you design how security controls are embedded into this foundation—ensuring every workload deployed inherits consistent protection without manual intervention.

This unit focuses on the security design area within landing zones, guiding you through the key decisions that shape your organization's security posture.

## Security as a design area

Security is one of several design areas that define your landing zone architecture. Unlike workload-specific security (which you address later using the Well-Architected Framework), landing zone security establishes the baseline controls that apply across your entire cloud estate.

The security design area intersects with other design areas:

| Design area | Security intersection |
|-------------|----------------------|
| **Identity and access** | Authentication foundation, privileged access management, role definitions |
| **Network topology** | Segmentation boundaries, traffic inspection points, perimeter controls |
| **Resource organization** | Policy scope, compliance boundaries, audit aggregation |
| **Governance** | Policy enforcement, compliance monitoring, drift detection |

Effective security architecture requires collaboration across these areas. Decisions made in network topology affect your ability to implement Zero Trust segmentation. Identity choices determine how you enforce least-privilege access. Resource organization defines where policies apply and how you aggregate security telemetry.

## Key security design decisions

When designing security for landing zones, address these architectural questions:

### Identity and access control

Identity forms your primary security perimeter in cloud environments. Design decisions include:

- **Authentication strategy**: How do users and services authenticate? Consider federated identity, certificate-based authentication, and managed identities for workloads.
- **Privileged access model**: How do you control administrative access? Design for just-in-time elevation, approval workflows, and session monitoring.
- **Authorization boundaries**: How do you scope permissions? Consider role-based access control (RBAC) inheritance through your management group hierarchy.

Apply Zero Trust principles: verify explicitly, enforce least privilege, and assume breach in your identity architecture.

### Network security architecture

Network controls complement identity-based security. Key decisions include:

- **Segmentation strategy**: How do you isolate workloads? Design network boundaries that limit lateral movement and contain potential breaches.
- **Traffic inspection**: Where do you inspect traffic? Determine inspection points for north-south (internet) and east-west (internal) traffic flows.
- **Connectivity model**: How do workloads connect to on-premises resources, the internet, and each other? Design connectivity that enables security monitoring and control.
- **Encryption requirements**: Where do you require encryption in transit? Consider encryption between regions, to on-premises, and within your cloud environment.

### Security operations foundation

Your landing zone should enable effective security operations from day one:

- **Telemetry aggregation**: How do you collect and centralize security logs? Design log routing that ensures visibility across all landing zones while managing costs.
- **Alert routing**: How do security alerts reach the right teams? Consider workload ownership, severity levels, and escalation paths.
- **Incident response**: How do you respond to security events? Ensure your architecture supports investigation, containment, and recovery workflows.

### Governance and compliance

Security governance ensures controls remain effective over time:

- **Policy enforcement**: How do you prevent non-compliant deployments? Design policies that block insecure configurations before resources are created.
- **Compliance monitoring**: How do you detect drift from security baselines? Implement continuous assessment against your security requirements.
- **Audit and reporting**: How do you demonstrate compliance? Design audit trails that support regulatory requirements and security reviews.

## Platform versus workload security responsibilities

Landing zones implement a shared responsibility model between platform teams and workload teams. Clearly defining this boundary prevents gaps and overlaps.

**Platform team responsibilities** (enforced through landing zone design):

- Centralized identity and access management infrastructure
- Network perimeter and segmentation controls
- Security monitoring and log aggregation
- Baseline policies that apply to all workloads
- Incident response coordination and escalation

**Workload team responsibilities** (implemented within application landing zones):

- Application-specific access controls and permissions
- Data classification and protection within their workload
- Workload-specific security monitoring and alerting
- Compliance with platform security policies
- Security testing and vulnerability remediation

Document these responsibilities clearly. Ambiguity creates security gaps.

## Security baseline through policy

Policy-as-code enables you to enforce security requirements automatically across all landing zones. Design your policy strategy to:

- **Prevent insecure configurations**: Deny policies block non-compliant resource deployments before they occur.
- **Enforce security standards**: Require specific security configurations such as encryption, network controls, or diagnostic settings.
- **Enable visibility**: Audit policies identify resources that don't meet security requirements without blocking deployment.
- **Auto-remediate drift**: Deploy-if-not-exists policies automatically apply required configurations.

Organize policies through your management group hierarchy. Platform-wide policies apply at higher levels, while workload-specific policies apply closer to application landing zones.

## Greenfield versus brownfield considerations

Your approach differs based on whether you're building a new environment or securing an existing one.

**Greenfield (new environment)**:

- Start with a reference architecture that embeds security controls
- Deploy security infrastructure before workloads
- Establish policy guardrails before teams begin deploying
- Design for your target security posture from the beginning

**Brownfield (existing environment)**:

- Assess current security posture against your target state
- Prioritize gaps based on risk—exposed privileges, missing encryption, unmonitored assets
- Implement policies in audit mode first to understand impact
- Plan remediation in phases to avoid business disruption

Both approaches benefit from infrastructure as code. Codified landing zones ensure security controls are consistently applied and can be version-controlled, reviewed, and tested.

## Designing for security sustainment

Security isn't complete at deployment. Design your landing zone to support ongoing security operations:

- **Continuous posture assessment**: Integrate security scoring and recommendations into operational workflows
- **Automated compliance reporting**: Generate compliance evidence without manual effort
- **Drift detection**: Alert when resources deviate from security baselines
- **Update management**: Design for security patching across your cloud estate

Build feedback loops that connect security findings to landing zone improvements. Incident learnings should drive policy updates. Vulnerability trends should inform baseline changes.
