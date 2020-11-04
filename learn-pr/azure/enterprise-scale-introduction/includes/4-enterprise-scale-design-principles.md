Just like organizing books in a library follows a set of design principles, so does organizing resources in subscriptions. Enterprise-scale architecture includes a reference implementation of the infrastructure as code CI/CD pipeline, which helps organizations establish a cloud operating model. The enterprise-scale architecture and reference implementation help organizations not only meet the criteria of success for cloud adoption, but also meet requirements for what must be true for success with continuous engineering. Familiarize yourself with these principles to understand their impact and the trade-offs associated with nonadherence.

## Subscription democratization

Subscriptions are units of management and scale that are aligned with the business goals and priorities. Avoid maintaining centralized control and manage subscription, and allow business units to manage subscriptions themselves. The governance model of an enterprise-scale approach ensures that when subscriptions are created or moved to different management groups, Azure policies are applied to provide the necessary guardrails.

- Subscriptions as unit of management and scale
- Subscriptions as unit of cost
- Agility for business units

## Policy-driven governance

Azure Policy provides guardrails for subscriptions to ensure the continued compliance of an organization's platform and applications, while also providing application owners with sufficient freedom and an security, unhindered path to the cloud. Governance rules should be defined in code to create guardrails authoritatively across the platform. Organizations declare the intent of the policy, and effects like deploy-if-not-exists and deny policies are ensure a compliant resource configuration and prevent configuration drift.

- Management group level policies
- Infrastructure deployment by policy

## Single control and management plane

An enterprise-scale architecture should not rely on abstraction layers such as internally developed portals or tooling, and should provide a consistent experience for both AppOps (centrally managed operation teams) and DevOps (dedicated application operation teams). It shouldn't differentiate between old and new applications or infrastructure as a service and platform as a service cloud management paradigm. Ultimately, we should provide a safe and secure foundation for all workload types to be deployed on the Azure platform. Azure provides a unified and consistent control plane across all Azure resources and provisioning channels subject to role-based access and policy-driven controls. Azure can be used to establish a standardized set of policies and controls for governing the entire enterprise estate.

- Avoid building abstraction layer and orchestration services
- Use Azure as single control and management plane

## Application-centric and archetype-neutral

Enterprise-scale architecture should focus on application-centric migrations and development rather than a pure infrastructure lift-and-shift migration (such as migrating virtual machines by virtual machines), and should not differentiate between old and new applications or IaaS and PaaS applications.

- Group application components together
- Support for migration and net-new development
- Group workloads based on compliance needs

## Align Azure-native design and platform roadmap

Enterprise-scale architecture strongly favors using native platform services and capabilities wherever possible, fully aligned with Azure platform roadmaps from the outset to ensure new capabilities are quickly made available in your environment.

- Use Azure-native services as much as possible
- Stay aware of preview and upcoming features

## Critical design areas

Enterprise-scale design principles are our guide in architectural decisions to reducing friction in cloud adoption and plan for the changes that scale requires. The critical design areas provide a common lexicon between on-premises and cloud platform landing zone design. The following design guidelines helps you translate your requirements to Azure constructs and capabilities. Each critical design area addresses the mismatch between on-premises and cloud-design infrastructure, which typically creates dissonance and friction between the enterprise-scale definition and Azure adoption. A set of subsequent considerations and recommendations for critical design areas helps accelerate architectural design. A high-level overview is provided below. The critical design areas are discussed in more detail in other Microsoft Learn modules about enterprise-scale architecture.

- **Enterprise enrollment and Azure AD tenants**: An Enterprise Agreement (EA) enrollment represents the commercial relationship between Microsoft and how your organization uses Azure. It provides the basis for billing across all your subscriptions and affects administration of your digital estate.

- **Identity and access management**: Identity and access management provides the basis of a large part of security assurance. It enables access based on identity authentication and authorization controls in cloud services to protect data and resources and helps decide which requests should be permitted.

- **Management group and subscription organization**: Management group structures within an Azure Active Directory (Azure AD) tenant must be considered thoroughly when an organization plans Azure adoption at scale. A well-defined management group and subscription organization simplifies the management of Azure Policy and role-based access control (RBAC) assignments.

- **Network topology and connectivity**: There are key design considerations and recommendations surrounding networking and connectivity to, from, and within Azure. Network topology is a critical element of an enterprise-scale architecture because it defines how applications can communicate with each other.

- **Management and monitoring**: Management and monitoring presents key recommendations for central teams to maintain operational visibility within a large-scale Azure platform. Key considerations for operationally maintaining an Azure enterprise estate with centralized management and monitoring at a platform level.

- **Business continuity and disaster recovery**: Organizations capture disaster recovery (DR) requirements to design suitable platform-level capabilities that application workloads can consume to reach the specific recovery time objectives (RTO) and recovery point objectives (RPO) in Azure.

- **Security, governance and compliance**: This critical design area covers encryption and a framework to assess the enterprise security readiness of Azure services.

- **Platform automation and DevOps**: Many traditional IT operating models aren't compatible with the cloud. In this section, we look at planning for a platform DevOps approach, as well as central and federated responsibilities.
