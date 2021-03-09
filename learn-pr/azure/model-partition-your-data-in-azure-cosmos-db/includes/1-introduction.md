<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: orient the learner to the area covered in this module

    Heading: do not add an H1 or H2 title here, the auto-generated H1 will appear above this content automatically

    Example: "Azure Logic Apps let you automate your business processes and run them in the cloud."

    Recommended: visual like an image, table, list, etc. that supports the topic sentence(s)

    [Introduction unit guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=master#rule-use-the-standard-module-introduction-format)
-->

In this module, we will:

 - Identify key access patterns for a sample e-commerce application. 
 - Define the data model for each of the entities and the containers to store the data with a partition key

The objective is to end up with a data mode and partition scheme that results in an efficient and scalable data store for our e-commerce application.

<!-- 2. Scenario -----------------------------------------------------------------------------------------

    Goal: describe the real-world scenario this module will use to illustrate the concepts

    Heading: use the H2 "Example scenario"

    Example: "Suppose you work at an athletic shoe company on the marketing team. You're launching a new basketball shoe created by a celebrity athlete. Previous launches resulted in a social media frenzy as people shared stories and photos of themselves wearing their new shoes. The marketing team wants to monitor hundreds of social media sites, blogs, and websites to determine consumer reaction. There will be more data than you can process manually. You would like a cloud-hosted system that automates monitoring, text analytics, database storage, and email notifications."

    Recommended: an image that visualizes the scenario

    Optional: a "scenario video" that visualizes the scenario

    [Scenario guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-scenarios)
    [Scenario video guidance](TBD)
 -->
## Example scenario

Imagine that you work for a retail startup that's designing a database to manage online orders. You're working on a proposal for an efficient database design. You've been given a relational model to start from. To improve scalability and performance, you want to migrate the model to NoSQL. But to do so the data needs to be modeled correctly to realize the best efficiency and performance.

This is the model you will be starting from. The relational model has nine entities each in their own table.

:::image type="content" source="../media/full-relational-model.png" alt-text="relational model for our application":::

<!-- 3. Prose table-of-contents --------------------------------------------------------------------------

    Goal: List the activities the learner will do in this content. This differs from the title and the learning objectives. The title and the learning objectives are "outcome focused"; that is, they describe the skills the learner will acquire as a result of consuming this content. By contrast, here you should be specific about what the learning will **do** in order to acquire those skills. The format can be either prose or bulleted-list; however, a list will yield better results when transformed into other output types such as PowerPoint.

    Heading: use the H2 "What will we be doing?"

    Example: "Here, you'll create a business workflow using Azure Logic Apps to automate the processing of tweets:
                * **Launch**: when a new tweet is available
                * **Process**: determine if the sentiment of the tweet is positive or negative
                * **Route**: branch based on the sentiment score"

 -->
## What will we be doing?

We will be reviewing the application to determine the data access patterns. Based upon the identified patterns we will then model the data and create partitions within Azure Cosmos DB to optimize performance of the application.

<!-- 4. Terminal learning objective ----------------------------------------------------------------------

    Goal: This is a restatement of the module title into a complete sentence. You have more room here to convey the main goal than in a space-limited title. Make it outcome-focused so it describes the main skill the learner will acquire as a result of this training. In other words, it should answer the question: "what is the key thing the learner will be able to do as a result of consuming this training?"

    Heading: use the H2 "What is the main goal?"

    Example: "By the end of this session, you'll be able to create workflows which route and process data using Azure Logic Apps and its built-in connectors."

 -->
## What is the main goal?

- Determine access patterns for data
- Apply data model and partitioning strategies to support an efficient and scalable NoSQL database

<!-- Do **not** include any other content like learning objectives, prerequisites, unit summary, "next unit" lead-in, or references. -->