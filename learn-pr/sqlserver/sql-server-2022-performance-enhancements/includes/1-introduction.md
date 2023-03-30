<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: orient the learner to the area covered in this module

    Heading: none

    Example: "Azure Logic Apps let you automate your business processes and run them in the cloud."

    Recommended: visual like an image, table, list, etc. that supports the topic sentence(s)

    [Introduction unit guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=main#rule-use-the-standard-module-introduction-format)
-->
## Solutions for faster performance with no code changes using the next generation of Intelligent Query Processing (IQP)
---

Intelligent Query Processing is a family of capabilities built into the query processor in the database engine designed to accelerate performance with no code changes. The next generation of Intelligent Query Processing is built on a foundation of capabilities found in SQL Server 2017 and 2019 as seen in the following figure:

![SQL Server Intelligent Query Processing Feature Family](https://github.com/microsoft/sqlworkshops-sql2022workshop/blob/main/sql2022workshop/graphics/iqp-feature-family.svg)

As you can see in this diagram there have been several IQP features that were part of SQL Server 2017 and SQL Server 2019. SQL Server 2022 adds several new capabilities for IQP. 

SQL Server 2022 provides built-in capabilities to reduce time for query tuning with the Query Store and next generation of IQP features to help you gain faster and consistent performance with no code changes.

The database engine uses two principles to make decisions for Intelligent Query Processing (IQP):

- Avoid causing any query performance regressions by using a new method or automation.
- Provide a method at the database or query level to disable a specific IQP capability. 

This allows you to pick and choose which IQP feature you want enabled at the database or query level while using other IQP feature depending on your dbcompat level.

### Query Store Improvements
In SQL Server 2022 additional improvements, default behaviors, and included functionality is now available.

##### Query Store on by default
The Query Store is now on by default for any any new database created on a SQL Server 2022 instance. Prior to SQL Server 2022, the Query Store must be enabled using the T-SQL ALTER DATABASE statement.

##### Query Store Hints
Query Store hints provide an easy-to-use method for shaping query plans without changing application code. ou can take any query that is stored in the Query Store and use system stored procedures to apply a query hint to affect the query plan with the intention of improving query performance with out changing application code. For example, you could apply a query store hint to require a query to use a specific MAXDOP value without changing the query text.

Query store hints are not intended to be used as a normal step to tune query performance but can be a useful tool for query tuning especially if you cannot change the query text in an application. In addition, some new Intelligent Query Processing features use a query store hint. You can view any persisted query store hints in the sys.query_store_query_hints catalog view.

##### Query for read replicas
While the Query Store is beneficial for reducing the amount of time required to tune queries or easily identify query performance issues, performance information is only available for queries executed against the primary replica in an Always On Availability Group. In SQL Server 2022 and new option is available using the T-SQL **ALTER DATABASE** statement to enable the Query Store to collect performance information for read-only queries executed on secondary replicas. All performance information for all replicas is persisted on the primary replica. New information is captured in the Query Store to indicate which replica is associated with a query or query plan.

> NOTE: Trace flag 12606 is required in order to be able enable Query Store for secondary replicas

##### Query Store for IQP
While the Query Store collected key performance information for queries, the query processor in SQL Server 2022 will also use the Query Store to persist information to accelerate query performance including to support features such as Optimized Plan Forcing, Memory Grant feedback, Cardinality Estimation (CE) Model feedback, and Degree of Parallelism (DOP) feedback.

<!-- 2. Scenario -----------------------------------------------------------------------------------------

    Goal: describe the real-world scenario this module will use to illustrate the concepts

    Heading: "## Example scenario"

    Example: "Suppose you work at an athletic shoe company on the marketing team. You're launching a new basketball shoe created by a celebrity athlete. Previous launches resulted in a social media frenzy as people shared stories and photos of themselves wearing their new shoes. The marketing team wants to monitor hundreds of social media sites, blogs, and websites to determine consumer reaction. There will be more data than you can process manually. You would like a cloud-hosted system that automates monitoring, text analytics, database storage, and email notifications."

    Recommended: an image that visualizes the scenario, use the image markdown extension (https://review.docs.microsoft.com/help/contribute/markdown-reference?branch=main#images)

    Optional: a "scenario video" that visualizes the scenario

    [Scenario guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-scenarios)
    [Scenario video guidance](TBD)
 -->
## Example scenario
TODO: add your scenario
TODO: add a visual element

<!-- 3. Prose table-of-contents --------------------------------------------------------------------------

    Goal: List the activities the learner will do in this content. This differs from the title and the learning objectives. The title and the learning objectives are "outcome focused"; that is, they describe the skills the learner will acquire as a result of consuming this content. By contrast, here you should be specific about what the learning will **do** in order to acquire those skills. The format can be either prose or bulleted-list; however, a list will yield better results when transformed into other output types such as PowerPoint.

    Heading: "## What will we be doing?"

    Example: "Here, you'll create a business workflow using Azure Logic Apps to automate the processing of tweets:
                * **Launch**: when a new tweet is available
                * **Process**: determine if the sentiment of the tweet is positive or negative
                * **Route**: branch based on the sentiment score"

 -->
## What will we be doing?
TODO: add your activities

<!-- 4. Terminal learning objective ----------------------------------------------------------------------

    Goal: This is a restatement of the module title into a complete sentence. You have more room here to convey the main goal than in a space-limited title. Make it outcome-focused so it describes the main skill the learner will acquire as a result of this training. In other words, it should answer the question: "what is the key thing the learner will be able to do as a result of consuming this training?"

    Heading: "## What is the main goal?"

    Example: "By the end of this session, you'll be able to create workflows which route and process data using Azure Logic Apps and its built-in connectors."

 -->
## What is the main goal?
By the end of this session, you'll be able to (TODO)

<!-- Do **not** include any other content like learning objectives, prerequisites, unit summary, "next unit" lead-in, or references. -->