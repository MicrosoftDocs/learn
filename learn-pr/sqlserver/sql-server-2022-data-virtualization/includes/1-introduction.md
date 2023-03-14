Data Virtualization integrates data at query time, without replicating or moving the original data. It is the ability to access the data where it lives.

Data virtualization relies on three principles:

- **Data abstraction:** hides the complexities of accessing data from the underlying data system, their formats and structures.

- **Zero replication:** Unlike traditional ETL, data virtualization does not need to “collect” the data into a separate repository to transform it to the destination format. It handles transformation and aggregation on-the-fly.

- **Real-Time data:** Since data virtualization connects to the data source on-the-fly, it always delivers the latest available data.

## Benefits of data virtualization

Major benefits of data virtualization:

- **No data movement:** Access the data where it is.

- **Transact-SQL (T-SQL) language:** Ability to leverage all the benefits of the T-SQL language, its commands, enhancements, and familiarity.

- **One source for all your data:** Users and applications can use SQL Server 2022 as its single data source for all of the required data, as a data hub, hiding the complexity from the application. While database administrators and data engineers have a single environment to maintain.

- **Security:** Leverage SQL Server security features for granular permissions, credential management, and control.

- **Cost:** PolyBase is available in all SQL Server 2022 editions.


TODO: add your topic sentences(s)
TODO: add a visual element

## Example scenario

Data Virtualization use cases:

- **Data Hub:** Using SQL Server as a centralized hub that connects, protects and query different data sources and files. Hiding all the complexity of the application. With no need to use an ETL tool to aggregate and to copy/move the data to a stagging area.

- **In-Database analytics:** Combining with all SQ Server capabilities and familiarity.

- Off-load\Export data to other data sources.

<!-- 3. Prose table-of-contents --------------------------------------------------------------------------

    Goal: List the activities the learner will do in this content. This differs from the title and the learning objectives. The title and the learning objectives are "outcome focused"; that is, they describe the skills the learner will acquire as a result of consuming this content. By contrast, here you should be specific about what the learning will **do** in order to acquire those skills. The format can be either prose or bulleted-list; however, a list will yield better results when transformed into other output types such as PowerPoint.

    Heading: "## What will we be doing?"

    Example: "Here, you'll create a business workflow using Azure Logic Apps to automate the processing of tweets:
                * **Launch**: when a new tweet is available
                * **Process**: determine if the sentiment of the tweet is positive or negative
                * **Route**: branch based on the sentiment score"

 -->
## Learning objectives
TODO: add your activities

<!-- 4. Terminal learning objective ----------------------------------------------------------------------

    Goal: This is a restatement of the module title into a complete sentence. You have more room here to convey the main goal than in a space-limited title. Make it outcome-focused so it describes the main skill the learner will acquire as a result of this training. In other words, it should answer the question: "what is the key thing the learner will be able to do as a result of consuming this training?"

    Heading: "## What is the main goal?"

    Example: "By the end of this session, you'll be able to create workflows which route and process data using Azure Logic Apps and its built-in connectors."

 -->

## Prerequisites

- Basic working knowledge of SQL Server
- Fundamental knowledge of the T-SQL language
- Basic knowledge of Azure concepts, including subscriptions, resource groups, Infrastructure-as-a-Service and Platform-as-a-Service

## What is the main goal?
By the end of this session, you'll be able to (TODO)

<!-- Do **not** include any other content like learning objectives, prerequisites, unit summary, "next unit" lead-in, or references. -->