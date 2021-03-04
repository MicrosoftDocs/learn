In this exercise, you will review common operating models to see which ones best align to Tailwind Traders narrative. You will also learn how to evaluate and map the operating model that best fits your cloud adoption plans. This information will help you choose the most relevant Azure landing zone to begin building your cloud environment.

## Comparing common operating models

Four common operating models show up across countless cloud adoption efforts. We use these operating models to shape conversations about environmental design and configuration. Each operating model maps to one or more Azure landing zones to accelerate initial deployment.

:::image type="content" source="../media/operating-model-complexity.png" alt-text="List of the four common operating models compared in this article." border="false":::
_Figure 1: A comparison of common operating models discussed in this unit, ranked by architectural complexity: decentralized operations, central operations, enterprise operations, and distributed operations._

The image above plots the four common operating models from least to most complex for comparison purposes.

## Operating model characteristics

The following characteristics aid in aligning to one of the common operating models:

**Strategic priority:** Innovation, control (optimized operations), democratization (autonomy), and integration are all important strategic priorities when adopting the cloud. When speaking to the executive stakeholders, which will be the most important factor for your company in the next three to five years?

**Organization:** Organization of people drives a number of operations decisions. Do you have a small IT team cover all of your portfolio? Are there separate teams dedicated to functions like security, governance, operations? Are teams organized around individual workloads? Are you bound by rigid third-party compliance standards that are reviewed by an auditor or other compliance bodies?

