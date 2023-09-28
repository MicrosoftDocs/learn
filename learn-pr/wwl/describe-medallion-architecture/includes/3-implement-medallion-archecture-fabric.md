Now that you have a solid understanding of the medallion architecture, let's explore how to put it into action within Fabric.

- **Set up the foundation**: [Create your Fabric lakehouse](/fabric/onelake/create-lakehouse-onelake). You can use the same lakehouse for multiple medallion architectures, or alternatively, you can use different lakehouses and even different lakehouses in different workspaces, depending on your use case. We'll dive more into this in unit 5.
- **Design your architecture**: Create your architecture layout, define your layers, and determine how data will flow between them. The most straightforward implementation is to use Bronze as the raw layer, Silver as the curated layer, and gold as the presentation layer. Your gold layer should be modeled in a star schema and optimized for reporting.

    |  Question  | Bronze | Silver | Gold |
    | --- | --- | --- | --- |
    | What happens in that layer? | Ingest raw data | Cleanse and validate data | Additional transformations and modeling |
    | What tool is used? | Pipelines, dataflows, notebooks | Dataflows or notebooks | SQL Endpoint or dataset |

- **Ingest data into bronze**: Determine how you'll ingest data into your bronze layer. You can do this using pipelines, dataflows, or notebooks.
- **Transform data and load to silver**: Determine how you'll transform data in your silver layer. You can do this using dataflows or notebooks. Transformations at the silver level should be focused on data quality and consistency, not on data modeling.
- **Generate a gold layer**: Determine how you'll generate your gold layer(s), what it will contain, and how it will be used.
  - The gold layer is where you'll model your data for reporting using a dimensional model. Here you'll establish relationships, define measures, and incorporate any other elements essential for effective reporting.
  - You can have multiple gold layers for different audiences or domains. For example, you might have a gold layer for your finance team and a separate gold layer for your sales team. You might also have a gold layer for your data scientists that is optimized for machine learning.
  - Depending on your needs, you might also use a Data Warehouse as your gold layer. See [Get started with data warehouses in Microsoft Fabric](/training/modules/get-started-data-warehouse/) to learn more.
  - In Fabric, you can transform your data using dataflows or notebooks, and then load it into a gold Delta table in the lakehouse. You can then connect to the Delta table using a SQL endpoint and use SQL to model your data for reporting. Alternatively, you can use Power BI to connect to the SQL endpoint of the gold layer and model your data for reporting.
- **Enable downstream consumption**: Determine how you'll enable downstream consumption of your data. You can do this using workspace or item permissions, or by connecting to the SQL endpoint.