Before deploying an Azure landing zone, it's important to understand what you will need from your cloud environment to support your chosen operating model. Each Azure landing zone implementation option provides a deployment approach and defined design principles. Before choosing an implementation option, use this article to gain an understanding of the design areas listed in the following table.

## Design areas

Regardless of the deployment option, you should carefully consider each design area. Your decisions affect the platform foundation on which each landing zone depends.

| Design areas | Objective | Relevant methodologies |
|---|---|---|
| Enterprise enrollment | For enterprise customers with an Azure commitment, proper tenant creation and enrollment is an important early step. | Ready |
| Identity | Identity and access management is a primary security boundary in the public cloud. It's the foundation for any secure and fully compliant architecture. | Ready |
| Network topology and connectivity | Networking and connectivity decisions are an equally important foundational aspect of any cloud architecture. | Ready |
| Resource organization | As cloud adoption scales, considerations for subscription design and management group hierarchy have an impact on governance, operations management, and adoption patterns. | Govern |
| Governance disciplines | Automate auditing and enforcement of security, governance, and compliance policies. | Govern |
| Operations baseline | For stable, ongoing operations in the cloud, an operations baseline is required to provide visibility, operations compliance, and protect and recover capabilities. | Manage |
| Business continuity and disaster recovery (BCDR) | BCDR provides the foundation for reliability and rapid recovery. | Manage |
| Deployment options | Align the best tools and templates to deploy your landing zones and supporting resources. | Ready |

## Start with enterprise scale

For customers who adhere to an enterprise operations model, the enterprise-scale approach will provide a rich set of design principles in each of the above areas.

### Subscription democratization

Subscriptions should be used as a unit of management and scale aligned with business needs and priorities to support business areas and portfolio owners to accelerate application migrations and new application development. Subscriptions should be provided to business units to support the design, development, and testing of new workloads and migration of workloads.

**Design impact:** Multiple subscriptions should be allocated for each design area to segment team responsibilities. Additionally, multiple subscriptions should be allocated for workload collection to segment access and create separation of duties.

### Policy-driven governance

Azure Policy should be used to provide guardrails and ensure continued compliance with your organization's platform, along with the applications deployed onto it. Azure Policy also provides application owners with sufficient freedom and a secure unhindered path to the cloud.

**Design impact:** Azure Policy provides a cloud-first governance approach by enforcing sound policies. It is also used in a DeployIfNotExists capacity to automatically deploy critical architecture elements if they are deleted or changed, integrating the continuous integration/continuous development pipeline for deploying environments with the central governance tooling.

### Single control and management plane

<!-- cSpell:ignore AppOps -->

Enterprise-scale architecture shouldn't consider any abstraction layers such as customer-developed portals or tooling. It should provide a consistent experience for both centrally managed operation teams and dedicated workload operations teams. Azure provides a unified and consistent control plane across all Azure resources and provisioning channels subject to role-based access and policy-driven controls. Azure can be used to establish a standardized set of policies and controls for governing the entire enterprise estate.

**Design impact:** Role-based access control and Azure Policy are used to ensure that all workload deployments adhere to separation of duties and other governance requirements.

### Application-centric and archetype-neutral

Enterprise-scale architecture should focus on application-centric migrations and development rather than pure infrastructure lift-and-shift migrations, such as moving virtual machines. It shouldn't differentiate between old and new applications, infrastructure as a service, or platform as a service applications. Ultimately, it should provide a safe and secure foundation for all application types to be deployed onto your Azure platform.

**Design impact:** Environmental configuration should cover PaaS and IaaS deployments equally, with no distinction.

### Align Azure-native design and roadmaps

The enterprise-scale architecture approach advocates using Azure-native platform services and capabilities whenever possible. This approach should align with Azure platform roadmaps to ensure that new capabilities are available within your environments. Azure platform roadmaps should help to inform the migration strategy and enterprise-scale trajectory.

**Design impact:** Operations management, security, and governance processes will use cloud-native tooling as a primary operating model when using this approach. This will result in changes to existing operational processes.

### Recommendations

Be prepared to trade off functionality because it's unlikely that everything will be required on day one. Use preview services and take dependencies on service roadmaps to remove technical blockers.

**Design impact:** Not all aspects of the desired operating model will be in general availability when using this approach.

## Start small and expand

For customers who adhere to a centralized operations model, the enterprise-scale approach provides references to get you started on the core design areas following one core design principle of landing zone refactoring.

### Initial adoption requirements

When starting initial adoption efforts, there a few core criteria that must be met prior to adoption. Before moving assets to the cloud, the design areas of identity, network, and deployment options. Some specific requirements regarding resource organization should also be addressed, specifically initial subscriptions design, naming standards, and tagging schemas.

**Design impact:** The initial architecture will be significantly smaller and will require additional effort reach production readiness.

### Teach fundamental decisions

Rather than provide opinionated solutions the start small approach uses decision trees to help guide customers to specific implementations, best practices, and smaller modular reference architectures. This teaches the cloud platform team to build out the most appropriate solution for their needs.

**Design impact:** Many design decisions are purposefully not included in the initial architecture to help the team learn through best practice implementation.

### Deferred decisions

When building out an environment to support existing operations processes, you don't always know what you will need in the beginning. The start-small approach demonstrates ways to use cloud-first tools including Azure Resource Manager, Azure Policy, and Azure Blueprints to start building your environment. But rich configuration decisions are then deferred to run in parallel to your cloud adoption plan. As adoption progresses, the Govern, Manage, and Secure methodologies of the Cloud Adoption Framework (CAF) guide implementation of those individual disciplines.

