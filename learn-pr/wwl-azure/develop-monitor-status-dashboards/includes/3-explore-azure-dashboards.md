Effective visualizations transform raw monitoring data into **actionable insights** that teams can understand at a glance. Charts, graphs, and dashboards enable you to:

**Identify patterns and trends:**

- **Spot anomalies:** Sudden spikes or drops that indicate problems
- **Track trends:** Gradual changes revealing long-term issues or improvements
- **Correlate events:** Relationship between different metrics (CPU usage vs. response time)
- **Compare baselines:** Current performance vs. historical norms

**Enable faster troubleshooting:**

- **Drill down:** Navigate from high-level overviews to detailed metrics
- **Filter context:** Isolate specific time ranges, resources, or components
- **Visual correlation:** See relationships between metrics that aren't obvious in raw data
- **Historical comparison:** Compare current state to previous periods

**Facilitate collaboration:**

- **Shared visibility:** Teams see the same data, enabling aligned conversations
- **Executive reporting:** High-level dashboards for leadership without technical details
- **Cross-team coordination:** Operations, development, and business stakeholders view relevant metrics
- **External stakeholders:** Share status with customers, partners, or auditors

## Azure Dashboards overview

**[Azure Dashboards](/azure/azure-portal/azure-portal-dashboards)** are the **primary built-in dashboarding technology** for the Azure platform, providing a centralized, customizable view of your Azure resources and monitoring data.

**Key characteristics:**

- **Single pane of glass:** Unified view across multiple Azure services, subscriptions, and resource groups
- **Tile-based interface:** Drag-and-drop tiles from various Azure services onto a customizable canvas
- **Native integration:** Deep connections to Azure Monitor, Application Insights, Log Analytics, and all Azure services
- **Portal-based:** Built directly into the Azure portal—no separate tool installation required
- **Quick issue identification:** Critical metrics and alerts visible immediately upon dashboard load

**Common use cases:**

**Infrastructure monitoring:**

- **Virtual machines:** CPU, memory, disk I/O, network metrics across VM fleets
- **Databases:** Query performance, DTU consumption, connection statistics
- **Storage accounts:** Blob transactions, bandwidth usage, availability metrics
- **Networks:** VPN gateway health, application gateway request rates, load balancer metrics

**Application performance:**

- **Application Insights:** Request rates, response times, failure rates, dependency performance
- **Service health:** Azure service status, planned maintenance notifications
- **Custom metrics:** Business KPIs, transaction volumes, user activity

**DevOps and CI/CD:**

- **Pipeline execution:** Build success rates, deployment frequency, release duration
- **Resource provisioning:** Infrastructure deployment status, configuration drift
- **Cost monitoring:** Azure spending trends, resource cost breakdown, budget alerts

**Executive dashboards:**

- **Business metrics:** Revenue indicators, user growth, transaction volumes
- **SLA compliance:** Uptime percentages, availability statistics, incident counts
- **Capacity planning:** Resource utilization trends, growth projections, scaling needs

:::image type="content" source="../media/azure-dashboards-274204b2.png" alt-text="Diagram showing Azure Dashboards with multiple tiles displaying metrics, logs, and visualizations from various Azure services in a unified customizable interface.":::

## Key advantages of Azure Dashboards

Azure Dashboards offer **powerful capabilities** that make them ideal for monitoring and operational visibility across Azure environments:

### Deep Azure integration

**Native platform connection:**
Azure Dashboards are **deeply integrated** into the Azure ecosystem, enabling you to pin visualizations from virtually any Azure service directly to your dashboard without additional configuration or integration work.

**Pinnable sources:**

- **[Metrics explorer](/azure/azure-monitor/platform/metrics-charts):** Real-time and historical metric charts for any Azure resource
- **[Log Analytics queries](/azure/azure-monitor/log-query/log-query-overview):** Custom KQL queries visualizing log data from multiple workspaces
- **[Application Insights](/azure/azure-monitor/app/app-insights-overview):** Application performance metrics, user analytics, failure rates
- **[Azure Monitor maps](/azure/azure-monitor/app/app-map):** Dependency visualization showing application component relationships
- **[Availability tests](/azure/azure-monitor/app/availability-overview):** Web test results tracking endpoint uptime and response times
- **Resource blade charts:** Any chart visible in an Azure resource's blade (VM metrics, database performance, etc.)
- **Azure Advisor recommendations:** Security, performance, reliability, and cost optimization suggestions
- **Azure Service Health:** Service issues, planned maintenance, health advisories

