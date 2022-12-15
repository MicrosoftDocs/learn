In this exercise, we're going to query two data sources and then use visualizations to allow you to analyze the results. We'll also use the options for rendering the visualizations to make them easily readable and user-friendly.

- We're going to query **Azure Resource Health** to easily see service issues affecting your resources. We'll group the resources that are experiencing issues and the resources that aren't experiencing issues, so that you can easily see what needs intervention.
- We're going to use **Azure Monitor Metrics** which use numeric data collected at regular intervals to measure a specific aspect of a system at a particular time. We'll create a graph that displays important metrics, such as CPU usage, failed requests, or available memory.

We'll display the results using these visualizations:
 - a chart that provides a quick visual overview of the health of the infrastructure running our application
 - a color-coded honeycomb graph to show the CPU usage of your virtual machines

Keep in mind that the data sources and visualizations in this tutorial are just two examples you can include in your workbooks.

## Add a visualization to show the availability of your resources

1. In your workbook, select **Edit** from the top toolbar.
1. Select **Add**, and then **Add Query**.
    - In the **Data source** field, select **Azure Resource Health**.
    - In the **Resource type** field, select **Subscriptions**.
    - In the **Subscriptions** field, select the **Subscription** resource parameter. You will see a list of all of the Azure resources in the subscription.

        :::image type="content" source="../media/5-resource-health-query.png" alt-text="Screenshot that shows a resource health query in Azure workbooks. ":::

1. To group the resources by Availability state:
    - Select **Column settings** at the top of the control.
    - In the **Tree/Group by** section, select **Group by**, and then select **Availability state**.
    - Select **Save and Close**.
    - In **Advanced Settings**, enter a name for the chart, such as "Resource Health" in the **Chart title**.
    - Select **Done editing**.
    You now have a chart listing all of the Azure resources in the subscription, grouped by availability.

    :::image type="content" source="../media/5-resource-health-query-grouped.png" alt-text="Screenshot that shows an Azure Workbook with resources grouped by availability. "::: 

## Add a visualization that shows the CPU usage of your virtual machines
