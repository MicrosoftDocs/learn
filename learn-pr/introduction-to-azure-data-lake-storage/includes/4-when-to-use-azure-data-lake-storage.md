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
Now we'll consider whether Azure Data Lake Storage is the correct choice for your organization's big data requirements. Your organization wants to control costs, remove data silos, make it easy to generate business insights from on any data, and run analytics workloads on real-time data streams.

We'll list some criteria that indicate whether Azure Data Lake Storage will meet your performance and functional goals.

* Costs
* Data access
* Data insights
* Real-time analytics

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

If your organization stores big data, it most likely uses a *data warehouse*. A data warehouse is a repository for data that has been processed—cleaned, structured, and filtered—in a way that enables employees—such as managers and business analysts—to extract business intelligence by running analytics workloads.

Administrators and data engineers know that traditional data warehouses are expensive, create barriers to access, cannot extract business insights from external data sets, and don't provide real-time analysis of big data. These problems are not issues if your organization deals with a single type of data or with data sets that are relatively small. Let's talk more about each of these factors.

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

### Costs

When deciding whether to move to a data lake from a traditional, on-premises data warehouse, one of the biggest factors is cost. Does a data lake solution such as Azure Data Lake Storage reduce total cost of ownership (TCO)?

First, let's look at why traditional data warehouses have high TCO:

* They generally use costly, high-end hardware for reliability and performance.
* They require expensive software licenses to process and analyze the data.
* It can be expensive (and complicated) to make significant changes to the data warehouse configuration or data structures.
* Their overall costs grow as data volume grows.
* They have associated, fixed costs for items such as maintenance, administration, and backups.

How does Azure Data Lake Storage compare? Let's take a look:

* Azure Data Lake Storage runs on virtual hardware in the Azure cloud, so storage is scalable, fast, and reliable without incurring massive charges.
* All the software you need to ingest, process, and analyze data is available within your Azure subscription and can be used as needed for little cost.
* Data is unprocessed and resides (usually) in a hierarchical namespace, so it costs little (and is easy) to make changes.
* Azure Data Lake Storage separates storage costs from compute costs, so as your data volume grows, only your storage requirements change. Paying for more cloud storage is far less expensive than adding hardware to store extra data.
* Costs for items such as maintenance, administration, and backups are mostly handled by Azure.

### Data access

Does a data lake solution such as Azure Data Lake Storage make it easier for users to access data—that is, browse, search, and query the data—than with a traditional data warehouse?

First, let's see why a traditional data warehouse can often create significant barriers to access (that is, data silos):

* Data exploration is limited to what's available using the data warehouse's dedicated data access front-end software.
* There's no exploratory access to raw data.
* Data exploration doesn't include data that's incompatible with or stored outside of the data warehouse.
* If different types of data are stored in separate data warehouses, there's usually no straightforward or cost-effective way to share or combine these data sets.

Azure Data Lake Storage overcomes all of the above data access barriers—that is, it enables so-called *data democratization*—by enabling your organization to store all your data formats—including raw data—in a single location. Eliminating data silos means users can open a tool such as Azure Data Explorer and use it to access and work with every data item in your storage account.

### Data insights

Does Azure Data Lake Storage facilitate the extraction of useful business intelligence and other types of business analytics? Data warehouses are purpose-built for analyzing large amounts of data, but the nature of the data warehouse sets limits on the types of insights users can glean:

* The incoming data is highly processed. That processing can introduce subtle biases or restrictions that can make some insights unavailable or difficult to extract.
* The stored data is almost always a subset of the total data (to keep costs in check), so users might miss insights that rely on the unavailable data.
* Data warehouses are generally configured to make it easy for business professionals to mine the data for insights. However, that ease of use usually means that users who want to dive deeper into the organization's data—such as data analysts and data scientists—are out of luck because the data they need is unavailable.

> [!NOTE]
> In database parlance, a *schema* is a kind of blueprint for the organizational structure of the data. Data warehouses apply a schema to all incoming data, an approach often referred to as *schema-on-read*. Azure Data Lake Storage, by contrast, doesn't apply a schema to its data. Instead, a schema only gets applied when a tool or framework wants to use the data in some way (say, for an analytics workload), an approach known as *schema-on-write*.

