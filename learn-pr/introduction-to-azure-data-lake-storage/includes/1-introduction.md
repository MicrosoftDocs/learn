Modern organizations are data-generating machines that gather and produce massive amounts of data. This data comes in diverse formats such as:

- Structured databases such as PDF files and other documents
- Images and other media
- Device data
- Web server logs
- JavaScript Object Notation (JSON) files

How do you integrate these data types in a way that lets your company use and analyze all that data? You can use Azure Data Lake Storage to store a wide variety of data types in a single location. With all your data in one place, services such as Azure HDInsight and Azure Data Lake Analytics can work directly with Azure Data Lake Storage <!--Paul, this next bit is a bit marketing-like. Could we cut that part out to say "...can work directly with Azure Data Lake Storage to process, analyze, and visualize that data."? -->to give you powerful, cost-effective, and secure tools to process, analyze, and visualize that data.

:::image type="content" source="../media/1-introduction-topic.png" alt-text="Network diagram of a hub virtual network, several spoke virtual networks, and an on-premises network, with all traffic to and from the internet passing through an Azure Firewall instance in the hub network.":::

## Example scenario

Suppose you work for an organization with many different departments, each of which generates large amounts of data in diverse formats:

- Your Internet of Things (IoT) department has deployed thousands of sensors that generate a continuous stream of raw data.
- Your web services team operates dozens of web servers that each generate huge amounts of server log data.
- Your business units create a constant stream of spreadsheets, presentations, PDF files, and other documents.
- Your developers maintain a large number of HTML, CSS, JavaScript, JSON, and other programming files.
- Your marketing team creates many videos, images, and other media.
- Your IT department stores a huge amount of structured business data in relational database systems such as Microsoft SQL Server.

In the past, these business units would maintain separate stores of data, resulting in data *silos* that can't be used or analyzed together. However, with Azure Data Lake Storage, you eliminate data silos by bringing these disparate data stores into a single location where they can be combined and analyzed.

## What will we be doing?

In this module, you'll learn the fundamentals of Azure Data Lake Storage and be able to describe its main features. You'll also learn how Azure Data Lake Storage ingests, stores, and processes data. Finally, you'll determine when you should use Azure Data Lake Storage.

## What is the main goal?

By the end of this session, you'll be able to evaluate whether Azure Data Lake Storage is the correct solution for bringing together your organization's separate data stores. You'll also be able to describe how Azure Data Lake Storage provides a scalable, fast, more secure, and cost-effective way to store any type of data your organization generates.
