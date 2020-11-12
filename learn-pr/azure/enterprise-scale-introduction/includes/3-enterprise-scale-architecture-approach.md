Enterprise-scale design comes with a set of design principles for managing the platform at scale. These principles serve as a compass for subsequent design decisions across critical technical domains. To better understand their impact and the trade-offs associated with nonadherence, familiarize yourself with the following principles:

- **Subscription democratization**: Use subscriptions as a unit of management and scale that's aligned with business needs and priorities. This approach supports business areas and portfolio owners as they accelerate application migrations and new application development.

   :::image type="content" source="../media/3-subscription-democratization.svg" alt-text="Diagram that illustrates subscription democratization." lightbox="../media/3-subscription-democratization-large.png":::

- **Policy-driven governance**: Apply Azure Policy to provide guardrails and ensure continued compliance with your organization's platform, along with the applications that are deployed onto it.

  :::image type="content" source="../media/3-policy.png" alt-text="Diagram of Azure Policy showing management group and subscription organization." lightbox="../media/3-policy-large.png":::

- **Single control and management plane**: Enterprise-scale architecture shouldn't consider any abstraction layers, such as customer-developed portals or tooling. It should provide a consistent experience for both AppOps (centrally managed operation teams) and DevOps (dedicated application operation teams).

- **Application-centric and archetype-neutral approach**: Enterprise-scale architecture should focus on application-centric migrations and development rather than pure infrastructure lift-and-shift migrations, such as moving virtual machines. Organizations shouldn't differentiate between old and new applications.

- **Azure-native design and platform roadmap alignment**: The enterprise-scale architecture approach favors using Azure-native platform services and capabilities whenever possible. It's crucial to align with the Azure platform roadmap to ensure that new capabilities are made available within customer environments.

- **Enterprise-scale architecture definition and composition approach**: Through an enterprise-scale architecture approach and reference implementation, you enable the effective construction and operationalization of landing zones on Azure, at scale and aligned with the Azure roadmap and the Microsoft Cloud Adoption Framework for Azure. Enterprise-scale architecture represents the strategic design path and target technical state of your Azure environment. The architecture will continue to evolve along with the Azure platform, and it's ultimately defined by design decisions that are aligned with the principles to safeguard your Azure journey.

  Not all enterprises adopt Azure the same way. Enterprise-scale landing zone architectures, as illustrated in the following diagram, might vary between customers, depending on their requirements. Varied design guideline considerations and recommendations might yield different trade-offs, depending on your organization's scenario. Some variation is expected, but if you follow the core recommendations, the resulting target architecture will set your organization on a path to sustainable scale.

  :::image type="content" source="../media/3-enterprise-scale-landing-zone.png" alt-text="Diagram of an enterprise-scale landing zone." lightbox="../media/3-enterprise-scale-landing-zone-large.png":::

- **Scope**: With enterprise-scale landing zones, the scope of a landing zone grows considerably to support application migrations and green field development at scale in Azure. This expansion allows for design that can scale across your organization's full IT portfolio, which looks well beyond a short-term cloud adoption plan.

- **Refactoring**: The number of subscriptions that are required to support a full enterprise-scale IT portfolio can be large. Initially, the Cloud Adoption Framework encourages a high frequency of refactoring, which should stabilize before the tenth production workload is deployed to the cloud. When you work across an enterprise portfolio, ten applications can be deployed quickly and make refactoring impractical. Instead, a central IT team or a cloud center of excellence should deliver a more complete landing zone during the first release.

- **Goal**: Provide consistent landing zones based on an application archetype subscription strategy to minimize subscription sprawl. Expand the definition of requisite components to better fit the governance and compliance needs of a cloud-mature enterprise.

- **Principal purpose**: Limited refactoring opportunities and a defined subscription strategy create an opportunity to mature your organization's landing zones faster. Enterprise-scale landing zones broaden the primary purpose of a landing zone to focus on aspects of governance, compliance, security, and operational management. Each of these areas is addressed in the first release of the landing zone and supporting shared platform services.

To use an analogy, shared city utilities such as water, gas, and electricity are available to new homes before they're constructed. Likewise, for landing zones, the network, identity and access management, policies, management, and monitoring must be readily available to help streamline the application migration process before it begins.

In addition to the key aspects noted here, the design, configuration, deployment, and integration of each landing zone should meet your organization's critical requirements as they relate to:

- Business continuity and disaster recovery at platform and application levels.
- Service management, such as incident response and support.
- A service catalog, such as configuration management database.