Here's how the Azure Data Lake Storage solution compares:

* Data is not processed in any way during ingestion, so there are no biases or restrictions introduced into the data.
* Azure Data Lake Storage stores all the available data, whether it's raw, semi-structures, or structured.
* Although Azure Data Lake Storage can output data to tools such as Power BI that appeal to business analysts, with the data unprocessed and complete, data scientists and other users can easily and quickly design prototypes—called *analytical sandboxes*—to explore, test, mash up, and in other ways dive deeply into the data.

### Real-time analytics

Is Azure Data Lake Storage the right choice for the ingestion and storage of real-time data to be used in machine learning, the creation of accurate prediction models, and similar real-time analytics? Data warehouses are usually not ideal for handling streaming data for the following reasons:

* Most data warehouses are configured for *batch input* where the data is ingested in discrete transactions rather than in real time.
* The schema-on-read approach used by data warehouses is expensive and slow when applied to the high velocity of incoming streaming data.
* Data warehouses work best with structured data, but streaming data is often in a semi-structured format such as JSON or XML key-value pairs.
* Data warehouses filter incoming data, but the analytics workloads for streaming data—particularly for machine learning—almost always require access to the complete data set.
* Real-time data for a single application often comes in multiple formats—for example, JSON files, log files, and CSV files—and data warehouses are often not configured to handle disparate data formats.

By contrast, Azure Data Lake Storage was built with real-time data in mind:

* Azure Data Lake Storage can ingest real-time data directly from an instance of HDInsight Storm, Azure IoT Hub, Azure Event Hubs, or Azure Stream Analytics.
* Azure Data Lake Storage does not apply a schema during ingestion, so there's no incoming bottleneck for real-time data.
* Azure Data Lake Storage works with semi-structured data.
* You can ingest all your real-time data into your storage account.
* Azure Data Lake Storage is format-agnostic and can therefore give analysts access to multiple data formats as needed.

Besides these advantages, Azure Data Lake Storage is ideal for real-time analytics because the ingested streaming data can be output to various Azure services, such as Azure Machine Learning and Azure Stream Analytics.

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

To decide whether Azure Data Lake Storage is the right solution for your organization, review the following use cases and recommendations.

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

### Should you use Azure Data Lake Storage to lower costs?

Organizations that deal with relatively small amounts of data (measured, say, in gigabytes rather than terabytes or even petabytes) or data that is generated or modified relatively slowly, might not save much money by moving from a data warehouse to a data lake.

However, you should consider using Azure Data Lake Storage to reduce TCO if any of the following apply to your organization:

* You generate massive amounts of data.
* You generate new data quickly.
* You often change the configuration of your data.
* Your costs for hardware, software, and maintenance take up a significant and increasing portion of your IT budget.

### Should you use Azure Data Lake Storage to improve data access?

Organizations that want to keep tight control over how users access data and that don't have the need to store raw and semi-structured data might not require the improved data access that comes from moving to Azure Data Lake Storage.

However, you should consider using Azure Data Lake Storage to enhance data democratization if any of the following apply to your organization:

* You want to prevent the data silos that occur when separate data sets can't be queried or integrated.
* You want to give users access to all your organization's data.
* You want to give users more flexibility in the tools they use to access the data.

### Should you use Azure Data Lake Storage for data insights?

Using Azure Data Lake Storage for data insights might not be suitable for organizations that have a narrow scope of what they want to look for when analyzing data or where analyzing data is handled mostly by business professionals.

However, you should consider using Azure Data Lake Storage for data insights if any of the following apply to your organization:

* You want to offer users a more flexible approach to exploring the data.
* You want to give analysts access to raw and semi-structured data.
* You want users to be able to build models and sandboxes that use any (or even all) available data.

### Should you use Azure Data Lake Storage for real-time analysis?

You do not need Azure Data Lake Storage to handle real-time data if your organization's streaming data has a relatively slow velocity, comes in a single data format (such as JSON files), and your data warehouse is configured to handle that data format applying any processing.

However, you should consider using Azure Data Lake Storage for real-time analytics if any of the following apply to your organization:

* Your streaming data comes in very fast.
* Your real-time data arrives in multiple data formats.
* You want to apply multiple types of analytics workloads to the data, such as machine learning, model prediction, and sentiment analysis.

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