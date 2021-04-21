<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: state what's in this unit and how it aligns to the 'evaluate' learning objective.

    Pattern:
        One paragraph of 2 sentences:
            Sentence 1: State that this unit addresses ("when to use it").
            Sentence 2: State that this unit targets this learning objective: "Evaluate whether <product> is appropriate to <general product use case>."
        Decision criteria as a bulleted list.

    Heading: none

    Example: "Here, we'll discuss how you can decide whether Logic Apps is the right choice for a workflow. We'll list some criteria that indicate whether Logic Apps will meet your performance and functional goals.
        * Integration
        * Performance
        * Conditionals
        * Connectors"
-->
Use Azure Monitor when you need to collect, analyze, and act on availability, health, and performance telemetry for your applications and infra resources.  IT Ops, DevOps and developer teams can use Azure Monitor for day-to-day operations, continuous monitoring, pre-production and development phases of the app lifecycle.

Users can take advantage of Azure Monitor Insights for at-scale monitoring views to track performance across multiple resources and start investigations by drilling into the details of a single resource.

Users can share reports with Azure Monitor workbooks and maintain operational awareness with dashboards.

Users can perform triage and root cause analysis using custom charts in Metrics Explorer or by analyzing logs with queries in Azure Monitor Logs.

Users can be notified, take action and scale their workloads in response to user-defined performance criteria or machine learning based thresholds.

Here, we'll discuss some examples of when you might want to use Azure Monitor to:
* Collect data using Azure Monitor Metrics
* Discuss Log Analytics usage with Azure Monitor
* Visualize monitoring data

<!-- 2. Decision criteria introduction --------------------------------------------------------------------------------

    Goal: Lead-in to the criteria discussion.

    Pattern:
        1 paragraph consisting of 3 sentences
            Sentence 1: summarizing the criteria from a positive view ("when to use").
            Sentence 2: describing the negative ("when not to use") at a high level.
            Sentence 3: transition/lead-in to the detailed discussion.

    Heading: "## Decision criteria"

    Example:
        "Decision criteria"
         "Logic Apps helps you coordinate the flow of data through disparate systems. The cases where Logic Apps might not be the best option typically involve real-time requirements, complex business rules, or use of non-standard services. Here's some discussion of each of these factors."
-->
## Decision criteria
Collecting data with Azure Monitor Metrics allows you to view performance data in real-time. If you want to store the data for later evaluation, you would select the logging capability and use a Log Analytics Workspace to store the recorded data. Visualizing the data allows you to see the information in various formats, that you can choose.

<!-- 3a. Decision criteria (for simple criteria) ----------------------------------------------------

    Note:
        Choose either 3a or 3b for your content; do not do both.
        This pattern is for simple criteria where the analysis is brief and does not require a visual element.

    Goal: Describe in detail each criterion that helps the "when to use it" decision.

    Heading: none, this content will be the 'body' for the "Decision criteria" heading above.

    Pattern:
        No heading.
        Place both the criteria and analysis into a table.

    Example:
        | | |
        | --- | --- |
        | **Criteria** | **Analysis**|
        | **Integration** | The key question to ask when you're considering Logic Apps is "do I need to integrate services?".... |
        | **Performance** | The next consideration is performance. The Logic Apps execution engine scales your apps automatically.... |
        | **Conditionals** | Logic Apps provides control constructs like Boolean expressions, switch statements, and loops.... |
        | **Connectors** | The last consideration is whether there are pre-built connectors for all the services you need to access. |
        |   |   |
-->
Let's look at the different mechanisms for monitoring and viewing your Azure resources.

| Monitoring Option | Usage |
| --- | --- |
| Metrics | Metrics are numerical values that describe some aspect of a system at a particular point in time. They are lightweight and capable of supporting near real-time scenarios. |
| Logs | Log data collected by Azure Monitor can be analyzed with queries to quickly retrieve, consolidate, and analyze collected data. You can create and test queries using Log Analytics in the Azure portal. You can then either directly analyze the data using different tools or save queries for use with visualizations or alert rules. |
| Visualizations | Azure Monitor has its own features for visualizing monitoring data and leverages other Azure services for publishing it to different audiences. Azure dashboards allow you to combine different kinds of data into a single pane in the Azure portal. Workbooks provide a flexible canvas for data analysis and the creation of rich visual reports in the Azure portal. |


