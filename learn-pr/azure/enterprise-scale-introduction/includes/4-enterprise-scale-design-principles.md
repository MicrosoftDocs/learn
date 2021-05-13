Organizing books in a library follows a set of design principles, as does organizing resources in subscriptions. Enterprise-scale architecture includes a reference implementation of the infrastructure-as-code, continuous integration and continuous delivery (CI/CD) pipeline, which helps organizations establish a cloud operating model. 

Enterprise-scale architecture and reference implementation help organizations meet not only the criteria of success for cloud adoption, but also the requirements for success with continuous engineering. Familiarize yourself with these principles to understand their impact and the trade-offs associated with nonadherence.

## Subscription democratization

Subscriptions are units of management and scale that are aligned with an organization's business goals and priorities. Avoid maintaining centralized control and management of subscriptions, and allow business units to manage subscriptions themselves. The governance model of an enterprise-scale approach ensures that when subscriptions are created or moved to different management groups, Azure policies are applied to provide the necessary guardrails.

<!---- Subscriptions as unit of management and scale
- Subscriptions as unit of cost
- Agility for business units--->

## Policy-driven governance

Azure Policy provides guardrails for subscriptions to ensure continuous compliance of an organization's platform and applications. At the same time, Policy helps to provide application owners both sufficient freedom and a secure, unhindered path to the cloud. Organizations should define governance rules in code to create guardrails authoritatively across the platform. Organizations declare the intent of the policy, and certain effects, such as *deploy-if-not-exists* and *deny* policies, help ensure a compliant resource configuration and prevent configuration drift.

<!---- Management group level policies
- Infrastructure deployment by policy--->

## Single control and management plane

Enterprise-scale architecture shouldn't rely on abstraction layers, such as internally developed portals or tooling. It should provide a consistent experience for both AppOps (centrally managed operation teams) and DevOps (dedicated application operation teams). It shouldn't differentiate between old and new applications or infrastructure as a service (IaaS) and platform as a service (PaaS) cloud-management paradigms. 

Ultimately, the architecture should provide a safe and secure foundation for all workload types to be deployed on the Azure platform. Azure provides a unified and consistent control plane across all Azure resources and provisioning channels, subject to role-based access and policy-driven controls. The organization can use Azure to establish a standardized set of policies and controls for governing the entire enterprise estate.

<!---- Avoid building abstraction layer and orchestration services
- Use Azure as single control and management plane--->

## Application-centric and archetype-neutral

Enterprise-scale architecture should focus on application-centric migrations and development rather than a pure infrastructure lift-and-shift migration (such as migrating virtual machines). The architecture shouldn't differentiate between old and new applications or IaaS and PaaS applications.

<!---- Group application components together
- Support for migration and net-new development
- Group workloads based on compliance needs--->

## Align Azure-native design with the platform roadmap

Enterprise-scale architecture strongly favors using native platform services and capabilities wherever possible. This approach fully aligns with Azure platform roadmaps from the outset to ensure that new capabilities are quickly made available in your environment.

<!---- Use Azure-native services as much as possible
- Stay aware of preview and upcoming features--->

## Critical design areas

When organizations make architectural decisions, enterprise-scale design principles are a good guide to reducing friction in cloud adoption and the changes that scale requires. The critical design areas provide a common lexicon between on-premises and cloud platform landing zone design. 

The following high-level design guidelines can help translate your organization's requirements into Azure constructs and capabilities. Each critical design area addresses the mismatch between on-premises and cloud-design infrastructure, which typically creates dissonance and friction between the enterprise-scale definition and Azure adoption. A set of subsequent considerations and recommendations for critical design areas helps accelerate architectural design.  

These design areas are discussed in more detail in other Microsoft Learn modules about enterprise-scale architecture.

- **Enterprise enrollment and Azure Active Directory (Azure AD) tenants**: An Enterprise Agreement (EA) enrollment represents the commercial relationship between Microsoft and how your organization uses Azure. It provides the basis for billing across all your subscriptions and affects the administration of your digital estate.

- **Identity and access management**: Identity and access management provides the basis of a large part of security assurance. To protect data and resources, it enables access based on identity authentication and authorization controls, and it helps you decide which requests should be permitted.

- **Management group and subscription organization**: When an organization plans Azure adoption at scale, it must thoroughly consider management group structures within an Azure AD tenant. A well-defined management group and subscription organization simplifies the management of Azure Policy and role-based access control (RBAC) assignments.

- **Network topology and connectivity**: There are key design considerations and recommendations surrounding networking and connectivity to, from, and within Azure. Network topology is a critical element of an enterprise-scale architecture, because it defines how applications can communicate with each other.

- **Management and monitoring**: A management and monitoring process gives central teams key recommendations for maintaining operational visibility within a large-scale Azure platform. This is a key consideration for operationally maintaining an Azure enterprise estate with centralized management and monitoring at a platform level.

- **Business continuity and disaster recovery**: Organizations capture disaster recovery (DR) requirements to design suitable platform-level capabilities that application workloads can consume. This helps organizations reach their specific recovery time objectives (RTOs) and recovery point objectives (RPOs) in Azure.

- **Security, governance, and compliance**: This critical design area covers encryption and a framework for assessing the enterprise security readiness of Azure services.

- **Platform automation and DevOps**: Many traditional IT operating models aren't compatible with the cloud. In this section, we look at planning for a platform DevOps approach, as well as central and federated responsibilities.
