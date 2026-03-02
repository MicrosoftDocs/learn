
An Azure landing zone is a standardized, Microsoft-recommended approach for setting up Azure environments so workloads can be deployed in a secure, governed, and scalable way.

Rather than being a single Azure resource or service, an Azure landing zone is:

- A reference architecture defined in the Cloud Adoption Framework (CAF)
- A set of design areas covering identity, networking, security, governance, and management
- A scalable, modular, and repeatable environment that every workload can safely "land" in

The architecture is **scalable** because it provides repeatable environments with consistent configuration and controls, regardless of which workloads are deployed. It's **modular** because you can extend or modify specific components as requirements evolve, without redesigning the entire environment.

Think of an Azure landing zone as a prepared runway—it ensures that when workloads are deployed, they inherit the right controls from day one.

:::image type="content" source="../media/understand-azure-landing-zones-no-header.png" alt-text="A diagram representing Azure landing zones." lightbox="../media/understand-azure-landing-zones-no-header.png":::

## Concept vs. deployment: the key distinction

### Azure landing zone as a concept

At the conceptual level, an Azure landing zone is a design blueprint:

- Defined by Microsoft's Cloud Adoption Framework
- Describes how Azure resources should be organized and governed
- Focuses on architecture, not individual services

This conceptual architecture answers questions like:

- How should subscriptions be organized?
- Where should security and governance controls be applied?
- How do identity, networking, and monitoring work together at scale?

### Azure landing zone as a deployment

At the deployment level, organizations implement the conceptual architecture by:

- Creating management group hierarchies
- Assigning Azure Policy and security baselines
- Establishing core networking and monitoring
- Using Infrastructure as Code (IaC) or Microsoft-provided accelerators

You don't deploy "Azure landing zone" as a service—you deploy an environment that follows the Azure landing zone architecture.

## Azure landing zone design areas

The Azure landing zone architecture is organized around eight design areas. Each design area addresses a specific set of decisions that must be made before deploying a landing zone:

| Design area | What it covers |
|-------------|---------------|
| **Azure billing and Microsoft Entra tenant** | Tenant creation, enrollment, and billing structure |
| **Identity and access management** | Authentication, authorization, and privileged access |
| **Resource organization** | Management groups, subscriptions, and naming conventions |
| **Network topology and connectivity** | Hub-spoke or Virtual WAN, DNS, and hybrid connectivity |
| **Security** | Security operations tooling, access control, and Zero Trust |
| **Management** | Monitoring, logging, patching, and operational tooling |
| **Governance** | Policy enforcement, compliance, and cost management |
| **Platform automation and DevOps** | Infrastructure as code, CI/CD pipelines, and automation |

These design areas are interdependent. For example, identity decisions affect security controls, network topology shapes Zero Trust segmentation, and resource organization determines where policies apply. As a cybersecurity architect, understanding all eight areas helps you design security controls that work with the broader landing zone architecture rather than in isolation.

## Platform landing zone vs. application landing zones

### Platform landing zone

A platform landing zone is typically deployed once and provides shared services used by all workloads. It commonly includes:

- Management groups and subscription organization
- Centralized security and governance
- Core networking (hub or Virtual WAN)
- Logging, monitoring, and operational tooling

The platform landing zone forms the foundation of the Azure environment.

### Application landing zones

Application landing zones are deployed many times—usually as subscriptions—where workloads actually run. They:

- Host applications and data
- Inherit policies, security controls, and guardrails from the platform landing zone
- Allow workload teams to move fast without bypassing governance

This separation between platform and application landing zones enables scale while maintaining control.

## How Azure landing zones support security

Azure landing zones are a critical enabler for Microsoft security services, including:

- Microsoft Entra ID (identity and access management)
- Microsoft Defender for Cloud (security posture and workload protection)
- Microsoft Sentinel (SIEM and SOAR)
- Azure Policy (governance and compliance enforcement)

By applying security and governance at the management group level, landing zones ensure that:

- Security controls are consistent
- New subscriptions inherit protections automatically
- Zero Trust principles are enforced by design

## Azure landing zone architecture

For many organizations, the Azure landing zone architecture below represents the destination in their cloud adoption journey. It's a mature, scaled-out target architecture intended to help organizations operate successful cloud environments that drive their business while maintaining best practices for security and governance.

This architecture represents scale and maturity decisions based on a wealth of lessons learned and feedback from customers who have adopted Azure as part of their digital estate.

While your specific implementation might vary, as a result of specific business decisions or existing investments in tools that need to persist in your cloud environment, this architecture helps set a direction for the overall approach your organization takes to designing and implementing a landing zone.

Use this architecture as a starting point. Download the Visio file and modify it to fit your specific business and technical requirements when planning your landing zone implementation.

:::image type="content" source="../media/azure-landing-zone-architecture-diagram-hub-spoke.png" alt-text="A reference architecture diagram of an Azure landing zone." lightbox="../media/azure-landing-zone-architecture-diagram-hub-spoke.png":::