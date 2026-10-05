Contoso's incident started a week before anyone opened a ticket. The metrics that would show it were being collected the whole time, and nobody was looking. An alert closes that gap: it watches a condition continuously and tells you when the condition is met, so the first person to notice a problem works for you rather than buying from you. In this unit, you build an alert rule on rate-limited requests, choose a threshold you can defend, and learn which conditions are worth alerting on in the first place.

## Understand what an alert rule is made of

Every Azure Monitor alert rule has the same four parts, whichever signal it watches:

- **Scope**, the resource being monitored. For Azure Cosmos DB, the scope is the account.
- **Condition**, the signal, the logic, and the threshold that together decide when the rule fires.
- **Actions**, an action group naming who to notify and what to run.
- **Rule details**, the name, description, and severity.

The signal determines the type of rule, and Azure Cosmos DB supports three:

| Alert type | Signal | Use it for |
| :--- | :--- | :--- |
| Metric alert | A platform metric, evaluated at a regular interval | Throttling, latency, normalized request unit consumption, storage growth |
| Log alert | A Log Analytics query, evaluated on a schedule | Conditions that only appear in diagnostic logs, such as a logical partition key approaching its storage limit |
| Activity log alert | A control-plane event | Account keys rotated, a region added or taken offline, throughput changed |

Metric alerts are the ones you reach for most, because platform metrics are collected without configuration and evaluate in near real time. Log alerts require diagnostic settings to be enabled first, which the next unit covers.

## Alert on rate-limited requests

Rate limiting is the condition most worth alerting on for a Cosmos DB account, because it's the one that degrades user experience while the application still reports success. The signal is the **Total Requests** metric, filtered to the `StatusCode` dimension with a value of `429`.

Dimensions are what make this rule useful. Without one, the rule watches every request the account serves. With `StatusCode` set to `429`, it watches only the rate-limited ones. You can narrow further with `DatabaseName` and `CollectionName` when a single container matters more than the rest.

Create the action group first, because the alert rule references it:

```azurecli
$actionGroupId = az monitor action-group create `
    --name "dp420-oncall" `
    --resource-group $resourceGroup `
    --short-name "dp420" `
    --action email oncall you@contoso.com `
    --query id `
    --output tsv
```

Then create the rule against the account:

```azurecli
az monitor metrics alert create `
    --name "Rate limited requests" `
    --resource-group $resourceGroup `
    --scopes $accountId `
    --condition "count TotalRequests > 100 where StatusCode includes 429" `
    --window-size 5m `
    --evaluation-frequency 1m `
    --action $actionGroupId `
    --description "More than 100 rate-limited requests in five minutes."
```

Two settings in that command control how sensitive the rule is. **Window size** is the period each evaluation looks back over, and **evaluation frequency** is how often the evaluation runs. This rule counts rate-limited requests across the preceding five minutes, so a short burst of more than 100 requests can trigger it. A longer count window can include more requests. It doesn't require the condition to persist throughout the window or add a fixed notification delay.

The portal builds the same rule through **Monitor** > **Alerts** > **Create alert rule**, where the threshold is either static or dynamic. A **static** threshold is the fixed number the previous command sets. A **dynamic** threshold learns the metric's normal pattern and flags departures from it. Dynamic thresholds suit metrics with a daily or weekly rhythm, where a fixed number is either too noisy overnight or too permissive at peak. Static thresholds suit conditions where you already know the number that matters.

Whichever path you take, an alert rule becomes active within about 10 minutes of creation.

> [!TIP]
> The Azure Cosmos DB documentation also shows an alert using the **Total Request Units** metric. The two metrics measure different quantities: **Total Requests** with **Count** counts requests, while **Total Request Units** with **Total** sums their request charges. Use Total Requests for this rule's threshold of 100 rate-limited requests. A threshold of 100 request units isn't equivalent.

## Choose a threshold you can defend

The hardest part of an alert isn't building it. It's picking a number that fires when something is wrong and stays quiet when nothing is.

Start from the objectives you set in the previous unit. If 1 to 5 percent of requests returning 429 is healthy for your workload, then an alert on the first 429 fires constantly and gets muted within a week. A muted alert is worse than no alert, because it creates the impression of coverage without any.

Instead, size the threshold against the traffic you expect. A container serving 5,000 requests in five minutes has a healthy ceiling of roughly 250 rate-limited requests over that window, so a threshold of 500 catches a genuine departure while ignoring normal operation. Recalculate when your traffic profile changes materially, because a threshold tuned for last quarter's volume is a threshold tuned for the wrong system.

These conditions are worth a rule on most accounts:

| Condition | Type | Why it matters |
| :--- | :--- | :--- |
| Rate-limited requests above your calculated ceiling | Metric | The workload is exceeding provisioned throughput |
| Normalized request unit consumption sustained near 100 percent | Metric | Capacity headroom is gone before errors appear |
| Server-side latency above your objective | Metric | Degradation that leaves the error rate untouched |
| A logical partition key approaching 20 GB | Log | A partition key design problem that provisioning can't fix |
| Account keys rotated | Activity log | A credential change that breaks clients still holding the old key |
| A region added, removed, or taken offline | Activity log | A topology change with availability consequences |

The logical partition key rule is a log alert rather than a metric alert, because per-partition-key storage isn't a platform metric. It comes from the `PartitionKeyStatistics` diagnostic log category, which means enabling diagnostic settings is a prerequisite. It's also the rule that saves the most painful failure in this list. A logical partition's default limit is 20 GB. Remediation can include removing data that no longer needs to be retained or migrating to a container with a more suitable partition key. Hierarchical partition keys are one recommended option for distributing a large first-level key across multiple logical partitions.

Your alerting strategy now links service objectives to signals, thresholds, and action groups. In the next unit, diagnostic logs provide the request-level detail you need when an alert calls for investigation.
