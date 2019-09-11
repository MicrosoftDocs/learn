The process of adopting the cloud is a journey, not a destination. Along the way, there are clear milestones and tangible business benefits. The final state of cloud adoption is unknown when an organization begins the journey. As your organization moves or deploys new applications to the cloud, this final state starts to form. It’s important to consider the following aspects of managing and operating a cloud platform:

- **Define governance solutions for your cloud environment** that meet your organization’s business needs, provide agility, and control risks.
- **Manage your cloud environment based on the governance solutions** to allow it to evolve, grow, and adapt to your organization’s changing business needs.

## Cloud governance

Cloud governance creates guardrails that keep the organization on a safe path throughout the journey. The Cloud Adoption Framework for Azure governance model identifies key areas of importance. Each area relates to different types of risks the organization must address as it adopts more cloud services.

### Define corporate policy

:::row:::
:::column:::

![Business risk icon](../media/business-risk.png)

:::column-end:::
:::column span="3":::

**Business risks**

Document evolving business risks and the business's tolerance for risk based on data classification and application critically.

:::column-end:::
:::row-end:::
:::row:::
:::column:::

![Policy and compliance icon](../media/policy-compliance.png)

:::column-end:::
:::column span="3":::

**Policy and compliance**

Convert risk decisions into policy statements to establish cloud adoption boundaries.

:::column-end:::
:::row-end:::
:::row:::
:::column:::

![Process icon](../media/process.png)

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

### Five disciplines of cloud governance

:::row:::
:::column:::

![Cost management icon](../media/cost-management.png)

:::column-end:::
:::column span="3":::

**Cost management**

Evaluate and monitor costs, limit IT spend, scale to meet need, and create cost accountability.

:::column-end:::
:::row-end:::
:::row:::
:::column:::

![Security baseline icon](../media/security-baseline.png)

:::column-end:::
:::column span="3":::

**Security baseline**

Ensure compliance with IT security requirements by applying a security baseline to all adoption efforts.

:::column-end:::
:::row-end:::
:::row:::
:::column:::

![Resource consistency icon](../media/resource-consistency.png)

:::column-end:::
:::column span="3":::

**Resource consistency**

Ensure consistency in resource configuration. Enforce practices for onboarding, recovery, and discoverability.

:::column-end:::
:::row-end:::
:::row:::
:::column:::

![Identity baseline icon](../media/identity-baseline.png)

:::column-end:::
:::column span="3":::

**Identity baseline**

Ensure the baseline for identity and access are enforced by consistently applying role definitions and assignments.

:::column-end:::
:::row-end:::
:::row:::
:::column:::

![Deployment acceleration icon](../media/deployment-acceleration.png)

:::column-end:::
:::column span="3":::

**Deployment acceleration**

Accelerate deployment through centralization, consistency, and standardization across deployment templates.

:::column-end:::
:::row-end:::
:::row:::
:::column:::

:::column-end:::
:::column:::

:::column-end:::
:::row-end:::

Because governance requirements will evolve throughout the cloud adoption journey, a flexible approach to governance is required. IT governance must move quickly and keep pace with business demands to stay relevant during cloud adoption.

An *incremental governance* approach empowers these traits. Incremental governance relies on a small set of corporate policies, processes, and tools to establish a foundation for adoption and governance. That foundation is called a *minimum viable product (MVP)*. An MVP allows the governance team to quickly incorporate governance into implementations throughout the adoption lifecycle. After this MVP is deployed, additional layers of governance can be quickly incorporated into the environment.

> [!TIP]
> To determine where you should start to implement your own cloud governance, use the Cloud Governance Tool linked in the “Summary and resources” unit at the end of this module.

## Cloud management

The goal of the Cloud Adoption Framework Operate methodology is to maximize ongoing business returns by creating balance between stability and operational costs. Stable business operations lead to stable revenue streams. Controlled operational costs reduce the overhead to drive more profit from the business processes. To create this balance, follow the two-step process outlined here.

### Business stability

