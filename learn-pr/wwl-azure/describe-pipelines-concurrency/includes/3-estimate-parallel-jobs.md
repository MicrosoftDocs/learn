Start with the free tier to understand your organization's usage patterns. Each Azure DevOps organization gets free parallel jobs with monthly limits:

- **Private projects**: 1 parallel job with 60-minute limit and 1,800 minutes per month
- **Public projects**: 10 parallel jobs for Microsoft-hosted agents (unlimited minutes)

When queues become too long, consider purchasing additional parallel jobs.

## Estimation guidelines

**Quick estimate**: Plan for one parallel job per 4-5 users in your organization.

**Detailed analysis** - You may need more parallel jobs if you have:

- **Multiple teams**: Each team doing continuous integration may need dedicated capacity
- **Multiple branches**: Active branches with CI triggers require separate job slots  
- **Multiple applications**: Simultaneous deployments across different applications
- **Complex workflows**: Pipelines with multiple stages running in parallel

## Checking your current usage

To view your parallel job limits and usage:

1. Navigate to **Organization settings** > **Pipelines** > **Parallel jobs**
2. Or visit: `https://{your_organization}/_settings/buildqueue?_a=concurrentJobs`
3. Select **View in-progress jobs** to see active and queued jobs

:::image type="content" source="../media/parallel-jobs-organization-settings-679bb5c6.png" alt-text="Screenshot of parallel jobs in organization settings.":::

## How parallel jobs are shared

**Organization-level resource**: Parallel jobs belong to your entire organization, not individual projects.

**Shared capacity**: All projects compete for the same parallel job pool. For example:
- Organization has 2 parallel jobs
- Project A starts 2 pipelines (uses both slots)
- Project B's pipeline waits until Project A's jobs complete

**No partitioning**: Currently, you can't dedicate parallel jobs to specific projects or agent pools.
