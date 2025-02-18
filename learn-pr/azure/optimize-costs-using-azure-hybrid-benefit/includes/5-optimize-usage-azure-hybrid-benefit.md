Managing and keeping track of Azure Hybrid Benefit can be challenging. For organizations with several licenses and VMs, ensuring that you're utilizing your entitlements effectively while maintaining compliance with licensing agreements requires careful monitoring and management. It's essential to have a clear understanding of your organization's licensing landscape and establish processes for tracking and applying Azure Hybrid Benefit entitlements.

There are many ways to monitor your savings after applying Azure Hybrid Benefit:

- **Microsoft Cost Management.** You can use Cost Management (formerly known as *Azure Cost Management and Billing*) to track your savings. This tool provides detailed insights into your spending and savings, allowing you to monitor the impact of Azure Hybrid Benefit on your overall costs. You can create custom reports and dashboards to visualize your savings over time.
- **Azure Hybrid Benefit workbooks.** Azure Hybrid Benefit workbooks are customizable dashboards that help you track and visualize cost savings opportunities. You can tailor these workbooks to your specific needs so they provide insight into how you can optimize your cloud spending.
- **Azure portal.** From the Azure portal, you can review detailed cost analysis and savings reports. For example, the portal provides a comprehensive view of your resource usage and costs, including the savings achieved through Azure Hybrid Benefit.
- **Azure Marketplace.** When using Azure Marketplace, you can track your savings by selecting pay-as-you-go SQL Server images and activating Azure Hybrid Benefit during the creation process. This allows you to discover the cost savings directly in the marketplace.

You can track your Azure Hybrid Benefit use in the Azure portal by completing the following steps:

1. **Navigate to the Azure portal.** Access the Azure portal, and then sign in with your Azure account credentials.
1. **Open Cost Management + Billing.** To access a comprehensive view of your Azure spending and usage, in the navigation pane, select **Cost Management + Billing**.
1. **View cost analysis.** Under **Cost Management**, select **Cost analysis**. You can then use this tool to analyze your spending and usage data. You can then filter the data to specific resources, including those utilizing Azure Hybrid Benefit.
1. **Filter by Azure Hybrid Benefit.** In the **Cost analysis** view, select the **Add filter** option, and then select **Azure Hybrid Benefit**. This will display the costs and usage associated with resources that are leveraging Azure Hybrid Benefit.
1. **Monitor usage.** You can monitor Azure Hybrid Benefit usage by reviewing the detailed breakdown of costs and use. This includes information on how much you're saving by using Azure Hybrid Benefit, and which resources are benefiting from it.
1. **Create custom reports.** To create custom reports to track Azure Hybrid Benefit use over time, you can download the data from the **Cost analysis** view by selecting **Export**. If you want to analyze the data further, select the format you want the data exported in, such as CSV or Microsoft Excel.
1. **Set Up cost alerts.** To help stay informed with your Azure Hybrid Benefit usage or avoid unexpected costs, you can set up cost alerts. In the **Cost Management** section, select **Alerts**, and then create new alerts based on your spending and usage thresholds.

### Tracking Azure Hybrid Benefit using Azure Workbooks

Azure Workbooks provide a flexible, interactive, and customizable way to visualize and analyze your Azure resources. You can use Azure Workbooks to simplify the management of Azure Hybrid Benefit in your environment. By querying the Azure Resource Graph, the report gathers real-time information about your VM usage of Azure Hybrid Benefit and creates visualizations to help you understand your licensing landscape.

You can manage Azure Workbooks by completing the following steps:

1. **Access Azure Workbooks:**

    a. Navigate to the Azure portal and sign in with your Azure account credentials.

    b. From the navigation pane, select **Monitor**, and then select **Workbooks**. This opens the Azure Workbooks gallery, where you can create and manage workbooks.

1. **Create a new workbook or use an existing one:**
   - You can either create a new workbook or use an existing one. To create a new workbook, select **New**, and then select **Workbook**. To use an existing workbook, browse the Azure Workbooks gallery and select a workbook that suits your needs¾such as the **Cost Optimization Workbook**.

1. **Add data sources:**
    - In your workbook, add data sources that provide information about your Azure resources and their usage. You can add data sources like Azure Resource Graph, Azure Monitor Logs, and Microsoft Cost Management data.

1. **Configure queries:**
    - You can configure queries to retrieve data related to Azure Hybrid Benefit. For example, you can create a query to filter and display resources that utilize Azure Hybrid Benefit, such as Windows Server VMs, SQL Server VMs, or other eligible resources.

1. **Visualize data:**
    - Use various visualization options such as charts, graphs, tables, or other visual elements available in Azure Workbooks to display Azure Hybrid Benefit data such as usage and cost savings. For example, you can create a chart of the number of VMs using Azure Hybrid Benefit and the associated cost savings.

1. **Customize and save:**
    - Customize the workbook to meet your specific requirements. You can add parameters, filters, and interactive elements to make the workbook more dynamic and user-friendly. After you're satisfied with the configuration, you can save the workbook for future use.

1. **Monitor and analyze:**
    - Use the workbook to monitor and analyze Azure Hybrid Benefit usage over time. You can track cost savings, identify trends, and make informed decisions to optimize your Azure spending.

### Microsoft Cost Management

*Microsoft Cost Management* is a suite of tools that help organizations analyze, monitor, and optimize their Microsoft Cloud costs. It's available to anyone with access to a billing account, subscription, resource group, or management group.

You can access Cost Management within the billing and resource management experiences or separately as a standalone tool optimized for teams that manage cost across multiple scopes. You can also automate and extend native capabilities or enrich your own tools and processes.

To successfully implement Cost Management and optimize costs, your organization must be prepared with the proper tools for success. They also must be accountable for costs and take appropriate action to optimize spending.

To position your organization for successful cloud cost management, it's important to perform comprehensive, up-front planning and inform people about the Azure costs for which they're responsible. Also, you should make sure that the people responsible are accountable for their team's spending, consider purchase and licensing optimizations along with infrastructure deployment changes, and stay involved with the cost management lifecycle on an ongoing basis.

:::image type="content" source="../media/cost-management-value-prop-image-inline.png" alt-text="Screenshot of the Azure user interface in the Cost Management's Cost analysis section, which includes a stacked bar chart of spend categories by day." lightbox="../media/cost-management-value-prop-image-inline.png" border="false":::

While Cost Management is available from within the Billing experience, Cost Management is also available from every subscription, resource group, and management group in the Azure portal. This ensures everyone has full visibility into costs they're responsible for and can optimize their workloads to maximize efficiency. Cost Management is also available independently to streamline the cost management process across multiple billing accounts, subscriptions, resource groups, and/or management groups.

The main benefits of Cost Management are:

- It provides visibility into current cloud costs to help track usage, spot trends, and gain insights for informed decisions.

- It includes governance policies to increase accountability.

- It helps maximize the return on investment (ROI) of your Azure investment with continuous cost optimization.
