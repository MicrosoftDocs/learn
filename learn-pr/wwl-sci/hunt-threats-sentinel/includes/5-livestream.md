Microsoft Sentinel hunts help you organize proactive investigations around a hypothesis. A hunt can contain multiple queries, bookmarks, entities, comments, related analytics rules, and incidents. This structure preserves investigation context and lets security analysts collaborate over time.

> [!NOTE]
> Microsoft Sentinel livestreams are no longer available. To automate queries and notifications, use Kusto Query Language (KQL) jobs, analytics rules, or playbooks.

## Create a hunt

You can create a hunt from selected queries or start with a blank hunt:

1. In Microsoft Sentinel, select **Threat management** > **Hunting**.
1. To start from existing queries, select the queries on the **Queries** tab, and then select **Hunt actions** > **Create new hunt**. To start without queries, select the **Hunts** tab, and then select **New hunt**.
1. Enter a name and description that state the hypothesis that you want to investigate.
1. Select **Create**.

## Investigate with queries and bookmarks

Run the queries associated with the hunt and review their results. For example, the following query returns Azure Activity events that recorded a deleted resource:

```kusto
AzureActivity
| where OperationName has 'delete'
| where ActivityStatus == 'Accepted'
| extend AccountCustomEntity = Caller
| extend IPCustomEntity = CallerIpAddress
```

When you find important results, add them as bookmarks. Bookmarks preserve the result, query, and time range. You can also map entities, add tags and notes, investigate related entities, and use bookmarks to create or enrich an incident.

## Act on hunt results

If a hunt query produces reliable findings, create an analytics rule from the query. The rule can generate alerts or incidents when future activity matches the detection logic. You can also create incidents from hunt bookmarks and run playbooks on bookmarked entities.

As the investigation progresses, update the hunt's hypothesis and status. Close the hunt after you record the outcome and complete related actions.

Choose the best response for the following question.
