Azure Container Apps supports a broad range of KEDA scalers beyond Azure-native services. These scalers enable event-driven scaling based on Apache Kafka consumer lag, Redis queue depth, Prometheus metrics, scheduled time windows, and many other event sources. Understanding how to configure these scalers expands your options for building applications that respond to diverse workload signals.

## Explore available KEDA scalers

Azure Container Apps supports any ScaledObject-based KEDA scaler, providing access to dozens of event sources. Beyond the Azure-native scalers covered in the previous unit, commonly used scalers include Apache Kafka, Redis Lists, Redis Streams, Prometheus, Cron, PostgreSQL, MySQL, MongoDB, and external metrics APIs. Each scaler monitors a specific event source and reports metrics that drive scaling decisions.

When evaluating whether a specific scaler meets your requirements, consider the authentication methods it supports, the metrics it exposes, and how those metrics translate to replica counts. Review the [KEDA scalers documentation](https://keda.sh/docs/scalers/) for detailed specifications of each scaler, including required and optional metadata parameters, supported authentication mechanisms, and example configurations.

Scalers are categorized by their maintainer. Microsoft maintains Azure-native scalers with direct support. Community-maintained scalers receive contributions from the open-source community and may have varying levels of documentation and support. External scalers run as separate components and require additional deployment steps not covered by the built-in Container Apps configuration.

## Configure Apache Kafka scaling

Apache Kafka scaling triggers replica changes based on consumer group lag. The scaler monitors the difference between the latest offset in each partition and the committed offset of your consumer group. When lag accumulates, the scaler increases replica count to process messages faster and reduce the backlog.

The key metadata parameters for Kafka scaling include `bootstrapServers`, `consumerGroup`, `topic`, and `lagThreshold`. The `lagThreshold` parameter sets the lag per partition that triggers scaling. For example, if you set `lagThreshold` to 100 and your consumer group has 500 messages of lag across partitions, the scaler calculates that 5 replicas are needed.

Kafka authentication typically uses SASL mechanisms. You configure credentials as Container Apps secrets and reference them in the scaler authentication settings. The scaler supports SASL/PLAIN, SASL/SCRAM, and TLS authentication depending on your Kafka cluster configuration.

The following YAML configuration demonstrates Kafka scaling for an order processing application. The scaler monitors the `orders` topic and scales when consumer lag exceeds 100 messages per partition:

```yaml
# Code fragment - focus on Kafka scaler configuration
scale:
  minReplicas: 1
  maxReplicas: 50
  rules:
    - name: kafka-scaling
      custom:
        type: kafka
        metadata:
          bootstrapServers: "kafka-broker:9092"
          consumerGroup: "order-consumers"
          topic: "orders"
          lagThreshold: "100"
        auth:
          - secretRef: kafka-credentials
            triggerParameter: sasl
```

Like Event Hubs, Kafka partition count affects maximum effective scaling. Each partition can have only one active consumer per consumer group, so replica count above your partition count provides no benefit. Plan your partition count based on expected maximum parallelism requirements.

## Configure Redis scaling

Redis scaling supports workloads that use Redis Lists or Streams as task queues. The scaler monitors queue depth and adjusts replicas based on pending work. Two distinct scaler types exist: Redis Lists scalers monitor the length of a list, while Redis Streams scalers monitor pending entries in a consumer group.

Redis Lists scaling is straightforward. The scaler queries the list length using `LLEN` and compares it to your configured threshold. This approach works well for simple producer-consumer patterns where items are pushed to a list and popped by workers. The metadata parameters include `address`, `listName`, and `listLength` (the threshold).

Redis Streams scaling provides more sophisticated monitoring for applications using the Streams data type. The scaler tracks pending entries for a specific consumer group, accounting for messages that have been delivered but not yet acknowledged. This approach handles failure scenarios better than list length because it considers work in progress, not just queued work.

Container Apps supports scalers for standard Redis deployments, Redis Cluster topologies, and Redis Sentinel configurations. Choose the appropriate scaler variant based on your Redis deployment architecture. Each variant has specific connection string formats and authentication requirements.

## Configure cron-based scaling

Cron scaling enables scheduled scaling based on time rather than metrics. The scaler activates during specified time windows and requests a fixed number of replicas. Outside these windows, the scaler is inactive and doesn't influence replica count. This approach is useful for predictable traffic patterns where you want to pre-scale capacity before expected load increases.

The metadata parameters for cron scaling include `timezone`, `start`, `end`, and `desiredReplicas`. The `start` and `end` parameters use cron expression format to define when the scale window begins and ends. The `desiredReplicas` parameter specifies how many replicas the scaler requests during the active window.

Cron scaling is most effective when combined with other scalers. Configure a cron scaler to establish baseline capacity during expected peak hours, and add HTTP or event-driven scalers to handle unexpected load spikes. When multiple scalers are active, Container Apps uses the highest replica count among them.

The following YAML configuration demonstrates cron scaling combined with HTTP scaling. The cron scaler maintains five replicas during business hours (8 AM to 6 PM, Monday through Friday, Eastern time), while HTTP scaling handles variations in request volume:

```yaml
# Code fragment - focus on cron scaler configuration
scale:
  minReplicas: 0
  maxReplicas: 20
  rules:
    - name: business-hours
      custom:
        type: cron
        metadata:
          timezone: "America/New_York"
          start: "0 8 * * 1-5"
          end: "0 18 * * 1-5"
          desiredReplicas: "5"
    - name: http-scaling
      http:
        metadata:
          concurrentRequests: "50"
```

Outside business hours, if no HTTP requests arrive, the application can scale to zero. During business hours, at least five replicas run regardless of HTTP traffic, providing immediate capacity when requests arrive.

## Configure Prometheus metrics scaling

Prometheus scaling triggers replica changes based on custom metrics exposed by your application or infrastructure. The scaler queries a Prometheus server and evaluates the result against your configured threshold. This approach enables scaling based on application-specific business metrics, SLO indicators, or any metric available in your Prometheus deployment.

The metadata parameters for Prometheus scaling include `serverAddress`, `metricName`, `query`, and `threshold`. The `query` parameter accepts a PromQL expression that returns a numeric value. The scaler divides this value by the threshold to determine desired replica count.

Custom metrics scaling is appropriate when standard metrics like HTTP concurrency or queue depth don't accurately reflect your application's workload. For example, you might scale based on active user sessions, pending transactions, or custom business indicators that correlate with resource requirements.

## Convert KEDA specifications to Container Apps rules

When migrating from Kubernetes with KEDA or adapting example configurations from KEDA documentation, you need to convert KEDA ScaledObject specifications to Container Apps scale rules. The process involves extracting key values from the KEDA format and mapping them to Container Apps CLI parameters or YAML properties.

Follow these steps to convert a KEDA scaler specification:

1. Identify the scaler type from the KEDA `triggers[].type` field. Use this value as the `--scale-rule-type` parameter or the `type` field under `custom` in YAML.

1. Extract metadata values from the KEDA `triggers[].metadata` section. Convert these to key-value pairs for `--scale-rule-metadata` or the `metadata` object in YAML.

1. Map authentication parameters from the KEDA `TriggerAuthentication` object. Create Container Apps secrets for credentials and reference them in `--scale-rule-auth` or the `auth` array in YAML. Alternatively, use managed identity with `--scale-rule-identity` if the scaler supports it.

1. Configure scale limits using `--min-replicas` and `--max-replicas`. These correspond to the `minReplicaCount` and `maxReplicaCount` in KEDA ScaledObject specifications.

The Container Apps format differs from native KEDA in several ways. Container Apps doesn't support the full TriggerAuthentication resource type; instead, you reference secrets directly in the scale rule. Some advanced KEDA features like external scalers or custom scaling intervals may not be available or may require different configuration approaches.

## Best practices

- **Start with Azure-native scalers:** Azure Service Bus, Event Hubs, and Storage Queue scalers have first-party support and are maintained by Microsoft. Use these for Azure resources before considering community-maintained alternatives.

- **Test scaler behavior in staging:** Custom scalers may have unexpected polling or threshold behaviors. Validate scaling patterns in a non-production environment before deploying to production. Monitor how quickly scaling responds to load changes and verify that thresholds produce the expected replica counts.

- **Combine scheduled and reactive scaling:** Use cron scalers to establish baseline capacity before known peak periods. Add event-driven or HTTP scalers to handle variations and unexpected spikes. This combination ensures capacity is available when needed while still responding to actual demand.

- **Document scaler configurations:** Custom scaler metadata is not self-documenting. Maintain documentation that explains why specific thresholds were chosen, how authentication is configured, and what metrics drive scaling decisions. This documentation helps team members understand and maintain scaling configurations over time.

## Additional resources

- [KEDA scalers catalog](https://keda.sh/docs/scalers/)
- [Apache Kafka scaler](https://keda.sh/docs/scalers/apache-kafka/)
- [Cron scaler](https://keda.sh/docs/scalers/cron/)
