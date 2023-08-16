Now that you have a solid understanding of the medallion architecture, let's explore how to put it into action within Fabric.

## Move data across layers in Fabric

Moving data across medallion layers refines, organizes, and prepares it for downstream data activities. Within Fabric's lakehouse, there is more than one way to move data between layers, ensuring that you can choose the method that works for your team.

There are a few things to consider when deciding how to move and transform data across layers.

- How much data are you working with?
- How complex are the transformations you need to make?
- How often will you need to move data between layers?
- What tools are you most comfortable with?

Understanding the difference between data transformation and data orchestration will help you select the right tools for the job within Fabric.

*Data transformation* involves altering the structure or content of data to meet specific requirements. Tools for data transformation in Fabric include Dataflows (Gen2) and notebooks. Dataflows are a great option for smaller datasets and simple transformations. Notebooks are a better option for larger datasets and more complex transformations. Notebooks also allow you to save your transformed data as a managed Delta table in the lakehouse, ready for reporting. <!-- can you load data to a delta table from a dataflow?-->

*Data orchestration* refers to the coordination and management of multiple data-related processes, ensuring they work together to achieve a desired outcome. The primary tool for data orchestration in Fabric is *pipelines*. A pipeline is a series of steps that move data from one place to another, in this case, from one layer of the medallion architecture to the next. Pipelines can be automated to run on a schedule or triggered by an event.

## Design a medallion architecture in Fabric

<!--Steps - make sure this is conceptual and doesn't look like a tutorial. Also need to add screenshots/diagrams -->

- **Set up the foundation**: [Create your Fabric lakehouse](/fabric/onelake/create-lakehouse-onelake)
  - You can use the same lakehouse for multiple medallion architectures, or alternatively, you can use different lakehouses and even different lakehouses in different workspaces, depending on your use case. We'll dive more into this in unit 5.
- **Design your architecture**: Create your architecture layout, define your layers, and determine how data will flow between them.
  - The most straightforward implementation is to use Bronze as the raw layer, Silver as the curated layer, and gold as the presentation layer. Your gold layer should be modeled in a star schema and optimized for reporting.
- **Ingest data into Bronze**: Determine how you'll ingest data into your Bronze layer. You can do this using pipelines, dataflows, or notebooks.
- **Transform data and load to Silver**: Determine how you'll transform data in your Silver layer. You can do this using dataflows or notebooks.
  - Transformations at the silver level should be focused on data quality and consistency, not on data modeling.
- **Generate a gold layer**: Determine how you'll generate your gold layer(s), what it will contain, and how it will be used.
  - The gold layer is where you'll model your data for reporting using a dimensional model. Here you'll establish relationships, define measures, and incorporate any other elements essential for effective reporting.
  - You can have multiple gold layers for different audiences or domains. For example, you might have a gold layer for your finance team and a separate gold layer for your sales team. You might also have a gold layer for your data scientists that is optimized for machine learning.
  - Depending on your needs, you might also use a Data Warehouse as your gold layer.
  - In Fabric, you can transform your data using dataflows or notebooks, and then load it into a Delta table in the lakehouse. You can then connect to the Delta table using a SQL endpoint and use SQL to model your data for reporting. Alternatively, you can use Power BI to connect to the SQL endpoint and model your data for reporting.
- **Enable downstream consumption**: Determine how you'll enable downstream consumption of your data.
  - You can do this using workspace or item permissions, or by connecting to the SQL endpoint.