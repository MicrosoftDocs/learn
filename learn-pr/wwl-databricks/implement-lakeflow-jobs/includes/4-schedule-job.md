When you schedule a Lakeflow Job, you define exactly when your workflow runs without manual intervention. Scheduling transforms ad hoc data processing into reliable, automated pipelines that keep your data fresh and your business processes running smoothly.

Azure Databricks provides two scheduling approaches. Simple schedules handle recurring intervals like "every 12 hours," while advanced schedules give you precise control through cron expressions that can target specific days, times, and even months.

## Create a simple schedule

Simple schedules work well when you need consistent intervals between job runs. You specify a number and a time unit—minutes, hours, days, or weeks—and Azure Databricks handles the rest.

To add a simple schedule to your job:

1. In your Azure Databricks workspace sidebar, select **Jobs & Pipelines**.
2. Select your job's name to open its details.
3. In the **Job details** panel, select **Add trigger**.
4. Set **Trigger type** to **Scheduled**.
5. Set **Schedule type** to **Simple**.
6. Specify your interval (for example, 12 hours).
7. Select **Save**.

With simple schedules, you can't control when the first run happens—the scheduler picks a time when you save the configuration. Each subsequent run then follows your specified interval.

> [!NOTE]
> Azure Databricks enforces a minimum interval of 10 seconds between job runs, regardless of your configuration.

## Configure an advanced schedule

Advanced schedules use cron expressions to define precisely when your job runs. This approach handles complex requirements like "at 8:00 AM every weekday" or "on the last Friday of each month."

To create an advanced schedule:

1. In the Job details panel, select **Add trigger**.
2. Set **Trigger type** to **Scheduled**.
3. Set **Schedule type** to **Advanced**.
4. Specify the period, starting time, and time zone.
5. Optionally, select **Show Cron Syntax** to view and edit the expression directly.
6. Select **Save**.

### Understand cron expression format

A cron expression contains six or seven fields separated by spaces:

| Field        | Required | Allowed values   | Special characters |
| ------------ | -------- | ---------------- | ------------------ |
| Seconds      | Yes      | 0-59             | `, - * /`          |
| Minutes      | Yes      | 0-59             | `, - * /`          |
| Hours        | Yes      | 0-23             | `, - * /`          |
| Day of month | Yes      | 1-31             | `, - * ? / L W`    |
| Month        | Yes      | 1-12 or JAN-DEC  | `, - * /`          |
| Day of week  | Yes      | 1-7 or SUN-SAT   | `, - * ? / L #`    |
| Year         | No       | empty, 1970-2099 | `, - * /`          |

The special characters let you build flexible schedules:

- `*` selects all values in a field ("every minute" or "every hour")
- `?` means "no specific value"—use it in day-of-month or day-of-week when you specify the other
- `-` defines ranges like `10-12` for hours 10, 11, and 12
- `,` lists multiple values like `MON,WED,FRI`
- `/` specifies increments—`0/15` in minutes means every 15 minutes starting at 0
- `L` means "last"—in day-of-month, it's the last day; `6L` in day-of-week means "last Friday"
- `#` specifies "nth occurrence"—`6#3` means "third Friday of the month"

### Common cron expression examples

These expressions cover typical scheduling scenarios:

| Expression            | Schedule                              |
| --------------------- | ------------------------------------- |
| `0 0 12 * * ?`        | Every day at noon                     |
| `0 15 10 ? * MON-FRI` | Weekdays at 10:15 AM                  |
| `0 0 8 1 * ?`         | First day of every month at 8:00 AM   |
| `0 30 6 ? * 6L`       | Last Friday of every month at 6:30 AM |
| `0 0 */2 * * ?`       | Every 2 hours                         |

## Choose the right time zone

Time zone selection affects when your scheduled jobs actually run. Azure Databricks lets you choose any time zone, but your choice has implications for consistency.

Time zones that observe daylight saving time (DST) create complications. When DST begins or ends, an hourly job might skip a run or appear delayed by an hour or two. If your business logic depends on consistent hourly execution—measured in absolute time—select UTC instead.

Consider these factors when choosing a time zone:

- **Business alignment**: If stakeholders expect reports at 8:00 AM local time, schedule in their time zone and accept DST shifts.
- **Data consistency**: If you process data from systems using UTC timestamps, schedule in UTC to maintain alignment.
- **Cross-region coordination**: When jobs must run simultaneously across regions, UTC provides a single reference point.

> [!TIP]
> For jobs that must run at exact intervals regardless of local time changes, always use UTC.

## Control concurrent job runs

When scheduled jobs take longer than expected, a new run might start before the previous one finishes. This overlap can cause data corruption, duplicate processing, or resource contention. Azure Databricks provides concurrency settings to control this behavior.

### Configure maximum concurrent runs

The **Maximum concurrent runs** setting limits how many instances of the same job can execute simultaneously. By default, jobs allow multiple concurrent runs. For jobs that must not overlap—such as those writing to the same tables—set this value to **1**.

To configure maximum concurrent runs:

1. Open your job in the **Jobs & Pipelines** workspace UI.
2. In the **Job details** panel, locate the **Maximum concurrent runs** setting.
3. Set the value to control how many runs can execute at once.

When a new run is triggered but the maximum concurrent runs limit is reached, Azure Databricks must decide what to do with the incoming run.

### Configure queue behavior for overlapping runs

When concurrent runs exceed your configured limit, you choose how the scheduler handles the new run:

| Behavior | Description | Use case |
|----------|-------------|----------|
| **Queue the run** | The new run waits until a slot becomes available, then executes | Jobs that must eventually run—no triggers should be missed |
| **Cancel the run** | The new run is immediately canceled | Jobs where stale triggers are not valuable |
| **Skip the run** | Similar to cancel—the run doesn't execute | Jobs where missing occasional runs is acceptable |

For most data pipelines, **queue the run** ensures that all scheduled executions eventually complete. This approach prevents data gaps when a job occasionally runs longer than its schedule interval.

Consider a job scheduled to run every hour. If a run takes 75 minutes to complete, the next scheduled trigger arrives while the job is still running. With concurrency set to 1 and queue enabled:

1. The first run continues processing.
2. The second run enters the queue.
3. When the first run completes, the queued run starts immediately.

This pattern ensures sequential, non-overlapping execution while preserving all scheduled runs.

> [!NOTE]
> Queued runs consume no compute resources while waiting. They only start when a concurrent slot becomes available.

## Scheduling considerations for production workloads

The Azure Databricks job scheduler handles most scenarios reliably, but it's not designed for low-latency requirements. Network conditions or cloud service issues can occasionally delay job starts by several minutes. When service recovers, scheduled jobs run immediately.

Keep these points in mind:

- Schedule jobs with buffer time between dependent pipelines
- Don't rely on sub-minute precision for business-critical timing
- Monitor job run history to identify scheduling patterns or delays
- Use the minimum 10-second interval rule when planning high-frequency jobs
