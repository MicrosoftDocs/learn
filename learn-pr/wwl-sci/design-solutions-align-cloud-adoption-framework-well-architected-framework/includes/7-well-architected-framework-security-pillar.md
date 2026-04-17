Unit 6 introduced the Well-Architected Framework and its five pillars. This unit focuses on the security pillar—the pillar most directly relevant to cybersecurity architects designing solutions in Azure.

The security pillar provides guidance for protecting the confidentiality, integrity, and availability of a workload. It's built on a Zero Trust foundation and organized around five design principles that guide every security decision you make for a workload.

## Security design principles

The security pillar defines five design principles. Each principle addresses a critical aspect of workload security:

| Principle | What it means |
|-----------|---------------|
| **Plan your security readiness** | Create a security plan aligned with business priorities. Define segmentation boundaries, establish incident response procedures, understand compliance requirements, and set team-level security standards. |
| **Design to protect confidentiality** | Prevent exposure of sensitive data through strong access controls, data classification, and encryption at rest, in transit, and during processing. Guard against data exfiltration and maintain audit trails. |
| **Design to protect integrity** | Prevent corruption of design, implementation, operations, and data. Implement controls against tampering of business logic, deployment processes, and supply chain components. Use cryptographic techniques to verify trust. |
| **Design to protect availability** | Prevent or minimize downtime from security incidents. Protect against resource exhaustion attacks, prevent compromised identities from misusing access, and ensure recovery resources have the same security rigor as primary systems. |
| **Sustain and evolve your security posture** | Continuously improve security operations. Measure your posture, enforce policies, validate mitigations, and apply lessons learned from incidents. Your security posture must not degrade over time. |

These principles map directly to the CIA triad—confidentiality, integrity, and availability—with planning and sustainment framing the lifecycle. As a cybersecurity architect, you apply these principles when designing security for individual workloads deployed into your landing zones.

## What the security pillar covers

The security pillar's guidance is organized into layers that help you build, protect, and validate workload security:

**Create a security foundation:**

- Establish a security baseline for your workload
- Secure your development lifecycle
- Classify data by sensitivity and risk
- Monitor workload security through threat detection
- Perform threat modeling to identify attack vectors

**Protect workload assets:**

- Segment components to limit blast radius
- Manage identities and access using least-privilege principles
- Protect the network through segmentation and perimeter controls
- Use encryption to safeguard data
- Harden resources and guard application secrets

**Validate and improve security:**

- Perform security testing (penetration testing, code scanning)
- Plan and practice incident response

Each layer builds on the previous one. You can't protect assets effectively without a foundation, and you can't validate security without knowing what you're protecting.

## Zero Trust as the security foundation

The security pillar treats Zero Trust as the default security model, not an optional strategy. Every design principle references Zero Trust concepts:

- **Verify explicitly**: Authenticate and authorize based on all available data points—identity, location, device health, data classification
- **Use least-privilege access**: Limit access with just-in-time and just-enough-access policies, risk-based adaptive policies, and data protection
- **Assume breach**: Minimize blast radius through segmentation, verify end-to-end encryption, and use analytics for threat detection

When designing workload security, apply these principles at every layer—identity, network, data, application, and infrastructure. The security pillar provides specific guidance for implementing Zero Trust across each layer.

## Shared responsibility in practice

The security pillar reinforces that workload security is a shared responsibility between your organization and the cloud provider. Understanding this boundary is essential for designing complete security coverage.

As you move from IaaS to PaaS to SaaS, more security responsibility shifts to the cloud provider. However, your organization always retains responsibility for:

- Data classification and protection
- Identity and access management
- Application-level security controls
- Compliance with regulatory requirements

The cloud provider handles physical security, hypervisor security, and (for PaaS/SaaS) portions of infrastructure and platform security. Design your workload security to address the responsibilities that remain with your organization, and verify that the cloud provider meets your requirements for the rest.

:::image type="content" source="../media/shared-responsibility-model.png" alt-text="Diagram of the cloud shared responsibility model." lightbox="../media/shared-responsibility-model.png":::

## AI workload security

AI workloads introduce attack surfaces that traditional security controls don't fully address. The security pillar provides dedicated guidance for these scenarios:

- **Prompt injection**: Malicious inputs designed to manipulate model behavior or extract unauthorized information. Design input validation and output filtering as defense layers.
- **Training data protection**: Protect the confidentiality of datasets during collection, storage, and training to prevent data leakage through model outputs.
- **Model integrity**: Implement controls to prevent unauthorized access or modification of model weights and parameters.
- **Inference security**: Monitor inference endpoints for data exfiltration patterns and implement rate limiting and anomaly detection.

Zero Trust principles apply directly to AI workloads—verify all requests to AI endpoints, restrict model access to authorized users, and assume that content filtering on outputs is necessary.

The shared responsibility model also extends to AI. Microsoft publishes an [AI shared responsibility model](/azure/security/fundamentals/shared-responsibility-ai) that defines how responsibilities shift depending on the AI deployment type. With SaaS AI solutions (such as Microsoft 365 Copilot), Microsoft manages the model, infrastructure, and platform safety systems. With PaaS solutions (such as Azure OpenAI Service), your organization takes on extra responsibility for model selection, prompt engineering, and application-level safety controls. For custom-built models, you own the full AI stack. Regardless of deployment type, your organization remains responsible for data governance, access management, compliance, and ensuring AI outputs are reviewed and used appropriately.

:::image type="content" source="../media/ai-shared-responsibility-v2.png" alt-text="Diagram of the AI shared responsibility model." lightbox="../media/ai-shared-responsibility-v2.png":::

## Connecting the pillar to design decisions

The security pillar's principles and guidance inform the workload-level security decisions you make as a cybersecurity architect. While Azure landing zones provide the platform-level security foundation (baseline policies, network perimeter, centralized monitoring), the security pillar guides how you design security *within* each workload.

In subsequent units, you apply these principles when designing specific security solutions—translating the pillar's guidance into architectural decisions for identity, data protection, network security, and security operations.