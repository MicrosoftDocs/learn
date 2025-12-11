When you design task logic for a **Lakeflow Job**, you make decisions that affect how your workflow executes, scales, and responds to changing conditions. A well-designed job balances performance, cost, and maintainability while meeting business requirements.

In this unit, you learn how to structure task dependencies, choose execution patterns, and configure parameters that make your jobs flexible and reusable.

## Understand task relationships in a job

Lakeflow Jobs represent tasks and their relationships as a **Directed Acyclic Graph (DAG)**. Each task in the DAG can depend on one or more upstream tasks, creating a visual map of your workflow's execution order.

:::image type="content" source="../media/4-understand-task-relationships.png" alt-text="Diagram explaining Directed Acyclic Graph in declarative pipelines and jobs." border="false" lightbox="../media/4-understand-task-relationships.png":::

Consider a typical data processing workflow. You might have an ingestion task that loads raw data, followed by transformation tasks that clean and aggregate that data, and finally a task that publishes results. The dependencies between these tasks determine not just the order of execution, but also how failures propagate through your workflow.

When you configure task dependencies, you choose from several dependency conditions:

| Dependency condition   | Behavior                                                     |
| ---------------------- | ------------------------------------------------------------ |
| All succeeded          | Runs only when all upstream tasks complete successfully      |
| At least one succeeded | Runs when any upstream task succeeds                         |
| None failed            | Runs when no upstream tasks failed, even if some are skipped |
| All done               | Runs after all upstream tasks finish, regardless of outcome  |
| At least one failed    | Runs only when at least one upstream task fails              |
| All failed             | Runs only when all upstream tasks fail                       |

These conditions give you control over task execution beyond simple sequential ordering. For example, you might configure a cleanup task with **All done** to ensure temporary resources are released regardless of whether earlier tasks succeeded.

## Design task execution patterns

Your choice between **serial** and **parallel execution** affects both runtime performance and resource utilization. Tasks without dependencies on each other can run simultaneously, reducing total job duration.

Consider a scenario where you need to process data from three independent sources. If you design these as sequential tasks, your job waits for each source to complete before starting the next. With parallel execution, all three tasks run simultaneously.

:::image type="content" source="../media/4-design-task-execution-patterns.png" alt-text="Diagram showing task execution patterns." border="false" lightbox="../media/4-design-task-execution-patterns.png":::

However, parallel execution requires more compute resources. When designing your task graph, balance parallelism against the compute capacity available in your workspace. Azure Databricks limits concurrent task runs per workspace, so highly parallel jobs might experience queuing during peak usage.

Tasks that share a compute resource run on the same cluster, which reduces startup latency but means they share available memory and CPU. Consider grouping related tasks on **shared compute** while keeping resource-intensive tasks on **dedicated clusters**.

## Add conditional logic to task flows

Real-world workflows often require decisions based on data conditions or processing outcomes. Lakeflow Jobs provides two primary mechanisms for conditional execution.

### If/else branching

Use **If/else condition** tasks when you need to choose between different processing paths based on values or state. The condition evaluates an expression using task values, job parameters, or dynamic references.

For example, suppose your data quality check produces a count of invalid records. You can configure an If/else task to route execution:

- If invalid records exceed a threshold, run a remediation workflow
- Otherwise, proceed to the standard transformation pipeline

The condition expression might look like: `{{tasks.quality_check.values.invalid_count}} > 100`

When the condition evaluates to true, tasks configured to depend on the true outcome execute. When false, the alternative path runs instead.

:::image type="content" source="../media/4-add-conditional-logic-task-flows.png" alt-text="Screenshot of Azure Databricks tasks designer, highlighting if/else condition and Run if dependencies." border="false" lightbox="../media/4-add-conditional-logic-task-flows.png":::

### Run if conditions

For tasks that should execute based on upstream task outcomes rather than data values, use **Run if** dependencies. This approach handles scenarios like:

- Running a notification task only when upstream tasks fail
- Executing cleanup logic regardless of success or failure
- Proceeding when at least one of several alternative data sources succeeds

Run if conditions evaluate automatically based on task state, without requiring explicit value comparisons.

## Implement iterative processing with For each

When you need to apply the same processing logic across multiple items, the **For each** task eliminates repetitive task definitions. You define a single nested task that executes once for each element in an input array.

Common scenarios for For each tasks include:

- Processing files from a list of paths
- Transforming data for multiple regions or date ranges
- Running the same analysis across different product categories

The input array can come from several sources. You might define it directly as JSON, reference a task value from a preceding task, or use a job parameter. Each iteration receives the corresponding array element as its input.

```python
# A preceding task might set values like this:
regions = ["us-east", "us-west", "eu-central"]
dbutils.jobs.taskValues.set(key="regions_to_process", value=regions)
```

The **For each** task then references `{{tasks.get_regions.values.regions_to_process}}` and runs its nested task three times—once for each region.

:::image type="content" source="../media/4-iterative-processing.png" alt-text="Screenshot showing a For each task, referencing a task value from a preceding task." lightbox="../media/4-iterative-processing.png":::

You control concurrency by setting how many iterations can run in parallel. Higher concurrency processes items faster but requires more compute resources.

## Configure parameters for flexibility

Well-designed jobs accept **parameters** that allow the same workflow to handle different scenarios without modification. Parameters can be defined at the job level and accessed by any task, or passed specifically to individual tasks.

Consider designing your jobs with these parameter patterns:

**Date and time parameters**: Enable the same job to process different time periods. This supports both scheduled runs with current dates and backfill operations for historical data.

**Environment parameters**: Allow switching between development, staging, and production configurations. You might parameterize catalog names, storage paths, or connection settings.

**Processing parameters**: Control job behavior like batch sizes, filtering criteria, or output formats.

To reference a job parameter within a task, use the syntax `{{job.parameters.<parameter_name>}}` in the task configuration. For example, if you define a job parameter called `target_catalog`, configure the notebook task to pass it as a base parameter with value `{{job.parameters.target_catalog}}`. Then access it in your notebook:

```python
# Access the parameter passed to the notebook
target_catalog = dbutils.widgets.get("target_catalog")
spark.sql(f"USE CATALOG {target_catalog}")
```

Databricks provides **dynamic value references** that inject runtime context into parameters. For scheduled jobs, `{{job.trigger.time.iso_date}}` provides the trigger date. For backfill runs, `{{backfill.iso_datetime}}` supplies the backfill timestamp.

## Select compute resources for tasks

Each task type has recommended compute options that affect both capability and cost. Your task logic design should account for compute requirements:

| Task type                      | Recommended compute         |
| ------------------------------ | --------------------------- |
| Notebooks, Python scripts      | Serverless jobs compute     |
| SQL queries and files          | Serverless SQL warehouse    |
| Lakeflow Declarative Pipelines | Serverless pipeline compute |
| JAR and Spark Submit           | Classic jobs compute        |

Tasks within the same job can use different compute resources. A common pattern assigns SQL tasks to a SQL warehouse while notebook-based transformations run on jobs compute.

When multiple tasks share a cluster, the cluster remains active until all tasks complete. This reduces startup time but incurs cost during idle periods between task executions. Balance shared compute benefits against the resource isolation of dedicated clusters.

For production jobs, **serverless compute** eliminates cluster management overhead and scales automatically. **Classic compute** provides more configuration control when you need specific Spark versions, custom libraries, or particular instance types.

Your task logic design establishes the foundation for reliable, efficient data workflows. As you implement and test your jobs, you can refine dependencies, adjust parallelism, and tune parameters to match actual workload characteristics.