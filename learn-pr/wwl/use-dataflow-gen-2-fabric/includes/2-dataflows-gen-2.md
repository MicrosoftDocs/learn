---
ms.custom:
  - build-2023
---
In our scenario, you need to develop a data model that can standardize the data and provide access to the business. By using Dataflows (Gen2), you can connect to the various data sources, and then prep and transform the data. To allow access, you can land the data directly into your Lakehouse or use a data pipeline for other destinations.

## What is a dataflow?

*Dataflows* are a type of cloud-based ETL (*Extract, Transform, Load*) tool for building and executing scalable data transformation processes.

Dataflows (Gen2) allow you to extract data from various sources, transform it using a wide range of transformation operations, and load it into a destination. Using Power Query Online also allows for a visual interface to perform these tasks.

Fundamentally, a dataflow includes all of the transformations to reduce data prep time and then can be loaded into a new table, included in a Data Pipeline, or used as a data source by data analysts.

## How to use Dataflows (Gen2)

Traditionally, data engineers spend significant time extracting, transforming, and loading data into a consumable format for downstream analytics. The goal of Dataflows (Gen2) is to provide an easy, reusable way to perform ETL tasks using Power Query Online.

If you only choose to use a Data Pipeline, you copy data, then use your preferred coding language to extract, transform, and load the data. Alternatively, you can create a Dataflow (Gen2) first to extract and transform the data. You can also load the data into a Lakehouse, and other destinations. Now the business can easily consume the curated data model.

Adding a data destination to your dataflow is optional, and the dataflow preserves all transformation steps. To perform other tasks or load data to a different destination after transformation, create a Data Pipeline and add the Dataflow (Gen2) activity to your orchestration.

Another option might be to use a Data Pipeline and Dataflow (Gen2) for ELT *(Extract, Load, Transform)* process. For this order, you'd use a Pipeline to extract and load the data into your preferred destination, such as the Lakehouse. Then you'd create a Dataflow (Gen2) to connect to Lakehouse data to cleanse and transform data. In this case, you'd offer the Dataflow as a curated dataset for data analysts to develop reports.

Dataflows can be horizontally partitioned as well. Once you create a global dataflow, data analysts can use dataflows to create specialized datasets for specific needs.

Dataflows allow you to promote reusable ETL logic that prevents the need to create more connections to your data source. Dataflows offer a wide variety of transformations, and can be run manually, on a refresh schedule, or as part of a Data Pipeline orchestration.

## Benefits and limitations

There's more than one way to ETL or ELT data in Microsoft Fabric. Consider the benefits and limitations for using Dataflows (Gen2).

Benefits:

- Extend data with consistent data, such as a standard date dimension table.
- Allow self-service users access to a subset of data warehouse separately.
- Optimize performance with dataflows, which enable extracting data once for reuse, reducing data refresh time for slower sources.
- Simplify data source complexity by only exposing dataflows to larger analyst groups.
- Ensure consistency and quality of data by enabling users to clean and transform data before loading it to a destination.
- Simplify data integration by providing a low-code interface that ingests data from various sources.

Limitations:

- Not a replacement for a data warehouse.
- Row-level security isn't supported.
- Fabric capacity workspace is required.
