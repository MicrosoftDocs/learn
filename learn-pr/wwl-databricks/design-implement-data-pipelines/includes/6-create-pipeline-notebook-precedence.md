Data pipelines often require multiple notebooks to run in a specific sequence. When you build a pipeline using notebooks in Azure Databricks, you configure **task dependencies** that control the execution order. These dependencies ensure that each step completes before dependent steps begin.

## Add a notebook task to a Lakeflow Job

A **notebook task** runs a Databricks notebook as part of a job workflow. You specify the notebook path, configure compute resources, and define any parameters the notebook requires. Multiple notebook tasks can be chained together to form a complete data pipeline.

:::image type="content" source="../media/6-add-notebook-task-to-job.png" alt-text="Screenshot showing how to add a notebook task to a Lakeflow Job." lightbox="../media/6-add-notebook-task-to-job.png":::

When you add notebook tasks to a job, each task appears as a node in a **Directed Acyclic Graph (DAG)**. The DAG provides a visual representation of your pipeline's execution flow, showing which tasks run first and which tasks depend on others.

Consider a typical data pipeline that processes sales data. The pipeline might include three notebooks: one for data ingestion, one for transformation, and one for loading data into a final table. Without dependencies configured, these notebooks could run simultaneously and cause failures when the transformation notebook tries to read data that hasn't been ingested yet.

## Configure task dependencies

**Task dependencies** control when each notebook runs relative to other tasks in your job. When you configure a dependency, you specify that one task must wait for another task to complete before starting.

To add a dependency between tasks:

1. Select a task in the job DAG.
2. In the **Depends on** field, select the upstream task from the drop-down menu.
3. Select **Save task**.

When you select a task in the DAG before creating a new task, the new task automatically has a dependency on the selected task. This default behavior helps you build sequential pipelines quickly.

Dependencies create a clear **execution path** through your pipeline. In a four-task job where Task 2 and Task 3 both depend on Task 1, and Task 4 depends on both Task 2 and Task 3, Azure Databricks runs Task 1 first. After Task 1 completes successfully, Task 2 and Task 3 run **in parallel**. Task 4 starts only after both Task 2 and Task 3 finish.

```
Task 1 (ingest_data)
    ├── Task 2 (transform_customers)
    └── Task 3 (transform_orders)
            └── Task 4 (generate_report)
```

## Create a notebook task from scratch

Building a notebook-based pipeline starts with creating the job and adding your first notebook task. The following steps walk through the complete configuration process.

1. In your Azure Databricks workspace, select **Jobs & Pipelines** in the sidebar.
2. Select **Create**, then select **Job**.
3. Enter a task name that describes the notebook's purpose, such as `ingest_sales_data`.
4. In the **Type** drop-down menu, select **Notebook**.
5. In the **Source** drop-down menu, select **Workspace** to use a notebook stored in your workspace.
6. Select the **Path** field and browse to your notebook location.
7. Configure compute resources using the **Compute** field.
8. Select **Create task**.

After creating the first task, add additional notebook tasks and configure their dependencies to complete your pipeline structure. Each new task you add while another task is selected automatically inherits a dependency on that task.

## Pass parameters between notebooks

Notebook tasks can receive **parameters** at runtime through the **Parameters** configuration. These parameters are accessible in the notebook using `dbutils.widgets`. Parameter passing enables you to reuse notebooks across different jobs with varying inputs.

To configure parameters for a notebook task:

1. Select the task in your job configuration.
2. Under **Parameters**, select **Add**.
3. Enter the parameter name in the **Key** field.
4. Enter the parameter value in the **Value** field.
5. Select **Save task**.

In your notebook, retrieve parameters using `dbutils.widgets.get()`:

```python
# Retrieve a parameter named 'process_date' with a default value
dbutils.widgets.text("process_date", "2024-01-01", "Process Date")
process_date = dbutils.widgets.get("process_date")

# Use the parameter in your processing logic
df = spark.read.table("sales_raw").filter(f"date = '{process_date}'")
```

This approach keeps your notebooks flexible and allows the same notebook to process different data based on job parameters.

## Best practices for notebook pipelines

When building production notebook pipelines, follow these practices to maintain reliability and clarity.

- **Use descriptive task names** that indicate the notebook's function. Names like `bronze_ingest_orders` or `silver_transform_customers` make the pipeline's purpose immediately clear in the DAG view.

- **Organize notebooks in folders** that mirror your pipeline structure. A folder hierarchy such as `/pipelines/sales/bronze/` and `/pipelines/sales/silver/` helps team members locate notebooks quickly.

- **Minimize task dependencies** where possible. While dependencies ensure correct execution order, excessive dependencies can reduce parallelism and slow down your pipeline. Only add dependencies where a true data relationship exists.

- **Use workspace notebooks for production jobs** rather than notebooks in Git folders when you need to track MLflow experiments. Notebooks run from remote Git repositories are ephemeral and can't reliably track MLflow runs or models.

- **Consider output limits** when designing your notebooks. Notebook cell output is limited to 20 MB total, with individual cells limited to 8 MB. If your notebooks generate large outputs, write results to tables instead of displaying them in cell output.
