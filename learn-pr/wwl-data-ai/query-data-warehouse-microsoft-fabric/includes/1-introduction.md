Microsoft Fabric Data Warehouse is a complete platform for data, analytics, and AI (Artificial Intelligence). A data warehouse stores, organizes, and manages large volumes of structured and semi-structured data. 

The data warehouse in Microsoft Fabric offers a rich set of features that make it easier to manage and analyze data. It includes advanced query processing capabilities and supports the full transactional T-SQL capabilities of an enterprise data warehouse.

The process of querying a data warehouse is a key component of business intelligence. It involves extracting and analyzing data stored in a data warehouse, allowing users to uncover valuable insights from large volumes of data.

## Star schema design

In a typical data warehouse, the data is organized using a schema, often a [star schema](/power-bi/guidance/star-schema?azure-portal=true) or a [snowflake schema](/power-bi/guidance/star-schema#snowflake-dimensions?azure-portal=true). The star schema and snowflake schema are mature modeling approaches widely adopted by relational data warehouses. These approaches require you to classify tables as either dimension or fact.

Fact tables store the measurable, quantitative data about a business, while dimension tables contain descriptive attributes related to fact data.

:::image type="content" border="false" source="../media/1-star-schema.svg" alt-text="Diagram of a star schema for sales facts with a central fact table and five dimension tables forming the points of the star.":::

In the diagram, a central **Sales** fact table stores the measurable data — quantities sold, revenue, and other numeric values. The five surrounding dimension tables answer the key questions about each sale: **Customer** (who), **Product** (what), **Store** (where), **Date** (when), and **Currency** (how much). Without the dimension tables, the fact table numbers have no context.

We'll explore different ways to connect and query a data warehouse, and how they can help you effectively extract insights from your data.
