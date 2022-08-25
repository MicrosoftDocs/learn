<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: briefly summarize the project and setup requirements in 1-3 sentences.

    Heading: none

    Pattern: "You'll be <doing> a <thing> that <goal>. Here, we'll discuss the project <big picture>. We'll also cover the <things> you'll need."

    Example: "You'll be <building> a <Logic App> that <determines the sentiment of new tweets and reacts accordingly>. Here, we'll discuss the project <business logic and target behavior>. We'll also cover the <accounts and software> you'll need."
-->
You'll be writing KQL queries to extract, transform, and visualize data that helps you address the IT issues your retail chain is experiencing. Here, we'll discuss the approach we'll take to making sense of data in Azure Monitor Logs and extracting meaningful insights and answers to operational and business questions. 

<!-- 2. Project overview -------------------------------------------------------------------------------------

    Goal: Describe the end state of the project and the tasks they'll need to do in their solution. Keep the discussion at a high level and avoid implementation details.

    Structure:
        1. H2 of "Project overview"
        1. Lead sentence summarizing project goal(s). Remainder of paragraph describing project behavior in 1-2 sentences.
        1. One or both of the following:
            1. Paragraph followed by conceptual diagram or flowchart that captures the conditions the finished project must satisfy.
            1. Paragraph with a screenshot of the finished project. 
        1. Lead sentence followed by numbered list of sub-tasks needed to complete the project. You can use the exercise-unit titles as the basis for the list.

    Example:
        "The goal of the project is to design, build, and test a Logic App that processes tweets. Your app will check Twitter periodically for new tweets about your company. You'll determine whether the sentiment of tweet is positive or negative and branch the app based on the results.

        The following flowchart shows the business logic the app needs to perform:
            <flowchart>

        You'll map each business rule to a Logic Apps connector and assemble the connectors into an app. The following diagram shows the mapping:
            <diagram>

        The key tasks you'll need to do are:
            1. Select the connectors you'll need to implement the business rules.
            1. Create the app and add a trigger to launch the app when a new tweet is available.
            1. Use the Azure machine learning analytics service to analyze the text of the tweet.
            1. Based on the tweet sentiment, you'll either store the tweet in a database or email it to customer service.
-->
## Project overview

The goal of the project is to translate log data into information that helps you understand how you can address and mitigate the computer performance issues in your stores. 

The key tasks you'll need to perform are:

1. Set the scope of your analysis. Which questions do you want to answer and which data do you need to answer these questions?
1. Find the tables and columns that hold the log data relevant to your analysis.
1. Write KQL queries to extract the data you need from your logs. 

The following diagram depicts the approach to log analysis you'll be following throughout this project:

:::image type="content" source="../media/kql-log-analysis-azure-monitor-log-analytics.png" alt-text="A diagram that depicts the flow of defining questions, finding relevant log data and writing KQL queries. ":::

## Set analysis goals

Recall that your IT team has noticed recurring issues related to virtual machines with high CPU usage and insufficient free space. 

You also want to ensure that you're getting data about all active virtual machines in your network. You need to be able to identify machines that stop sending data, so that you can investigate and ensure have full visibility of the status of your virtual machines.

Therefore, for your analysis, you will need data about:

- Virtual machines that stop sending data. 
- CPU usage of virtual machines.
- Virtual machine free space statistics.

## Assess logs

Which tables hold data that's relevant to your analysis goals?

| Analysis goal | Log table with relevant data |
| --- | --- |
|  Virtual machines that stop sending data | The [Heartbeat](/azure/azure-monitor/reference/tables/heartbeat) table collects virtual machine health data from each virtual machine at one-minute intervals. |
| CPU usage of virtual machines | The [Perf](/azure/azure-monitor/reference/tables/perf) table collects data about the performance of hardware components, operating systems, and applications. |
| Virtual machine free space statistics | The [Perf](/azure/azure-monitor/reference/tables/perf) table. |
## Write queries

In the following units, you'll write KQL queries to extract and transform data based on your analysis goals. 