**Pin workflow:**

1. Navigate to any supported visualization in the Azure portal
2. Select the **Pin icon** (pushpin) in the top-right corner of the visualization
3. Choose **existing dashboard** or **create new dashboard**
4. Visualization appears as a tile on the selected dashboard

### Dual data source support

**Metrics AND logs:**
Unlike many monitoring tools that specialize in either metrics or logs, Azure Dashboards support **both data types simultaneously** on the same dashboard:

**Metrics (time-series data):**

- **Characteristics:** High-frequency numerical measurements collected at regular intervals
- **Examples:** CPU percentage, memory usage, request count, response time
- **Refresh rate:** Depends on time range (minimum 5 minutes for short ranges, longer for extended ranges)
- **Use case:** Real-time monitoring, alerting on threshold violations, capacity planning

**Logs (event data):**

- **Characteristics:** Discrete events with detailed contextual information
- **Examples:** Application logs, security events, audit trails, diagnostic messages
- **Refresh rate:** Updates every 1 minute for queries on shared dashboards
- **Use case:** Troubleshooting specific incidents, compliance auditing, detailed analytics

**Combined value:**
Placing metrics and logs side-by-side enables **correlation analysis**—for example, seeing CPU metrics spike (metrics) alongside error log volume (logs) reveals causation relationships.

### Multi-source data combination

**Unified view across services:**
Azure Dashboards excel at **aggregating data** from diverse sources into a single cohesive view:

**Cross-service scenarios:**

**Example 1: Full-stack application monitoring**

- **Frontend:** Application Insights metrics (page load times, user sessions)
- **API layer:** API Management metrics (request rates, latency, errors)
- **Backend:** App Service metrics (CPU, memory, response times)
- **Database:** Azure SQL Database metrics (DTU consumption, query performance)
- **Dependencies:** Azure Storage metrics (blob transactions, latency)

**Example 2: Infrastructure and security**

- **Virtual machines:** VM metrics (CPU, disk, network)
- **Networking:** NSG flow logs analyzing traffic patterns
- **Security:** Azure Security Center alerts and recommendations
- **Compliance:** Azure Policy compliance state across subscriptions

**Example 3: DevOps and operations**

- **Build pipelines:** Azure DevOps build success rates and duration
- **Release pipelines:** Deployment frequency and change failure rate
- **Application health:** Application Insights availability and performance
- **Cost management:** Azure Cost Management spending trends

**Data source types supported:**

- **[Metrics explorer](/azure/azure-monitor/platform/metrics-charts) output:** Platform metrics from any Azure resource
- **[Log Analytics queries](/azure/azure-monitor/log-query/log-query-overview):** KQL queries across Log Analytics workspaces
- **[Application Insights maps](/azure/azure-monitor/app/app-map):** Dependency topology visualizations
- **[Application Insights availability](/azure/azure-monitor/app/availability-overview):** Synthetic monitoring results
- **Resource-specific charts:** Service-specific visualizations (e.g., Azure SQL query insights)
- **Static content:** Markdown tiles with documentation, links, or instructions

### Personal and shared dashboards with RBAC

**Dashboard visibility models:**

**Personal dashboards:**

- **Visibility:** Only visible to the creating user
- **Use case:** Individual developer's monitoring view, personal work context
- **Storage:** Saved to user's Azure portal profile
- **Advantage:** No RBAC configuration required, immediate creation

**Shared dashboards:**

- **Visibility:** Published to an Azure resource group, visible to authorized users
- **Use case:** Team dashboards, operational views, executive reporting
- **Storage:** Saved as Azure resources within specified resource group
- **Advantage:** Team collaboration, consistent views across organization

**[Azure role-based access control (RBAC)](/azure/role-based-access-control/overview) integration:**

**Dashboard permissions:**

- **Owner:** Full control—can edit, delete, and manage dashboard permissions
- **Contributor:** Can edit dashboard content but cannot modify RBAC settings
- **Reader:** View-only access—can see dashboard but cannot make changes

**Common RBAC scenarios:**

**Scenario 1: Team operations dashboard**

- **Requirement:** Operations team needs edit access, developers need read-only access
- **Configuration:**
  - Publish dashboard to shared resource group
  - Grant "Contributor" to operations team security group
  - Grant "Reader" to developers security group

**Scenario 2: Executive dashboard**

