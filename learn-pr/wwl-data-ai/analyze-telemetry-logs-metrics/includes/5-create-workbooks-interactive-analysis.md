Dashboards provide at-a-glance operational awareness, but investigating an incident or exploring a trend requires interactivity. Azure Monitor Workbooks provide a flexible canvas that combines text, KQL queries, metrics, and parameters into interactive reports where users can adjust filters, select time ranges, and drill into specific data points. This unit covers how to create workbooks that enable developers and operations teams to explore telemetry data dynamically.

## Understand Azure Monitor Workbooks

Azure Monitor Workbooks are interactive analysis tools that let developers combine rich text, KQL queries, metrics, and parameters into reusable reports. Workbooks go beyond dashboards by supporting user interactions: selecting a parameter value, choosing a time range, or clicking a grid row dynamically updates all dependent visualizations. This interactivity makes workbooks the right choice for troubleshooting, root cause analysis, and any scenario where the investigator needs to adjust the analysis scope based on what they find.

Dashboards and workbooks serve different purposes in the monitoring workflow. Dashboards show static tiles for ongoing operational awareness, answering the question "is the system healthy?" Workbooks enable exploratory analysis, answering the question "why is the system behaving this way?" During an incident, a team member might glance at a dashboard to confirm that error rates are elevated, then open a workbook to filter by service, time window, and error type to identify the root cause.

You can access workbooks from Azure Monitor, from a Log Analytics workspace, or directly from an Application Insights resource. The Azure portal includes a gallery of prebuilt workbook templates organized by category, such as performance analysis, failure analysis, and usage analysis. You can use these templates as starting points and customize them for your application, or you can create workbooks from scratch.

## Add query steps and visualizations

Workbooks are built by adding steps vertically, with each step rendering a component in the final report. The available step types include text blocks for explanations and instructions, query steps that execute KQL queries and display results, metrics steps that show Azure resource metrics, and parameter steps that create interactive filters. Steps render in the order they appear, creating a top-to-bottom narrative flow.

To add a KQL query step, you select **Add query**, choose **Logs** as the data source, specify the Application Insights resource as the scope, write your KQL query, and select a visualization type. The available visualization types include grid (tabular results), chart (line, bar, area), tiles (summary cards), and map (geographic distribution). Each visualization type suits different data shapes and analysis goals.

The following query works as a workbook step that displays request success rates by service. It references a workbook parameter called `{TimeRange}` to control the query window:

```kusto
requests
| where timestamp > ago({TimeRange})
| summarize totalRequests = count(),
    failedRequests = countif(success == false)
    by cloud_RoleName
| extend successRate = round(100.0 * (totalRequests - failedRequests) / totalRequests, 2)
| project cloud_RoleName, totalRequests, failedRequests, successRate
```

The `{TimeRange}` syntax references a workbook parameter. When the user changes the time range parameter at the top of the workbook, this query and all other queries that reference `{TimeRange}` automatically re-execute with the new value. This behavior creates a coordinated analysis experience where adjusting one filter updates the entire workbook.

## Use parameters for interactive filtering

Parameters are the feature that makes workbooks interactive. Each parameter appears as a control at the top of the workbook, typically a dropdown menu, text input, or time picker. Users select values from these controls, and the selected values are injected into query steps throughout the workbook.

The most common parameter types are:

- **Time range:** Controls the time window for all queries in the workbook. This parameter type provides a standard dropdown with options like "last hour," "last 24 hours," and "last seven days."
- **Dropdown:** Populated by a KQL query or a static list of values. Dropdown parameters let users filter results by dimensions like service name, environment, or error type.
- **Resource picker:** Lets users select which Application Insights resource or Log Analytics workspace to analyze. This parameter type is useful for workbooks that need to work across multiple environments.

To create a dropdown parameter that lists all services in your application, you add a parameter step and configure a KQL query that returns distinct `cloud_RoleName` values from the `requests` table. Subsequent query steps reference the parameter using the `{ServiceName}` syntax to filter their results to the selected service.

When a dropdown parameter allows multi-select, users can choose several services at once. The parameter value becomes a comma-separated list, and queries use the `in` operator to filter by multiple values. For example, `| where cloud_RoleName in ({ServiceName})` filters results to all selected services. Multi-select parameters are useful when team members need to compare behavior across two or three specific services without viewing the entire pipeline.

## Configure conditional visibility and linked content

Conditional visibility and grid link actions add depth to workbooks by creating drill-down experiences. Instead of showing every detail upfront, you can design workbooks that start with a high-level summary and reveal detailed analysis only when the user selects a specific item.

Conditional visibility controls whether a workbook step is shown or hidden based on a parameter value. You configure this by editing a step's advanced settings and specifying a condition. For example, you can create a workbook where a detailed exception analysis step is hidden by default and only appears when the user selects a specific service from the dropdown. This approach keeps the initial view clean and focused, while making detailed data available on demand.

Grid link actions create interactive tables where selecting a row triggers a downstream action. When you configure a grid column as a link, clicking a cell in that column can open the end-to-end transaction details for a specific request, navigate to another workbook for deeper analysis, or export a parameter value that other steps reference. The exported parameter pattern is powerful: you can display a summary grid of services with error counts, and when a user select a service name, the selected value populates a parameter that filters the remaining workbook steps to show only data for that service.

Effective workbook design follows a consistent pattern. You can start with a summary query at the top that shows overall pipeline health across all services, add parameter filters for time range and service selection, and use linked grids to enable drill-down from the summary into specific services or operations. You can place detailed analysis steps, such as exception stack traces or dependency timelines, in conditionally visible sections that appear only when the user selects a specific item. You can also keep the number of query steps manageable to maintain fast load times, because each query step executes against the Log Analytics backend every time a parameter changes.

## Additional resources

- [Azure Monitor Workbooks overview](/azure/azure-monitor/visualize/workbooks-overview)
- [Workbooks parameters](/azure/azure-monitor/visualize/workbooks-parameters)
- [Workbooks visualizations](/azure/azure-monitor/visualize/workbooks-visualizations)
