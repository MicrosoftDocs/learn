Deploying a semantic model to production isn't the end of the lifecycle. Models need regular data refreshes and ongoing monitoring to remain reliable over time. Without these operational practices, even well-built models degrade as data grows stale and refresh failures go unnoticed.

## Scheduled refresh

A semantic model that isn't refreshed serves stale data. Scheduled refresh ensures your model stays current by running data loads on a defined cadence.

To configure scheduled refresh:

1. In the Power BI service, navigate to the semantic model settings.
1. Under **Scheduled refresh**, turn on the refresh schedule.
1. Set the frequency (daily or weekly) and the specific times.
1. Configure failure notifications so the model owner is alerted if a refresh fails.

For on-premises data sources, a data gateway must be installed and configured. The gateway acts as a bridge between the cloud service and the on-premises server, handling authentication and data transfer securely. Cloud data sources connect directly and don't require a gateway.

The refresh frequency depends on your business requirements. Models that serve real-time dashboards might need multiple refreshes per day. Models for monthly reporting might refresh once a week. Match the refresh cadence to how often the underlying data changes and how quickly users need to see updates.

> [!TIP]
> Schedule refreshes during off-peak hours to avoid competing with query workloads on the capacity. If your model serves users in multiple time zones, choose a refresh time that minimizes the window of stale data for the largest user group.

## Refresh with Data Factory pipelines

For more complex refresh patterns, use a Data Factory pipeline with a semantic model refresh activity. A pipeline can orchestrate multiple steps in sequence:

1. Refresh upstream data in a lakehouse.
1. Transform the data.
1. Trigger the semantic model refresh.
1. Send a notification on completion.

Pipeline-based refresh is useful when the semantic model depends on upstream data transformations that must complete first. Instead of relying on timing alone (scheduling the semantic model refresh an hour after the lakehouse refresh and hoping it finished), the pipeline enforces a sequential order. The semantic model refresh starts only after the upstream steps succeed.

You can also add conditional logic to pipelines. For example, if the lakehouse refresh fails, skip the semantic model refresh and send an alert. This prevents the model from refreshing against incomplete or corrupt data.

## Monitor refresh operations

The Monitoring Hub in the Fabric portal shows the status of all running and recent activities in your workspace, including semantic model refreshes. Use the Monitoring Hub to:

- Verify that scheduled refreshes completed successfully.
- Investigate refresh failures by checking error details, duration, and timing.
- Identify patterns in refresh performance over time. A refresh that gradually takes longer might indicate growing data volumes or an inefficient query.

You can also view refresh history for a specific semantic model in the model settings. The history shows the status, duration, and type (scheduled, on-demand, or pipeline-triggered) of each refresh. Compare recent refresh times to historical averages to spot performance degradation early.

When a refresh fails, the error message often points to the root cause: an expired credential, a data source timeout, or a schema change in the source system. Address failures promptly because a failed refresh means users see outdated data until the issue is resolved.

## Troubleshoot with lineage view

During operational troubleshooting, you might need to understand how items in a workspace connect to each other. Lineage view provides a visual map of data flow from sources through semantic models to reports. If a report shows stale data, you can trace the lineage upstream to find the semantic model, check its last refresh time, and identify whether the data source is the bottleneck.

> [!NOTE]
> Lineage view, impact analysis, and endorsement are governance capabilities covered in depth in a separate module. From a lifecycle perspective, the key operational point is this: before you make schema changes to a deployed model, run impact analysis to identify downstream consumers that might break. After deployment, use lineage view to troubleshoot data freshness issues.

With operational monitoring in place, the **Monitor** stage is complete — and so is the full lifecycle: **Develop → Validate → Deploy → Monitor**. The next step in your analytics journey is securing data access.