- **Requirement:** Leadership team views business metrics, operations team maintains content
- **Configuration:**
  - Publish to shared resource group accessible to executives
  - Grant "Contributor" to operations team
  - Grant "Reader" to executive team security group

**Scenario 3: Customer-facing status dashboard**

- **Requirement:** External stakeholders view service health without Azure portal access
- **Solution:** Export dashboard to Power BI or create custom status page (dashboards cannot be made truly public)

### Automatic refresh

**Real-time data updates:**
Azure Dashboards automatically refresh data without manual intervention, ensuring you always see **current information.**

**Metrics refresh intervals:**

- **Time range dependency:** Refresh rate adapts based on the time range selected for each chart
- **Short time ranges (last hour):** Refresh approximately every **5 minutes**
- **Medium time ranges (last 24 hours):** Refresh approximately every **15 minutes**
- **Long time ranges (last 30 days):** Refresh approximately every **30 minutes**
- **Rationale:** Balances data freshness with query cost and portal performance

**Logs refresh interval:**

- **Standard refresh:** Log Analytics query results refresh every **1 minute**
- **Applies to:** All log-based tiles on shared dashboards
- **Performance note:** Complex queries may impact refresh speed

**Manual refresh:**

- **Full dashboard:** Select the **Refresh button** in dashboard toolbar to update all tiles immediately
- **Individual tile:** Hover over tile and select **More options (...)** > **Refresh** for single tile updates
- **Use case:** After making configuration changes, deploying applications, or needing immediate data

**Auto-refresh considerations:**

- **Query cost:** Frequent refreshes of expensive Log Analytics queries can increase costs
- **Performance:** Too many tiles with 1-minute refresh can slow portal performance
- **Optimization:** Use longer time ranges for historical analysis to reduce refresh frequency

### Parameterized dashboards

**Dynamic dashboard capabilities:**
Azure Dashboards support **parameters** that enable users to filter and customize views without editing the underlying dashboard structure.

**Parameter types:**

**Timestamp parameters:**

- **Purpose:** Allow users to select time range for all tiles
- **Common values:** Last hour, Last 24 hours, Last 7 days, Last 30 days, Custom range
- **Use case:** Quickly switch between real-time monitoring and historical analysis
- **Implementation:** Dashboard-level setting that applies to all tiles supporting time ranges

**Custom parameters:**

- **Purpose:** Filter dashboard data by specific values (subscription, resource group, resource, etc.)
- **Examples:**
  - **Subscription ID:** Show metrics for specific Azure subscription
  - **Resource group:** Filter to resources in particular resource group
  - **Environment:** Switch between production, staging, development views
  - **Region:** Focus on specific Azure region's resources
- **Use case:** Single dashboard serves multiple contexts (e.g., one dashboard for all environments)
- **Implementation:** Define parameters in dashboard settings, reference in tile queries

**Parameter benefits:**

- **Reusability:** One dashboard template serves multiple scenarios
- **Reduced management:** Fewer dashboards to maintain and update
- **Consistent views:** Same structure with different data filters ensures consistency
- **User flexibility:** Viewers customize their view without editing dashboard

### Flexible layout options

**Customizable grid system:**
Azure Dashboards use a **flexible grid layout** enabling precise tile positioning and sizing:

**Layout capabilities:**

- **Drag-and-drop positioning:** Move tiles anywhere on canvas
- **Resizing:** Adjust tile dimensions to emphasize important visualizations
- **Grid snapping:** Tiles align to grid for clean, organized appearance
- **Multi-column layouts:** Create columns for logical grouping (e.g., infrastructure | applications | costs)
- **Visual hierarchy:** Size tiles based on importance (large tiles for critical metrics, small tiles for supporting data)

**Layout best practices:**

**Create visual hierarchy:**

- **Top left:** Most critical/actionable metrics (human eye starts here)
- **Larger tiles:** More important information
- **Smaller tiles:** Supporting context or less critical metrics

**Group related metrics:**

- **Logical sections:** Infrastructure, applications, security, costs
- **Visual separation:** Leave whitespace or use markdown tiles as section headers
- **Consistent sizing:** Related metrics use similar tile sizes for visual consistency

**Optimize for audience:**

- **Operations teams:** Dense layouts with many detailed metrics
- **Executives:** Sparse layouts with high-level KPIs and trends
- **Mixed audiences:** Hierarchical layout with summary at top, details below

**Consider viewing contexts:**

- **Desktop monitors:** Can support dense layouts with many tiles
- **Laptops:** Medium density with essential metrics prioritized
- **Full-screen displays:** Large tiles with high visibility from distance

