This module covers various units that provide an overview of some of the data orchestration and data movement technologies within Microsoft Fabric. It provides an overview of the scheduling and event-based triggering capabilities, which can help data engineers design pro-active systems to support the rapidly changing data needs of business.

## Pipelines in Microsoft Fabric

Data Factory provides a modern data integration experience to ingest, prepare, and transform data from various sources like databases, data warehouses, Lakehouse, and real-time data. It supports both citizen and professional developers with intelligent transformations and a rich set of activities. Users can create pipelines to execute multiple activities, access data sources through linked services, and add triggers to automate processes. Data Factory in Microsoft Fabric introduces Fast Copy capabilities for rapid data movement between data stores, enabling efficient data transfer to Lakehouse and Data Warehouse for analytics.

## Notebooks in Microsoft Fabric

Notebooks in Microsoft Fabric offer a versatile environment for data exploration, transformation, and analysis. They support various programming languages, including Python, KQL, and SQL, and provide an interactive interface for running code, visualizing data, and documenting workflows. Key features include:

- Microsoft Fabric notebooks provide an **interactive, browser-based environment** where you can write and run code without needing local setup. They allow you to combine code, text written in Markdown, and visual outputs in a single place, making them useful for both exploration and documentation.

- Notebooks support **multiple languages**, including PySpark, Python, Scala, Spark SQL, and SparkR, and you can even switch between languages from one cell to another. For working with data, the built-in display() function makes it easy to turn DataFrames or query results into **interactive tables and simple charts**, with options to filter and inspect rows and columns directly in the notebook.

- In terms of execution, notebooks can be run **interactively** while you work, **scheduled** to run automatically, or embedded in a pipeline. The way they run depends on the context—sometimes under your own account, other times under a pipeline or scheduler—which controls the level of access.

- Finally, **environments** in Fabric make it possible to manage dependencies consistently. Shared environments and reusable configurations help teams standardize their work and avoid repeating setup across multiple notebooks.

## Schedules and Triggers in Microsoft Fabric

Scheduling pipelines includes three standard types of scheduling, including time-based, event-based, and custom scheduling. Scheduling in Microsoft Fabric also allows for seamless integration with other services, which allow for more dynamic event-driven pipelines.

The articles covered in this module include:

- Understanding pipelines in Microsoft Fabric.
- Understanding notebooks in Microsoft Fabric.
- Event-based triggers and scheduling in Microsoft Fabric.
- practice some dynamic features of Microsoft Fabric notebooks

Students learn how Data Factory in Microsoft Fabric is used for modern data integration, including ingesting, preparing, and transforming data from various sources. They understand how to create pipelines, automate processes with triggers, and utilize Fast Copy for rapid data movement to Lakehouse and Data Warehouse. Additionally, they explore Notebooks in Microsoft Fabric for interactive data exploration, multi-language support, data visualization, and collaboration. The training provides an overview of integration with other Microsoft Fabric services, event-based triggers, scheduling, and dynamic features of notebooks, providing an understanding of data workflows within Microsoft Fabric.
