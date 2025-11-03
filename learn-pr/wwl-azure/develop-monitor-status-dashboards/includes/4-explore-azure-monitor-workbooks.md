[Azure Monitor Workbooks](/azure/application-insights/app-insights-usage-workbooks) are **interactive, parameterized documents** that combine text narratives, visualizations, and queries to provide deep analytical capabilities for Azure monitoring data. Unlike dashboards that focus on at-a-glance monitoring, Workbooks excel at **investigation, analysis, and storytelling** with data.

**Key characteristics:**

- **Interactive exploration:** Parameters and queries respond to user input, enabling dynamic filtering and drill-down
- **Narrative structure:** Combine visualizations with markdown text for context, explanations, and guidance
- **Rich visualizations:** Support charts, grids (tables), metrics, text, parameters, and custom HTML
- **Flexible querying:** Use KQL (Kusto Query Language), Azure Resource Graph queries, and metrics together
- **Template ecosystem:** Leverage pre-built templates or create custom templates for reusability

**Primary use cases:**

**Troubleshooting guides:**

- **Purpose:** Structured investigation workflows guiding operators through diagnostic procedures
- **Example:** Web application slowness troubleshooting—check request rates → analyze response time percentiles → identify slow dependencies → drill into specific operations
- **Benefits:** Consistent investigation approach, reduces mean time to resolution (MTTR), captures tribal knowledge

**Incident postmortems:**

- **Purpose:** Document incident timeline, root cause analysis, impact assessment, and remediation steps
- **Example:** Database outage postmortem showing metrics before/during/after incident, correlated with deployment events and configuration changes
- **Benefits:** Creates permanent record, facilitates learning, informs future prevention strategies

**Performance analysis:**

- **Purpose:** Deep-dive into application or infrastructure performance characteristics
- **Example:** Analyze database query performance across multiple dimensions (query type, database, time range, user)
- **Benefits:** Identify optimization opportunities, validate performance improvements, understand usage patterns

**Usage analytics:**

- **Purpose:** Understand user behavior, feature adoption, and application usage patterns
- **Example:** Track user journeys through application, analyze feature usage by customer segment, identify drop-off points
- **Benefits:** Inform product decisions, prioritize feature development, optimize user experience

**Security investigations:**

- **Purpose:** Analyze security events, identify attack patterns, assess security posture
- **Example:** Investigate failed login attempts by geographic location, time, user account, and IP address
- **Benefits:** Detect threats quickly, understand attack vectors, support forensic analysis

**Compliance reporting:**

- **Purpose:** Generate evidence of compliance with standards (SOC 2, HIPAA, PCI-DSS, etc.)
- **Example:** Document access patterns, change management activities, security control effectiveness
- **Benefits:** Audit-ready documentation, automated compliance evidence collection

:::image type="content" source="../media/workbooks-0b9dbd99.png" alt-text="Screenshot of Azure Monitor Workbooks interface showing interactive parameters, visualizations including charts and grids, and markdown text combining to create a comprehensive analytical document with dynamic filtering capabilities.":::

## Key advantages of Azure Monitor Workbooks

Azure Monitor Workbooks provide **sophisticated analytical capabilities** that complement Azure Dashboards with deeper interactivity and richer reporting:

### Dual data source support (metrics and logs)

**Unified analysis:**
Like Azure Dashboards, Workbooks support **both metrics and logs,** but with significantly more powerful integration and correlation capabilities.

**Metrics integration:**

- **Platform metrics:** CPU, memory, network, disk from Azure resources
- **Custom metrics:** Application-specific measurements via Application Insights or custom APIs
- **Metric charts:** Time-series visualizations with multiple series, aggregations, and filters
- **Threshold visualization:** Highlight values exceeding baselines or SLA targets

**Logs integration:**

- **Log Analytics:** KQL queries across multiple workspaces
- **Application Insights:** Application telemetry, traces, exceptions, custom events
- **Table visualizations:** Full data table support (unlike dashboards)
- **Complex aggregations:** Joins, unions, advanced KQL operations

**Cross-source correlation:**

- **Example scenario:** Show application request rate (metrics) alongside error logs (logs) to correlate performance with failures
- **Benefit:** Identify causation relationships (e.g., CPU spike caused by specific query pattern)
- **Implementation:** Sequential steps in workbook showing related metrics and logs with consistent time ranges via parameters

### Interactive parameterized reporting

