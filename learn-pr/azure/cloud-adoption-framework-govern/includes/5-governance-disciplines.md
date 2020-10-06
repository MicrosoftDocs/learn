Common governance disciplines within cloud platforms inform policies, align toolchains, and help organizations to determine how to best automate and enforce corporate policies across their unique cloud platforms.

## Governance disciplines

The following table summarizes each discipline from the Cloud Adoption Framework Govern methodology:

|  |  |
|--|--|
| <br> :::image type="content" source="../media/cost-management-icon.png" alt-text="Cost management icon." border="false"::: | <br> [Cost Management](https://docs.microsoft.com/azure/cloud-adoption-framework/govern/cost-management/?azure-portal=true): Cost is a primary concern for cloud users. Develop policies for cost control for all cloud platforms. |
| <br> :::image type="content" source="../media/security-baseline-icon.png" alt-text="Security baseline icon." border="false"::: | <br> [Security Baseline](https://docs.microsoft.com/azure/cloud-adoption-framework/govern/security-baseline/?azure-portal=true): Security is a complex subject that's unique to each company. Once security requirements are established, cloud governance policies and enforcement apply those requirements across network, data, and asset configurations.|
| <br> :::image type="content" source="../media/identity-baseline-icon.png" alt-text="Identity baseline icon." border="false"::: | <br> [Identity Baseline](https://docs.microsoft.com/azure/cloud-adoption-framework/govern/identity-baseline/?azure-portal=true): Inconsistencies in the application of identity requirements can increase the risk of breach. The Identity Baseline discipline focuses ensuring that identity is consistently applied across cloud adoption efforts. |
| <br> :::image type="content" source="../media/resource-consistency-icon.png" alt-text="Resource consistency icon." border="false"::: | <br> [Resource Consistency](https://docs.microsoft.com/azure/cloud-adoption-framework/govern/resource-consistency/?azure-portal=true): Cloud operations depend on consistent resource configuration. Through governance tooling, resources can be configured consistently to manage risks related to onboarding, drift, discoverability, and recovery. |
| <br> :::image type="content" source="../media/deployment-acceleration-icon.png" alt-text="Deployment acceleration icon." border="false"::: | <br> [Deployment Acceleration](https://docs.microsoft.com/azure/cloud-adoption-framework/govern/deployment-acceleration/?azure-portal=true): Centralization, standardization, and consistency in approaches to deployment and configuration improve governance practices. When provided through cloud-based governance tooling, they create a cloud factor that can accelerate deployment activities. |

## Resource Consistency

Resource consistency focuses on the initial organization of resources required to establish a foundation for governance. Long term, this discipline focuses on proper onboarding processes to ensure that all assets meet any operational support requirements.

:::image type="content" source="../media/resource-consistency.png" alt-text="The Resource Consistency baseline." border="false":::
_Figure 1: Resource Consistency._

A subsequent unit in this module will apply this discipline to the early needs of our customer narrative, Tailwind Traders.

## Cost Management

This discipline focuses on scaling the operational best practices for cost management, across all workloads and assets in your portfolio.

:::image type="content" source="../media/cost-management.png" alt-text="The Cost Management discipline." border="false":::
_Figure 2: The Cost Management discipline._

A future unit in this module will demonstrate how Tailwind Traders can add cost controls to their governance foundation.

## Security Baseline

This discipline focuses on automating the application of security principles to ensure consistency across your environment.

:::image type="content" source="../media/security-baseline.png" alt-text="The security baseline." border="false":::
_Figure 3: The Security Baseline discipline._

## Identity Baseline

Once you've established identity and access requirements for your cloud environment, this discipline ensures that those requirements are consistently applied to all workloads and assets.

:::image type="content" source="../media/identity-baseline.png" alt-text="The Identity Baseline discipline." border="false":::
_Figure 4: The Identity Baseline discipline._

## Deployment Acceleration

Automating governance leads to automation in adoption. Providing infrastructure-as-code templates to the various adoption teams allows them to quickly deploy workloads into compliant, well-managed environments.

:::image type="content" source="../media/deployment-acceleration.png" alt-text="The Deployment Acceleration discipline." border="false":::
_Figure 5: The Deployment Acceleration discipline._

## Tailwind Traders' risks

These disciplines help establish the right collection of processes, tools, and automation to address common risks and concerns.

| Discipline | Risks | Sample trigger | Sample action |
|-----------------------------|----------------|---------------|
| Cost Management | Overspending | Monthly cloud spending is 20 percent higher than expected. | Notify the billing unit leader who will begin a review of resource usage. |
| Cost Management | Overspending | Deployed assets are not using the allocated cpu or memory | Notify the billing unit leader and when possible automatically resize to fit actual usage. |
| Security Baseline | Security or compliance requirements | Detect any deviation from defined security or compliance. | Notify the IT security team and when possible automate remediation. |
| Security Baseline | Risk of improper access compromising systems or data | Traffic patterns deviate from approved network topologies | Notify the IT security team and when possible automatically close attack vectors. |
| Resource Consistency | Operations management issues or oversights | CPU utilization for a workload is greater than 90 percent. | Notify the IT operations team and scale out additional resources to handle the load. |
| Resource Consistency | Operations management issues or oversights | Assets that fail to meet patching or business continuity and disaster recovery requirements trigger operational compliance warning. | Notify the IT operations team and when possible automatically resolve the deviation. |
| Identity | Improper access compromising systems or data | Assets are configured without proper role assignments or elevated privileges | Notify the IT security team and when possible automatically resolve the deviation. |
| Deployment Acceleration | Inconsistent governance | Assets identified that are not included in required governance processes | Notify the IT governance team and when possible automatically resolve the deviation. |

Breaking these risks down into disciplines will help Tailwind Traders focus on addressing tangible risks and concerns against a prioritized backlog. In following units, we will look at some technical solutions to get you started with a cloud governance foundation to support each discipline. We'll also look at some technical solutions to address the cost management related risks.
