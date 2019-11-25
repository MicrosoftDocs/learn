You've decided to look at how the new project is going store the catalog for your customer facing e-commerce site. The sales team is likely to need support for adding new product categories quickly. The team had issues in the past as the old system that was using a relational database was too structured. Any necessary changes to add properties to products required downtime to update the table schemas, queries, and databases.

A flat, denormalized table was being used, which also lead to many columns being empty. The database needs to store products in a way that will enable filtering data based on the category where the products are located.

For example:
- A clothing product needs to be searchable by sex, size, color, and style.
- A TV needs to be searchable on LCD or OLED, screen resolution, screen ratio, and HDR support.
- A DVD needs to have a region, the languages supported, and any extras.

## Problem analysis

The sales team's primary requirement is to support semi-structured data. The schema needs to be flexible in order to store an ever-increasing number of product categories. The system needs to support searching and sorting across many different properties. There is a structured relational database that can be used to import data.

## Recommended API: Core (SQL)

The existing app uses a traditional relational database, which means that none of the other APIs are currently being used. However, Core (SQL) won't allow for any code reuse, but your team should quickly get up-to-speed with the SQL-like query language that is supported by Core (SQL).

Supporting new product categories is an important requirement for your project, and the Core (SQL) schema is flexible and requires a schemaless data store. As a result of this architecture, bringing a new product category online is as simple as adding a document for the new product. Changes to the schema or taking the database offline are not required.

## Why not any of the other APIs?

Using the decision matrix from the previous unit, you can see why the other APIs are not a good solution for this scenario:

| API | Description |
|---|---|
| **Azure Table** | This API should only be used to allow existing apps that are based on the Table API access to Azure Cosmos DB. However, new projects should always choose Core (SQL). |
| **Cassandra** | This API isn't a good choice in this particular scenario, because the schema is unknown and will change over time. |
| **Gremlin** | This API isn't a good choice since the scenario  doesn't need to process graph-based data. |
| **MongoDB** | MongoDB's lack of support for SQL-like queries give Core (SQL) an advantage for your existing relational database users. |
