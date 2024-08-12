Collecting metrics associated with project lifecycle allows organizations to gain insights into their software development practices and streamline their DevOps processes. By enabling telemetry data collection from project activities, teams can track pipeline runs, work item updates, and other DevOps-related events in real-time. This approach is important for enhancing visibility, monitoring performance, and optimizing the software development lifecycle. It empowers teams to make data-driven decisions, identify bottlenecks in the project workflow, and continuously improve their development practices.

Both GitHub and Azure DevOps include support for collecting and analyzing project-related telemetry. GitHub implements a few built-in metrics that reflect repository activity, pull request performance, and community engagement through its Insights feature, but its project tracking and analytics capabilities are limited. Azure DevOps, on the other hand, offers a comprehensive set of analytics and reporting features specifically designed to support project monitoring and management. It provides customizable dashboards, rich reporting capabilities, and a wide range of predefined metrics and queries that facilitate tracking work progress throughout the software development lifecycle.

In addition to the telemetry functionality built into GitHub and Azure DevOps, you can extend the scope of monitoring by taking advantage of Azure services such as Azure Monitor and Application Insights. In this case, Azure DevOps also offers richer and more streamlined integration than GitHub.

## Using GitHub built-in project tracking

In GitHub projects, tracking progress involves monitoring metrics such as issue throughput, issue aging, code review turnaround time, pull request merge time, and contributor activity. These metrics offer insights into project health, team efficiency, and code quality, helping with identifying areas for improvement and project execution.

The simplest way to review metrics in GitHub projects is to use the Insights functionality, which supports visualizing repository activity, pull request performance, and community engagement.

In addition, it is possible to create custom GitHub Actions workflows that automate the collection and processing of project metrics. Such workflows can be triggered based on events such as pull requests, issues, or code pushes, and include actions to collect and analyze metrics.

Another option is to leverage GitHub REST API to programmatically access project data, including metrics related to issues, pull requests, and contributors. Such data can serve as the basis for building custom dashboards or reports using other analytics tools.

## Using Azure DevOps built-in project tracking

Azure DevOps offers a large number of built-in metrics that reflect various aspects of project management, such as cycle time, lead time, workflow efficiency, and backlog health. In general, these metrics can be grouped into several categories:

 -  Work Item Metrics:
     -  Count of Work Items: Monitor the total number of work items created, completed, or in progress over time.
     -  Work Item Age: Track the age of open work items to identify overdue tasks.
     -  Velocity: Measure the rate at which work items are completed over iterations or sprints.
 -  Build and Release Metrics:
     -  Build Success Rate: Monitor the percentage of successful builds versus failed builds.
     -  Release Deployment Frequency: Track how frequently releases are deployed to production or other environments.
     -  Deployment Success Rate: Measure the percentage of successful deployments to identify any deployment issues.
 -  Test Metrics:
     -  Test Case Pass Rate: Monitor the percentage of passed test cases versus failed test cases.
     -  Test Case Execution Time: Track the time taken to execute test cases to identify performance bottlenecks.
     -  Test Case Failure Trends: Analyze trends in test case failures to identify recurring issues.
 -  Code Metrics:
     -  Code Churn: Measure the amount of code added, modified, or deleted over time.
     -  Code Quality Metrics: Monitor code quality metrics such as code coverage, cyclomatic complexity, and maintainability index.
 -  Team Performance Metrics:
     -  Sprint Burndown: Track the progress of sprint goals by monitoring the remaining work versus time.
     -  Team Velocity: Measure the average amount of work completed by the team in each sprint.
     -  Lead Time: Monitor the time taken from the creation of a work item to its completion.

You can display and analyze these metrics by using dashboards accessible directly within Azure DevOps portal. For additional insights into project progress and performance, consider creating custom, query-based reports in Azure DevOps Analytics. Some of the more commonly used queries, groupings, and visualizations that provide meaningful insights into Azure DevOps Projects include:

 -  **Cycle Time Analysis**
     -  Query to calculate the cycle time (time taken to complete a work item from start to finish) for different types of work items (e.g., user stories, bugs) over time.
     -  Group the work items by their state (e.g., Active, Resolved, Closed).
     -  Calculate the time difference between the creation date and the completion date of each work item.
     -  Visualize the average cycle time per state over time to identify bottlenecks and improve process efficiency.
 -  **Lead Time Distribution**
     -  Query to analyze the lead time (time taken from the creation of a work item to its completion) distribution for different teams or areas of the project.
     -  Group the work items by their area path or team assignment.
     -  Calculate the lead time for each work item and visualize the distribution using a histogram or box plot.
     -  Identify outliers and investigate the reasons for longer lead times in specific areas to optimize workflow and reduce delivery time.
 -  **Cumulative Flow Diagram (CFD)**
     -  Query to create a Cumulative Flow Diagram that tracks the number of work items in each state (e.g., To Do, In Progress, Done) over time.
     -  Group the work items by their state and order them by their date of state change.
     -  Calculate the cumulative count of work items in each state at regular intervals (e.g., daily, weekly).
     -  Visualize the CFD to monitor the flow of work items through the project stages and identify areas of congestion or delays.
 -  **Work Item Aging Analysis**
     -  Query to analyze the aging of work items in the backlog or specific stages of the project.
     -  Group the work items by their age (e.g., days since creation) and their priority or type.
     -  Calculate metrics such as the average age of work items, the percentage of overdue work items, and the distribution of aging across different categories.
     -  Visualize the aging trends to prioritize backlog grooming activities and ensure timely delivery of high-priority items.

## Using Azure Monitor and Application Insights for project tracking

There are numerous ways to integrate project tracking with Azure Monitor and Application Insights, but one of the more commonly used approaches involves combining continuous monitoring, release annotations, and work items. This optimizes the software development lifecycle by providing valuable information on performance bottlenecks, facilitating proactive issue resolution, and enabling informed decision-making in order to successfully deliver high-quality software.

With continuous monitoring, release pipelines can incorporate monitoring data from Application Insights. Effectively, an Application Insights alert can block or rollback a gated deployment until the alert is resolved. Conversely, if monitoring checks pass, deployments can proceed automatically, without the need for manual intervention.

Annotations designate events in the CI/CD pipeline. They capture correlation with between delivery of software releases and the resulting application performance. Azure DevOps support automatic generation of annotations by build pipelines. You can also create arbitrary annotations by using PowerShell.

Work items integration functionality facilitates embedding contextual Application Insights data when generating work items in GitHub and Azure DevOps. The supports a number of features that facilitate data capture and work item generation, including:

 -  Advanced fields like assignee, projects, or milestones.
 -  Multiple configurations for any number of repositories or work items.
 -  Pre-built & customizable Keyword Query Language (KQL) queries to add Application Insights data to work items.
 -  Customizable workbook templates.
