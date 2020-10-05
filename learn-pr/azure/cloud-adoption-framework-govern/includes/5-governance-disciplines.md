With any cloud platform, there are common governance disciplines that help inform policies and align toolchains. These disciplines guide decisions about the proper level of automation and enforcement of corporate policy across cloud platforms.

## Governance disciplines

The following table summarizes each of the governance disciplines

|  |  |
|--|--|
| <br> :::image type="content" source="https://docs.microsoft.com/azure/cloud-adoption-framework/_images/govern/cost-management.png" alt-text="cost management icon" border="false"::: | <br> [Cost Management](https://docs.microsoft.com/azure/cloud-adoption-framework/govern/cost-management/index.md): Cost is a primary concern for cloud users. Develop policies for cost control for all cloud platforms. |
| <br> :::image type="content" source="https://docs.microsoft.com/azure/cloud-adoption-framework/_images/govern/security-baseline.png" alt-text="security baseline icon" border="false"::: | <br> [Security Baseline](https://docs.microsoft.com/azure/cloud-adoption-framework/govern/security-baseline/index.md): Security is a complex subject, unique to each company. Once security requirements are established, cloud governance policies and enforcement apply those requirements across network, data, and asset configurations.|
| <br> :::image type="content" source="https://docs.microsoft.com/azure/cloud-adoption-framework/_images/govern/identity-baseline.png" alt-text="Identity baseline icon" border="false"::: | <br> [Identity Baseline](https://docs.microsoft.com/azure/cloud-adoption-framework/govern/identity-baseline/index.md): Inconsistencies in the application of identity requirements can increase the risk of breach. The Identity Baseline discipline focuses ensuring that identity is consistently applied across cloud adoption efforts. |
| <br> :::image type="content" source="https://docs.microsoft.com/azure/cloud-adoption-framework/_images/govern/resource-consistency.png" alt-text="Resource consistency icon" border="false"::: | <br> [Resource Consistency](https://docs.microsoft.com/azure/cloud-adoption-framework/govern/resource-consistency/index.md): Cloud operations depend on consistent resource configuration. Through governance tooling, resources can be configured consistently to manage risks related to onboarding, drift, discoverability, and recovery. |
| <br> :::image type="content" source="https://docs.microsoft.com/azure/cloud-adoption-framework/_images/govern/deployment-acceleration.png" alt-text="deployment acceleration icon" border="false"::: | <br> [Deployment Acceleration](https://docs.microsoft.com/azure/cloud-adoption-framework/govern/deployment-acceleration/index.md): Centralization, standardization, and consistency in approaches to deployment and configuration improve governance practices. When provided through cloud-based governance tooling, they create a cloud factor that can accelerate deployment activities. |

## Resource Consistency

Resource consistency focuses on the initial organization of resources required to establish a foundation for governance. Longer term, this discipline focuses on proper on-boarding processes to ensure that all assets meet any operational support requirements.

:::image type="content" source="../media/resource-consistency.png" alt-text="resource consistency" border="false":::

A subsequent unit in this module will apply this discipline to the early needs of our customer narrative, Tailwind Traders.

## Cost Management

This discipline focuses on scaling the operational best practices for cost management, across all workloads and assets in your portfolio.

:::image type="content" source="../media/cost-management.png" alt-text="cost management" border="false":::

A subsequent unit in this module will demonstrate how Tailwind Traders can expand their governance foundation to add cost controls to their governance foundation.

## Security Baseline

This discipline focuses on automating the application of security principles to ensure consistency across your environment.

:::image type="content" source="../media/security-baseline.png" alt-text="security baseline" border="false":::

## Identity Baseline

Once you've established identity and access requirements for your cloud environment, this discipline ensures that those requirements are consistently applied to all workloads and assets.

:::image type="content" source="../media/identity-baseline.png" alt-text="identity baseline" border="false":::

## Deployment Acceleration

Automation of governance leads to automation in adoption. Providing infrastructure-as-code templates to the various adoption teams, allows them to quickly deploy workloads into compliant, well-managed environments.

:::image type="content" source="../media/deployment-acceleration.png" alt-text="deployment acceleration" border="false":::

## Tailwind Traders' risks

These disciplines help establish the right collection of processes, tools, and automation to address common risks and concerns.

| Discipline | Risks | Sample trigger | Sample action |
|-----------------------------|----------------|---------------|
| Cost Management | Overspending | Monthly cloud spending is more than 20% higher than expected. | Notify the billing unit leader who will begin a review of resource usage. |
| Cost Management | Overspending | Deployed assets are not using the allocated cpu or memory | Notify the billing unit leader and when possible automatically resize to fit actual usage. |
| Security Baseline | Security or compliance requirements | Detect any deviation from defined security or compliance. | Notify the IT security team and when possible automate remediation. |
| Security Baseline | Risk of improper access compromising systems or data | Traffic patterns deviate from approved network topologies | Notify the IT security team and when possible automatically close attack vectors. |
| Resource Consistency | Operations management issues or oversights | CPU utilization for a workload is greater than 90%. | Notify the IT operations team and scale out additional resources to handle the load. |
| Resource Consistency | Operations management issues or oversights | Assets that fail to meet patching or BCDR requirements trigger operational compliance warning. | Notify the IT operations team and when possible automatically resolve the deviation. |
| Identity | Improper access compromising systems or data | Assets are configured without proper role assignments or elevated privileges | Notify the IT security team and when possible automatically resolve the deviation. |
| Deployment Acceleration | Inconsistent governance | Assets identified that are not included in required governance processes | Notify the IT governance team and when possible automatically resolve the deviation. |

Breaking these risks down into disciplines will help Tailwind Traders focus on addressing tangible risks and concerns against a prioritized backlog. In following units, we will look at some technical solutions to get you started with a cloud governance foundation to support each discipline. We'll also look at some technical solutions to address the cost management related risks.
