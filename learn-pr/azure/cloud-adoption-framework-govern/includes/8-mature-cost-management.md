## Monitor cloud governance

After your policies are in place and you align your organization's processes and procedures with the policies, you must monitor your cloud governance compliance. Use monitoring to determine areas that lack compliance and make changes to reduce noncompliance problems.

Add examples of the Tailwind story

Use monitoring tools

Use compliance dashboards
Determine compliance

Configure alerts
define noncompliance
route alerts

Develop a remediation plan







### Best practices by team and accountability

Cost management across the enterprise is a function of cloud governance and cloud operations. All cost-management decisions change the assets that support a workload. When those changes affect a workload's architecture, other considerations are required to minimize the impact on users and business functions. It's likely that the cloud-adoption team that configured or developed that workload is accountable for following through with those changes.

- **Tagging is critical to all governance**: Make sure that all workloads and resources follow [proper naming and tagging conventions](/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging) and that you [enforce tagging conventions by using Azure Policy](/azure/governance/policy/tutorials/govern-tags).

- **Identify right-size opportunities**: Review your current resource utilization and performance requirements across the environment.
- **Resize**: Modify each resource to use the smallest instance or SKU that can support the performance requirements of each resource.
- **Horizontal versus vertical scale**: Using multiple small instances can give you an easier scaling path than a single larger instance. Using multiple smaller instances supports scale automation, which creates cost optimization.

### Operational cost management best practices

The following best practices typically are achieved by a member of the cloud-governance or cloud-operations team in accordance with patching and other scheduled maintenance processes. These best practices map to actionable guidance we describe later in this unit.

- **Tagging is critical to all governance**: Ensure that all workloads and resources follow [proper naming and tagging conventions](/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging) and that you [enforce tagging conventions by using Azure Policy](/azure/governance/policy/tutorials/govern-tags).

- **Identify right-size opportunities**: Review your current resource utilization and performance requirements across the environment to identify resources that have remained underutilized for more than 90 days.
- **Right-size provisioned SKUs**: Modify underutilized resources to use the smallest instance or SKU that can support the performance requirements of each resource.
- **Autoshutdown for virtual machines (VMs)**: When a VM isn't used constantly, consider automated shutdown. The VM isn't deleted or decommissioned, but it does stop consuming compute and memory costs until it's turned back on.
- **Autoshutdown for all nonproduction assets**: If a VM is part of a nonproduction environment, specifically in a development environment, establish an autoshutdown policy to reduce the cost of nonuse. Whenever possible, use Azure DevTest Labs as a self-service option to help developers hold themselves accountable for cost.
- **Shut down and decommission unused resources**: Yes, we said it twice. If a resource hasn't been used in more than 90 days and doesn't have a clear uptime requirement, turn it off. More importantly, if a machine has been stopped or shut down for more than 90 days, deprovision and delete that resource. Validate that any data-retention policies are met through backup or other mechanisms.
- **Clean up orphaned disks**: Delete unused storage, especially VM storage that's no longer attached to a VM.
- **Right-size redundancy**: If the resource doesn't require a high degree of redundancy, remove geo-redundant storage.
- **Adjust autoscale parameters**: Operational monitoring is likely to uncover usage patterns for various assets. When those usage patterns map to the parameters that are used to drive autoscale behaviors, it's common for the operations team to adjust autoscale parameters to meet seasonal demand or changes to budget allocations. Review workload cost management best practices for important precautions.

### Workload cost management best practices

Before making architectural changes, consult the technical lead for the workload. Facilitate a review of the workload by using the [Azure Well-Architected Framework overview](/azure/architecture/framework/) and [introduction](/training/modules/azure-well-architected-introduction/) to guide decisions about the following architectural changes:

- **Azure App Service**: Verify production requirements for any Premium tier App Service plan. Without an understanding of the business requirements for a workload and the underlying assets configuration, it's difficult to determine whether a Premium tier plan is required.

- **Horizontal versus vertical scale**: Using multiple small instances can give you an easier scaling path than a single larger instance. Using small instances supports scale automation, which creates cost optimization. Before a workload can scale horizontally, the technical team must verify that the application is idempotent. Achieving horizontal scale might first require changes to the code and configuring various layers of the application.
- **Autoscale**: Enable autoscale on all app services for a burstable number of smaller VMs. Enabling autoscale has the same idempotent requirement, which requires an understanding of the workload architecture. The workload and supporting assets must be approved for horizontal scaling and autoscaling by the cloud-adoption team before any operational changes are made.
- **Implement serverless technologies**: VM workloads often are migrated as-is to avoid downtime. Often, VMs host tasks that are intermittent, tasks that take a short period to run, or tasks that run for many hours. Examples are VMs that run scheduled tasks, like Windows task scheduler or PowerShell scripts. When these tasks aren't running, you're still paying for the VMs and disk storage. After migration, consider rearchitecting layers of the workload as serverless technologies like Azure Functions or Azure Batch jobs.

## Microsoft Cost Management

Microsoft Cost Management is your default tool in Azure to bring together all the data for managing your cost strategy.

Microsoft Cost Management brings together resource organization, Azure Advisor alerts, and your governance foundation to meet your cost management needs.

Monitor resource optimization. Use Azure Advisor to monitor Azure resources for reliability, security, operational excellence, performance, and cost. Set alerts for any new Advisor recommendations.

Configure cost alerts

### Exercise: Create a budget

To get started with Microsoft Cost Management, create your first budget with the [Create and manage Azure budgets](/azure/cost-management-billing/costs/tutorial-acm-create-budgets) tutorial.

### Exercise: Find opportunities to optimize

If you have existing deployments in your Azure environment, you likely have recommendations in the Azure portal that might affect your overall spending. Complete the [Optimize costs from recommendations](/azure/cost-management-billing/costs/tutorial-acm-opt-recommendations) tutorial to view recommendations from Azure Advisor and other recommendations that might reduce your costs. The recommendations identify opportunities to apply the operational best practices described in this unit.

### Exercise: Use Azure Policy to prevent cost risks

To proactively limit unexpected costs, you can use Azure Policy to create guardrails that affect the ability of any role to overspend. The two most common cost risks come from misunderstood decisions:

- **Azure regions**: Asset costs vary between Azure regions. When possible, you can use Azure Policy to limit deploying resources across regions.

- **Azure SKUs**: The SKU that's selected during deployment directly affects costs. Minimizing the use of expensive resources in self-service or workload-owned subscriptions can limit surprise budget overrun.

Add a policy to [deny VM SKUs](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Fcccc23c7-8427-4f53-ad12-b6a63eb452b3) in your nonproduction environments to see this type of cost control policy in action.

Add a policy to specify [allowed locations](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Fe56962a6-4747-49cd-b67b-bf8b01975c4c) for specific subscriptions to avoid cost drift related to regional pricing.
