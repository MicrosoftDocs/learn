The final configuration lever manages data over its lifetime. Much of the data an application stores loses value after a fixed window. Examples include session records, event logs, cached results, or Contoso's older records that no longer serve the workload. If the data is left in place, that data grows storage cost and forces you to write cleanup jobs. Time to live (TTL) expires data automatically, turning retention into a setting instead of a maintenance task.

## How time to live works

TTL defines how long an item lives, measured in seconds from its last modification. When an item's TTL elapses, Azure Cosmos DB purges it automatically as a background task. On a provisioned throughput account, this task uses leftover request units, so it never competes with the application's requests. On a serverless account, the deletions cost the same as regular delete operations. Either way, expiration reduces storage cost and removes the need for manual deletion logic, without the need to schedule anything.

Expiration takes effect for readers the moment the TTL elapses. An expired item stops appearing in query responses immediately, even before the background task deletes it. Your application code never needs to filter out expired data. When a container runs short of request units, only the physical deletion is delayed.

You configure TTL at the container level through the container's `DefaultTimeToLive` property. That property behaves in three ways:

| `DefaultTimeToLive` value | Behavior |
| :--- | :--- |
| Not set, or `null` | TTL is disabled. Items never expire. |
| `-1` | TTL is enabled, but items don't expire by default. |
| A positive integer *n* | Items expire *n* seconds after they were last modified. The maximum is 2,147,483,647 seconds, about 68 years. |

The distinction between "not set" and `-1` matters: setting `-1` turns on the TTL *mechanism* without expiring everything, which is what lets individual items opt in to expiration.

TTL also depends on indexing. You can't enable TTL on a container whose indexing mode is `none`, and you can't switch a container to that indexing mode while TTL is active.

:::image type="content" source="../media/time-to-live-item-lifecycle.png" alt-text="Diagram showing each item modification resetting time to live, expiration removing the item from queries, and background deletion.":::

## Override retention per item

When TTL is enabled on the container (set to either a positive value or `-1`), an individual item can override the container default through its own `ttl` property. This property lets one container hold data with different lifetimes: a default retention for most items, a longer, or shorter one for specific items, or no expiry at all.

The interaction between the two settings follows a clear rule: the item's `ttl` wins whenever the container has TTL enabled:

| Container `DefaultTimeToLive` | Item `ttl` | Result |
| :--- | :--- | :--- |
| `1000` | *not set* | Expires in 1,000 seconds |
| `1000` | `2000` | Expires in 2,000 seconds (item overrides) |
| `1000` | `-1` | Never expires (item overrides) |
| `-1` | `2000` | Expires in 2,000 seconds (only this item expires) |
| *not set* | `2000` | Never expires. TTL is disabled at the container level |

The last row is the common pitfall: an item's `ttl` has no effect unless the container enables TTL first. If you set per-item expiration and see nothing expire, check the container's `DefaultTimeToLive`.

The two properties treat `null` differently. On the container, `null` is valid and turns off TTL. On an item, `null` isn't supported: the value must be a positive integer up to 2,147,483,647, or `-1`. To put an item back on the container default, remove the `ttl` property rather than setting it to `null`.

## Configure container TTL

In the Azure portal, you enable TTL from the container's **Scale and Settings** page by setting **Time to Live** to **On (no default)**, equivalent to `-1`, or **On** with a default number of seconds. You set the same value when you create or update a container in code or with the Azure CLI. It appears as `DefaultTimeToLive` in the .NET SDK, `default_ttl` in the Python SDK, and `--ttl` in the CLI.

> [!NOTE]
> TTL deletions don't appear in the change feed by default. To capture them, read the change feed in all versions and deletes mode. This mode reports the deletion when the item is physically purged, not when it logically expires. Downstream systems that sync or audit from the change feed need this mode to see expired data disappear. A later module discusses change feed modes in more detail.

This unit covers container-level TTL as a cost and lifecycle control. Fine-grained, per-item TTL for concurrency and data-lifecycle patterns in application code builds on the same properties and is covered later when you work with item operations in the SDK.

> [!div class="alert is-primary"]
> **Guiding question:** Think of a data type your applications store that stops being useful after a set time, such as a password-reset token, a temporary export, or a daily rollup. What TTL would you set on its container, and would any items in it need a per-item override? Connect your answer to the storage cost you'd avoid.