**Dynamic parameters:**
Workbooks excel at **parameters** that enable users to filter, customize, and explore data interactively without editing the workbook structure.

**Parameter types:**

**Time range parameters:**

- **Purpose:** Control time window for all queries in workbook
- **Common values:** Last hour, Last 24 hours, Last 7 days, Custom range
- **User experience:** Select time range once at top of workbook, all visualizations update automatically

**Dropdown parameters:**

- **Purpose:** Select from predefined list of values (subscription, resource group, resource, etc.)
- **Source:** Static list, query-derived list (e.g., all VMs in selected resource group), Azure Resource Graph
- **Multi-select:** Allow selecting multiple values simultaneously
- **Example:** Choose one or more Application Insights resources to analyze

**Text input parameters:**

- **Purpose:** Free-form text entry for search, filtering, or custom query construction
- **Use case:** Search for specific user ID, error message, or transaction ID
- **Validation:** Optional regex validation to ensure correct format

**Resource picker parameters:**

- **Purpose:** Select Azure resources using built-in resource picker UI
- **Scope:** Can limit to specific resource types (VMs, databases, web apps, etc.)
- **Multi-select:** Choose multiple resources for comparative analysis

**Query-derived parameters:**

- **Purpose:** Parameter values come from query results (e.g., distinct application names, unique error codes)
- **Dynamic:** Values update as underlying data changes
- **Dependency chains:** One parameter filters another (select subscription → resource groups populate based on selection)

**Interactive visualization updates:**

**Selection-based filtering:**

- **Capability:** Clicking element in table or chart **updates associated visualizations dynamically**
- **Example workflow:**
  1. Table shows top 10 operations by request count
  2. User **clicks** specific operation name
  3. Charts below automatically filter to show only that operation's performance, errors, and dependencies
  4. Additional tables show detailed telemetry for selected operation

**Cross-visualization interaction:**

- **Scenario:** Multiple visualizations respond to selections in one visualization
- **Example:** Click country/region in geographic map → updates request volume chart, error rate chart, and user activity table to show only that country/region's data

**Drill-down capabilities:**

- **High-level to detailed:** Start with aggregates, click to drill into specific resources or time periods
- **Example:** Application overview → click high error rate region → see specific errors → click error type → view stack traces

**Benefits of interactivity:**

- **Flexible exploration:** Users investigate their specific questions without pre-configured views
- **Reduced workbook count:** One parameterized workbook replaces dozens of static variations
- **Faster insights:** No need to edit queries or create new visualizations for ad-hoc analysis
- **User empowerment:** Non-technical users can explore data without writing KQL

### Document-like narrative flow

**Storytelling with data:**
Workbooks follow a **vertical document structure** with sequential steps, enabling narrative storytelling that guides users through analysis.

**Content structure:**

**Markdown text sections:**

- **Purpose:** Provide context, explanations, instructions, and interpretations
- **Formatting:** Full markdown support including headings, lists, links, code blocks, images
- **Use cases:**
  - **Introduction:** Explain workbook's purpose and how to use it
  - **Section headers:** Organize content into logical sections
  - **Interpretation guidance:** Explain what metrics mean and how to act on findings
  - **Troubleshooting steps:** Provide step-by-step investigation procedures
  - **Remediation instructions:** Link to documentation or runbooks for issue resolution

**Query steps (visualizations):**

- **Purpose:** Display data via charts, tables, metrics, or custom visualizations
- **Sequencing:** Arrange in logical flow (overview → drill-down → details)
- **Visibility control:** Show/hide steps based on conditions or parameters

**Parameter steps:**

- **Purpose:** Collect user input for filtering and customization
- **Placement:** Typically at top of workbook for workbook-wide parameters, or before relevant sections for section-specific parameters

**Group steps:**

- **Purpose:** Organize related content into collapsible sections
- **Use case:** Long workbooks with multiple topics (group by investigation area, resource type, or analysis phase)

**Workflow examples:**

**Troubleshooting guide structure:**

- **Introduction (markdown):** Problem description and investigation approach
- **Parameters:** Time range, resource selection
- **Overview (queries):** High-level metrics showing problem scope
- **Hypothesis section 1 (markdown + queries):** "Is it a network issue?" + network metrics
- **Hypothesis section 2 (markdown + queries):** "Is it a database issue?" + database performance
- **Detailed analysis (queries):** Drill-down into identified root cause
- **Recommendations (markdown):** Remediation steps and prevention strategies

**Performance analysis structure:**

