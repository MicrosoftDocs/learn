Now you feel confident in your ability to describe the process of migrating your Oracle databases to Azure SQL Managed Instance. However, you also want to convey to your managers how to optimize costs and simplify management in Azure.

When you're thinking about a cloud migration project, consider the following questions.

## How does your application fit within your organization's wider Azure strategy?

During a migration, you're primarily concerned with ensuring that your specific application successfully makes the transition to the cloud. At the same time, you're likely also part of a wider effort across your organization to adopt modern cloud-hosting solutions. As such, you need to understand the goals, limitations, and overall strategy of this effort.

Find guidance to help your organization plan, manage, and govern its cloud adoption process in the [Microsoft Cloud Adoption Framework for Azure](/azure/cloud-adoption-framework/). Following the best practices in this framework can help your organization achieve the best business outcomes possible in your cloud adoption effort. Make sure, when planning this effort, that you've considered the following concepts:

- Fit your workload within the wider organizational [cloud adoption strategy](/azure/cloud-adoption-framework/strategy/). This strategy includes both business justification and aspirational goals for the organization's cloud adoption efforts. If your organization hasn't already defined this strategy, work with your managers and wider business team to start the process of creating one.

- Understand or help establish your organization-wide [cloud adoption plan](/azure/cloud-adoption-framework/plan/) for all cloud-hosted workloads and how that affects your particular workload migration. This plan creates actionable plans from the overall strategy and can set you up for success [managing and organizing your Azure resources](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org).

- Determine how your application fits into the global [management group](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups) and [subscription](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-subscriptions) structure. Be aware of any permissions or administrative restrictions you may need to address.

- Plan for [governance](/azure/cloud-adoption-framework/govern/) after migration, based on organizational policies and processes. If you don't have these policies and processes, you'll need to create them prior to migration.

- Identify [security](/azure/cloud-adoption-framework/secure/) and [management](/azure/cloud-adoption-framework/manage/) requirements for your workloads. Are there network or access restrictions that need to be implemented as a matter of policy? Are there logging and alerting requirements you need to meet? Are there legal or other jurisdictional issues that apply to your data?

## How can you best optimize your costs on Azure?

Your management will want to understand how you plan to optimize Azure costs. Azure offers many potential cost benefits over traditional on-premises hosting, but to make the most of these benefits, you need to proactively [plan how to manage costs](/azure/cost-management-billing/understand/plan-manage-costs).

![Screen UI of example cost analysis in Azure.](../media/6-cost-optimization.png)

Cost optimization includes ensuring that the size and scale of your compute or storage usage is appropriate to your needs. For example, you may find that the VM sizes you chose for your app migration are larger than needed or that the VM instance count you're running to handle peak demand is much higher than during low-demand periods. Achieve savings by resizing your VMs to better match your needs or setting up scaling rules to add or remove instances on demand. Azure tools can help:

- Get insight into spending and areas where you could improve usage by using the [Microsoft Cost Management](/azure/cost-management-billing/costs/overview-cost-management) tools.

- Analyze deployed Azure resources and get performance and cost optimization recommendations from [Azure Advisor](/azure/advisor/advisor-overview).

- Help ensure that your solutions are reliable, secure, performant, and optimized for costs by following the [Azure Well-Architected Framework](/azure/well-architected/) approach when designing your Azure solutions. Specific [guidance for solutions built on Azure SQL Managed Instance](https://techcommunity.microsoft.com/t5/azure-sql-blog/optimize-your-azure-sql-managed-instance-cost-with-microsoft/ba-p/2235216) is available.

- Take self-paced training to learn how to manage Azure costs with the following learning path on Microsoft Learn: [Control Azure spending and manage bills with Microsoft Cost Management + Billing](/training/paths/control-spending-manage-bills/).

- Lock in pricing with [Azure Reservations](/azure/cost-management-billing/reservations/save-compute-costs-reservations) for significant savings over pay-as-you-go plans, if you can predict your cloud usage. Save more with [Azure Hybrid Benefit](/azure/azure-sql/azure-hybrid-benefit) by bringing your own SQL Server licenses covered under Software Assurance.