**Portfolio scope:** The size of your portfolio and where you focus operations is another important consideration for each operating model. Do you manage a large, complex, multicloud workload portfolio? Can the portfolio be supported by a single cloud platform? Do all of your workloads need to live in a single production subscription? Do you focus on workload-specific operations with no central support? Learn more about these terms in the [portfolio hierarchy article](https://docs.microsoft.com/azure/cloud-adoption-framework/reference/fundamental-concepts/hosting-hierarchy?azure-portal=true).

**Accountability (separation of duties):** When it comes to technology, there's always something that can go wrong. That's why few teams sign up for a 100% uptime SLA. When things break or aren't performing as expected, who's accountable for taking the call? Who's accountable for proactive fixes to minimize outage? Who's accountable for cloud economics and ongoing budgets? Accountability (and associated access requirements) drives a number of environmental design decisions.

**Standardization:** Standardizing foundational utilities like network, identity, and security can produce tangible cost savings and reduce the amount of people power dedicated to various efforts. How important is standardization of utility or shared resources?

**Operations priority:** When modernizing operations, it's common for operations team to choose cloud-first services as the primary form of operations support. Alternatively, when existing on-premises tooling is the desired primary operations tooling, the cloud can be an extension or secondary operating model. Looking forward, do you prefer a cloud-first view of operations and supporting tools? Will you be carrying forward existing tools to extend into the cloud? Are you looking for a unified operations approach that can seamlessly blend public and private cloud operations?

**Platform development velocity:** Workloads require their own assets, which create the direct workload environment. Beyond those directly supporting assets, there are various degrees of up front investment. How much effort do you want to invest in foundational utilities that will be shared across workloads (such as network and identity)? How much upfront effort should go into a centralized cloud foundation that will share those utilities across multiple landing zones?

## Decentralized operations

The least complex operating model is a fully decentralized model. This model is highly focused on independent workloads with minimal dependency on centralized operations. This model is also referred to as bimodal IT or decentralized IT.

:::image type="content" source="../media/decentralized-operations.png" alt-text="Image explaining decentralized operations focuses on individual workloads and dependent assets." border="false":::
_Figure 2: Decentralized operations focuses on individual workloads and dependent assets._

**Strategic priority:** Decentralization is most commonly seen when organizations prioritize *innovation over control*. This model is very common in startup organizations but is an increasing trend in larger organizations, as well.

**Organization:** Teams are organized around workloads or business processes, which contrast with the other three operating models.

**Portfolio scope:** Scope of the portfolio is also isolated to workload levels. When an organization is entirely decentralized the organization is unlikely to invest much time in management of portfolio alignment.

**Accountability (separation of duties):** The workload team is entirely accountable for operations, governance, and security decisions. There is no shared accountability model in decentralized operations.

**Standardization:** Best practices and deployment automation (continuous integration/continuous development pipelines) are critical to create any degree of standardization across workloads. Without centralized functions, standardization is unlikely to persist for any length of time.

**Operations priority:** Decentralized operations team are more likely to prioritize cloud-first operations using software-as-a-service or platform as a service tools to automate operations.

**Platform development velocity:** Decentralized operations may share deployment scripts across workloads, but there are little to no central resources shared across workloads.

Compare more pros, cons, and characteristics of [decentralized operations in the Cloud Adoption Framework](https://docs.microsoft.com/azure/cloud-adoption-framework/operating-model/compare?azure-portal=true).

## Centralized operations

Centralized operations is the most common operations model in information technology. This model is highly focused on controlled production environment managed solely by centralized operations.

:::image type="content" source="../media/centralized-operations.png" alt-text="Image explaining centralized operations focuses on a smaller number of landing zones with embedded foundational utilities." border="false":::
_Figure 3: Centralized operations focuses on a smaller number of landing zones with embedded foundational utilities._

Management of nonproduction environments vary significantly from organization to organization. But in a centralized operations model, even the nonproduction environments are likely to be constrained by governance and security requirements.

**Strategic priority:** When control and stability in the business are more important than innovation, this model tends to be the highest trend. Central operations is often seen in larger organizations or stable organizations. This model is very common when party compliance requirements-driven environmental decisions.

**Organization:** Teams are organized around functions or processes first. In smaller organizations, central IT is home for security, governance, operations, and infrastructure focused team members. As organizations grow, those functions may spin out into teams dedicated to each function.

**Portfolio scope:** Centralized operations teams tend to focus on one landing zone or a small number of landing zones. Within those landing zones, foundational utilities are deployed to support a combination of workloads in each landing zone. This operations model tends to create scale challenges when supporting robust cloud foundations and multicloud portfolios.

**Accountability (separation of duties):** In this operations model, central IT or central operations are typically accountable for all assets in production. Separation of duties tends to focus on environment isolation, which prevents workload-specific teams from interacting with production assets.

**Standardization:** Standardization across workloads is likely high. However, as the portfolio grows to span multiple landing zones or multiple cloud platforms, that standardization could break down requiring significant modifications to the environment.

**Operations priority:** Centralized operations is most commonly seen when an organization considers their cloud operating model to be a secondary operating model. Since the existing on-premises or private cloud operations are the primary model, these organizations tend to carry forward existing operations tools and limit primary usage of modern cloud-first operations tools.

**Platform development velocity:** Central operations teams typically require a start-small approach to address common utilities. Then over time, the team will focus on building best of breed solutions into the environment.

Compare more pros, cons, and characteristics of [centralized operations in the Cloud Adoption Framework](https://docs.microsoft.com/azure/cloud-adoption-framework/operating-model/compare#centralized-operations?azure-portal=true).

## Enterprise operations

Enterprise operations is the suggested operating model for customers who are migrating entire datacenters or large portfolios to the cloud.

:::image type="content" source="../media/enterprise-operations.png" alt-text="Image explaining enterprise operations focuses on a larger number of landing zones with foundational utilities centralized into a platform foundation." border="false":::
_Figure 4: Enterprise operations focuses on a larger number of landing zones with foundational utilities centralized into a platform foundation._

This operating model focuses on democratizing decisions and delegated responsibilities to balance the need for innovation in some landing zones and tighter control in others.

**Strategic priority:** The strategic priority operating model prioritizes democratization to balance innovation and control. This is a strategic priority for large organizations that need to protect existing interests while empowering innovation to keep pace with market changes.

**Organization:** Enterprise operations empowers build and operate capabilities in each workload team. is a series of teams aligned by function, such as governance, security, and operations. Uniting the workload and supporting teams is a dedicated cloud center of excellence team to coordinate activities and ensure operational excellence across the cloud foundation.

**Portfolio scope:** The scope of enterprise operations focuses on the holistic cloud foundation to ensure that foundational utilities are centralized and available to all landing zones. Landing zones and dedicated workload environments can then be deployed in a self-service capacity with all the required dependencies provided by the cloud foundation.

**Accountability (separation of duties):** The cloud center of excellence is responsible for maintaining the necessary centralized resources and creating visibility across the portfolio. Central operations or workload-specific operations teams are then accountable for the day-to-day support of the individual workloads.

**Standardization:** Standardization is highest in this operating model. The centralized cloud foundation ensures consistency in the configuration of all landing zone design areas. Sound best practices favor automated deployment for all workloads allowing for further standardization at the workload and asset level.

**Operations priority:** An enterprise operating model requires a cloud-first approach to operations. First party cloud-based tools are essential to maintaining centralized operations in the cloud. This type of model must look to the cloud as the primary operating model to be effective. The existing on-premises operations are viewed as secondary operations and should be included in a long-term transition plan.

**Platform development velocity:** To encourage centralization of governance, security, and operations across a fast growing portfolio of workloads, the enterprise operations teams will require an enterprise solution be implemented prior to adoption.

Compare more pros, cons, and characteristics of [enterprise operations in the Cloud Adoption Framework](https://docs.microsoft.com/azure/cloud-adoption-framework/operating-model/compare#enterprise-operations?azure-portal=true).

## Distributed operations

Distributed operations is the most complex form of operations, which attempts to blend each of the models above.

:::image type="content" source="../media/complex-operations.png" alt-text="Image explaining distributed operations attempts to integrate various current operating models." border="false":::

_Figure 5: Distributed operations attempts to integrate various current operating models._

This approach to operations is discouraged when ever possible. This approach is commonly seen when companies grow through rapid acquisition resulting in a distributed mixture of the prior three operating models. Companies may exist in this state for extended periods of time, but in order to minimize redundancy and promote more efficient operations customers should consider developing a plan to transition to one of the less complex models.

**Strategic priority:** This model is used when organizations favor integration of acquired business units, over innovation or control. This is often a temporary or bridge strategy required to move to a more efficient operating model in the future. This model does tend to persist when the organization seeks to maintain autonomy and is considering a near term exit strategy, as is commonly seen in private equity or holding companies.

**Organization:** Centralized structure for the organization is challenging to maintain in the operating model. It is advised that organizations start with the formation of a cloud center of excellence virtual team early in the process to create visibility and awareness to operations around the organization.

**Portfolio scope:** Distributed operations focus on a complex portfolio. Over time, that focus can narrow down to focus on more granular levels of the portfolio.

**Accountability (separation of duties):** Accountability will vary among business units. Separation of duties from a central perspective is difficult to achieve.

**Standardization:** The first step towards standardization in a distributed operations model is to gain a clear view of the digital estate for the full portfolio. A data-driven approach will start to identify commonalities in the portfolio that lean towards a central or enterprise operations model.

**Operations priority:** Operations priority in this model is around data. Centralizing data using tools designed for unified operations will allow a cloud center of excellence team to coach and mentor the various business units during transitions or maturity efforts. Before forcing a consistent operations priority, evaluate the portfolio of workload operations to ensure proper tooling and baselines.

**Platform development velocity:** Evaluation of the portfolio of workload operations should identify an acceptable velocity for platform development that aligns to "start small" or "enterprise-scale" approaches. The primary data point to determine direction will depend on the most common operations management approach across the portfolio.

Compare more pros, cons, and characteristics of [distributed operations in the Cloud Adoption Framework](https://docs.microsoft.com/azure/cloud-adoption-framework/operating-model/compare#distributed-operations?azure-portal=true).