- **Executive summary (markdown + metrics):** Key performance indicators
- **Trend analysis (queries):** Performance over time with historical comparison
- **Bottleneck identification (queries):** Slowest operations, highest resource consumption
- **Comparative analysis (queries):** Performance across regions, versions, or customer segments
- **Optimization recommendations (markdown):** Specific actions to improve performance

### Personal and shared workbooks

**Visibility models:**

**Personal workbooks:**

- **Scope:** Private to creating user
- **Storage:** User's Azure Monitor workspace
- **Use case:** Individual analysis, experimentation, draft versions before sharing
- **Advantage:** No permissions or resource group setup required

**Shared workbooks:**

- **Scope:** Published to Azure subscription/resource group, accessible to authorized users
- **Storage:** Azure resource (can appear in Azure portal resource lists)
- **Use case:** Team troubleshooting guides, standardized reporting, organizational dashboards
- **RBAC:** Role-based access control determines who can view, edit, or delete

**Workbook lifecycle:**

**Development workflow:**

1. **Create personal workbook:** Start with personal copy for experimentation
2. **Build content:** Add queries, parameters, visualizations, markdown
3. **Test interactivity:** Validate parameters, selections, drill-down behavior
4. **Share with team:** Publish to shared workbook in appropriate resource group
5. **Gather feedback:** Team reviews and suggests improvements
6. **Iterate:** Make updates (shared workbooks support versioning)
7. **Establish as standard:** Document when/how to use workbook, link from dashboards or runbooks

**Collaboration patterns:**

**Template creation:**

- **Author:** Senior engineer creates workbook template capturing investigation best practices
- **Team adoption:** Team members use template for consistent troubleshooting
- **Continuous improvement:** Team feedback incorporated into template updates

**Incident investigation:**

- **Responder:** On-call engineer uses shared troubleshooting workbook during incident
- **Documentation:** Saves specific workbook instance with incident timeline and findings
- **Review:** Team reviews saved workbook during postmortem for shared understanding

### Collaborative-friendly authoring experience

**User-friendly editor:**
Azure Monitor Workbooks provide an **intuitive, low-code authoring environment** accessible to users without deep technical expertise.

**Edit mode features:**

**Visual editor:**

- **Add steps:** Click "Add" to insert query, parameter, text, or metric steps
- **Drag-and-drop:** Reorder steps by dragging
- **Settings panels:** Configure step properties through forms and dropdown menus
- **Live preview:** See results immediately as you make changes

**Query builder assistance:**

- **Query editor:** Syntax highlighting and auto-completion for KQL
- **Example queries:** Pre-populated examples for common scenarios
- **Query testing:** Run queries independently before adding to workbook
- **Result preview:** See query output before choosing visualization type

**Visualization configuration:**

- **Chart types:** Column, bar, line, area, scatter, pie, map, etc.
- **Visual customization:** Colors, axis labels, legends, thresholds, annotations
- **Conditional formatting:** Highlight values based on rules (e.g., red for errors, green for success)
- **Custom column rendering:** Format table columns with icons, links, sparklines, heatmaps

**Parameter configuration:**

- **Type selection:** Choose parameter type from dropdown (time range, resource picker, dropdown, etc.)
- **Query for values:** Write KQL query to populate parameter options
- **Default values:** Set sensible defaults for better user experience
- **Dependencies:** Configure parameters that filter other parameters

**Low-code approach benefits:**

- **Accessibility:** Non-developers can create sophisticated monitoring reports
- **Faster development:** Build workbooks in hours, not days
- **Lower maintenance:** Visual editor makes updates easier than code-based tools
- **Team contribution:** More team members can contribute to monitoring content

**Advanced authoring (optional):**

- **JSON editing:** Switch to JSON view for advanced customization
- **Custom visualizations:** Integrate custom HTML/JavaScript for specialized needs
- **API integration:** Call external APIs for data enrichment
- **Advanced KQL:** Leverage full KQL power for complex analytics

### Template ecosystem

**Public template gallery:**
Azure Monitor Workbooks benefit from a **rich ecosystem** of pre-built templates covering common monitoring scenarios.

**Template sources:**

**Microsoft-provided templates:**

- **Coverage:** Application Insights, VM insights, Container insights, Azure services
- **Quality:** Microsoft-maintained, regularly updated
- **Examples:**
  - **Application Insights - Performance:** Application performance analysis with requests, dependencies, exceptions
  - **Virtual Machine Performance:** CPU, memory, disk, network analysis for VMs
  - **Azure Kubernetes Service (AKS):** Container health, pod performance, node utilization
  - **Security Center:** Security recommendations, alerts, compliance status

