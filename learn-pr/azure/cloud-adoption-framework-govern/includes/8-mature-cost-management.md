Cost management is often the first discipline that customers choose to mature in any governance engagement. This unit will outline the outcomes, tools, processes, and a reference implementation to mature your cost discipline.

## Discipline objective

The objective of Cost Management is to build confidence in your ability to control costs and respond to the following triggers by:

- Addressing concerns about budgets.
- Defining cost allocation across business units.
- Implementing cost guardrails.
- Analyzing workload costs.
- Applying operational best practices across your portfolio.
- Creating accountability for cost best practices with each workload team.

## Cost management best practices

The objective of this discipline is to apply these Cost Management best practices:

- Align teams and accountability.
- Manage best practices centrally.
- Establish best practices for workload levels.

### Best practices by team and accountability

Cost Management across the enterprise is a function of cloud governance and cloud operations. All Cost Management decisions change the assets that support a workload. When those changes impact a workload's architecture, additional considerations are required to minimize the impact on end users and business functions. It's likely for the cloud adoption team who configured or developed that workload to be accountable for following through with those changes.

- **Tagging is critical to all governance.** Ensure all workloads and resources follow [proper naming and tagging conventions](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging?azure-portal=true) and [enforce tagging conventions using Azure Policy](https://docs.microsoft.com/azure/governance/policy/tutorials/govern-tags?azure-portal=true).
- **Identify right size opportunities.** Review your current resource utilization and performance requirements across the environment.
- **Resize:** Modify each resource to use the smallest instance or SKU that can support the performance requirements of each resource.
- **Horizontal over vertical scale.** Using multiple small instances can allow for an easier scaling path that a single larger instance. This allows for scale automation, which creates cost optimization.

## Operational cost management best practices

The following best practices are typically completed by a member of the cloud governance or cloud operations team, in accordance with patching and other scheduled maintenance processes. These best practices map to actionable guidance later in this article.

- **Tagging is critical to all governance:** Ensure all workloads and resources follow [proper naming and tagging conventions](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging?azure-portal=true) and [enforce tagging conventions using Azure Policy](https://docs.microsoft.com/azure/governance/policy/tutorials/govern-tags?azure-portal=true).
- **Identify right size opportunities:** Review your current resource utilization and performance requirements across the environment to identify resources that have remained underutilized for more than 90 days.
- **Right-size provisioned SKUs:** Modify underutilized resource to use the smallest instance or SKU that can support the performance requirements of each resource.
- **Auto-shutdown for virtual machines (VM):** When a VM isn't used constantly, consider automated shutdown. The VM won't be deleted or decommissioned, but it will stop consuming compute and memory costs until it's turned back on.
- **Auto-shutdown all nonproduction assets:** If a VM is part of a nonproduction environment, specifically development environments, establish an auto-shutdown policy to reduce unused costs. Whenever possible, use Azure DevTest Labs as a self-service option to help developers hold themselves accountable for cost.
- **Shut down and decommission unused resources:** Yes, we said it twice. If a resource hasn't been used in more than 90 days and doesn't have a clear uptime requirement, turn it off. More importantly, if a machine has been stopped or shut down for more than 90 days, then deprovision and delete that resource. Validate that any data retention policies are met through backup or other mechanisms.
- **Clean up orphaned disks:** Delete unused storage, especially VM storage that is no longer attached to any VMs.
- **Right-size redundancy:** If the resource doesn't require a high degree of redundancy, remove geo-redundant storage.
- **Adjust autoscale parameters:** Operational monitoring is likely to uncover usage patterns for various assets. When those usage patterns map to the parameters used to drive autoscale behaviors, it's common for the operations team to adjust autoscale parameters to meet seasonal demand or changes to budget allocations. Review workload cost management best practices for important precautions.

## Workload cost management best practices

Before making architectural changes, consult the technical lead for the workload. Facilitate a review of the workload using the [Microsoft Azure Well-Architected Framework Overview](https://docs.microsoft.com/azure/architecture/framework?azure-portal=true) and [Introduction](https://docs.microsoft.com/learn/modules/azure-well-architected-introduction?azure-portal=true) to guide decisions regarding the following architectural changes:

- **Azure App Service:** Verify production requirements for any Premium tier App Service plans. Without an understanding of the business requirements for a workload and the underlying assets configuration, it's difficult to determine if a Premium tier plan is required.
- **Horizontal over vertical scale:** Using multiple small instances can allow for an easier scaling path that a single larger instance. This allows for scale automation, which creates cost optimization. Before a workload can scale horizontally, the technical team must verify that the application is idempotent. Achieving horizontal scale may first require changes to the code and configuration of various layers of the application.
- **Autoscale:** Enable autoscale on all app services to allow for a burstable number of smaller VMs. Enabling autoscale has the same idempotent requirement, which requires an understanding of the workload architecture. The workload and supporting assets must be approved for horizontal scaling and autoscaling by the adoption team, prior to any operational changes.
- **Implement serverless technologies:** VM workloads are often migrated "as is" to avoid downtime. Often VMs may host tasks that are intermittent, taking a short period to run, or alternatively many hours. For example, VMs that run scheduled tasks such as Windows task scheduler or PowerShell scripts. When these tasks aren't running, you're nevertheless absorbing VM and disk storage costs. After migration, consider rearchitecting layers of the workload to serverless technologies such as Azure Functions or Azure Batch jobs.

## The Cost Management process

The above best practices are actionable, but how and when do you apply them? Cost Management is a continuous discipline that involves and process with multiple roles.

:::image type="content" source="../media/cost-management-process.png" alt-text="The Cost Management discipline as a process." border="false":::
_Figure 1: The Cost Management discipline as a process._

Work with the central operations and workload teams to ensure proper ownership of each Cost Management best practice in Figure 1. Based on how you manage workloads in your environment, some of the best practices might move between teams. While select organizations place all cost management burden on central IT and without accountability for the workload teams, other organizations place all of the cost management burden on the workload team; here, central IT serves only as a reporting and budget management function. Most organizations fall somewhere between these two extremes.

Once you align roles, establish recurring processes to meet and hold each other accountable for this important recurring task.

## Azure Cost Management

Azure cost management is the default tool in Azure to bring all of the data together to manage your cost strategy.

Azure Cost Management brings together resource organization, Azure Advisor alerts, and your governance foundation to meet Cost Management needs.

## Exercise: Create a budget

To get started with Azure Cost Management, create your first budget using the steps in the [Azure Cost Management tutorial on creating a budget](https://docs.microsoft.com/azure/cost-management-billing/costs/tutorial-acm-create-budgets?azure-portal=true).

## Exercise: Find opportunities to optimize

If you have existing deployments in your Azure environment, you will likely have recommendations that could impact your overall spend. Complete the Azure Cost Management tutorial: [Act on recommendations](https://docs.microsoft.com/azure/cost-management-billing/costs/tutorial-acm-opt-recommendations?azure-portal=true) to view Advisor recommendations and other recommendations that could reduce your costs. Those recommendations will identify opportunities to apply the operational best practices listed above.

## Exercise: Limit cost risks with Azure Policy

To proactively limit unexpected costs, you can use Azure Policy to create guardrails that impact end users' ability to overspend. The two most common costs risks come from misunderstood decisions:

- Azure regions: Asset costs vary between Azure regions. When possible, you can use Azure Policy to limit deploying resources across regions.
- Azure SKUs: The SKU selected during deployment directly impact costs. Minimizing the use of expensive resources in self-service or workload-owned subscriptions can limit surprise budget overrun.

Add a policy to [Deny VM SKUs](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Fcccc23c7-8427-4f53-ad12-b6a63eb452b3?azure-portal=true) in your nonproduction environments to see this type of cost control policy in action.

Add a policy to specify [Allowed locations](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Fe56962a6-4747-49cd-b67b-bf8b01975c4c?azure-portal=true) for specific subscriptions to avoid cost drift related to regional pricing.
