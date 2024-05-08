GitHub's offers native monitoring of project-related activities through its insights, including code changes and collaboration metrics. By enabling the monitoring functionality, you can track repository traffic, assess contributor activity, and identify trends over time. This enhances visibility, fosters collaboration, and helps making data-driven decisions. By default, charts are available to anyone that can view the project.

With insights for Projects, you can use the default or create custom charts. Insights support two types of charts: current and historical.

## Current charts

Current charts provide the ability to visualize project items. The default Status chart shows the current total number of items in the project. You can create custom charts to show how many work items are assigned to each team member or how many issues are raised in each iteration. You also can modify the way data is presented through filtering, such as displaying the volume of remaining work, but limiting the results to particular labels or assignees.

## Historical charts

Historical charts provide the ability to track and visualize changes to project items over time. The default Burn up chart visualizes the progress of project issues over time, showing how much work is completed and how much is left. You can use this chart to view progress, spot trends, and identify bottlenecks to help move the project forward. With custom charts, you can target items with open issues and pull requests, items with issues that were closed as completed or merged via pull requests, as well as items with issues that were closed as not planned. Note that Insights don't track items you have archived or deleted.

## Creating charts

Insights are available for all new projects by default although historical charts require GitHub Team and GitHub Enterprise Cloud. You can create unlimited charts in private projects with GitHub Team and GitHub Enterprise Cloud for organizations and GitHub Pro for users. Users and organizations using public projects can create an unlimited number of charts. Users and organizations using GitHub Free are limited to two charts per private project.

To create a chart, in GitHub.com navigate to the target project and, in the top-right corner of the page, select the Insights icon displaying a graph. Next, in the vertical navigation menu on the left side of the page, select New chart. Assign a meaningful name to the chart and select Configure to modify the default chart settings. In the Configure chart pane, select the values of the following properties:

 -  Layout: Bar, Column, Line, Stacked area, Stacked bar, or Stacked column.
 -  X-axis: Assignees, Labels, Milestone, Repository, Status, or Time.
 -  Group by (optional): None, Assignees, Labels, Milestone, or Repository.
 -  Y-axis; Count of items, Sum of a field, Average of a field, Minimum of a field, or Maximum of a field.

To create a historical chart, set your chart's X-axis to Time. If needed, above the chart, enter filters to scope the data used to construct the chart.