**[Public GitHub-based gallery](https://github.com/microsoft/Application-Insights-Workbooks):**

- **Community contributions:** Workbooks shared by Azure users worldwide
- **Diverse scenarios:** Industry-specific, technology-specific, or use-case-specific workbooks
- **Open source:** View source JSON, learn authoring techniques, contribute improvements
- **Examples:**
  - Industry-specific (retail, healthcare, finance) monitoring patterns
  - Technology-specific (Cosmos DB, Azure SQL, Service Bus) analysis
  - Use-case-specific (cost optimization, security auditing, performance benchmarking)

**Organizational templates:**

- **Internal sharing:** Create templates for your organization's common patterns
- **Standardization:** Ensure consistent monitoring approaches across teams
- **Best practices:** Capture institutional knowledge in reusable templates

**Using templates:**

**Template instantiation:**

1. **Browse gallery:** Navigate to Workbooks in Azure Monitor
2. **Select template:** Choose template matching your scenario
3. **Configure parameters:** Provide required inputs (subscriptions, resources, etc.)
4. **View results:** Template populates with your data
5. **Customize (optional):** Edit template to add organization-specific content
6. **Save:** Save as personal or shared workbook for future use

**Template customization:**

- **Start with template:** Use template as starting point rather than building from scratch
- **Add sections:** Include organization-specific metrics, thresholds, or context
- **Modify queries:** Adjust queries to match your resource naming, tagging, or structure
- **Branding:** Add company logos, style guidelines, or standard headers
- **Save as new template:** Share customized version with your teams

**Template benefits:**

- **Faster time to value:** Deploy monitoring in minutes instead of hours
- **Best practices:** Learn from experts' query patterns and visualization choices
- **Consistency:** Standard templates ensure consistent monitoring across organization
- **Learning tool:** Study template queries to improve KQL and monitoring skills

## Limitations to understand

While Workbooks offer powerful analytical capabilities, recognizing their **limitations** helps you choose the appropriate tool for each monitoring scenario:

### No automatic refresh

**Manual refresh requirement:**

- **Behavior:** Workbooks do **not automatically refresh** data like Azure Dashboards
- **User action required:** Users must manually refresh by clicking the **Refresh button** or re-opening the workbook
- **Impact:** Not suitable for real-time monitoring or continuously displayed operational views
- **Rationale:** Workbooks are designed for analytical sessions (investigation, reporting) rather than continuous monitoring

**When this matters:**

**Real-time monitoring scenarios:**

- **Use case:** NOC wall displays, always-on system health monitors
- **Impact:** High—stale data defeats purpose of real-time monitoring
- **Recommendation:** Use Azure Dashboards instead

**Interactive investigation:**

- **Use case:** Incident troubleshooting, performance analysis sessions
- **Impact:** Low—users actively engaged and can manually refresh as needed
- **Recommendation:** Workbooks are appropriate

**Scheduled reporting:**

- **Use case:** Weekly/monthly reports saved and shared with stakeholders
- **Impact:** Low—report represents specific point in time
- **Recommendation:** Workbooks work well (refresh before saving/sharing)

**Workarounds:**

**Manual refresh during active use:**

- **Approach:** Refresh workbook periodically during investigation sessions
- **Best practice:** Refresh after each significant finding or when data seems outdated
- **Keyboard shortcut:** May be available depending on browser

**Scheduled report generation:**

- **Approach:** Use Azure Logic Apps or Azure Functions to open workbook URL at scheduled intervals
- **Save output:** Capture workbook state as PDF or image for distribution
- **Distribution:** Email results to stakeholders

**Combine with dashboards:**

- **Dashboard:** Real-time monitoring and alerting
- **Workbook:** Deep investigation when dashboard indicates issues
- **Workflow:** Dashboard provides continuous monitoring → alerts on anomaly → user opens workbook for detailed analysis

### No dense layout (not a "single pane of glass")

**Vertical document format:**

- **Design:** Workbooks use **vertical, scrollable** document structure
- **Contrast:** Dashboards use **grid-based** layouts with all tiles visible simultaneously
- **Impact:** Cannot see all metrics at once—must scroll through workbook
- **Purpose:** Optimized for narrative flow and detailed analysis, not at-a-glance monitoring

**When this matters:**

**At-a-glance monitoring:**

- **Use case:** Operator needs to see all critical systems simultaneously
- **Impact:** High—scrolling defeats purpose of quick status check
- **Recommendation:** Use Azure Dashboards for operational monitoring

**Executive dashboards:**

- **Use case:** Leadership review of key metrics during meetings
- **Impact:** Medium—may want summary view before diving into details
- **Recommendation:** Start with dashboard for overview, use workbook for drill-down

**Guided investigations:**

- **Use case:** Step-by-step troubleshooting or performance analysis
- **Impact:** Low (or positive)—vertical flow guides user through logical sequence
- **Recommendation:** Workbooks excel in this scenario

**Characteristics of workbook layout:**

**Advantages:**

- **Narrative structure:** Sequential steps guide users through logical analysis flow
- **Unlimited space:** Not constrained by screen size—can include extensive detail
- **Focus:** User focuses on one section at a time without distraction
- **Mobile-friendly:** Vertical scrolling works well on tablets and smaller screens

**Disadvantages:**

- **No holistic view:** Cannot see all metrics simultaneously
- **Scrolling required:** May need to scroll extensively in long workbooks
- **Comparison difficulty:** Harder to visually compare metrics displayed in different sections
- **Context switching:** Scrolling between sections creates cognitive load

**Mitigation strategies:**

**Table of contents:**

- **Add navigation:** Create clickable table of contents at top of workbook
- **Jump links:** Enable users to skip directly to relevant sections
- **Benefit:** Reduces scrolling, improves usability for long workbooks

**Collapsible groups:**

- **Organize content:** Use group steps to create expandable/collapsible sections
- **Default state:** Collapse less-used sections by default
- **Benefit:** Reduces apparent workbook length, improves scannability

**Multiple tabs:**

- **Separate concerns:** Use tabs for major topic divisions (Infrastructure | Applications | Security)
- **User control:** Users navigate directly to relevant tab
- **Benefit:** Reduces scrolling within each tab, maintains focus

**Summary sections:**

- **Executive summary:** Include high-level summary at top with key findings
- **Detailed sections below:** Deep dive details in subsequent sections
- **Benefit:** Provides both at-a-glance and detailed views in same workbook

## When to use Azure Monitor Workbooks

**Ideal scenarios:**

**Investigation and troubleshooting:**

- **Use case:** Diagnosing performance issues, analyzing incidents, root cause analysis
- **Reason:** Interactive parameters, drill-down capabilities, sequential investigation flow
- **Example:** Troubleshooting application slowness with guided analysis of requests → dependencies → databases → queries

**Ad-hoc analysis:**

- **Use case:** Exploring data to answer specific questions or validate hypotheses
- **Reason:** Flexible parameterization, rich query capabilities, interactive visualizations
- **Example:** Analyzing impact of recent deployment on error rates across customer segments

**Reporting and documentation:**

- **Use case:** Performance reports, security audits, compliance documentation, incident postmortems
- **Reason:** Narrative structure combining visualizations and explanatory text
- **Example:** Quarterly performance review showing trends, achievements, areas for improvement

**Template-based monitoring:**

- **Use case:** Standardized analysis across similar resources or recurring scenarios
- **Reason:** Template ecosystem, reusability, customization capabilities
- **Example:** VM performance analysis template applied to all VMs in infrastructure

**Training and knowledge sharing:**

- **Use case:** Teaching team members how to investigate issues or interpret metrics
- **Reason:** Markdown text for explanations, guided workflows, saved examples
- **Example:** "New hire monitoring guide" workbook explaining key metrics and investigation procedures

**When to use dashboards instead:**

**Continuous monitoring:**

- **Need:** Always-on display of system health for rapid issue detection
- **Why dashboards:** Automatic refresh, dense grid layout, full-screen mode
- **Workbook limitation:** Manual refresh required

**At-a-glance status:**

- **Need:** See all critical metrics simultaneously without scrolling
- **Why dashboards:** Holistic view with all tiles visible
- **Workbook limitation:** Vertical scroll format

**Multiple simultaneous consumers:**

- **Need:** Many team members viewing same real-time data
- **Why dashboards:** Designed for shared operational views
- **Workbook limitation:** Better for individual analytical sessions

**Best approach:**
Use **dashboards for monitoring** (continuous visibility, alerting, operational awareness) and **Workbooks for analysis** (investigation, troubleshooting, reporting, deep dives). These tools are complementary, not competing—leverage both for comprehensive monitoring strategy.
