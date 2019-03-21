Let's examine three use cases for using an Azure Data Lake Store.

## Creating a Modern Data Warehouse

Imagine you are a Data Engineering consultant for Contoso. In the past, they've created an on-premises business intelligence solution that used a Microsoft SQL Server Database Engine, Integration Services, Analysis Services, and Reporting Services to provide historical reports. An attempt was made to use the Analysis Services Data Mining component to create a predictive analytics solution to predict the buying behavior of customers. While this approach worked well with low volumes of data, it couldn't scale after more than a gigabyte of data was collected. Furthermore, they were never able to deal with the JSON data that a third-party application generated when a customer used the feedback module of the POS application. 

Contoso has turned to you for help with creating an architecture that can scale with the data needs that is required to create a predictive model and to handle the JSON data so that it's integrated into the BI solution. You suggest the following architecture:

![Screenshot of a Modern Data Warehouse architecture.](../media/6-modern-data-warehouse.jpg)

The following architecture sees Azure Data Lake Storage at the heart of the solution for a modern data warehouse. Integration Services is replaced by Azure Data Factory to ingest data into the Data Lake from a business application. This serves as the source of truth for the predictive model built in Azure Databricks, and PolyBase is used to transfer the historical data into a big data relational format held in SQL Data Warehouse. This in turn also stores the results of the trained model from Databricks. Analysis Services provides the caching capability for Azure SQL Data warehouse to service many users and present the data through reports using Power BI.

## Advanced analytics for Big Data

In this second use case, Azure Data Lake Storage again plays an important role in providing a large-scale data store. In this case, your skills are needed by AdventureWorks, a global seller of bicycles and cycling components through a chain of resellers and on the Internet. They have a requirement to ensure the results of a recommendation engine built in Azure Databricks can scale globally to meet the needs of recommending products to customers on their websites as they browse the product catalog and add items to their basket. The basis of performing the recommendation is on the web log files that are stored on the web servers and transferred to the Azure Databricks model on an hourly basis. The response time for the recommendation should be less than 1 ms. You propose the following architecture: 

![Screenshot of an Advanced Analytics with Big Data architecture.](../media/6-advanced-analytics.jpg)

In this solution, Azure Data factory is transferring terabytes of web logs from a web server to the Data Lake on an hourly basis. This data is provided as features to the predictive model in Azure Databricks, which is then trained and scored. The result of the model is then distributed globally using Azure Cosmos DB, that the real-time app – in this case the Adventure work website – will use to provide recommendations to the customers as they add products to their online basket.

To complete this architecture, PolyBase is used against the Data Lake to transfer descriptive data to the Azure SQL Data Warehouse for reporting purposes. This data is presented to Analysis Services to provide the caching capability for Azure SQL Data warehouse to service many users and display the data through reports using Power BI.

## Real-time analytical solutions

To perform real-time analytical solutions, the major change that occurs to the architecture is to the ingestion phase for processing big data solutions. In this example architecture, you will note the introduction of Apache Kafka for HDInsight to ingest streaming data from an Internet of Things (IoT) device, although this could be replaced with IoT Hubs and Stream Analytics. The key point is that the data is persisted in Data Lake Storage to service other parts of the solution.

In this use case, you are a Data Engineer for Trey Research, an organization that is working with a transport company to monitor the fleet of Heavy Goods Vehicles (HGV) that drive around Europe. Each HGV is equipped with sensor hardware that will continuously report metric data on the temperature, the speed, and the oil and brake solution levels of an HGV. When the engine is turned off, the sensor also outputs a file with summary information about a trip, including the mileage and elevation of a trip. A trip is a period in which the HGV engine is turned on and off.

Both the real-time data and batch data is processed in a machine learning model to predict maintenance schedule for each of the HGVs, and this data is made available to the downstream application that third-party Garage companies can use should an HGV breakdown anywhere in Europe. In addition, historical reports about the HGV should be visually presented to users. As a result, the following architecture is proposed:

![Screenshots of processing data](../media/6-real-time-analytics.jpg)

In this architecture, there are two ingestion streams. Azure Data Factory is used to ingest the summary files that are generated when the HGV engine is turned off. Apache Kafka provides the real-time ingestion engine for the telemetry data. Both data streams are stored in Data Lake store for use in the future, but they are also passed onto other technologies to meet the business needs. Both streaming and batch data are provided to the predictive model in Azure Databricks, of which the results are published to Azure Cosmos DB to be used by the third-party garages. PolyBase transfers data from the Data Lake Store into SQL Data Warehouse for the HGV reports created through Power BI through Azure Analysis Services.