**Data pipelines** move data from source systems through multiple processing stages before delivering it to consumers. Understanding the **order of operations** helps you design pipelines that are reliable, maintainable, and aligned with business requirements. Each stage in the pipeline serves a specific purpose, and the sequence you choose affects **data quality**, **processing efficiency**, and how quickly insights reach your users.

When you design a data pipeline in Azure Databricks, you typically follow a pattern that mirrors the **medallion architecture**: raw data flows through progressively refined layers until it's ready for consumption. This approach ensures that each stage builds on validated, well-structured data from the previous stage.

:::image type="content" source="../media/2-design-order-operations-pipeline.png" alt-text="Diagram explaining the different stages of a medallion architecture." border="false" lightbox="../media/2-design-order-operations-pipeline.png":::

## Ingest data from source systems

**Data ingestion** is the entry point of your pipeline. At this stage, you focus on capturing data from source systems and preserving it in its original form. The goal is **reliability** and **completeness**—you want to ensure that no data is lost during the transfer.

During ingestion, consider the following factors:

- **Source characteristics**: Different sources require different approaches. **Streaming sources** like message queues deliver data continuously, while **batch sources** like databases or file systems provide data at scheduled intervals.

- **Data preservation**: Store ingested data with minimal transformation. Keeping the **raw state** enables you to reprocess data if downstream requirements change.

- **Incremental processing**: Configure ingestion to process only new or changed data, reducing processing time and compute costs.

This stage corresponds to the **bronze layer** in the medallion architecture. Data engineers typically implement ingestion logic that runs on a schedule or triggers when new data arrives.

## Clean and validate data

After ingestion, data enters the **cleaning and validation** stage. You transform raw data into a validated, consistent format that downstream processes can rely on. This stage is critical because **data quality issues** caught early prevent problems from propagating through the rest of your pipeline.

Cleaning operations typically include:

- **Schema enforcement**: Apply consistent data types and structures to ensure data conforms to expected formats.

- **Null and missing value handling**: Define rules for how your pipeline treats incomplete records—whether to fill defaults, drop records, or flag for review.

- **Deduplication**: Identify and remove duplicate records that might have entered through multiple ingestion paths or retry mechanisms.

- **Data quality checks**: Apply validation rules that verify business constraints, such as ensuring dates fall within valid ranges or required fields contain appropriate values.

This stage maps to the **silver layer**. By separating cleaning from ingestion, you maintain the raw data for **auditing** while providing a reliable foundation for transformation.

## Transform data for consumption

**Transformation** shapes your validated data into structures that serve specific business needs. At this stage, you apply **business logic**, combine data from multiple sources, and create the datasets that analysts, data scientists, and applications use.

Common transformation patterns include:

- **Joining datasets**: Combine data from different sources to create unified views. For example, joining customer records with transaction data to create a complete customer activity dataset.

- **Aggregation**: Summarize data at different levels of granularity, such as calculating daily totals, monthly averages, or regional summaries.

- **Denormalization**: Flatten hierarchical or normalized data structures to optimize **query performance** for analytics workloads.

- **Business logic application**: Implement calculations, categorizations, and derived metrics that align with how your organization measures and reports on data.

Transformation logic should be **clear and testable**. When business requirements change, well-structured transformations are easier to modify without disrupting other parts of the pipeline.

## Load data to target destinations

**Loading** represents the handoff from data engineering to data consumption. At this stage, you write processed data to tables, views, or external systems where consumers access it.

Key considerations for the load stage include:

- **Table design**: Structure tables to support common query patterns. Consider **partitioning strategies** that align with how users filter data.

- **Write patterns**: Choose between **full refresh**, **incremental append**, or **merge operations** based on data volumes and freshness requirements.

- **Schema evolution**: Plan for how your tables handle changes to data structure over time without breaking dependent workloads.

Data loaded at this stage often corresponds to the **gold layer**—highly curated datasets optimized for analytics, reporting, and machine learning.

## Serve data to consumers

Once data reaches its target destination, the **serving layer** makes it accessible to different consumer groups. This stage focuses on providing appropriate **access patterns** and **performance characteristics** for each use case.

Serving considerations include:

- **Views and access layers**: Create views that present data in formats optimized for specific consumer needs, such as dashboards, reports, or analytical queries.

- **Performance optimization**: Configure **compute resources** and **caching strategies** that meet latency requirements for interactive queries.

- **Access control**: Implement **security policies** that ensure consumers see only the data they're authorized to access.

The serving layer bridges data engineering and data consumption. While data engineers build and maintain the underlying infrastructure, analysts and applications interact with the served data without needing to understand pipeline internals.

## Monitor and optimize pipeline performance

**Pipeline monitoring** ensures your data flows reliably and efficiently over time. Without ongoing observation, issues like **data delays**, **quality degradation**, or **resource inefficiency** can go unnoticed until they affect business decisions.

Establish monitoring for:

- **Processing metrics**: Track **execution times**, **record counts**, and **resource utilization** to identify bottlenecks or unexpected changes in data volumes.

- **Data quality trends**: Monitor validation results over time to detect gradual **drift** in data quality or sudden spikes in invalid records.

- **Cost and performance**: Review compute usage patterns to identify opportunities for **optimization**, such as adjusting cluster sizes or scheduling non-urgent workloads during off-peak hours.

**Optimization** is an ongoing activity. As data volumes grow and business requirements evolve, revisit your pipeline design to ensure it continues to meet performance and cost objectives.
