<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: briefly orient the learner to the product; what category of problem does it solve?

    Heading: none

    Example: "Implementing a business process can be challenging because you typically need to make diverse services work together. Think about everything your company uses to store and process data: Salesforce, Microsoft 365, Oracle, Twitter, YouTube, Dropbox, Google services, Azure Cognitive Services, and so on. How do you integrate all these products? Azure Logic Apps gives you pre-built components to connect to hundreds of services. You use a graphical design tool to put the pieces together in any combination you need and Logic Apps will run your process automatically in the cloud."

    Recommended: visual like an image (preferred), table, list, etc.

    [Introduction unit guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=master#rule-use-the-standard-module-introduction-format)
-->
Tracking the data that your organization uses can be challenging. The data is constantly growing, stored in different locations, and shared among users. How do users know what data is available? How do administrators manage data when they may not know what type of data exists and where it is stored? Does the data contain sensitive or personal information?

All these questions are typically not easy to answer without insights into the data and the source of storage. Before you can develop solid security plans for storage and usage, it's important to have a good idea of the data your organization uses.

:::image type="content" source="../media/unified.png" alt-text="Screenshot of Azure Purview data sources listing collections that consist of SQL Server, SAP-HANA, Azure Data Lake Storage among others.":::

<!-- 2. Scenario -----------------------------------------------------------------------------------------

    Goal: Describe the real-world scenario you'll use to illustrate the product. Include 2-3 customer tasks that represent the most-common use cases for the product.

    Heading: "## Example scenario"

    Example: "Suppose you work at an athletic shoe company that is launching a new product. You sell the shoes on your website, manage your cloud-hosted advertising videos, and monitor social media to gauge reactions to the launch. The following illustration shows these processes. Notice how the tasks include both customer-facing processes like direct sales and administrative tasks like auto-archiving old videos. Here, you'll see how Logic Apps automates these types of business processes."

    Recommended: an image that visualizes the scenario

    [Scenario guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-scenarios)
 -->
## Example scenario
Suppose you are a data consumer or producer of data. You may be a business or technical data analyst, data scientist, or data engineer. You likely spend much time on manual processes to annotate, catalog, and find trusted data sources.

Because there's no central location to register data sources, users might be unaware of a data source unless they come into contact with it as part of another process.

Annotating data sources with descriptive metadata is often a lost effort. Client applications typically ignore descriptions that are stored in the data source. Creating documentation for data sources can be difficult and it's an ongoing responsibility to keep documentation in sync with data sources. Users might not trust documentation that's perceived as being out of date.

Azure Purview is designed to address these issues and to help enterprises get the most value from their existing information assets. The catalog makes data sources easily discoverable and understandable by the users who manage the data.

:::image type="content" source="../media/schema-tab.png" alt-text="Screenshot depicting the schema tab of a .csv file data source stored in Azure Blob storage. The tab displays column names, classifications such as IP address, credit card numbers, and person's name classifications for the data. Also included is the data type for each data column. ":::

<!-- 3. Prose table-of-contents --------------------------------------------------------------------------

    Goal: List the activities the learner will do. This differs from the learning objectives. The learning objectives are "outcome focused"; that is, they describe the skills the learner will acquire as a result of consuming this content. By contrast, here you should be specific about what the learning will **do** in order to acquire those skills. The format can be either prose or bulleted-list; however, a list will yield better results when transformed into other output types such as PowerPoint.

    Heading: "## What will we be doing?"

    Example: "We’ll analyze the capabilities of Logic Apps to help you decide when to use them:
                * **Launch**: what conditions can you set to launch your app?
                * **Connect**: which services can you connect to?
                * **Branch**: what types of business logic can you add to your app?"

 -->
## What will we be doing?
We'll get a high-level overview of Azure Purview and discover the key aspects that make it the tool of choice for mapping out your enterprise data. We'll learn how it can help you:
* Manage and govern your data across various platforms and locations.
* Map out your data landscape
* Classify sensitive data
* Empower customers fo find trustworthy data

<!-- 4. Terminal learning objective ----------------------------------------------------------------------

    Goal: The title of an "Introduction to (product)" module tells our customers that this is a good place to start their learning. This helps our customers find the right content quickly. The trade-off is that the title does not reflect the terminal learning objective of the module. Here, you explain that this module teaches the 'evaluate' task. To do this, you:
        - Start with your 'evaluate' learning objective
        - Make it a complete sentence if it's not already
        - Use plain language so it sounds conversational
        - Include the lead-in shown below ("By the end...")

    Heading: "## What is the main goal?"

    Example: "By the end of this session, you'll be able to decide whether Logic Apps is a good choice to automate your business processes."

 -->
## What is the main goal?
By the end of this session, you'll be able to decide if Azure Purview is the right choice to help you manage your enterprise data environment and get a handle on your various data sources.

<!-- Do **not** include any other content like learning objectives, prerequisites, unit summary, "next unit" lead-in, or references. -->