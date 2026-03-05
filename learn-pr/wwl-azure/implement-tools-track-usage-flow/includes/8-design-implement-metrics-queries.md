**Collecting metrics associated with project lifecycle** allows organizations to gain insights into their software development practices and streamline their DevOps processes. By enabling **telemetry data collection from project activities**, teams can track pipeline runs, work item updates, and other DevOps-related events in real-time.

### Why project metrics matter

This approach is important for several reasons:

**Enhancing visibility:**

- See real-time status of all projects and teams
- Understand work distribution and capacity
- Track progress toward milestones and deadlines
- Identify dependencies and blockers early

**Monitoring performance:**

- Measure team velocity and throughput
- Track cycle time and lead time trends
- Monitor build and deployment success rates
- Identify performance degradation patterns

**Optimizing the software development lifecycle:**

- Identify bottlenecks in the project workflow
- Make data-driven decisions about process improvements
- Continuously improve development practices
- Correlate development activities with application performance

**Key benefits:**

- Empowers teams to make **data-driven decisions**
- Provides objective metrics for retrospectives
- Supports capacity planning and forecasting
- Enables proactive risk management

## Comparing platforms: GitHub vs. Azure DevOps

Both **GitHub and Azure DevOps** include support for collecting and analyzing project-related telemetry, but their capabilities differ significantly:

### GitHub project tracking capabilities

**GitHub Insights features:**

- **Built-in metrics:** Repository activity, pull request performance, community engagement
- **Pulse view:** Activity summary for repositories
- **Contributors graph:** Code contributions over time
- **Traffic analytics:** Views, clones, referrers

**Limitations:**

- **Project tracking analytics are limited** compared to dedicated project management tools
- Fewer predefined metrics for agile project management
- Basic visualization capabilities
- Limited custom reporting options
- No built-in integration with Azure Monitor

### Azure DevOps project tracking capabilities

**Azure DevOps Analytics features:**

- **Comprehensive set of analytics and reporting features** specifically designed for project monitoring
- **Customizable dashboards:** Drag-and-drop widgets for custom views
- **Rich reporting capabilities:** Power BI integration, OData feeds
- **Wide range of predefined metrics and queries:** Velocity, burndown, cycle time, lead time
- **Facilitate tracking work progress** throughout the software development lifecycle

**Advantages:**

- Purpose-built for agile project management
- Extensive widget library for dashboards
- Advanced query capabilities with WIT Query Language
- Deep integration with Azure services

### Extending monitoring with Azure services

In addition to the **telemetry functionality built into GitHub and Azure DevOps**, you can extend the scope of monitoring by taking advantage of **Azure services** such as Azure Monitor and Application Insights:

**Integration capabilities:**

- **Azure DevOps:** Offers **richer and more streamlined integration** than GitHub
- **Native connectors:** Azure DevOps pipelines natively integrate with Application Insights
- **Release annotations:** Automatic correlation of deployments with performance metrics
- **Work item integration:** Create work items directly from Application Insights alerts
- **Unified dashboards:** Combine project metrics with application telemetry

## Using GitHub built-in project tracking

In GitHub projects, **tracking progress** involves monitoring key development metrics:

**Key GitHub metrics:**

- **Issue throughput:** Rate of issue creation and closure
- **Issue aging:** How long issues remain open
- **Code review turnaround time:** Time from PR creation to first review and approval
- **Pull request merge time:** Duration from PR creation to merge
- **Contributor activity:** Frequency and volume of contributions

These metrics offer **insights into project health, team efficiency, and code quality**, helping identify areas for improvement.

### GitHub Insights

The **simplest way to review metrics** is using the **Insights functionality**:

- Visualize repository activity over time
- Track pull request performance (open, merged, closed)
- Monitor community engagement (forks, stars, watchers)
- View contributor statistics and code frequency

### Custom automation with GitHub Actions

Create **custom GitHub Actions workflows** that automate metric collection:

- **Trigger-based:** Events such as pull requests, issues, or code pushes
- **Scheduled:** Run on cron schedules for periodic reporting
- **Actions:** Collect and analyze metrics, generate reports, post to dashboards

### Programmatic access with REST API

Leverage **GitHub REST API** to access project data programmatically:

- Issue and pull request metrics
- Contributor statistics
- Repository activity data
- Build custom dashboards or reports using analytics tools

## Using Azure DevOps built-in project tracking

Azure DevOps offers a **large number of built-in metrics** that reflect various aspects of project management: cycle time, lead time, workflow efficiency, and backlog health. These metrics can be grouped into several categories:

### Work Item Metrics

- **Count of Work Items:** Monitor the total number of work items created, completed, or in progress over time
- **Work Item Age:** Track the age of open work items to identify overdue tasks
- **Velocity:** Measure the rate at which work items are completed over iterations or sprints
- **Backlog growth:** Monitor rate of new work item creation vs. completion
- **Work item distribution:** Track types of work items (bugs, features, tasks)

### Build and Release Metrics

- **Build Success Rate:** Monitor the percentage of successful builds versus failed builds
- **Release Deployment Frequency:** Track how frequently releases are deployed to production or other environments
- **Deployment Success Rate:** Measure the percentage of successful deployments to identify deployment issues
- **Build duration:** Track time to complete builds
- **Deployment lead time:** Time from commit to production

### Test Metrics

- **Test Case Pass Rate:** Monitor the percentage of passed test cases versus failed test cases
- **Test Case Execution Time:** Track the time taken to execute test cases to identify performance bottlenecks
- **Test Case Failure Trends:** Analyze trends in test case failures to identify recurring issues
- **Test coverage:** Percentage of code covered by tests
- **Flaky test detection:** Identify unreliable tests