### Full-screen mode

**Immersive monitoring experience:**
Azure Dashboards support **full-screen mode** for distraction-free monitoring:

**Activation:**

- Select the **Full screen button** in dashboard toolbar
- **Keyboard shortcut:** F11 (browser-dependent)

**Use cases:**

**Operations centers (NOC):**

- **Display:** Large wall-mounted monitors showing critical system health
- **Benefit:** Team has constant visibility into infrastructure and application status
- **Configuration:** Rotate through multiple dashboards on interval or dedicate displays to specific dashboards

**Incident response:**

- **Context:** During outages or incidents, maximize screen real estate for troubleshooting
- **Benefit:** See more metrics simultaneously, reducing context switching
- **Practice:** Keep incident dashboard ready for quick full-screen activation

**Presentations and demos:**

- **Audience:** Stakeholders, customers, or team meetings
- **Benefit:** Professional appearance without Azure portal chrome/navigation
- **Tip:** Prepare dashboard beforehand with appropriate time ranges and filters

**Focus mode:**

- **Individual use:** Developer or operator needs to focus solely on specific system
- **Benefit:** Eliminates distractions from email, chat, browser tabs
- **Duration:** Enter full-screen during troubleshooting sessions or focused monitoring periods

## Limitations to consider

While Azure Dashboards offer powerful capabilities, understanding their **limitations** helps you choose the right tool for specific scenarios or supplement with other visualization options:

### Limited log visualization control

**Data table restrictions:**

- **No support:** Azure Dashboards do **not support** data table visualizations for log queries
- **Impact:** Cannot display log query results in tabular format on dashboards
- **Workaround:** Use Azure Monitor Workbooks (which support tables) or link to Log Analytics workspace for detailed table views
- **Use case affected:** Scenarios requiring detailed row-by-row log inspection (e.g., audit logs, error details)

**Data series limits:**

- **Maximum series:** Log visualizations are limited to **10 data series** per chart
- **Grouping behavior:** Data series beyond 10 are automatically grouped into an "Other" bucket
- **Impact:** High-cardinality data (e.g., metrics by individual user, by specific IP) may lose granularity
- **Example:** Query showing requests by country/region works well with <10 countries/regions, but 50+ countries/regions results in most grouped as "Other"
- **Workaround:** Add filters to reduce cardinality (e.g., "top 10 countries/regions by request volume")

### No custom parameters for log charts

**Parameter support limitation:**

- **Restriction:** Log-based tiles do **not support** custom dashboard parameters
- **What works:** Timestamp parameters work (users can change time range)
- **What doesn't work:** Custom parameters like resource group, subscription, or environment cannot filter log charts
- **Impact:** Cannot create a single dashboard with log charts that dynamically filter by parameter values
- **Workaround:** Create separate dashboards for each context (e.g., separate dashboards for prod/staging) or use Azure Monitor Workbooks (which support parameters fully)

**Contrast with metrics:**

- **Metrics tiles:** Support both timestamp and custom parameters
- **Log tiles:** Support timestamp parameters only

### Log chart time range limitation

**30-day maximum:**

- **Restriction:** Log-based charts pinned to dashboards are limited to the **last 30 days** of data
- **Impact:** Cannot create dashboard tiles showing log trends over quarters or years
- **Rationale:** Query performance and cost considerations for long-running log queries
- **Workaround:** For longer historical analysis, use Log Analytics workspace directly, export data to storage, or use Azure Monitor Workbooks with longer ranges

**Contrast with metrics:**

- **Metrics charts:** Support up to **90 days** of historical data (depending on metric retention)
- **Log charts:** Maximum **30 days** when pinned to dashboards

**Historical analysis alternatives:**

- **Azure Monitor Workbooks:** Support queries over full retention period (up to 2 years for Log Analytics)
- **Power BI:** Connect to Log Analytics for long-term trend analysis and reporting
- **Data export:** Export logs to Azure Storage or Azure Data Explorer for long-term retention and analysis

### Shared dashboard pinning requirement for logs

**Visibility restriction:**

- **Requirement:** Log charts can **only be pinned to shared dashboards,** not personal dashboards
- **Impact:** Individual users cannot create personal dashboards with log-based visualizations
- **Rationale:** Log queries consume resources and costs; shared dashboards enable organizational management and cost control
- **Workaround:** Create shared dashboard with restricted RBAC if personal-like access needed, or use personal Log Analytics workspace views

