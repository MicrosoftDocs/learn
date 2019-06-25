Adopting the cloud is a journey, not a destination. Along the way, there are clear milestones and tangible business benefits. However, the final state of cloud adoption is unknown when a company begins the journey. As your organization moves or deploys new applications to the cloud, this final state starts to form. It’s important to consider the following aspects of managing and operating a cloud platform:

- **Define governance solutions for your cloud environment** that meet your organization’s business needs, provide agility, and control risks.

- **Manage your cloud environment based on the governance solutions** to allow it to evolve, grow, and adapt to your organization’s changing business needs.

## Cloud govern

Cloud governance creates guardrails that keep the company on a safe path throughout the journey. The Cloud Adoption Framework governance model identifies key areas of importance. Each area relates to different types of risks the company must address as it adopts more cloud services.

### Define Corporate Policy

:::row:::
:::column:::

![business risk icon](../media/business-risk.png)

:::column-end:::
:::column span="3":::

**Business risks**

Document evolving business risks and the business' tolerance for risk, based on data classification and application critically.

:::column-end:::
:::row-end:::
:::row:::
:::column:::

![policy and compliance icon](../media/policy-compliance.png)

:::column-end:::
:::column span="3":::

**Policy & Compliance**

Convert Risk decisions into policy statements to establish cloud adoption boundaries.

:::column-end:::
:::row-end:::
:::row:::
:::column:::

![process icon](../media/process.png)

:::column-end:::
:::column span="3":::

**Process**

Establish processes to monitor violations and adherence to corporate policies.

:::column-end:::
:::row-end:::
:::row:::
:::column:::

:::column-end:::
:::column:::

:::column-end:::
:::row-end:::

### Five Disciplines of Cloud Governance

:::row:::
:::column:::

![cost management icon](../media/cost-management.png)

:::column-end:::
:::column span="3":::

**Cost Management**

Evaluate & monitor costs, limit IT spend, scale to meet need, create cost accountability.

:::column-end:::
:::row-end:::
:::row:::
:::column:::

![security baseline icon](../media/security-baseline.png)

:::column-end:::
:::column span="3":::

**Security Baseline**

Ensure compliance with IT Security requirements by applying a security baseline to all adoption efforts.

:::column-end:::
:::row-end:::
:::row:::
:::column:::

![resource consistency icon](../media/resource-consistency.png)

:::column-end:::
:::column span="3":::

**Resource Consistency**

Ensure consistency in resource configuration. Enforce practices for on-boarding, recovery and discoverability.

:::column-end:::
:::row-end:::
:::row:::
:::column:::

![identity baseline icon](../media/identity-baseline.png)

:::column-end:::
:::column span="3":::

**Identity Baseline**

Ensure the baseline for identity and access are enforced by consistently applying role definitions and assignments.

:::column-end:::
:::row-end:::
:::row:::
:::column:::

![deployment acceleration icon](../media/deployment-acceleration.png)

:::column-end:::
:::column span="3":::

**Deployment Acceleration**

Accelerate deployment through centralization, consistency and standardization across deployment templates.

:::column-end:::
:::row-end:::
:::row:::
:::column:::

:::column-end:::
:::column:::

:::column-end:::
:::row-end:::

Because governance requirements will evolve throughout the cloud adoption journey, a flexible approach to governance is required, and IT governance must move quickly and keep pace with business demands to stay relevant during cloud adoption.

An **incremental governance** approach empowers these traits. Incremental governance relies on a small set of corporate policies, processes, and tools to establish a foundation for adoption and governance. That foundation is called a **minimum viable product (MVP)**. An MVP allows the governance team to quickly incorporate governance into implementations throughout the adoption lifecycle. Once this MVP has been deployed, additional layers of governance can be quickly incorporated into the environment.

> [!TIP]
> To begin evaluating where you should start to implement your own cloud governance, use the Cloud Governance Tool linked in the “Summary and resources” unit at the end of this module. 

## Cloud manage

The goal of the Cloud Adoption Framework Operate methodology is to maximize on-going business returns by creating balance between stability and operational costs. Stable business operations lead to stable revenue streams, while controlled operational costs reduce the overhead to drive more profit from the business processes. Creating this balance is a two-step process outlined below.

### Business Stability

:::row:::
:::column:::

![Criticality icon](../media/criticality.png)

