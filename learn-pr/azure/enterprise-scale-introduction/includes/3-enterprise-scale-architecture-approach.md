Just like our example of organizing books in a library, enterprise-scale design comes with set of design principles to manage the platform at scale. These principles serve as a compass for subsequent design decisions across critical technical domains. Familiarize yourself with these principles to better understand their impact and the trade-offs associated with nonadherence.

:::image type="content" source="../media/subscription-democratization.png" alt-text="Subscription democratization":::

- **Subscription democratization**: Subscriptions should be used as a unit of management and scale aligned with business needs and priorities to support business areas and portfolio owners to accelerate application migrations and new application development.

- **Policy-driven governance**: Azure Policy should be used to provide guardrails and ensure continued compliance with your organization's platform, along with the applications deployed onto it.

  :::image type="content" source="../media/policy.png" alt-text="A diagram of Azure Policy with management group and subscription organization.":::

- **Single control and management plane**: Enterprise-scale architecture shouldn't consider any abstraction layers, such as customer-developed portals or tooling. It should provide a consistent experience for both AppOps (centrally managed operation teams) and DevOps (dedicated application operation teams).

- **Application-centric and archetype neutral approach**: Enterprise-scale architecture should focus on application-centric migrations and development rather than pure infrastructure lift-and-shift migrations like moving virtual machines. Organizations shouldn't differentiate between old/new applications.

- **Azure-native design and platform roadmap alignment**: The enterprise-scale architecture approach favors using Azure-native platform services and capabilities whenever possible. Aligned with Azure platform roadmap is crucial to ensure new capabilities are made available within customer environments.

- **Enterprise-scale architecture definition and composition approach**: The enterprise-scale architecture approach and reference implementation enable effective construction and operationalization of landing zones on Azure, at scale and aligned with the Azure roadmap and the Microsoft Cloud Adoption Framework for Azure. The enterprise-scale architecture represents the strategic design path and target technical state for your Azure environment. It will continue to evolve along with the Azure platform and is ultimately defined by the design decisions aligned with the principles to safeguard your Azure journey.

  Not all enterprises adopt Azure the same way, so enterprise-scale landing zone architectures like in the image below may vary between customers based on requirements. The design guideline considerations and recommendations might yield different trade-offs based on your organization's scenario. Some variation is expected, but if you follow the core recommendations, the resulting target architecture will set your organization on a path to sustainable scale.

  :::image type="content" source="../media/enterprise-scale-landing-zone.png" alt-text="A diagram of an enterprise-scale landing zone.":::

- **Scope**: With enterprise-scale landing zones, the scope of a landing zone grows considerably to support application migrations and green field development at scale in Azure. This expansion allows for design that can scale across your organization's full IT portfolio, which looks well beyond a short-term cloud adoption plan.

- **Refactoring**: The number of subscriptions required to support a full enterprise-scale IT portfolio can be large. Initially, the Cloud Adoption Framework encourages a high frequency of refactoring, which should stabilize before the tenth production workload is deployed to the cloud. When you work across an enterprise portfolio, ten applications can be deployed quickly and make refactoring impractical. Instead, a central IT team or a cloud center of excellence should deliver a more complete landing zone during the first release.

- **Goal**: Provide consistent landing zones based on an application archetype subscription strategy to minimize subscription sprawl. Expand the definition of requisite components to better fit the governance and compliance needs of a cloud-mature enterprise.

**Principal purpose**: Limited refactoring opportunities and a defined subscription strategy create an opportunity to mature your organization's landing zones faster. Enterprise-scale landing zones broaden the primary purpose of a landing zone to focus on aspects of governance, compliance, security, and operational management. Each of these areas is addressed in the first release of the landing zone and supporting shared platform services.

  An example is how city utilities like water, gas, and electricity are available before new homes are constructed. In this analogy, the network, identity and access management, policies, management, and monitoring are shared utility services that must be readily available to help streamline the application migration process before it begins.

In addition to the key aspects denoted here, the design, configuration, deployment, and integration of each landing zone should meet your organization's critical requirements relating to:

- Business continuity and disaster recovery at platform and application levels.
- Service management, such as incident response and support.
- A service catalog, such a configuration management database.