### Code Metrics

- **Code Churn:** Measure the amount of code added, modified, or deleted over time
- **Code Quality Metrics:** Monitor code coverage, cyclomatic complexity, and maintainability index
- **Pull request metrics:** Time to review, approval rates
- **Code review comments:** Frequency and types of feedback

### Team Performance Metrics

- **Sprint Burndown:** Track the progress of sprint goals by monitoring remaining work versus time
- **Team Velocity:** Measure the average amount of work completed by the team in each sprint
- **Lead Time:** Monitor the time taken from the creation of a work item to its completion
- **Cycle time:** Time from work start to completion
- **Throughput:** Work items completed per time period

### Dashboards and custom analytics

You can **display and analyze these metrics** using **dashboards accessible directly within Azure DevOps portal**. For additional insights, create **custom, query-based reports in Azure DevOps Analytics**.

### Common analytical queries

Some of the more commonly used queries, groupings, and visualizations include:

**1. Cycle Time Analysis:**

- **Query:** Calculate the cycle time (time taken to complete a work item from start to finish) for different types of work items
- **Grouping:** Work items by state (Active, Resolved, Closed)
- **Calculation:** Time difference between start date and completion date
- **Visualization:** Average cycle time per state over time
- **Purpose:** Identify bottlenecks and improve process efficiency

**2. Lead Time Distribution:**

- **Query:** Analyze lead time (creation to completion) distribution for different teams or areas
- **Grouping:** Work items by area path or team assignment
- **Calculation:** Lead time for each work item
- **Visualization:** Histogram or box plot showing distribution
- **Purpose:** Identify outliers and optimize workflow in specific areas to reduce delivery time

**3. Cumulative Flow Diagram (CFD):**

- **Query:** Track number of work items in each state (To Do, In Progress, Done) over time
- **Grouping:** Work items by state, ordered by date of state change
- **Calculation:** Cumulative count of work items in each state at regular intervals (daily, weekly)
- **Visualization:** CFD showing work item flow
- **Purpose:** Monitor flow through project stages and identify congestion or delays

**4. Work Item Aging Analysis:**

- **Query:** Analyze aging of work items in backlog or specific stages
- **Grouping:** Work items by age (days since creation), priority, or type
- **Calculation:** Average age, percentage overdue, aging distribution across categories
- **Visualization:** Aging trends over time
- **Purpose:** Prioritize backlog grooming and ensure timely delivery of high-priority items

## Using Azure Monitor and Application Insights for project tracking

There are **numerous ways to integrate project tracking** with Azure Monitor and Application Insights. One of the more commonly used approaches involves combining **continuous monitoring**, **release annotations**, and **work items integration**. This optimizes the software development lifecycle by:

**Benefits:**

- Providing valuable information on **performance bottlenecks**
- Facilitating **proactive issue resolution**
- Enabling **informed decision-making**
- Successfully delivering **high-quality software**

### Continuous monitoring integration

With **continuous monitoring**, release pipelines can incorporate monitoring data from Application Insights:

**Quality gates based on telemetry:**

- An **Application Insights alert can block or rollback** a gated deployment until the alert is resolved
- Monitor metrics like error rate, response time, exception count during deployment
- Prevent bad deployments from reaching production
- Conversely, if **monitoring checks pass**, deployments can **proceed automatically** without manual intervention

**Example scenario:**

1. Pipeline deploys to staging environment
2. Post-deployment gate monitors Application Insights for 15 minutes
3. If error rate >1%, deployment is blocked
4. If metrics are healthy, deployment automatically proceeds to production

### Release annotations

**Annotations designate events** in the CI/CD pipeline:

**Purpose:**

- Capture **correlation between delivery of software releases and resulting application performance**
- Mark deployment events in Application Insights charts
- See exactly when performance changes occurred relative to deployments
- Quickly identify if a deployment caused a performance regression

**Implementation:**

- **Azure DevOps:** Supports **automatic generation of annotations** by build pipelines
- **Custom annotations:** Create arbitrary annotations by using PowerShell
- **Metadata:** Include build number, release notes, deployment environment

**Use case:**
Performance metrics chart shows response time spike. Release annotation reveals spike coincides with deployment v2.3.1, immediately identifying the problematic release.

### Work items integration

**Work items integration functionality** facilitates embedding contextual Application Insights data when generating work items in GitHub and Azure DevOps:

**Features that facilitate data capture and work item generation:**

**Advanced fields:**

- Populate assignee, projects, or milestones automatically
- Set priority based on alert severity
- Tag with affected components or services
- Link to related work items

**Multiple configurations:**

- Support for any number of repositories or work item types
- Different configurations for different alert types
- Environment-specific work item templates

**Pre-built and customizable KQL queries:**

- Add **Application Insights data** to work items automatically
- Include error counts, affected users, stack traces
- Attach relevant log entries
- Embed performance charts

**Customizable workbook templates:**

- Create standardized work item formats
- Include troubleshooting checklists
- Link to runbooks and documentation
- Pre-populate diagnostic information

**Example workflow:**

1. Application Insights detects elevated exception rate
2. Alert fires automatically
3. Work item created in Azure DevOps with:
   - Title: "High exception rate in ProductService"
   - Description: KQL query results showing top exceptions
   - Assignee: On-call engineer from service team
   - Priority: High (based on user impact)
   - Attachments: Last 100 exception stack traces
   - Links: Related Application Insights queries, deployment annotation
4. Engineer receives notification and has all diagnostic info immediately
