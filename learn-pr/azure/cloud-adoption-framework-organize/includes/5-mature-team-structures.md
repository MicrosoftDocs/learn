All cloud functions are provided by someone during every cloud adoption effort. These assignments and team structures can develop organically, or an organization can intentionally design them to match a defined team structure. 

It's important for cloud implementation teams to understand where their team structures are today, and where they want them to end up. Again, this type of change is a journey that takes time, experimentation, and negotiation.

Watch this video to get an overview of common team structures at various stages of organizational maturity:

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4wvTS]

Organizational structures tend to move through the following common maturity model:

1. [Cloud adoption team only](/azure/cloud-adoption-framework/organize/organization-structures#cloud-adoption-team-only)
1. [Minimum viable product (MVP) best practice](/azure/cloud-adoption-framework/organize/organization-structures#best-practice-minimum-viable-product-mvp)
1. [Central IT team](/azure/cloud-adoption-framework/organize/organization-structures#central-it-team)
1. [Strategic alignment](/azure/cloud-adoption-framework/organize/organization-structures#strategic-alignment)
1. [Operational alignment](/azure/cloud-adoption-framework/organize/organization-structures#operational-alignment)
1. [Cloud center of excellence](/azure/cloud-adoption-framework/organize/organization-structures#cloud-center-of-excellence)

The following graphic outlines those structures based on typical maturation stages. Use these examples to find the organizational structure that best aligns with your operational needs.

:::image type="content" source="../media/organizational-maturity.png" alt-text="Diagram that illustrates team structures at various stages of organizational maturity." border="false" :::

Most companies start with little more than a cloud adoption team. But we recommend that you establish an organizational structure that more closely resembles the MVP best practice.

## Cloud adoption team only

The nucleus of all cloud adoption efforts is the cloud adoption team. This team drives the technical changes that enable adoption. Depending on the objectives of the adoption effort, this team might have the skills to handle a broad set of technical and business tasks.

:::image type="content" source="../media/adoption-team-only.png" alt-text="Diagram that illustrates cloud adoption via a lone cloud adoption team." border="false" :::

For small-scale or early-stage adoption efforts, this team might be as small as one person. In larger-scale or late-stage efforts, it's common to have several cloud adoption teams, each with around six engineers. Regardless of size or tasks, any cloud adoption team provides the means to bring solutions into the cloud. 

For some organizations, this team might be a sufficient organizational structure. For more insight into the team's structure, composition, and function, see the [Cloud adoption team](/azure/cloud-adoption-framework/organize/cloud-adoption) article.

> [!WARNING]
> Operating with only a cloud adoption team (or multiple cloud adoption teams) is considered an antipattern and should be avoided. At a minimum, consider the MVP best practice.

## MVP best practice

We recommend that you have two teams to create balance across cloud adoption efforts:

- **Cloud adoption team**: Accountable for technical solutions, business alignment, project management, and operations for solutions that are adopted.
- **Cloud governance team**: Accountable for platform maturity, platform operations, governance, and automation. This team is dedicated to ensuring excellence in the adopted solutions. 

:::image type="content" source="../media/best-practice.png" alt-text="Diagram that illustrates cloud adoption via the best practice of a cloud adoption team and a cloud governance team." border="false" :::

This proven approach is considered an MVP because it might not be sustainable. Each team is wearing many hats, as outlined in the [responsible, accountable, consulted, and informed (RACI) charts](/azure/cloud-adoption-framework/organize/raci-alignment).

The following sections describe a fully staffed, proven organizational structure. They also describe approaches to aligning the appropriate structure to your organization.

## Central IT team

As adoption scales, the cloud governance team might struggle to keep pace with the flow of innovation from multiple cloud adoption teams. Especially in environments with heavy compliance, operations, or security requirements.

At this stage, it's common for companies to shift cloud responsibilities to an existing central IT team. If that team can reassess tools, processes, and people to better support cloud adoption at scale, then it can add significant value. Subject matter experts from operations, automation, security, and administration can drive effective operational innovations to modernize the central IT team.

:::image type="content" source="../media/central-information-technology.png" alt-text="Diagram that illustrates cloud adoption with a central information technology team managing change control." border="false" :::

Unfortunately, the central IT team can bring one of the riskiest phases of organizational maturity. The central IT team must have a strong growth mindset. If it views the cloud as an opportunity to grow and adapt, it can provide great value throughout the process. But if it views cloud adoption as a threat to its existing model, it can become an obstacle to the cloud adoption teams and the business objectives that it supports. 

Some central IT teams spend months or even years trying to force the cloud into alignment with on-premises approaches, with only negative results. The cloud doesn't require everything to change within the central IT team, but it does require significant change. If the central IT team is resistant to change, this phase of maturity can quickly become a cultural antipattern.

Cloud adoption plans that are heavily focused on platform as a service (PaaS), DevOps, or other solutions that require less support for operations are less likely to see value during this phase of maturity. These types of solutions are the most likely to be hindered or blocked when attempting to centralize IT.

A higher level of maturity, like a CCoE, is more likely to yield positive results for those types of transformational efforts. To understand the differences between centralized IT in the cloud and a CCoE, see [Cloud center of excellence](/azure/cloud-adoption-framework/organize/cloud-center-of-excellence).

## Strategic alignment

As the investment in cloud adoption grows and the organization starts to see business value, business stakeholders often become more engaged. A defined cloud strategy team aligns those business stakeholders to maximize the value of cloud adoption investments.

:::image type="content" source="../media/strategic-alignment.png" alt-text="Diagram that illustrates strategic alignment of cloud adoption and cloud strategy teams." border="false" :::

When maturity happens organically, as a result of IT-led cloud adoption efforts, a governance or central IT team precedes strategic alignment. When the business leads cloud adoption efforts, the focus on operating model and organization tends to happen earlier. Whenever possible, define business outcomes and the cloud strategy team early in the process.

## Operational alignment

Realizing business value from cloud adoption efforts requires stable operations. Operations in the cloud might require new tools, processes, or skills. When you need stable IT operations to achieve business outcomes, it's important to add a defined cloud operations team.

:::image type="content" source="../media/operational-alignment.png" alt-text="Diagram that illustrates operational alignment of strategy, adoption, operation, and governance teams." border="false" :::

Existing roles in IT operations can deliver cloud operations. However, cloud operations are sometimes delegated to parties outside IT operations. Managed service providers, DevOps teams, and business unit IT often assume the responsibilities associated with cloud operations, with support and guardrails provided by IT operations. This structure is increasingly common for cloud adoption efforts that focus heavily on DevOps or PaaS deployments.

## Cloud center of excellence

At the highest state of maturity, a CCoE aligns teams around a modern cloud-first operating model. This approach provides centralized IT functions like governance, security, platform, and automation.

:::image type="content" source="../media/cloud-center-excellence.png" alt-text="Diagram that illustrates a mature team model for cloud center of excellence." border="false" :::

The main difference between this structure and the central IT team structure is a strong focus on self-service and democratization. The teams in this structure organize with the intent of delegating control as much as possible. 

Aligning governance and compliance practices to cloud-native solutions creates guardrails and protection mechanisms. Unlike the central IT team model, the cloud-native approach maximizes innovation and minimizes operational overhead. Adopting this model requires mutual agreement among business and IT leadership to modernize IT processes. This model is unlikely to happen organically and often requires executive support.