**Contrast with metrics:**

- **Metrics tiles:** Can pin to both personal and shared dashboards without restrictions

### No interactive dashboard data exploration

**Static visualization:**

- **Limitation:** Dashboard tiles are **not interactive**—clicking on data points does not enable drill-down or filtering
- **Impact:** Cannot click on spike in chart to see underlying details or filter to specific time window
- **User experience:** Dashboards serve as monitoring views, not interactive analysis tools
- **Workaround:** Configure tiles to **link to underlying resources** (e.g., clicking tile opens Log Analytics query or metrics explorer)

**Contrast with other tools:**

- **Azure Monitor Workbooks:** Fully interactive with drill-through, parameter updates on click, dynamic filtering
- **Power BI:** Rich interactivity including cross-filtering, drill-down hierarchies, and dynamic visuals

**Best practice:**
Configure **"Click to navigate"** behavior for tiles:

1. Edit dashboard
2. Select tile
3. In tile settings, configure **"On click" action:**
   - **Go to resource:** Opens the Azure resource blade
   - **Go to query:** Opens Log Analytics workspace with underlying query
   - **Custom URL:** Links to external documentation, runbooks, or related dashboards

### Limited contextual drill-down

**Shallow navigation:**

- **Limitation:** Dashboard tiles provide **minimal context** when investigating issues
- **Impact:** Often need to navigate away from dashboard to get full context (resource properties, related logs, historical comparisons)
- **User flow:** Dashboard identifies issue → Navigate to resource/workspace → Perform detailed investigation
- **Contrast:** Tools like Azure Monitor Workbooks provide rich contextual drill-down within single interface

**What's limited:**

- **No parameter passing:** Clicking tile cannot pass time range or filter values to target page
- **No correlation:** Cannot automatically show related metrics/logs when investigating specific issue
- **No drill-up:** Cannot navigate from specific resource to resource group or subscription aggregate views

**Mitigation strategies:**

**Organize dashboards hierarchically:**

- **Level 1:** High-level organizational dashboard with key aggregates
- **Level 2:** Service-specific dashboards with detailed metrics
- **Level 3:** Resource-specific dashboards for granular investigation
- **Navigation:** Use markdown tiles with links to guide users through hierarchy

**Create investigation runbooks:**

- **Document:** Standard investigation procedures for common issues
- **Link:** Include links to runbooks in dashboard markdown tiles
- **Context:** Provide context for interpreting dashboard data and next steps

**Supplement with workbooks:**

- **Dashboard:** High-level monitoring and alerting surface
- **Workbook:** Detailed interactive investigation when dashboard identifies issues
- **Workflow:** Dashboard for continuous monitoring → Workbook for incident investigation

## When to use Azure Dashboards

**Ideal scenarios:**

**Continuous operations monitoring:**

- **Use case:** NOC displays, developer monitors, always-on operational views
- **Reason:** Automatic refresh, full-screen mode, native Azure integration

**Executive and stakeholder reporting:**

- **Use case:** High-level KPIs, SLA tracking, business metric dashboards
- **Reason:** Clean interface, RBAC integration, professional appearance

**Cross-service aggregate views:**

- **Use case:** Full-stack application monitoring, infrastructure overview, multi-subscription visibility
- **Reason:** Can combine data from any Azure service without integration work

**Quick dashboard creation:**

- **Use case:** Need monitoring view immediately without custom development
- **Reason:** Pin-from-portal workflow enables dashboard creation in minutes

**When to consider alternatives:**

**Deep log analysis with tables:**

- **Alternative:** Azure Monitor Workbooks, Log Analytics workspace directly
- **Reason:** Dashboards don't support table visualizations for logs

**Long-term historical trends (>30 days for logs):**

- **Alternative:** Azure Monitor Workbooks, Power BI, exported data analysis
- **Reason:** Dashboard log charts limited to 30 days

**Highly interactive exploration:**

- **Alternative:** Azure Monitor Workbooks, Power BI
- **Reason:** Dashboards have limited interactivity and drill-down

**Complex parameterized views for logs:**

- **Alternative:** Azure Monitor Workbooks
- **Reason:** Dashboard log tiles don't support custom parameters

**Best approach:**
**Use dashboards as your primary monitoring surface,** supplemented with Azure Monitor Workbooks for detailed investigation and Power BI for executive reporting and long-term trend analysis. This multi-tool approach leverages each platform's strengths while mitigating individual limitations.