**Design impact:** You may need to complete a foundational implementation of the Govern, Manage, and Secure methodologies in parallel to landing zone deployment.

### Refactoring

The principles for the start-small approach are rooted in refactoring. To avoid many common blockers, we suggest an iterative approach based on well-structured cloud adoption plan, which maximizes learning opportunities and minimizes time to business success. Refactoring and parallel efforts are critical to this approach.

The concept of refactoring a landing zone is simple, but execution requires proper guardrails. The concept shown above outlines the basic flow:

- When you're ready to build your first landing zone, start with an initial landing zone defined via a template.
- Once that landing zone is deployed, use the decision trees in the subsequent articles under the **Expand your landing zone** section of the table of contents to refactor and add to your initial landing zone.
- Repeat decision trees and refactoring until you have an enterprise-ready environment that meets the enhanced requirements of your security, operations, and governance teams.

**Design impact:** Minor refactoring is common. Significant shifts from one operations model to another may result in major restructuring. In other words, customers who deploy one subscription to host workloads and foundational utilities might hit scale restrictions. If your portfolio is much broader, requiring multiple landing zones this approach may require restructuring or redesigning common elements such as Active Directory or networking to expand to an enterprise operating model.

#### Development approach

The advantage of a refactoring-based approach, is the ability to create parallel iteration paths for development. The image below provides an example of two parallel iteration paths: cloud adoption and cloud platform. Both progress at their own pace, with minimal risk of becoming a blocker to either team's daily efforts. Alignment on the adoption plan and refactoring guardrails can lead to agreement about milestones and clarity about future-state dependencies.

:::image type="content" source="../media/iterations.png" alt-text="Image showing landing zone parallel iteration." border="false":::
_Figure 1: Landing zone parallel iteration._

In the example iteration paths above, the cloud adoption team is migrating their portfolio of 100 workloads to the cloud. In parallel, the cloud platform team is focused on staying ahead of the cloud adoption plan to ensure the environment is prepared for those workloads.

In this example, the planned iterations run as follows:

- The cloud platform team starts the development efforts by deploying an initial landing zone. That landing zone allows the cloud adoption team to deploy and begin testing their first workload.
- To prepare for the cloud adoption team's next deployment of 10 workloads, the cloud platform team works ahead to refactor and add a connected environment, treating the cloud as a perimeter network.
- Before the adoption team can release their first production workload, the security team requires a security review. While the adoption team deploys their first 10 workloads, the platform team moves ahead to define and implement security requirements.
- By the time the first workload is released to production, both teams should have enough learnings to prepare for a longer term shared service model. Centralizing core service architectures will help align governance and operations team. Centralizing core services will help prepare the adoption team to scale and release the next several waves of production workloads.
- As the team approaches their goal of migrating 100 workloads, the team will natural begin to move towards more of a cloud center of excellence collaboration model and team structure.

Configuring an enterprise-ready environment will take time. This approach will not eliminate that requirement. Instead, this approach is designed to remove early blockers and create opportunities for the platform and adoption teams to learn together.

#### Landing zone refactoring guardrails

All initial landing zone templates have limitations. Guardrails or policies during refactoring should reflect those limitations. Before beginning a landing zone refactoring process, it is important to understand the long-term requirements of the cloud adoption plan and classification of the candidate workloads, compared to the initial template limitations.

As an example of establishing refactoring guardrails, let's compare the development approach in the prior example and the CAF Migration landing zone blueprint.

- Per the [assumptions of the CAF Migration landing zone blueprint](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/migrate-landing-zone#assumptions), this initial landing zone is not designed for sensitive data or mission-critical workloads. Those features will have to be added through refactoring.
- In this example, lets assume that the portfolio of 100 workloads will require both mission critical and sensitive data hosting capabilities.

To balance these two competing requirements, the adoption team and platform team will agree to and operate under the following conditions:

- The cloud adoption team will prioritize production workloads that don't have access to sensitive data and are not deemed mission critical.
- Prior to production release, the security and operations team will validate alignment to the prior policy.
- The cloud platform team will work with the security and governance teams to implement a security baseline. Once security approves the implementation, the adoption team will be cleared to migrate workloads that have access to some sensitive data.
- The cloud platform team will work with the operations team to implement a management baseline. Once the operations team approves the implementation, the adoption team will be cleared to migrate workloads with a higher level of criticality.

For this example, the above set of agreed upon conditions will allow the adoption team get started on their migration effort. It also helps the platform team shape their interactions with other teams as they build toward a longer-term enterprise ready environment.

#### Meeting long-term requirements while refactoring

The section of the Ready methodology on expanding your landing zone will aid in moving towards the longer term requirements. As the cloud adoption team progresses with their adoption plan, review [expand your landing zone](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/considerations/?azure-portal=true) for guidance to help make decisions and refactor to meet the evolving requirements of various teams.

:::image type="content" source="../media/refactor-methodologies.png" alt-text="Image showing parallel landing zone iteration." border="false":::
_Figure 2: Deeper methodologies assisting a parallel landing zone iteration._

Each subsection of [expand your landing zone](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/considerations/?azure-portal=true) maps to one of the additions outlined in the image above. Beyond those basic expansions, the deeper methodologies (such as the Govern or the Manage methodology) of this framework can help to go beyond basic landing zone modifications and implement long-term disciplines with.
