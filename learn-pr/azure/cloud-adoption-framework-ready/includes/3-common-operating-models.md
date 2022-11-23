In this unit, you'll review common operating models to see which ones best align to the Tailwind Traders narrative. You'll also learn how to evaluate and map the operating model that best fits your cloud adoption plans. This information will help you choose the most relevant Azure landing zone to begin building your cloud environment.

## Common operating models

The following four operating models show up across cloud adoption efforts. Examining these common operating models can shape conversations about environmental design and configuration. Each operating model maps to one or more Azure landing zones to accelerate initial deployment. 

:::image type="content" source="../media/operating-model-complexity.png" alt-text="Diagram that shows four common operating models: decentralized, centralized, enterprise, and distributed." border="false":::

The following characteristics aid in aligning to one of the common operating models:

**Strategic priority:** Innovation, control (optimized operations), democratization (autonomy), and integration are all important strategic priorities for adopting the cloud. When you're speaking to the executive stakeholders, which will be the most important factor for your company in the next three to five years?

**Organization:** Organization of people drives some operations decisions. Do you have a small IT team that covers all of your portfolio? Are separate teams dedicated to functions like security, governance, and operations? Are teams organized around individual workloads? Are you bound by rigid third-party compliance standards that are reviewed by an auditor or other compliance bodies?

**Portfolio scope:** The size of your portfolio and where you focus operations are important considerations for each operating model. Do you manage a large, complex, multicloud workload portfolio? Can a single cloud platform support the portfolio? Do all of your workloads need to live in a single production subscription? Do you focus on workload-specific operations with no central support? Learn more about these terms in the [portfolio hierarchy article](/azure/cloud-adoption-framework/reference/fundamental-concepts/hosting-hierarchy?azure-portal=true).

**Accountability (separation of duties):** When it comes to technology, there's always something that can go wrong. That's why few teams sign up for an uptime SLA of 100 percent. When things break or aren't performing as expected, who's accountable for taking the call? Who's accountable for proactive fixes to minimize outages? Who's accountable for cloud economics and ongoing budgets? Accountability and associated access requirements drive some environmental design decisions.

**Standardization:** Standardizing foundational utilities like network, identity, and security can produce tangible cost savings and reduce the amount of people power that's dedicated to various efforts. How important is standardization of utilities or shared resources?

**Operations priority:** In modernizing operations, it's common for an operations team to choose cloud-first services as the primary form of operations support. Alternatively, when existing on-premises tooling is the primary operations tooling that the team wants, the cloud can be an extension or a secondary operating model. Looking forward, do you prefer a cloud-first view of operations and supporting tools? Will you carry forward existing tools to extend into the cloud? Are you looking for a unified operations approach that can seamlessly blend public and private cloud operations?

**Platform development velocity:** Workloads require their own assets, which create the direct workload environment. Beyond those directly supporting assets, there are various degrees of upfront investment. How much effort do you want to invest in foundational utilities that will be shared across workloads (such as network and identity)? How much upfront effort should go into a centralized cloud foundation that will share those utilities across multiple landing zones?

### Decentralized operations

The least complex operating model is a fully decentralized model. This model is highly focused on independent workloads with minimal dependency on centralized operations. This model is also called bimodal IT or decentralized IT.

:::image type="content" source="../media/decentralized-operations.png" alt-text="Illustration that shows individual workloads and dependent assets in decentralized operations." border="false":::

**Strategic priority:** Organizations often use decentralization when they prioritize *innovation over control*. This model is common in startup organizations, but it's also an increasing trend in larger organizations.

**Organization:** Teams are organized around workloads or business processes, which contrasts with the other three operating models.

**Portfolio scope:** The portfolio's scope is also isolated to workload levels. When an organization is entirely decentralized, the organization is unlikely to invest much time in management of portfolio alignment.

**Accountability (separation of duties):** The workload team is entirely accountable for operations, governance, and security decisions. There is no shared accountability model in decentralized operations.

**Standardization:** Best practices and deployment automation (continuous integration/continuous delivery pipelines) are critical to create any degree of standardization across workloads. Without centralized functions, standardization probably won't last long.

**Operations priority:** A decentralized operations team is more likely to prioritize cloud-first operations by using software as a service (SaaS) or platform as a service (PaaS) tools to automate operations.

**Platform development velocity:** Decentralized operations might share deployment scripts across workloads, but there are few or no central resources shared across workloads.

[Compare more pros, cons, and characteristics of decentralized operations in the Cloud Adoption Framework](/azure/cloud-adoption-framework/operating-model/compare?azure-portal=true).

### Centralized operations

A centralized model is the most common operations model in IT. This model is highly focused on a controlled production environment that's managed solely by centralized operations. Centralized operations focus on a smaller number of landing zones with embedded foundational utilities.

:::image type="content" source="../media/centralized-operations.png" alt-text="Illustration of centralized operations with landing zones and embedded utilities." border="false":::

Management of nonproduction environments varies from organization to organization. But in a centralized operations model, even the nonproduction environments are likely to be constrained by governance and security requirements.

**Strategic priority:** When control and stability in the business are more important than innovation, this model tends to be the highest trend. Larger organizations or stable organizations often use centralized operations. This model is common when third-party compliance requirements drive environmental decisions.

**Organization:** Teams are organized around functions or processes first. In smaller organizations, central IT is home for team members who focus on security, governance, operations, and infrastructure. As organizations grow, those functions might spin out into teams that are dedicated to each function.

