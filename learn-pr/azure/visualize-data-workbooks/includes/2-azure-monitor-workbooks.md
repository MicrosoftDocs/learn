<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: briefly summarize the key skill this unit will teach

    Heading: none

    Example: "Organizations often have multiple storage accounts to let them implement different sets of requirements."

    [Learning-unit introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=main#rule-use-the-standard-learning-unit-introduction-format)
-->
Monitoring the health of your services and visualizing different components of your applications and services are a vital component of running a production system. Most organizations have different requirements for building rich visual reports aggregating information from a number of data sources and using easy to interpret and interactive visualizations.

Azure Monitor Workbooks provide a flexible canvas for data analysis and the creation of rich visual reports within the Azure portal. They allow you to tap into multiple data sources from across Azure, and combine them into unified interactive experiences.

Workbooks give you a single tool that can combine text, analytic queries, metrics, and parameters into rich interactive reports that you can share with your team members.

   :::image type="content" source="../media/AzMonitor-overview.png" alt-text="Diagram showing Azure Monitor architecture":::

## Data Sources
Azure Monitor Workbooks can query and combine data from multiple data sources within a single report. This allows for the creation of very powerful rich visuals. Currently supported data sources are:

- **Logs.** You can query Azure Monitor Logs (Application Insights Resources and Log Analytics Workspaces.) or resource-centric data (Activity logs).
- **Metrics.** You can query metrics emitted from Azure resources to Azure Monitor.
- **Azure Resource Graph.** You can query resources and their metadata using Azure Resource Graph.
- **Alerts (Preview).** You can query the resources' active alerts.
- **Workload Health.** You can query the availability and performance of Windows or Linux guest operating systems.
- **Azure Resource Health.** You an query service problems that affect your Azure resources.
- **Azure Data Explorer.** You can use Kusto query language to query Azure Data Explorer clusters.

## Visualizations
Azure Monitor Workbooks allow you to display the information generated from the queried data sources using a rich set of visualizations to customize the reports based on your needs and requirements. Currently available visualizations are:

- Text
- Charts
- Grids
- Tiles
- Trees
- Graphs
- Composite bar
- Honey comb
- Map

You can see below a sample of a metric chart.

   :::image type="content" source="../media/2-metric-chart.png" alt-text="Screenshot of a sample metric query in an Azure Monitor Workbook showing a summary of storage account transactions":::

<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario that will be solved by the content in this unit

    Heading: none, combine this with the topic sentence into a single paragraph

    Example: "In the shoe-company scenario, we will use a Twitter trigger to launch our app when tweets containing our product name are available."
-->
TODO: add your scenario sub-task

<!-- 3. Prose table-of-contents --------------------------------------------------------------------

    Goal: State concisely what's covered in this unit

    Heading: none, combine this with the topic sentence into a single paragraph

    Example: "Here, you will learn the policy factors that are controlled by a storage account so you can decide how many accounts you need."
-->
TODO: write your prose table-of-contents

<!-- 4. Visual element (highly recommended) ----------------------------------------------------------------

    Goal: Visual element, like an image, table, list, code sample, or blockquote. Ideally, you'll provide an image that illustrates the customer problem the unit will solve; it can use the scenario to do this or stay generic (i.e. not address the scenario).

    Heading: none
-->
TODO: add a visual element

<!-- 5. Chunked content-------------------------------------------------------------------------------------

    Goal: Provide all the information the learner needs to perform this sub-task.

    Structure: Break the content into 'chunks' where each chunk has three things:
        1. An H2 or H3 heading describing the goal of the chunk
        2. 1-3 paragraphs of text
        3. Visual like an image, table, list, code sample, or blockquote.

    [Learning-unit structural guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-structure-learning-content?branch=main)
-->

<!-- Pattern for simple chunks (repeat as needed) -->
## H2 heading
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list, code sample, blockquote)
Paragraph (optional)
Paragraph (optional)

<!-- Pattern for complex chunks (repeat as needed) -->
## H2 heading
Strong lead sentence; remainder of paragraph.
Visual (image, table, list)
### H3 heading
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list)
Paragraph (optional)
### H3 heading
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list)
Paragraph (optional)

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->