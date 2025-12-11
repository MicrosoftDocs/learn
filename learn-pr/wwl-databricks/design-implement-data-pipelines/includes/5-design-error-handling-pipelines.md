When data pipelines fail, the consequences extend beyond immediate job errors. Invalid records can corrupt downstream analytics, unnoticed failures can accumulate technical debt, and without proper alerting, teams might discover problems hours or days after they occur. Designing robust **error handling** transforms your pipelines from fragile processes into resilient systems that protect data quality and enable rapid recovery.

In this unit, you learn how to design error handling strategies for data pipelines, notebooks, and jobs in Azure Databricks.

## Understand error handling responsibilities

Error handling in Azure Databricks operates at multiple levels, each addressing different failure scenarios. The platform handles **infrastructure-level issues** like cluster node failures automatically. Your responsibility as a data engineer focuses on **data-level errors** and **application logic failures**.

:::image type="content" source="../media/5-understand-error-handling-responsibilities.png" alt-text="Diagram explaining error handling responsibilities." border="false" lightbox="../media/5-understand-error-handling-responsibilities.png":::

Consider a typical ETL pipeline processing customer transactions. Errors can occur when:

- Source data contains invalid formats or missing required fields
- Transformation logic encounters unexpected values
- External service connections time out
- Compute resources become unavailable

Each scenario requires a different response. Some errors warrant immediate pipeline termination, while others should log the issue and continue processing valid records.

## Define data quality expectations in declarative pipelines

Lakeflow Declarative Pipelines provides built-in data quality constraints called **expectations**. These constraints validate records as data flows through your pipeline, giving you control over how to handle invalid data.

:::image type="content" source="../media/5-define-data-quality-expectations.png" alt-text="Screenshot of the declarative pipeline editor, highlighting expectations." border="false" lightbox="../media/5-define-data-quality-expectations.png":::

When a record fails validation, three actions determine what happens:

| Action | Behavior | Use case |
|--------|----------|----------|
| **Warn** | Invalid records written to target; metrics logged | Monitoring data quality trends |
| **Drop** | Invalid records excluded from target | Preventing bad data from propagating |
| **Fail** | Pipeline stops immediately | Critical constraints that must never be violated |

> [!TIP]
> When a fail expectation triggers, only that specific flow stops. Other parallel flows in the same pipeline continue processing. This isolation prevents a single data quality issue from halting your entire data platform.

## Configure job-level error handling

Lakeflow Jobs provides several mechanisms to handle task failures and ensure pipeline reliability. These settings work together to create resilient workflows.

:::image type="content" source="../media/5-configure-job-level-error-handling.png" alt-text="Screenshot showing how to configure job-level error handling." lightbox="../media/5-configure-job-level-error-handling.png":::

### Set retry policies

Transient failures like network timeouts, temporary resource constraints, or brief service interruptions often resolve themselves. Configure **retry policies** to automatically attempt failed tasks again:

- **Retry count**: Number of attempts before marking the task as failed (typically 1-3 retries)
- **Retry interval**: Time between attempts, allowing systems to recover

For continuous jobs, the platform automatically applies **exponential backoff**. Each consecutive failure increases the wait time before the next retry, preventing rapid repeated failures from overwhelming resources.

### Configure timeouts

A task that hangs indefinitely consumes resources and blocks downstream processing. Set **timeout thresholds** to terminate unresponsive tasks:

- **Expected duration**: Triggers a warning notification if exceeded
- **Maximum duration**: Terminates the task if exceeded

### Add notifications

Proactive alerting enables rapid response to failures. Configure **notifications** to reach your team through:

- Email addresses
- Slack channels
- Microsoft Teams
- PagerDuty
- Custom webhooks

You can trigger notifications on job start, success, failure, or when duration thresholds are exceeded.

> [!IMPORTANT]
> Task-level notifications fire on each retry attempt. To avoid notification fatigue, select **Mute notifications until the last retry** when configuring task notifications.

### Design conditional task flows

Beyond simple retries, you can design jobs that respond intelligently to failures using **conditional task dependencies**:

- **All succeeded**: Continue only when every upstream task completes successfully
- **At least one failed**: Trigger error handling or cleanup tasks
- **All done**: Execute regardless of upstream status (useful for cleanup operations)

This approach enables patterns like running a notification task when processing fails, or executing cleanup logic before a retry.

## Implement error handling in notebooks

When building pipelines with notebooks, you implement error handling directly in your code. Python's **exception handling** provides granular control over failure responses.

### Catch and handle exceptions

Wrap operations that might fail in **try-except blocks**:

```python
from pyspark.errors import PySparkException

try:
    df = spark.read.table("source_data")
    transformed = df.filter("amount > 0")
    transformed.write.mode("append").saveAsTable("target_data")
except PySparkException as e:
    if e.getErrorClass() == "TABLE_OR_VIEW_NOT_FOUND":
        # Handle missing source table
        print(f"Source table not found: {e.getMessageParameters()['relationName']}")
    else:
        raise  # Re-raise unexpected errors
```

This example catches `PySparkException`, the base class for PySpark errors. The `getErrorClass()` method returns a standardized error code like `TABLE_OR_VIEW_NOT_FOUND`, allowing you to handle specific errors differently. The `getMessageParameters()` method provides context about the error, such as the name of the missing table. Errors you don't explicitly handle are re-raised to avoid silently ignoring unexpected issues.

### Implement retry logic

For operations prone to transient failures, implement retry with exponential backoff:

```python
import time

def run_with_retry(operation, max_retries=3, base_delay=10):
    for attempt in range(max_retries + 1):
        try:
            return operation()
        except Exception as e:
            if attempt == max_retries:
                raise
            delay = base_delay * (2 ** attempt)
            print(f"Attempt {attempt + 1} failed, retrying in {delay}s: {e}")
            time.sleep(delay)
```

### Signal success or failure to jobs

When a notebook runs as a job task, use `dbutils.notebook.exit()` to communicate results:

```python
try:
    # Processing logic
    records_processed = process_data()
    dbutils.notebook.exit(f"SUCCESS: Processed {records_processed} records")
except Exception as e:
    dbutils.notebook.exit(f"FAILED: {str(e)}")
```

Downstream tasks can then use these values in conditional logic or for reporting.

## Apply error handling best practices

Effective error handling balances thoroughness with practicality. Consider these guidelines:

**Fail fast for critical errors**: When data integrity is at stake, stop processing immediately. Continuing with corrupt data creates larger problems downstream.

**Log meaningful context**: Include enough information to diagnose issues without exposing sensitive data. Record timestamps, record counts, and error classifications.

**Plan for recovery**: Design pipelines so failed runs can be repaired. Use idempotent operations where possible, and structure jobs so only failed tasks need re-running.

**Monitor trends**: Track data quality metrics over time. A gradual increase in dropped records might indicate upstream system changes that need attention.

**Test failure scenarios**: Validate that your error handling works as expected by deliberately introducing failures during development.
