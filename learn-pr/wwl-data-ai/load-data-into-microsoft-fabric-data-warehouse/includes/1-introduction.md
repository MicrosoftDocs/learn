[Microsoft Fabric Data Warehouse](/fabric/data-warehouse/?azure-portal=true) is a complete platform for data, analytics, and AI (Artificial Intelligence). It refers to the process of storing, organizing, and managing large volumes of structured and semi-structured data. 

Data warehouse in Microsoft Fabric is powered up with Synapse Analytics by offering a rich set of features that make it easier to manage and analyze data. It includes advanced query processing capabilities, and supports the full transactional T-SQL capabilities like an enterprise data warehouse.

Unlike a dedicated SQL pool in Synapse Analytics, a warehouse in Microsoft Fabric is centered around a single data lake. The data in the Microsoft Fabric warehouse is stored in the Parquet file format. This setup allows users to focus on tasks such as data preparation, analysis, and reporting. It takes advantage of the SQL engine’s extensive capabilities, where a unique copy of their data is stored in [Microsoft OneLake](/fabric/onelake/onelake-overview?azure-portal=true).

:::image type="content" source="../media/1-access-onelake-data-other-tools.png" alt-text="Diagram showing the function and structure of OneLake." lightbox="../media/1-access-onelake-data-other-tools.png":::

## Understand the ETL (Extract, Transform and Load) process

ETL provides the foundation for data analytics and data warehouse workstreams. Let's review some aspects of data manipulation in an ETL process.

|  | Description |
|-------|-------------|
| **Data extraction** | It involves connecting to the source system and collecting necessary data for analytical processing. |
| **Data transformation** | It involves a series of steps performed on the extracted data to convert it into a standard format. Combining data from different tables, cleaning data, deduplicating data and performing data validations.|
| **Data loading** | The extracted and transformed data are loaded into the fact and dimension tables. For an incremental load, this involves periodically applying ongoing changes as per requirement. This process often involves reformatting the data to ensure its quality and compatibility with the data warehouse schema.|
| **Post-load optimizations** | Once the data is loaded, certain optimizations can be performed to enhance the performance of the data warehouse. |

All these steps in the ETL process can run in parallel depending on the scenario. As soon as some data is ready, it's loaded without waiting for the previous steps to be completed.

In the next units, we'll explore various ways of loading data in a warehouse, and how they can facilitate the tasks of building a data warehouse workload.