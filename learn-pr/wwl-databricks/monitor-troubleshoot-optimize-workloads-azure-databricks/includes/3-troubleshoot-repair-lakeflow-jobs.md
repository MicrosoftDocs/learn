When a Lakeflow Job fails, you must quickly identify the problem, understand the root cause, and take corrective action. Navigating failures efficiently keeps your pipelines running and your downstream consumers satisfied.

## Understand job failure states

Before you can fix a problem, you need to recognize the different ways a job run can end unsuccessfully. Azure Databricks determines job run status based on the outcome of *leaf tasks*—tasks with no downstream dependencies.

A job run can result in several states:

- **Failed**: One or more leaf tasks didn't complete successfully.
- **Succeeded with failures**: Some tasks failed, but all leaf tasks completed successfully.
- **Skipped**: The job didn't run because it exceeded maximum concurrent runs for the job or workspace.
- **Timed Out**: The job exceeded its configured maximum duration.
- **Canceled**: A user or automated process stopped the run.

Understanding these states helps you prioritize your response. A failed leaf task requires immediate attention, while a skipped run might indicate a scheduling conflict that resolves itself.

## Identify the cause of failure

The Lakeflow Jobs UI provides tools to pinpoint exactly where and why a job failed. The matrix view in the **Runs** tab displays a visual history of runs, with each cell representing a task's status across multiple runs.

To investigate a failed job:

1. Select **Jobs & Pipelines** in the sidebar.
2. Select the job name to open its details.
3. In the **Runs** tab, hover over a failed task (shown in red) to see metadata including start time, end time, status, duration, and error messages.
4. Select the failed task to open the **Task run details** page with complete output and logs.

The matrix view helps you identify patterns. If the same task fails repeatedly, the issue likely relates to that task's code or configuration. If failures appear random across different tasks, you might have a cluster or resource problem.

> [!TIP]
> Use the **Diagnose Error** button in the Jobs UI to get help from Databricks Assistant. This feature analyzes error messages and provides suggestions for common issues.

## Fix common failure causes

Once you identify the failing task, you can address the underlying problem. Common causes and their solutions include:

**Configuration issues**: If the failure relates to task settings, select **Edit task** to modify the configuration. You can update notebook paths, change parameters, or adjust timeout values.

**Insufficient compute resources**: Resource-related failures might require cluster changes. You can modify the cluster configuration to add workers, change instance types, or switch to a shared all-purpose cluster. If your workspace has resource quotas, you might need an administrator to increase limits.

**Maximum concurrent runs exceeded**: When jobs queue up behind other runs, you have two options. Wait for existing runs to complete, or increase the **Maximum concurrent runs** setting in the job configuration.

**External dependencies**: Sometimes failures originate outside your job—an unavailable data source, a network issue, or an upstream process that hasn't completed. After the external issue resolves, you can use the repair feature to re-run the job without starting from scratch.

## Repair failed job runs

The repair feature allows you to re-run only the unsuccessful tasks and their dependents, saving time and compute resources compared to restarting the entire job.

To repair a failed run:

1. Select the failed run in the **Start time** column or from the matrix view.
2. Select **Repair run** to open the repair dialog.
3. Review the list of tasks that will re-run—this includes all failed tasks plus any dependent tasks.
4. Optionally, modify task parameters in the dialog. These values override the original settings for this repair run only.
5. Select **Repair run** to start.

After the repair completes, the matrix view adds a new column showing the repaired run results. Tasks that were red (failed) should now appear green (successful).

> [!NOTE]
> Repair is available only for jobs with two or more tasks. If tasks share a job cluster, the repair creates a new cluster instance (for example, `my_job_cluster_v1`) so you can compare settings between the original and repaired runs.

## Stop and restart job runs

Sometimes you need to halt a running job or restart one that's stuck. The Jobs UI provides controls for both actions.

**To stop an active run**: From the **Runs** tab, active runs display a stop button. Select this button to cancel the specific run. You can also select **Cancel runs** or **Cancel all queued runs** from the dropdown menu to stop multiple runs at once.

**To restart continuous jobs**: Continuous jobs that fail repeatedly enter an exponential backoff state, where Azure Databricks waits progressively longer between retry attempts. The **Job details** panel shows the number of consecutive failures and the time until the next retry. Select **Restart run** to cancel the active run, reset the retry period, and immediately start a new run.

Use the stop function when a job consumes excessive resources, processes incorrect data, or needs immediate intervention. Use restart when you've fixed an underlying issue and want to bypass the exponential backoff waiting period.

## Monitor job health proactively

Reactive troubleshooting works, but proactive monitoring prevents many failures from impacting your workflows. Consider these practices:

- **Configure notifications**: Set up email, Slack, or webhook alerts for job failures so you learn about issues immediately.
- **Review run history regularly**: The matrix view reveals patterns over time. Frequent failures in specific tasks indicate areas needing attention.
- **Use system tables**: Query the `system.lakeflow` schema to analyze job performance across your account and identify trends before they become critical issues.

Combining proactive monitoring with efficient troubleshooting skills helps you maintain reliable data pipelines that your organization can depend on.