:::column-end:::
:::column span="3":::

**Criticality**

Document the Criticality and relative business value of each workload.

:::column-end:::
:::row-end:::
:::row:::
:::column:::

![Impact icon](../media/impact.png)

:::column-end:::
:::column span="3":::

**Impact**

Establish clear performance expectations and business interruption time/value metrics.

:::column-end:::
:::row-end:::
:::row:::
:::column:::

![Commitment icon](../media/commitment.png)

:::column-end:::
:::column span="3":::

**Commitment**

Document, track, and report on commitments to cost and performance.

:::column-end:::
:::row-end:::
:::row:::
:::column:::

:::column-end:::
:::column:::

:::column-end:::
:::row-end:::

### Cloud Operations

:::row:::
:::column:::

![inventory and visibility icon](../media/inventory-visibility.png)

:::column-end:::
:::column span="3":::

**Inventory & Visibility**

Establish a defined inventory of assets. Develop visibility into the asset telemetry.

:::column-end:::
:::row-end:::
:::row:::
:::column:::

![operational compliance icon](../media/operational-compliance.png)

:::column-end:::
:::column span="3":::

**Operational Compliance**

Manage configuration drift and standards. Apply management automation and controls.

:::column-end:::
:::row-end:::
:::row:::
:::column:::

![protect and recover icon](../media/protect-recover.png)

:::column-end:::
:::column span="3":::

**Protect & Recover**

Implement solutions to minimize performance interruptions and ensure rapid recovery when needed.

:::column-end:::
:::row-end:::
:::row:::
:::column:::

![platform operations icon](../media/platform-operations.png)

:::column-end:::
:::column span="3":::

**Platform Operations**

Customize operations to improve performance aspects specific to the commonly leveraged platforms.

:::column-end:::
:::row-end:::
:::row:::
:::column:::

![workload operations icon](../media/workload-operations.png)

:::column-end:::
:::column span="3":::

**Workload Operations**

Understand workload telemetry. Customize operations to maximize workload performance and functionality.

:::column-end:::
:::row-end:::
:::row:::
:::column:::

:::column-end:::
:::column:::

:::column-end:::
:::row-end:::

**Business stability** requirements are defined through negotiations with the business regarding criticality, impact, and commitment. 
- During *criticality* processes, each workload is assigned a mission criticality and relative business value. These values can often come from the Migration Backlog efforts during the Plan phase.
- During *impact* processes, the architecture is reviewed to determine clearly defined performance expectations. Those expectations would include resource scalability, availability, and resiliency needs.
- During *commitment* processes, the team communicates architectural changes and establishes processes for tracking and reporting on commitments to cost and performance.

> [!TIP]
> Links to the scalability, availability, and resiliency resources are available in the “Summary and resources” unit at the end of this module.

**Cloud operations** creates a maturity model that helps the team fulfill commitments to the business. In the early stages of maturity, customers focus on basic needs such as inventory and visibility into cloud assets and performance. As operations in the cloud mature, the team can use cloud native or hybrid approaches to maintaining operational compliance, which reduces likelihood of interruptions through configuration and state management. Once compliance is achieved, protection and recovery services provide low impact ways to reduce the duration and impact of business process interruptions. During Platform operations, aspects of various platforms (like containers or data platforms) are adjusted and automated to improve performance.

At the highest stage of evolution, the team partners with business stakeholders to improve the architecture and operations of mission critical workloads. This phase builds on monitoring data, commitments, and Common Design Principles to implement workload level performance improvements.

:::row:::
![Icon of lightbulb](../media/key-takeaway.png)
:::column:::

Here are the key points from this unit:

:::column-end:::
:::row-end:::

- As your organization moves or deploys new applications to the cloud, it’s important to consider these aspects of operating a cloud platform:

    - Defining governance solutions for your cloud environment
    - Managing your cloud environment

- The Cloud Adoption Framework governance model identifies key areas of importance, each relating to different types of risks the company must address as it adopts more cloud services. There are five disciplines of cloud governance: cost management, security baseline, resource consistency, identity baseline, and deployment acceleration.

- The goal of the Cloud Adoption Framework Operate methodology is to maximize ongoing business returns by creating balance between business stability and cloud operations costs.

Next, let's see what you've learned about the Cloud Adoption Framework with a knowledge check.
