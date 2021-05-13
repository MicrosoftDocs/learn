Although you have the opportunity to ingest data at the source directly into a data warehouse, it is more typical to store the source data within a staging area, which is also referred to as a landing zone. This typically is a neutral storage area that sits between the source systems and the data warehouse. The main reason for adding a staging area into the architecture of a modern data warehouse is for any one of the following reasons:

## To reduce contention on source systems

Source systems typically play an important role in fulfilling business operations that either bring in revenue to an organization, or provides a function that is mission critical to the business. As a result, ingesting data from these systems must minimize the resource usage against the source system so it does not disrupt it. As a result, some data warehouse design strategies will involve grabbing data at a source, and “dumping” the data into a staging area.

This approach involves no transformation or cleansing. It simply grabs the data, so it minimizes the contention on the source system. This may also involve having the source system output data into text files, that are then collected by your Extract, Transform and Load (ETL) process.

## Enables you to deal with the ingestion of source systems on different schedules.

Staging environments provide a great place to store data from different source systems regardless of the schedule on which the data is ingested. For example, you may grab data from some source systems in the early evening because this is the time when they are at their quietest, and then it may not be until the early hours of the morning until you can grab data from other system as they have backup process running on them first before you are able to ingest the data. Having a staging area enables you to handle these different schedules 

## To join data together from different source systems

A staging environment provides the opportunity to bring together a single view of data from different source systems. As the staging area is independent from the source systems and the data warehouse, you have the freedom to perform any work you need without impacting these systems. 

You can even create additional tables that can aid the process of joining data together from different source systems, referred to as mapping tables. In this scenario, imagine that you have a customer’s table in one source system, that has a column named FirstName. In a second source system, perhaps running an AS400 system, you have customer’s table that has a column named FIRNAM that also represents the first name of the customer too.

You can create a separate table that contains metadata that maps the data in a column from one source system, with another column from another source system that represent the same business entity. In this case firstname.

## To rerun failed data warehouse loads from a staging area

Not all data warehouse loads will complete successfully, so your data warehouse has to be able to handle scenarios where a rerun of the ETL process may have to occur during core business hours, and needs to occur without disrupting the source systems again. By holding onto the staging data, you are able to rerun the ETL process from the staging area, rather than the source system. 

In a modern data warehouse architecture, the source data can be so varied. The variety and volume of data that is generated and analyzed today is increasing. Companies have multiple sources of data, from websites to Point of Sale (POS) systems, and more recently from social media sites to Internet of Things (IoT) devices. Each source provides an essential aspect of data that needs to be collected, analyzed, and potentially acted upon.

Based on this, Azure Data Lake Gen 2 is the ideal storage solution for hosting staging data as it contains a set of capabilities dedicated to big data analytics known as a data lake. A data lake is a repository of data that is stored in its natural format, usually as blobs or files. Azure Data Lake Storage is a comprehensive, scalable, and cost-effective data lake solution for big data analytics built into Azure.

> [!VIDEO https://channel9.msdn.com/Shows/Learn-Azure/Understanding-Azure-Data-Lake-Storage-Gen-2/player?format=ny]

Azure Data Lake Storage combines a file system with a storage platform to help you quickly identify insights into your data. Data Lake Storage Gen2 builds on Azure Blob storage capabilities to optimize it specifically for analytics workloads. This integration enables analytics performance, the tiering and data lifecycle management capabilities of Blob storage, and the high-availability, security, and durability capabilities of Azure Storage.