:::row:::
:::column:::

![Criticality icon](../media/criticality.png)

:::column-end:::
:::column span="3":::

**Criticality**

Document the criticality and relative business value of each workload.

:::column-end:::
:::row-end:::
:::row:::
:::column:::

![Impact icon](../media/impact.png)

:::column-end:::
:::column span="3":::

**Impact**

Establish clear performance expectations and business interruption time and value metrics.

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

### Cloud operations

:::row:::
:::column:::

![Inventory and visibility icon](../media/inventory-visibility.png)

:::column-end:::
:::column span="3":::

**Inventory and visibility**

Establish a defined inventory of assets. Develop visibility into the asset telemetry.

:::column-end:::
:::row-end:::
:::row:::
:::column:::

![Operational compliance icon](../media/operational-compliance.png)

:::column-end:::
:::column span="3":::

**Operational compliance**

Manage configuration drift and standards. Apply management automation and controls.

:::column-end:::
:::row-end:::
:::row:::
:::column:::

![Protect and recover icon](../media/protect-recover.png)

:::column-end:::
:::column span="3":::

**Protect and recover**

Implement solutions to minimize performance interruptions and ensure rapid recovery when needed.

:::column-end:::
:::row-end:::
:::row:::
:::column:::

![Platform operations icon](../media/platform-operations.png)

:::column-end:::
:::column span="3":::

**Platform operations**

Customize operations to improve performance aspects specific to the commonly leveraged platforms.

:::column-end:::
:::row-end:::
:::row:::
:::column:::

![Workload operations icon](../media/workload-operations.png)

:::column-end:::
:::column span="3":::

**Workload operations**

Understand workload telemetry. Customize operations to maximize workload performance and functionality.

:::column-end:::
:::row-end:::
:::row:::
:::column:::

:::column-end:::
:::column:::

:::column-end:::
:::row-end:::

**Business stability** requirements are defined through negotiations with the business in regard to criticality, impact, and commitment. 
- During *criticality* processes, each workload is assigned a mission criticality and relative business value. These values can often come from the migration backlog efforts during the Plan phase.
- During *impact* processes, the architecture is reviewed to determine clearly defined performance expectations. Those expectations include resource scalability, availability, and resiliency needs.
- During *commitment* processes, the team communicates architectural changes and establishes processes for tracking and reporting on commitments to cost and performance.

> [!TIP]
> Links to the scalability, availability, and resiliency resources are available in the “Summary and resources” unit at the end of this module.

**Cloud operations** creates a maturity model that helps the team fulfill commitments to the business. In the early stages of maturity, customers focus on basic needs such as inventory and visibility into cloud assets and performance. As operations in the cloud mature, the team can use cloud native or hybrid approaches to maintaining operational compliance, which reduces the likelihood of interruptions through configuration and state management. After compliance is achieved, protection and recovery services provide low-impact ways to reduce the duration and effect of business process interruptions. During platform operations, aspects of various platforms (like containers or data platforms) are adjusted and automated to improve performance.

At the highest stage of evolution, the team partners with business stakeholders to improve the architecture and operations of mission-critical workloads. This phase builds on monitoring data, commitments, and common design principles to implement workload-level performance improvements.

:::row:::
![Icon of lightbulb](../media/key-takeaway.png)
:::column:::

Here are the key points from this unit:

:::column-end:::
:::row-end:::

- As your organization moves or deploys new applications to the cloud, it’s important to consider these aspects of operating a cloud platform:
    - Define governance solutions for your cloud environment.
    - Manage your cloud environment.
- The Cloud Adoption Framework governance model identifies key areas of importance. Each area relates to different types of risks the organization must address as it adopts more cloud services. There are five disciplines of cloud governance: cost management, security baseline, resource consistency, identity baseline, and deployment acceleration.
- The goal of the Cloud Adoption Framework Operate methodology is to maximize ongoing business returns by creating balance between business stability and cloud operations costs.

Next, let's see what you've learned about the Cloud Adoption Framework with a knowledge check.
