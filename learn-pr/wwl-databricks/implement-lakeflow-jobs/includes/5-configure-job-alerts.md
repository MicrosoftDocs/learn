When your data pipelines run in production, you need to know when something goes wrong—or even when everything goes right. Configuring **job alerts** in Azure Databricks gives you visibility into job execution without constantly monitoring dashboards. Alerts enable you to respond quickly to failures, track long-running jobs, and maintain confidence in your data workflows.

In this unit, you learn how to configure notifications for jobs and tasks, choose appropriate alert destinations, and apply best practices that keep your alerts actionable.

## Understand notification events

Azure Databricks can notify you when specific events occur during job execution. Each event type serves a different operational purpose.

| Event type            | When it fires                            | Use case                                                 |
| --------------------- | ---------------------------------------- | -------------------------------------------------------- |
| **Start**             | Job run begins                           | Track job initiation, confirm scheduled jobs started     |
| **Success**           | Job completes successfully               | Verify pipeline completion, trigger downstream processes |
| **Failure**           | Job terminates with error                | Investigate issues, initiate incident response           |
| **Duration warning**  | Run exceeds configured threshold         | Identify performance degradation, catch runaway jobs     |
| **Streaming backlog** | Backlog exceeds threshold for 10 minutes | Monitor streaming job health                             |

When a job completes in a **Succeeded with failures** state—meaning some tasks failed but the job itself finished—Databricks considers this a success. If you need visibility into partial failures, configure your Success notifications accordingly or add task-level notifications.

With these event types in mind, you can now configure where these notifications should go.

## Configure notification destinations

Notifications can go to email addresses or third-party systems. Third-party **system destinations** integrate with tools your team already uses for incident management and collaboration.

Supported system destinations include:

- **Slack**: Channel notifications for team visibility
- **Microsoft Teams**: Integration with your collaboration platform
- **PagerDuty**: Incident management and on-call escalation
- **HTTP webhooks**: Custom integrations with any service that accepts HTTP requests

Before you can use system destinations, a workspace administrator must configure them. Navigate to **Admin Settings** and select **Notifications** to create destinations. Each destination requires appropriate credentials—webhook URLs for Slack and Teams, integration keys for PagerDuty.

> [!TIP]
> Use different credentials for each configured destination. If one third-party endpoint is compromised, you can revoke its access without affecting other notification destinations.

For each job or task, you can configure up to three system destinations per event type. This limit encourages thoughtful notification design rather than flooding multiple channels.

## Add notifications to a job

To configure job-level notifications, follow these steps:

1. Open your job in the Azure Databricks workspace.
2. In the **Job details** panel, locate the **Job notifications** section.
3. Select **Edit notifications**.
4. Select **Add notification**.
5. Choose a destination type—either **Email address** or one of your configured system destinations.
6. Select the event types you want to trigger notifications: **Start**, **Success**, **Failure**, **Duration warning**, or **Streaming backlog**.
7. Select **Save** when you finish adding notifications.

Job-level notifications apply to the overall job run. However, job-level notifications aren't sent when individual tasks fail and retry. Consider this behavior when designing your notification strategy.

## Configure task-level notifications

For more granular visibility, configure notifications on individual tasks within your job. Task notifications fire for each task run, giving you insight into which specific step encountered issues.

To add task notifications:

1. Edit your job and select the task you want to monitor.
2. In the task panel, locate **Notifications** and select **Add**.
3. Configure the destination and event types just as you would for job notifications.
4. Save the task configuration.

Task notifications are particularly valuable when your job contains multiple independent tasks. If Task A fails, you receive an immediate notification rather than waiting for the entire job to complete or fail.

By default, Databricks retries failed tasks three times. If you don't want notifications for every retry attempt, select **Mute notifications until the last retry**. This reduces noise while still alerting you when a task ultimately fails.

## Reduce notification noise

Alert fatigue undermines the value of notifications. When teams receive too many alerts, they start ignoring them—including the critical ones. Apply these strategies to keep your alerts meaningful.

**Filter out skipped and canceled runs**: When you cancel a job or a run gets skipped due to concurrent run limits, you might not need a notification. Select **Mute notifications for skipped runs** or **Mute notifications for canceled runs** to suppress these.

**Use duration warnings strategically**: Rather than alerting on every long-running job, set duration thresholds based on historical performance. A job that usually takes 30 minutes might warrant a warning at 45 minutes—not at 35.

**Separate task and job notifications**: If you enable job failure notifications, you don't necessarily need task failure notifications for every task. Choose based on whether you need to know *that* a job failed or *which task* failed.

**Document your alert logic**: Record why each alert exists, what conditions trigger it, and what action the recipient should take. This documentation helps when troubleshooting alerts or onboarding new team members.

## Monitor with HTTP webhooks

When built-in integrations don't meet your needs, HTTP webhooks provide flexibility. Databricks sends a JSON payload to your endpoint when events occur, enabling custom processing, logging, or integration with internal systems.

Webhook payloads include the event type, workspace ID, job information, and run details:

```json
{
  "event_type": "jobs.on_failure",
  "workspace_id": "your_workspace_id",
  "run": {
    "run_id": "run_id"
  },
  "job": {
    "job_id": "job_id",
    "name": "job_name"
  }
}
```

If you require specific formatting for notifications, webhooks let you control the message structure completely. This approach is useful when integrating with monitoring platforms that have particular schema requirements.

## Monitor pipelines in Azure Data Factory

When your Databricks jobs are orchestrated by Azure Data Factory (ADF), you have additional monitoring options. ADF provides visual monitoring in the Azure portal where you can track pipeline runs, activity status, and execution duration.

ADF also supports creating alerts on metrics such as:

- Pipeline run status (failed, succeeded, canceled)
- Activity run counts
- Integration Runtime utilization

To configure ADF alerts, navigate to **Monitor** > **Alerts & metrics** in the Data Factory portal. Create alert rules that specify conditions, severity levels, and action groups for notifications via email, SMS, or other channels.

This layered approach—Databricks notifications for job-level events and ADF alerts for orchestration-level metrics—gives you comprehensive visibility across your data platform.

With alerts configured at the right granularity and sent to the right channels, you can respond to issues quickly while avoiding the distraction of unnecessary notifications. As you deploy more jobs to production, revisit your alerting strategy to ensure it scales with your workload.
