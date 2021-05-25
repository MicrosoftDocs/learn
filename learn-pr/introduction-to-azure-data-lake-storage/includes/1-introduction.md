Modern organizations are data-generating machines. They gather and produce massive amounts of information in diverse formats such as structured databases, documents, media files, server logs, JSON files, and raw device data<!-- When we have three or more items, that's usually an indicator we need to turn it into a bulleted list. We have 6 here, but I don't think a bulleted list this early would be good. Could you pick three format types and delete the rest? By using the term "such as," it denotes we aren't listing them all anyway. Also, Acrolinx doesn't like this sentence either - it asks us to possibly split it into two.-->. How do you integrate these data types in a way that lets your company use and analyze all that data? You can use the Microsoft Azure cloud services platform <!-- Please verify my addition here is correct. I added this because first mention of Azure should have "Microsoft" appended to it. -->Azure Data Lake Storage. Azure Data Lake Storage is designed to store a wide variety of data types in a single location. With all your data in one place, services such as Azure HDInsight, Azure Synapse Analytics, and Azure Databricks can work directly with Azure Data Lake Storage to process, analyze, and visualize that data<!-- Acrolinx asks us to split this sentence up as well, FWIW. -->.

## Example scenario

Suppose you work for a national package delivery service. Your organization has many different departments, each of which generates large amounts of data in diverse formats:

- Your delivery trucks generate a continuous stream of data from Internet of Things (IoT) sensors for engine diagnostics.
- Truck dash cams send continuous video feeds to monitor driver performance.
- Your web services team operates dozens of web servers that each generate huge amounts of server log data.
- Your business units create a constant stream of spreadsheets, presentations, PDF files, and other documents.
- Your developers maintain several HTML, CSS, JavaScript, JSON, and other programming files.
- Your marketing team creates many videos, images, and other media.
- Your IT department stores large amounts of structured business data in relational database systems such as Microsoft SQL Server.

In the past, these business units would maintain separate stores of data<!-- "separate data stores?" -->, resulting in data *silos* that can't be used or analyzed together.

:::image type="content" source="../media/1-introduction-before.png" alt-text="A variety of data types are stored in separate locations and can't connect with each other. This creates data silos.":::

However, with Azure Data Lake Storage, you eliminate data silos by bringing these disparate data stores into a single location. From here, they can be combined and analyzed.

:::image type="content" source="../media/1-introduction-after.png" alt-text="Different data types are ingested into Azure Data Lake Storage. It then passes the data to several Azure analytics services.":::

## What will we be doing?

In this module, you'll learn the fundamentals of Azure Data Lake Storage and be able to describe its main features. You’ll analyze the follow Azure Data Lake Storage capabilities to help you decide when to use them:

- **Ingest**: What methods can you use to bring data into Azure Data Lake Storage?
- **Access**: How do you access stored data and control who can view the data?
- **Analyze**: How does Azure Data Lake Storage help you run analytics workloads on stored and real-time data?"

## What is the main goal?

By the end of this session, you'll be able to evaluate whether Azure Data Lake Storage is the correct solution for bringing together your organization's separate data stores.
