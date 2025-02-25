## What is a business case?

Your organization depends on information technology (IT) for its operations, and probably for creating and supplying its products as well. It's a significant expense. For these reasons, a move to the cloud must be carefully considered and planned.

A business case provides a view of the technical and financial timeline of your environment, and can represent the opportunities for reinvestment into further modernization. Developing a business case includes building a financial plan that takes technical considerations into account and aligns with [business outcomes](/azure/cloud-adoption-framework/strategy/business-outcomes?azure-portal=true). It helps you foster support from your Finance team and other areas of the business, helps accelerate cloud migration, and enables business [agility](/azure/cloud-adoption-framework/strategy/business-outcomes/agility-outcomes?azure-portal=true).

## Key components of a business case

When you're planning your business case to migrate to the cloud, there are several key components to consider.

**Environment scope, technical and financial**: As you build out the on-premises view of your environment, think about how your environment scope, from both a technical and financial perspective, is aligned. You want to be sure the technical environment you're using for your plan matches up to the financial data.

**Baseline financial data**: Cost to run today: When you build out your business case, it’s important to pull your baseline financial data. Common questions you can ask to gather the financial data needed are:

* How much does it cost to run my environment today?
* What am I spending on servers in an average year?
* What am I spending in my data center operations categories, for example, power or lease costs?
* When is the next hardware refresh?

**Projections**: On-premises costs in on-premises scenario: Forecast what your on-premises costs are if you don’t migrate to the cloud.

:::image type="content" source="../media/optimization-opportunity.png" alt-text="Diagram of forecasting on-premises costs when not migrating to the cloud." border="false":::

**Projections: On-premises costs in Azure scenario**: Forecast what your on-premises costs are if you migrate to the cloud in an Azure scenario. It takes resources and time to shift your environment to the cloud, so it’s important to account for them in the business case. When you build out the Azure scenario, be sure to take into consideration and include all of the core benefits the cloud provides.

:::image type="content" source="../media/optimized-consumption-plan.png" alt-text="Diagram of forecasting on-premises costs when migrating to the cloud in an Azure scenario." border="false":::

**Projections: Migration timeline and Azure costs (optimized)**: Project what the migration timeline and Azure costs are with a given environment. Consider how you can optimize and get the most out of your Azure investment. For example, use reserved instances, scale capacity up and down, use the Azure hybrid benefit, and right-size your resources.

A business case isn't just a point-in-time view. It’s a plan for a time period. As you shift to the cloud, you reduce your spend over-time and create a cloud migration plan. You can model out what the ramp-down in spend will be on-premises over time associated with your cloud migration plan.

Once you've identified on-premises workloads and cost structure, you can then build out your optimized Azure consumption plan.

As a final step, when you create your business case, you want to compare the cloud environment to an on-premises or status quo scenario. You can take your Azure view and compare it to your on-premises or status quo scenario with no migration so you can assess the benefit of migrating to the cloud. The Azure view will show on-premises costs that are being reduced over time, your Azure environment costs, and any migration costs associated with shifting to a cloud environment.

:::image type="content" source="../media/cloud-on-premises-comparison.png" alt-text="Diagram of comparing the cloud to on-premises or the status quo." border="false":::

## Tools for preparing a business case

Azure offers a range of valuable tools and calculators to help you prepare a business case for your cloud migration.

**Azure Total Cost of Ownership (TCO) Calculator**: Use the [TCO Calculator](https://azure.microsoft.com/pricing/tco/calculator?azure-portal=true) online tool to estimate the cost savings you can realize when you migrate your workloads to Azure.

Enter details of your on-premises infrastructure into the tool including servers, databases, storage, and networking, licensing assumptions, and costs.

The Calculator creates a match from Azure Services to create a high-level initial TCO comparison. However, the results of the TCO Calculator need to be considered with care, since an on-premises server list is often complex, and optimization steps can be taken when considering Azure.

**Retail Rates Prices API**: Use the Retail Rates Prices API to retrieve retail prices for all Azure services. Previously, the only way to retrieve prices for Azure services was to either use the Azure Pricing Calculator or use the Azure portal. This API gives you an unauthenticated experience to get retail rates for all Azure services. Use the API to explore prices for Azure services against different regions and different SKUs. The programmatic API can also help you create your own tools for internal analysis and price comparison across SKUs and regions. To learn more, see [Retail Rates Prices API](/rest/api/cost-management/retail-prices/azure-retail-prices).

**Azure Pricing calculator**: Use the [Azure Pricing calculator](https://azure.microsoft.com/pricing/calculator?azure-portal=true) to configure and estimate the costs for Azure products.

**Partner toolsets**: Microsoft Partners have access to tools in the [Azure Marketplace](https://azuremarketplace.microsoft.com/home?azure-portal=true) that can help create a migration cost analysis.

**Solution assessments**: Get assistance from a Microsoft Solution Assessment expert or qualified partner as part of a [Solution Assessment engagement](https://www.microsoft.com/solutionassessments/).

**Azure Migration Program**: Join the [Azure Migration Program](https://azure.microsoft.com/migration/migration-program?azure-portal=true) to get the guidance and expert help you need at every stage of the cloud migration journey. Migrate infrastructure, databases, and apps, and move forward with confidence.

## Learn about Azure

Many other learning paths in [Microsoft Learn training](/training?azure-portal=true) can help you to build your business case:

* [Control Azure spending and manage bills with Microsoft Cost Management](/training/paths/control-spending-manage-bills?azure-portal=true)
* [Microsoft Azure Well-Architected Framework—Cost Optimization](/training/modules/azure-well-architected-cost-optimization?azure-portal=true)
* [Plan and manage your Azure costs](/training/modules/plan-manage-azure-costs?azure-portal=true).
* [Analyze costs and create budgets with Microsoft Cost Management](/training/modules/analyze-costs-create-budgets-azure-cost-management?azure-portal=true)
* [Save money with Azure Reserved Instances](/training/modules/save-money-with-azure-reserved-instances?azure-portal=true)
* [Optimize Azure costs with data analysis in Power BI](/training/modules/optimize-costs-data-analysis-powerbi?azure-portal=true)
* [Configure and manage costs as a Microsoft partner by using Microsoft Cost Management](/training/modules/manage-costs-partner-cost-management?azure-portal=true)
