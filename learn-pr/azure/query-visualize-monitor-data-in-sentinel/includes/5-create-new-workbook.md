Built-in templates can be used to create a customized workbook. However, you can also create a new workbook from scratch to produce highly interactive reports that contains, texts, analytic queries, metrics, and parameters.

## Create a custom workbook

You can create a custom workbook, by selecting **+Add workbook** in the header pane from the **Workbooks** page in the Azure Sentinel.

The **New workbook** page contains basic analytics query to get you started.

> [!Tip]

> Each workbook that you create is saved as a workbook resource in the Azure Sentinel resource group.

![](RackMultipart20201108-4-10kj3z7_html_faa6cadbe1d32d14.png)

You can start building your workbook by selecting **Edit.** From the right side of the **New Workbook** page select the **Edit** button to change the text that will appear in the new workbook template.

Each workbook provides a rich set of capabilities for visualizing the security data collected from the connectors. You can design your workbook with the following visualization types and elements:

- Text
- Query
- Parameters
- Links/tabs
- Metric

You can add new element to your workbook, by selecting **+Add,** as it shown in the following screenshot:

![](RackMultipart20201108-4-10kj3z7_html_fe37c8ffceef563f.png)

## Text visualizations

You can use text blocks to interpret your security data, section headings, telemetry data, etc. The text is edited through a Markdown formatting, that provides different heading and font styles, hyperlinks, tables, etc.

> [!Note]

> Markdown is markup language used to add format text in the plain text documents. For more information how to format text using Markdown control see the following [Markdown guide](https://www.markdownguide.org/getting-started/).

Once that you add the text, you can select **Preview** tab, to see how your content will look. Finally, when you complete editing the text, you should select **Done Editing** button.

![](RackMultipart20201108-4-10kj3z7_html_84741b6d55068e0d.png)

##

## Query item

You can create a different query from the logs and visualize the data as text, charts, or grids. You can write the query using KQL query and format the data using various visualizations:

- Grids (or tables)
- Area charts
- Bar charts
- Line charts
- Pie charts
- Scatter charts
- Time charts
- Tiles

When you create a query, a new step is added in the workbook as shown in the screenshot:

![](RackMultipart20201108-4-10kj3z7_html_4b90a0fa7f08caeb.png)

In the header bar there are several fields that provides you with the option to tune the output of the query.

| Run Query | This button will test the result of the query |
| --- | --- |
| Samples | Microsoft provide sample code that contains sample query that can be added to the workbook |
| Data Source | Specify the source of the data for the query |
| Resource type | You can select the type of the resource |
| Log Analytics workspace | You can query data against more than one resource |
| Time Range | You can specify a time range parameter to use in the query |
| Visualization | You can choose a specific visualization, or choose **Set by query** to present the data in different format |
| Size | You can choose the size of the visualization element |
| Color palette | You can choose specific series colors in chart settings |

In the **Advanced Settings** tab, you can provide additional customization on the settings and the style of your step. In the advanced setting tab, you can modify properties in two tabs:

- **Settings** tab. You use this tab to provide values that affect how the step will look.
- **Style** tab. You use this tab to set the values that affect how this step will look.

For example, in the **Settings** tab, you can enter the **Chart title** , as is shown in the following screenshot:

![](RackMultipart20201108-4-10kj3z7_html_9b52d138cff37780.png)

You can use the **Style** tab to adjust the margin and padding element in the step.

Do not forget, after you done all the customization to save the step by selecting **Done Editing**.

## Chart visualizations

When you create a query to present the security data as charts, you can customize:

- Height
- Width
- Color palette
- Legend
- Titles
- Axis types and series

You can use the following example to count all the security alert and visualize them in the pie chart.

'''
Kusto

SecurityAlert
| where TimeGenerated \&gt;= ago(180d)
| summarize Count=count() by AlertSeverity
| render piechart
'''

In the previous example, the visualization type of the data was provided in the query. You can enter the same query without render parameter and then use the **Visualization** drop-down menu to select one of the offered types of visualizations, shown in the following screenshot:

## ![](RackMultipart20201108-4-10kj3z7_html_88ea913b4aad37f6.png)

## Grid visualizations

You can use grids visualization to present the data in tables, which enrich the UI for the reports. You can select grid visualization, from the **Visualization** drop-down menu. Then you can select **Column Settings** button, to specify which column will be visible in the table and to provide column labels if necessary.

In the **Edit Column settings** tab, you can select different column renderer, for example, heatmap, bar, spark area, etc. If you select **Custom formatting** , you can set units, style, and formatting options for number values, as shown in the following screenshot:

![](RackMultipart20201108-4-10kj3z7_html_d2a4e739aee8224.png)

## Parameters

You can use parameters into your interactive workbook to manipulate the results of the query in different way.

When you create a new parameter step in the workbook, a **New Parameter** page is opened, where you can provide the name and other inputs required for the parameter.

You can create the following parameter types:

- You can enter arbitrary text
- Drop down. You can modify the look of the step to include drop-down menu from where you can select from a value or set of values. In this parameter type you can enter a KQL query or a JSON string, to provide the choices from dropdown.
- Options group. You can group multiple properties into group.
- Time range picker. You can select from prepopulated time ranges or select a custom range
- Resource picker. You can select one or more Azure resources
- You can select one or more Azure subscription resources
- Resource Type. You can select one or more Azure resource type values
- You can select one or more Azure location values

You can reference parameter values in other parts of the workbooks either via bindings or value expansions.

In the **Previews** section, from the **New Parameters** page, you can view the variables that will be displayed and used in the query code.

## Links/tabs

You can add links/tabs step to customize the navigation in the workbook with tabs, lists, paragraphs, or bullet list. You can provide the following inputs in the adding a new links/tabs step:

- **Text before link.** This text is shown before the link is selected
- **Link text.** This is the actual text that is shown in the link
- **Text after link.** This text is shown after the link is selected
- **Action.** You specify the action that will be perform when you select the link, such as **Url, Set a parameter value,** and **Scroll to a step.**
- **Value.** You can use as value for the link.
- **Settings.** These can be specific based on the link type, and support parameters syntax.
- **Context Blade.** You can open a new context blade to the side instead of a full view
- **Style.** You can select between Link, Button (primary), Button (secondary) style

You can add a new tab, by selecting **TABS** from the **Style** drop-down menu from the header bar.

![](RackMultipart20201108-4-10kj3z7_html_fc81737adf1438e1.png)

## Metric steps

You can use Metric steps, to combine the results of the workbook with metrics from different Azure resources.

Now that you learn the process of creating the custom workbook, do not forget when you made all the customization to save the workbook by selecting **Done Editing.**