**Portfolio scope:** Centralized operations teams tend to focus on one landing zone or a small number of landing zones. Within those landing zones, the organization deploys foundational utilities to support a combination of workloads in each landing zone. This operations model tends to create scale challenges when the organization supports robust cloud foundations and multicloud portfolios.

**Accountability (separation of duties):** In this operations model, central IT or central operations teams are typically accountable for all assets in production. Separation of duties tends to focus on environment isolation, which prevents workload-specific teams from interacting with production assets.

**Standardization:** Standardization across workloads is likely high. However, as the portfolio grows to span multiple landing zones or multiple cloud platforms, that standardization might break down and require significant modifications to the environment.

**Operations priority:** Organizations commonly use centralized operations when they consider their cloud operating model to be a secondary operating model. Because the existing on-premises or private cloud operations are the primary model, these organizations tend to carry forward existing operations tools and limit primary usage of modern cloud-first operations tools.

**Platform development velocity:** Central operations teams typically need a start-small approach to address common utilities. Over time, the teams will focus on building best-of-breed solutions into the environment.

[Compare more pros, cons, and characteristics of centralized operations in the Cloud Adoption Framework](/azure/cloud-adoption-framework/operating-model/compare#centralized-operations?azure-portal=true).

### Enterprise operations

An enterprise model is appropriate for customers who are migrating entire datacenters or large portfolios to the cloud. Enterprise operations focus on a larger number of landing zones with foundational utilities centralized into a platform foundation.

:::image type="content" source="../media/enterprise-operations.png" alt-text="Illustration of enterprise operations with landing zones and foundational utilities." border="false":::

**Strategic priority:** The enterprise model focuses on democratizing decisions and delegated responsibilities to balance the need for innovation in some landing zones and tighter control in others. This is a strategic priority for large organizations that need to protect existing interests while empowering innovation to keep pace with market changes.

**Organization:** Enterprise operations empower build-and-operate capabilities in each workload team. Workload teams are aligned by function, such as governance, security, and operations. A dedicated cloud center of excellence (CCoE) team unites the workload and supporting teams to coordinate activities and help ensure operational excellence across the cloud foundation.

**Portfolio scope:** The scope of enterprise operations focuses on the holistic cloud foundation to ensure that foundational utilities are centralized and available to all landing zones. Landing zones and dedicated workload environments can then be deployed in a self-service capacity, with the cloud foundation providing all the required dependencies.

**Accountability (separation of duties):** The CCoE team is responsible for maintaining the necessary centralized resources and creating visibility across the portfolio. Central operations or workload-specific operations teams are then accountable for the day-to-day support of the individual workloads.

**Standardization:** Standardization is highest in this operating model. The centralized cloud foundation ensures consistency in the configuration of all areas of landing zone design. Sound best practices favor automated deployment for all workloads. This automation allows for further standardization at the workload and asset levels.

**Operations priority:** An enterprise operating model requires a cloud-first approach to operations. First-party cloud-based tools are essential to maintaining centralized operations in the cloud. This type of model must look to the cloud as the primary operating model to be effective. The organization views existing on-premises operations as secondary operations and should include them in a long-term transition plan.

**Platform development velocity:** To encourage centralization of governance, security, and operations across a fast-growing portfolio of workloads, the enterprise operations teams will require the implementation of an enterprise solution before adoption.

[Compare more pros, cons, and characteristics of enterprise operations in the Cloud Adoption Framework](/azure/cloud-adoption-framework/operating-model/compare#enterprise-operations?azure-portal=true).

### Distributed operations

The distributed model is the most complex form of operations. It blends the other models.

:::image type="content" source="../media/complex-operations.png" alt-text="Diagram that shows the integration of operating models in distributed operations." border="false":::

Companies commonly take this approach when they grow through rapid acquisition, resulting in a distributed mixture of the previous three operating models. Companies can exist in this state for extended periods. But to minimize redundancy and promote more efficient operations, they should consider developing a plan to transition to one of the less complex models.

**Strategic priority:** Organizations use this model when they favor integration of acquired business units over innovation or control. This is often a temporary or bridge strategy that's required to move to a more efficient operating model in the future. This model tends to persist when the organization wants to maintain autonomy and is considering a near-term exit strategy, as is commonly seen in private equity or holding companies.

**Organization:** A centralized structure for the organization is challenging to maintain in this operating model. It's wise for organizations to start with the formation of a CCoE virtual team early in the process to create visibility and awareness of operations around the organization.

**Portfolio scope:** Distributed operations focus on a complex portfolio. Over time, that focus can narrow down to more granular levels of the portfolio.

**Accountability (separation of duties):** Accountability will vary among business units. Separation of duties from a central perspective is hard to achieve.

**Standardization:** The first step toward standardization in a distributed operations model is to gain a clear view of the digital estate for the full portfolio. A data-driven approach will start to identify commonalities in the portfolio that lean toward a centralized or enterprise operations model.

**Operations priority:** Operations priority in this model is around data. Centralizing data by using tools designed for unified operations will allow a CCoE team to coach and mentor the various business units during transitions or maturity efforts. Before you force a consistent operations priority, evaluate the portfolio of workload operations to ensure proper tooling and baselines.

**Platform development velocity:** Evaluation of the portfolio of workload operations should identify an acceptable velocity for platform development that aligns to start-small or enterprise-scale approaches. The primary data point to determine direction will depend on the most common approach to operations management across the portfolio.

[Compare more pros, cons, and characteristics of distributed operations in the Cloud Adoption Framework](/azure/cloud-adoption-framework/operating-model/compare#distributed-operations?azure-portal=true).
