Azure Container Apps manages automatic horizontal scaling through a set of declarative scaling rules. As a container app revision scales out, new instances of the revision are created on-demand. These instances are known as replicas.

Adding or editing scaling rules creates a new revision of your container app. A revision is an immutable snapshot of your container app.

## Scale definition

Scaling is defined by the combination of limits, rules, and behavior.

- Limits are the minimum and maximum possible number of replicas per revision as your container app scales.

    | Scale limit | Default value | Min value | Max value |
    | --- | --- | --- | --- |
    | Minimum number of replicas per revision | 0 | 0 | 300 |
    | Maximum number of replicas per revision | 10 | 1 | 300 |

    To request an increase in maximum replica amounts for your container app, submit a support ticket.

- Rules are the criteria used by Container Apps to decide when to add or remove replicas.

    Scale rules are implemented as HTTP, TCP, or custom.

- Behavior is how the rules and limits are combined together to determine scale decisions over time.

    Scale behavior explains how scale decisions are calculated.

As you define your scaling rules, keep in mind the following items:

- You aren't billed usage charges if your container app scales to zero.
- Replicas that aren't processing, but remain in memory might be billed at a lower "idle" rate. For more information, see Billing.
- If you want to ensure that an instance of your revision is always running, set the minimum number of replicas to 1 or higher.

## Scale rules

Scaling is driven by three different categories of triggers:

- HTTP: Based on the number of concurrent HTTP requests to your revision.
- TCP: Based on the number of concurrent TCP connections to your revision.
- Custom: Based on CPU, memory, or supported event-driven data sources such as:

    - Azure Service Bus
    - Azure Event Hubs
    - Apache Kafka
    - Redis

If you define more than one scale rule, the container app begins to scale once the first condition of any rules is met.

## HTTP

With an HTTP scaling rule, you have control over the threshold of concurrent HTTP requests that determines how your container app revision scales.

In the following example, the revision scales out up to five replicas and can scale in to zero. The scaling property is set to 100 concurrent requests per second.

### Configure an HTTP scale rule in the Azure portal

1. Open to your container app in the Azure portal.

1. On the lef-side menu, select **Scale**.

1. Select **Edit and deploy**.

1. Select the **Scale** tab.

1. Select the minimum and maximum replica range.

    ![Screenshot showing the Scale rule setting slider for the min and max replicas of a container app instance.](../media/azure-container-apps-scale-slide.png)

1. Select **Add**.

1. In the Rule name box, enter a rule name.

1. From the Type dropdown, select **HTTP Scaling**.

1. In the Concurrent requests box, enter your desired number of concurrent requests for your container app.

## TCP

With a TCP scaling rule, you have control over the threshold of concurrent TCP connections that determines how your app scales.

In the following example, the container app revision scales out up to five replicas and can scale in to zero. The scaling threshold is set to 100 concurrent connections per second.

### Configure a TCP scale rule using Azure CLI

Define a TCP scale rule using the `--scale-rule-tcp-concurrency` parameter in the `create` or `update` commands.

| CLI parameter | Description | Default value | Min value | Max value |
| --- | --- | --- | --- | --- |
| --scale-rule-tcp-concurrency | When the number of concurrent TCP connections exceeds this value, then another replica is added. Replicas will continue to be added up to the max-replicas amount as the number of concurrent connections increase. | 10 | 1 | n/a |

Here is an example of a `create` command that includes the `--scale-rule-tcp-concurrency` parameter:

```azurecli
az containerapp create \
  --name <CONTAINER_APP_NAME> \
  --resource-group <RESOURCE_GROUP> \
  --environment <ENVIRONMENT_NAME> \
  --image <CONTAINER_IMAGE_LOCATION>
  --min-replicas 0 \
  --max-replicas 5 \
  --scale-rule-name azure-tcp-rule \
  --scale-rule-type tcp \
  --scale-rule-tcp-concurrency 100
```

## Custom

You can create a custom Container Apps scaling rule based on any ScaledObject-based KEDA scaler with these defaults:

| Defaults | Seconds |
| --- | --- |
| Polling interval | 30 |
| Cool down period | 300 |

## Default scale rule

If you don't create a scale rule, the default scale rule is applied to your container app.

| Trigger | Min replicas | Max replicas |
| --- | --- | --- |
| HTTP | 0 | 10 |

> [!IMPORTANT]
> Make sure you create a scale rule or set minReplicas to 1 or more if you don't enable ingress. If ingress is disabled and you don't define a minReplicas or a custom scale rule, then your container app will scale to zero and have no way of starting back up.

## Scale behavior

Scaling behavior has the following defaults:

| Parameter | Value |
| --- | --- |
| Polling interval | 30 seconds |
| Cool down period | 300 seconds |
| Scale up stabilization window | 0 seconds |
| Scale down stabilization window | 300 seconds |
| Scale up step | 1, 4, 100% of current |
| Scale down step | 100% of current |
| Scaling algorithm | desiredReplicas = ceil(currentMetricValue / targetMetricValue) |

- Polling interval is how frequently event sources are queried by KEDA. This value doesn't apply to HTTP and TCP scale rules.
- Cool down period is how long after the last event was observed before the application scales down to its minimum replica count.
- Scale up stabilization window is how long to wait before performing a scale up decision once scale up conditions were met.
- Scale down stabilization window is how long to wait before performing a scale down decision once scale down conditions were met.
- Scale up step is the rate new instances are added at. It starts with 1, 4, 8, 16, 32, ... up to the configured maximum replica count.
- Scale down step is the rate at which replicas are removed. By default 100% of replicas that need to shut down are removed.
- Scaling algorithm is the formula used to calculate the current desired number of replicas.
