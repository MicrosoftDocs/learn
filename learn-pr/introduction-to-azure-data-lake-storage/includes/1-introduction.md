<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: briefly orient the learner to the product; what category of problem does it solve?

    Heading: none

    Example: "Implementing a business process can be challenging because you typically need to make diverse services work together. Think about everything your company uses to store and process data: Salesforce, Microsoft 365, Oracle, Twitter, YouTube, Dropbox, Google services, Azure Cognitive Services, and so on. How do you integrate all these products? Azure Logic Apps gives you pre-built components to connect to hundreds of services. You use a graphical design tool to put the pieces together in any combination you need and Logic Apps will run your process automatically in the cloud."

    Recommended: visual like an image (preferred), table, list, etc.

    [Introduction unit guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=master#rule-use-the-standard-module-introduction-format)
-->
Modern organizations are data-generating machines. Not only do today's enterprises gather and generate massive amounts of data, but that data also comes in diverse formats: structured databases, PDF files and other documents, images and other media, device data, web server logs, JSON files, and so on. How do you integrate these data types in a way that lets your company use and analyze all that data? Azure Data Lake Storage enables you to store a wide variety of data types in a single location. With all your data in one place, services such as HDInsight and Data Lake Analytics work directly with Azure Data Lake Storage to give you powerful, cost-effective, and secure tools to process, analyze, and visualize that data.

:::image type="content" source="../media/1-introduction-topic.png" alt-text="Network diagram of a hub virtual network, several spoke virtual networks, and an on-premises network, with all traffic to and from the internet passing through an Azure Firewall instance in the hub network.":::

<!-- 2. Scenario -----------------------------------------------------------------------------------------

    Goal: Describe the real-world scenario you'll use to illustrate the product. Include 2-3 customer tasks that represent the most-common use cases for the product.

    Heading: "## Example scenario"

    Example: "Suppose you work at an athletic shoe company that is launching a new product. You sell the shoes on your website, manage your cloud-hosted advertising videos, and monitor social media to gauge reactions to the launch. The following illustration shows these processes. Notice how the tasks include both customer-facing processes like direct sales and administrative tasks like auto-archiving old videos. Here, you'll see how Logic Apps automates these types of business processes."

    Recommended: an image that visualizes the scenario

    [Scenario guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-scenarios)
 -->

## Example scenario

Suppose you work for an organization with many different departments, each of which generates large amounts of data in diverse formats:

- Your Internet of Things (IoT) department has deployed thousands of sensors that generate a continuous stream of raw data.
- Your web services team operates dozens of web servers that each generate huge amounts of server log data.
- Your business units create a constant stream of spreadsheets, presentations, PDF files, and other documents.
- Your developers maintain a large number of HTML, CSS, JavaScript, JSON, and other programming files.
- Your marketing team creates many videos, images, and other media.
- Your IT department stores a huge amount of structured business data in a relational database system, such as SQL Server.

In the past, these business units would maintain separate stores of data, resulting in data *silos* that can't be used or analyzed together. However, with Azure Data Lake Storage, you eliminate data silos by bringing these disparate data stores into a single location where they can be combined and analyzed.

<!-- 3. Prose table-of-contents --------------------------------------------------------------------------

    Goal: List the activities the learner will do. This differs from the learning objectives. The learning objectives are "outcome focused"; that is, they describe the skills the learner will acquire as a result of consuming this content. By contrast, here you should be specific about what the learning will **do** in order to acquire those skills. The format can be either prose or bulleted-list; however, a list will yield better results when transformed into other output types such as PowerPoint.

    Heading: "## What will we be doing?"

    Example: "We’ll analyze the capabilities of Logic Apps to help you decide when to use them:
                * **Launch**: what conditions can you set to launch your app?
                * **Connect**: which services can you connect to?
                * **Branch**: what types of business logic can you add to your app?"

 -->

## What will we be doing?

In this module, you'll learn the fundamentals of Azure Data Lake Storage. You'll learn what it is and what are its main features. You'll also learn how Azure Data Lake Storage ingests, stores, and processes data. Finally, you'll determine when you should use Azure Data Lake Storage.

<!-- 4. Terminal learning objective ----------------------------------------------------------------------

    Goal: The title of an "Introduction to <product>" module tells our customers that this is a good place to start their learning. This helps our customers find the right content quickly. The trade-off is that the title does not reflect the terminal learning objective of the module. Here, you explain that this module teaches the 'evaluate' task. To do this, you:
        - Start with your 'evaluate' learning objective
        - Make it a complete sentence if it's not already
        - Use plain language so it sounds conversational
        - Include the lead-in shown below ("By the end...")

    Heading: "## What is the main goal?"

    Example: "By the end of this session, you'll be able to decide whether Logic Apps is a good choice to automate your business processes."

 -->

## What is the main goal?

By the end of this session, you'll be able to evaluate whether Azure Data Lake Storage is the right solution for bringing together your organization's separate data stores. You'll also be able to describe how Azure Data Lake Storage provides a scalable, fast, secure, and cost-effective way to store any type of data your organization generates.

<!-- Do **not** include any other content like learning objectives, prerequisites, unit summary, "next unit" lead-in, or references. -->