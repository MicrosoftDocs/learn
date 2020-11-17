Enterprise-scale architecture helps organizations get ready to take the first step toward cloud migration or to innovate on new workloads in Azure. Enterprise-scale landing zones address three main customer challenges:

- **Architecture complexity**: When an organization lacks the required level of understanding and experience on Azure, cloud adoption can be challenging. The mismatch between on-premises infrastructure and cloud-design considerations can create dissonance and friction with adoption planning. Organizations can struggle with the translation of on-premises requirements to Azure concepts, capabilities, and security models. Enterprise-scale architecture aligns technical architecture conversations into eight critical design areas to quickly help organize teams and provide architectural recommendations.

- **Operating compatibility**: Existing approaches and functions for the traditional delivery and management of IT services aren't compatible with the Azure platform and cloud operating models. An organization can face combined constraints where a lack of skills or experience creates a struggle to define the transformation of on-premises operating models to large-scale cloud infrastructure. Traditional IT management models can get lost in translation between cloud concepts, security models, and IT management processes. Organizations need an example continuous integration and continuous delivery (CI/CD) pipeline with an enterprise-scale approach to help them when they're establishing a cloud operating model.

- **Lack of trust and desire for control**: The absence of a detailed, compliant cloud architecture and a well-defined operating model to support such a platform might lead an IT team to distrust Azure and instead try to maintain full control. This desire for control often involves building walls and complicated processes, which ultimately get in the way of business units that are adopting Azure. The goal of enterprise-scale landing zones is to provide the right level of control to reduce friction between deploying workloads. These landing zones provide guardrails for governance and security, which in turn help ensure compliant and secure subscription landing zones for customer production workloads.

## What must be true for success

To build a sustainable cloud platform on Azure, an organization should establish the following practices:

- **Platform architecture in production**: Ensure that key foundational services, such as identity and access management, security, networking, monitoring, and shared infrastructure services, are in place. For example:

  - Follow an Azure native-first design approach.
  - Align architecture with the Azure product lifecycle and roadmap.
  - Design management and governance for scale.

- **Cloud operating model**: To support the platform architecture, ensure that a cross-functional capability combining engineering and operations is in place. Cloud operation teams should have the required skillsets, understand best practices, and have a consistent toolset for day-to-day operations.

- **Democratization**: Ensure that subscriptions, aligned with the platform architecture, are unblocked and provided to business units for the design, development, and testing that are needed to migrate workloads.

- **Application-centric migration**: An organization must support both existing application migrations and new application development, without discriminating between infrastructure as a service (IaaS) or platform as a service (PaaS) approaches. At the same time, the organization must provide a consistent experience for both AppOps (centrally managed applications) and DevOps (dedicated application teams) across the previously outlined design and architecture.

## What must be designed and built

The following considerations are included in the scope of enterprise-scale architecture and reference implementation that organizations must address for successful cloud adoption.

- Platform operations and management
- Platform DevOps
- Subscription organization and governance
- Application landing zones
- Identity and access management
- Policy management
- Security and compliance
- Network topology and connectivity
- Shared services infrastructure
- Business continuity and disaster recovery
- Service management
- Service catalog

## Continuous engineering and migration

To design an architectural platform isn't enough. The organization not only must implement and maintain the platform, but it also must design a systematic architectural and technical delivery approach to building patterns for success on the platform. The delivery team must build environments that meet these requirements as it applies Azure best practices.

The organization must develop a continuous engineering loop to ensure that environment lifecycles align with the Azure roadmap. It should validate new services in the context of enterprise controls, and it should channel its learnings back to the platform.