<!-- 3b. Decision criteria (for complex criteria) ----------------------------------------------------------

    Note:
        Choose either 3a or 3b for your content; do not do both.
        This pattern is for complex criteria where the analysis of each criterion needs both and a visual element.

    Goal: Describe in detail each criterion that helps the "when to use it" decision.

    Pattern:
        For each criterion, repeat this pattern:
            1. H3 of the criterion.
            2. 1-3 paragraphs of discussion/analysis.
            3. Visual like an image, table, list, code sample, or blockquote.
            
    Example:
        H3: "Integration"
        Prose: The key question to ask when you're considering Logic Apps is _"do I need to integrate services?"_ Logic Apps work well when you need to get multiple applications and systems to work together. That's what they were designed to do. If you're building an app with no external connections, Logic Apps is probably not the best option."
        Visual: <image preferred>
-->
### Metrics
Metrics are numerical values that describe some aspect of a system at a particular point in time. They are lightweight and capable of supporting near real-time scenarios. The metrics explorer is built into the Azure portal, allowing you to focus on a specific resource to monitor. Data is presented in a chart or graph format.

:::image type="content" source="../media/metrics.png" alt-text="Depiction of a metrics data element feeding values into a chart that uses a line graph format and is available in the Azure portal for many resources. It is found under the Monitoring category.":::

### Logs
Log data collected by Azure Monitor can be analyzed with queries to quickly retrieve, consolidate, and analyze collected data. You can create and test queries using Log Analytics in the Azure portal. You can then either directly analyze the data using different tools or save queries for use with visualizations or alert rules.

Azure Monitor uses a version of the Kusto query language that is suitable for simple log queries but also includes advanced functionality such as aggregations, joins, and smart analytics.

:::image type="content" source="../media/logs.png" alt-text="Depiction of log data feeding into a table display in Log Analytics":::

### Visualizations
Azure Monitor has its own features for visualizing monitoring data and leverages other Azure services for publishing it to different audiences. Azure dashboards allow you to combine different kinds of data into a single pane in the Azure portal.

:::image type="content" source="../media/dashboard.png" alt-text="Depiction of an Azure dashboard that is displaying metrics in graph format for application performance metrics on the left and security incidents on the right.":::

Workbooks provide a flexible canvas for data analysis and the creation of rich visual reports in the Azure portal. They allow you to tap into multiple data sources from across Azure, and combine them into unified interactive experiences. Use workbooks provided with Insights or create your own from predefined templates.

:::image type="content" source="../media/workbooks.png" alt-text="Depiction of three workbooks displaying logged data in various chart formats and table formats.":::

<!-- 4. Apply-the-criteria introduction --------------------------------------------------------------------------------

    Goal: Lead-in to the example applications of the criteria.

    Pattern:
        1 paragraph consisting of 3 sentences
            Sentence 1: summarizing the criteria from a positive view ("when to use").
            Sentence 2: Acknowledge that there are cases for which <product> won't work and/or there are edge cases that are difficult to decide.
            Sentence 3: transition/lead-in to the detailed discussion.

    Heading: "## Apply the criteria"

    Example:
        "Apply the criteria"
         "Logic Apps works best when you're integrating multiple services with some added control logic. The decision is often a judgment call though. Let's think about how to apply these criteria to our example processes."
-->
## Apply the criteria
TODO: add your 3 lead-in sentences

<!-- 5. Apply the criteria examples -----------------------------------------------------------------------------

    Goal: Apply the criteria to the 2-3 customer tasks in the scenario described in your introduction unit.

    Pattern:
        For each customer task, repeat this pattern:
            1. "### Should <scenario subtask> use <product>?".
            2. 1-3 paragraphs of discussion/analysis (first sentence should answer yes/no about whether the product is suitable).
            3. Visual like an image, table, list, code sample, or blockquote.

    Example:
        H3: "Should the video-archive utility use Logic Apps?"
        Prose: "The video archive task is a good fit for Logic Apps even though it doesn't integrate multiple systems. Logic Apps has a built-in timer trigger and an Azure blob connector that are perfect to implement this process...."
        Visual: <image preferred>
-->

### Should <scenario subtask> use <product>?
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list)
Paragraph (optional)

### Should <scenario subtask> use <product>?
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list)
Paragraph (optional)

### Should <scenario subtask> use <product>?
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list)
Paragraph (optional)

<!-- 6. Guidance summary (optional) ------------------------------------------------

    Goal: Job-aid for future use to help customers evaluate their own tasks against the criteria.

    Pattern:
        1. Heading "## Guidance summary"
        2. Lead-in sentence acknowledging that this is a summary/repeat of previous material.
        3. Visual like a flowchart (as an image) or rubric (as a table).

    Example:
        "The following flowchart summarizes the key questions to ask when you're considering using Logic Apps."
        <flowchart image>
-->

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->