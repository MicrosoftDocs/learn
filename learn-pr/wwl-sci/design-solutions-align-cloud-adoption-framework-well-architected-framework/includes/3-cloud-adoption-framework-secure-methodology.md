The Cloud Adoption Framework (CAF) Secure methodology integrates security into every phase of cloud adoption. It isn't a standalone phase—it's an overlay that applies across Strategy, Plan, Ready, Adopt, Govern, and Manage. Gaps in any phase weaken overall security posture.

As you work through each CAF phase, address security in parallel:

- **Strategy**: Define security objectives aligned with business goals
- **Plan**: Develop security requirements and identify skills gaps
- **Ready**: Prepare secure landing zones and establish security baselines
- **Adopt**: Implement security controls during migration and innovation
- **Govern**: Enforce security policies and maintain compliance
- **Manage**: Operate security monitoring, respond to incidents, and sustain posture

## Core principles: CIA Triad and Zero Trust

The Secure methodology organizes security activities around the CIA Triad and Zero Trust.

The **CIA Triad** provides the model for information protection. Map controls, processes, and metrics to each principle:

- **Confidentiality**: Restrict access to sensitive data through encryption, identity controls, access policies, network segmentation, and data classification.
- **Integrity**: Preserve data correctness through hashing, signing, immutable storage, version control, and secure update supply chains.
- **Availability**: Maintain timely access through redundancy design, fault isolation, autoscaling, backup, and disaster recovery.

Gaps in any single principle create cascading weaknesses. Apply the triad to drive data protection decisions, business continuity engineering, and compliance reporting.

All security activities should follow **Zero Trust** principles:

- **Verify explicitly**: Authenticate and authorize based on all available data points—identity, location, device health, data classification, and anomalies.
- **Use least privilege access**: Limit risk with just-in-time and just-enough-access (JIT/JEA) and risk-based adaptive policies.
- **Assume breach**: Minimize blast radius through segmentation, verify end-to-end encryption, and use analytics for threat detection.

Microsoft provides a Zero Trust adoption framework that aligns with the CAF Secure methodology.

## Key security strategy areas

The Secure methodology identifies four key areas to address when integrating security into your cloud adoption strategy.

### Security posture modernization

Continuously elevate your defenses, detections, and resilience capabilities. Static controls degrade quickly against evolving attacker techniques. Align modernization work with the Zero Trust adoption framework and prioritize based on measurable risk reduction—exposed privileges, insecure configurations, and unmonitored assets. Automate validation through policy, infrastructure as code, continuous compliance scanning, and secure score tracking.

### Incident preparedness and response

Even mature preventive controls can't eliminate intrusion attempts. Implement an end-to-end incident lifecycle covering readiness, detection, triage, containment, eradication, recovery, and post-incident learning. Codify roles, communication channels, and decision authority. Practice tabletop simulations and automate containment actions through orchestrated workflows.

### CIA Triad strategies

Each CIA principle requires a targeted strategy:

- **Confidentiality**: Prioritize data privacy and protection with clear objectives aligned to regulatory compliance. Define data loss prevention (DLP) objectives and establish encryption and access control frameworks.
- **Integrity**: Design data protection controls augmented with automation for policy management, data classification, and update management.
- **Availability**: Define criticality tiers for workloads and establish availability targets that balance cost and performance requirements across the cloud estate.

### Security posture sustainment

Security doesn't end with initial implementation. Continuously review and refine practices to keep up with emerging threats. Track secure score in Microsoft Defender for Cloud, automate drift detection through policy and configuration baselines, and feed incident retrospectives into backlog refinement.

## Security teams and roles

The Secure methodology identifies key security functions:

- **Cloud service provider**: Shared responsibility for underlying platform security
- **Infrastructure and platform teams**: Architecture, engineering, and operations of cloud resources
- **Security architecture and engineering**: Design security controls and posture management
- **Security operations (SecOps/SOC)**: Monitor, detect, respond to, and recover from incidents
- **Security governance, risk, and compliance (GRC)**: Policy enforcement, risk management, and regulatory compliance
- **Security education and awareness**: Training and policy communication across the organization

As a Security Architect, you work across these teams to ensure security is integrated into designs, decisions are informed by risk, and controls are operationally sustainable. Subsequent units build on this foundation by applying these principles to specific solution design areas.
