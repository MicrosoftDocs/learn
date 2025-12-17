When you build data pipelines in Azure Databricks, you have two primary approaches: **notebooks** with procedural code and **Lakeflow Declarative Pipelines**. Each approach serves different needs, and understanding when to use each helps you deliver maintainable, efficient data solutions.

## Understand the two approaches

Notebooks execute code **step by step**. You control every aspect of data processing—from reading sources to writing outputs. This **procedural approach** gives you full control over execution flow, error handling, and optimization decisions.

Lakeflow Declarative Pipelines work differently. Instead of specifying **how** to process data, you define **what** you want as the end result. You declare your **streaming tables** and **materialized views**, and the pipeline engine handles **orchestration**, **parallelization**, and **error recovery** automatically.

:::image type="content" source="../media/3-understand-notebook-pipeline-approach.png" alt-text="Diagram explaining the two approaches when it comes to choosing notebooks or Lakeflow Declarative Pipelines." border="false" lightbox="../media/3-understand-notebook-pipeline-approach.png":::

Consider a scenario where you need to ingest sales data, join it with product information, and calculate regional aggregates. With a notebook, you write explicit read, join, and aggregation commands in sequence. With Lakeflow Declarative Pipelines, you define the final tables and their relationships—the system determines the most efficient execution plan.

## When notebooks fit best

Notebooks excel in scenarios requiring **flexibility** and **detailed control**. Choose notebooks when your pipeline involves:

**Complex business logic** that's difficult to express declaratively. Some transformations require **conditional branching**, **loops over external APIs**, or **custom retry logic** that doesn't fit a declarative model.

**Rapid prototyping and exploration**. When you're still discovering the data structure or testing transformation approaches, notebooks let you **iterate cell by cell**, inspect intermediate results, and adjust your logic interactively.

**External library dependencies**. If you need specialized machine learning libraries, custom connectors, or legacy code integration, notebooks provide the flexibility to install and use any **Python** or **Scala** package.

**Fine-grained performance tuning**. When you need to manually control **partitioning**, **caching strategies**, or specific **Spark configurations**, notebooks give you direct access to these optimizations.

## When Lakeflow Declarative Pipelines fit best

Lakeflow Declarative Pipelines simplify **production data pipelines** by handling operational complexity automatically. Choose this approach when your pipeline needs:

**Standardized ETL patterns**. For common ingestion and transformation workflows—reading from cloud storage, applying **schema evolution**, maintaining **slowly changing dimensions**—the declarative approach reduces thousands of lines of code to a few statements.

**Built-in data quality enforcement**. Declarative pipelines include **expectations** that validate data as it flows through. You define **quality rules** directly in your pipeline definition, and the system tracks violations and can halt processing when data quality degrades.

**Automatic dependency management**. The pipeline engine analyzes relationships between your tables and determines the correct **execution order**. When source data updates, the engine refreshes only the **affected downstream tables**.

**Operational visibility**. Lakeflow Declarative Pipelines provide **lineage tracking**, **execution graphs**, and **monitoring dashboards** without additional configuration. Operations teams can trace data from source to target and troubleshoot issues faster.

## Compare the approaches

Understanding the key differences helps you match the right tool to your requirements:

| Criteria | Notebook | Lakeflow Declarative Pipeline |
|----------|----------|-------------------------------|
| Control level | Full control over execution | System manages execution |
| Code complexity | Can be verbose for standard patterns | Concise for common ETL |
| Error handling | Custom implementation required | Built-in retry logic |
| Data quality | Manual validation code | Declarative expectations |
| Lineage tracking | Requires external tooling | Automatic |
| Team skillset | Coding required | SQL-friendly, lower barrier |
| Best for | Custom logic, prototyping | Production, repeatable pipelines |

## Make your decision

Start by evaluating your specific requirements. Ask these questions:

- Does the transformation require **procedural logic** that's hard to express declaratively?
- Is this a **one-time analysis** or a **recurring production workload**?
- What level of **operational monitoring** does your team need?
- Who maintains this pipeline—**seasoned developers** or a broader team with varied skills?

For production pipelines with standard ingestion and transformation patterns, Lakeflow Declarative Pipelines **reduce operational burden** and **improve maintainability**. You spend less time writing orchestration code and more time defining business logic.

For exploratory work, complex integrations, or pipelines requiring extensive customization, notebooks provide the **flexibility** you need. You can always refactor successful notebook prototypes into declarative pipelines once the logic stabilizes.

Many teams use **both approaches together**. Notebooks handle custom preprocessing or machine learning model training, while Lakeflow Declarative Pipelines manage the core ETL workflow. This **hybrid approach** lets you use each tool where it performs best.
