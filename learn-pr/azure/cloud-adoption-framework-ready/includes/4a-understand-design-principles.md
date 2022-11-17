The conceptual architecture for Azure landing zones is universally applied to any process or implementation of landing zones. At the foundation of the architecture is a set of core design principles that serve as a compass for subsequent design decisions across critical technical domains.

The principles help you strive for an optimum design of the target architecture. If you choose to deploy an Azure landing zone accelerator or any version of the enterprise-scale landing zone code base, build on the architecture by applying the design principles described here.

Using these principles as part of your implementation will serve as a useful guide for realizing the benefits of cloud technologies. This cloud-oriented perspective, often called *cloud native*, represents ways of working and technical options for your organization that legacy technology approaches typically don't offer.

## Impact of design deviations

There might be valid reasons to deviate from the principles, such as in the case of Tailwind Traders. Organizational requirements might dictate specific outcomes or approaches in designing an Azure environment. In these cases, it's important to understand the impact that the deviation will have on the design and future operations. Carefully consider the tradeoffs outlined for each principle.

As a general rule, be prepared to balance requirements and functionality. Your journey to the conceptual architecture will evolve over time as requirements change and you learn from your implementation. For example, using preview services and taking dependencies on service roadmaps can remove technical blockers during adoption.

## Subscription democratization

Use subscriptions as a unit of management and scale to accelerate application migrations and new application development. Align subscriptions with business needs and priorities to support business areas and portfolio owners. Provide subscriptions to business units to support the design, development, and testing of new workloads and the migration of existing workloads.

To enable the organization to operate effectively at scale, support a subscription with a suitable [management group hierarchy](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups). This support will allow the subscription to be managed and organized efficiently.

### Impact of deviation

- One approach for implementing this principle is [decentralizing operations](/azure/cloud-adoption-framework/operating-model/compare) by transitioning them to business units and workload teams. This approach allows workload owners to have more control and autonomy over their workloads within the guardrails that the platform foundation has established. 

  Customers who need [centralized operations](/azure/cloud-adoption-framework/operating-model/compare), and who don't want to delegate control of production environments to workload teams or business units, might need to modify their [resource organization](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org) design and deviate from this principle.
- The design of the conceptual architecture for Azure landing zones assumes a specific management group and subscription hierarchy for all operations management subscriptions. This assumption might not align with your [operating model](/azure/cloud-adoption-framework/operating-model/define). 

  With this deviation, as your organization grows and evolves, your operational model might change. This change can lead to a migration of resources into separate subscriptions again, followed by complicated technical migrations. Before you commit to an approach, review the [Align](/azure/cloud-adoption-framework/ready/enterprise-scale/transition) guidance.

## Policy-driven governance

Use Azure Policy to provide guardrails and ensure continued compliance with your organization's platform and the applications deployed onto it. Azure Policy also provides application owners with independence and a secure path to the cloud.

### Impact of deviation

By not using Azure Policy to create guardrails within your environment, you increase the operation and management overhead of maintaining compliance. Azure Policy helps you restrict and automate your desired compliance state within your environment.

As part of your design considerations, review [how to use Azure Policy inside a landing zone implementation](/azure/cloud-adoption-framework/ready/enterprise-scale/dine-guidance).

## Single control and management plane

Avoid dependency on abstraction layers, such as customer-developed portals or tooling. We highly recommend having a consistent experience for both central operations and workload operations. 

Azure provides a unified and consistent control plane that's subject to role-based access and policy-driven controls. This applies across all Azure resources and provisioning channels. You can use Azure to establish a standardized set of policies and controls for governing the entire enterprise estate.

### Impact of deviation

Choosing a multiple-vendor approach to operate control and management planes might introduce complexity of integration and feature support. Replacing individual components to achieve a "best of breed" design or multiple-vendor operations tooling might have limitations and cause unintended errors due to inherent dependencies.

For customers who are bringing an existing tooling investment to operations, security, or governance, we recommend a review of the Azure services and any dependencies.

## Application-centric service model

Focus on application-centric migrations and development rather than pure infrastructure lift-and-shift migrations, such as moving virtual machines. The design choices shouldn't differentiate between old and new applications, infrastructure as a service (IaaS) applications, or platform as a service (PaaS) applications.

Regardless of the service model, strive to provide a secure environment for all applications deployed on the Azure platform.

### Impact of deviation

Segmenting workloads in a way that differs from the [implementation options](/azure/cloud-adoption-framework/ready/landing-zone/implementation-options) for management group hierarchy can create a complex policy and access control structure to govern your environment. Examples include deviation from the organizational hierarchy structure or grouping by Azure service. This tradeoff introduces the risk of unintentional policy duplication and exceptions, which add to operational and management overhead.

Another common approach that customers consider is the use of landing zones for dev/test/production workloads. For more information, see the FAQ question [How do we handle "dev/test/production" workload landing zones in enterprise-scale architecture?](/azure/cloud-adoption-framework/ready/enterprise-scale/faq#how-do-we-handle-devtestproduction-workload-landing-zones-in-enterprise-scale-architecture).

## Alignment with Azure-native design and roadmaps

Use Azure-native platform services and capabilities whenever possible. Align this approach with Azure platform roadmaps to ensure that new capabilities are available within your environments. Azure platform roadmaps should help inform the migration strategy and the conceptual trajectory of Azure landing zones.

### Impact of deviation

Introducing third-party solutions into your Azure environment can create a dependency upon those solutions to provide feature support and integration with Azure services.

Sometimes, bringing existing third-party solution investments into an environment is inevitable. Consider this principle and its tradeoffs carefully, in alignment with your requirements.

## Recommendations

Be prepared to trade off functionality, because it's unlikely that everything will be required on day one. Use preview services and take dependencies on service roadmaps to remove technical blockers.

Keep in mind that not all aspects of the desired operating model will be in general availability when you're using this approach.
