Azure Databricks is a single service platform with multiple technologies that enable working with data at scale. When using Azure Databricks, there are some key concepts to understand.

## Workspaces

A [workspace](/azure/databricks/admin/workspace/?azure-portal=true) is an environment for accessing all the Databricks assets. It provides a user interface to manage notebooks, libraries, and experiments. Workspaces can be organized into folders and shared among team members, facilitating collaboration and resource management.

## Notebooks

Databricks [notebooks](/azure/databricks/notebooks/?azure-portal=true) are interactive documents that contain runnable code, visualizations, and narrative text. They support multiple languages, including Python, R, Scala, and SQL, which can be used simultaneously within the same notebook. Notebooks are central to collaborative projects and are ideal for exploratory data analysis, data visualization, and complex data workflows.

## Clusters

[Clusters](/azure/databricks/compute/?azure-portal=true) are the computational engines of Azure Databricks. Users can create and scale clusters according to the computational resources needed. Clusters can be configured manually or set to auto-scale based on workload. They support different types of nodes for various tasks, like driver and worker nodes, ensuring efficient resource utilization.

## Jobs

[Jobs](/azure/databricks/workflows/jobs/create-run-jobs?azure-portal=true) in Azure Databricks are used to schedule and run automated tasks. These tasks can be notebook runs, Spark jobs, or arbitrary code executions. Jobs can be triggered on a schedule or run in response to certain events, making it easy to automate workflows and periodic data processing tasks.

## Databricks Runtime

The [Databricks Runtime](/azure/databricks/release-notes/runtime/?azure-portal=true) is a set of performance-optimized versions of Apache Spark. It includes enhancements for improved performance and additional functionality beyond standard Spark, such as optimizations for machine learning workloads, graph processing, and genomics.

## Delta Lake

[Delta Lake](/azure/databricks/structured-streaming/delta-lake?azure-portal=true) is an open-source storage layer that brings reliability and scalability to data lakes. It provides ACID transactions, scalable metadata handling, and unifies streaming and batch data processing, all crucial for managing large-scale data in a consistent and fault-tolerant manner.

## Databricks SQL

[Databricks SQL](/azure/databricks/sql/get-started/concepts?azure-portal=true) provides a way to perform SQL queries on the data within Azure Databricks. It allows data analysts to run quick ad-hoc queries and create reports directly on big data. It includes an SQL editor, dashboards, and automatic visualization tools, making it user-friendly for those accustomed to SQL environments.

## MLflow

[MLflow](/azure/databricks/machine-learning/?azure-portal=true) is an open-source platform for managing the end-to-end machine learning lifecycle. It includes features for experiment tracking, model management, and deployment, helping practitioners manage and share their ML models and experiments efficiently.
