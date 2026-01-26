Event-driven scaling enables your container apps to respond to external signals beyond HTTP traffic. Azure Container Apps integrates with KEDA (Kubernetes Event-driven Autoscaling) to provide scaling based on message queues, event streams, and other Azure services. This capability is essential for applications that process asynchronous workloads where scaling based on request volume alone does not reflect actual work being performed.

## Understand KEDA integration

Azure Container Apps uses KEDA to provide event-driven scaling beyond the built-in HTTP and TCP triggers. KEDA monitors external event sources and adjusts replica counts based on metrics like queue depth, partition lag, or custom metrics. The platform translates KEDA scaler configurations into Container Apps scale rules, handling the integration transparently.

Custom scalers in Container Apps follow the KEDA ScaledObject specification pattern. You specify the scaler type, metadata parameters that configure the connection and thresholds, and authentication settings. The platform polls the event source at 30-second intervals and calculates the desired replica count based on current metric values.

Microsoft maintains several Azure-native scalers with first-party support: Azure Service Bus, Azure Event Hubs, Azure Storage Queue, Azure Blob Storage, Azure Log Analytics, and Azure Monitor. These scalers receive regular updates and benefit from direct integration with Azure services. Community-maintained scalers are also available for non-Azure event sources.

Event-driven scaling supports scale-to-zero, making it ideal for background processing workloads. When no messages exist in a queue or no events are pending, your application can scale down to zero replicas. New messages or events trigger automatic scale-up, and the platform creates replicas to process the workload.

## Configure Azure Service Bus scaling

Azure Service Bus scaling triggers replica changes based on message count in queues or topic subscriptions. The scaler monitors the active message count and calculates the desired replica count by dividing the current message count by your configured threshold. This approach ensures your application has enough replicas to process the backlog within an acceptable timeframe.

The key metadata parameters for Service Bus scaling include `queueName` or `topicName` and `subscriptionName` (for topic subscriptions), `namespace`, and `messageCount`. The `messageCount` parameter sets the threshold that triggers scaling. For example, if you set `messageCount` to 5 and 50 messages are in the queue, the scaler requests 10 replicas.

The following command creates a container app that scales based on an Azure Service Bus queue. The application starts with zero replicas and scales up to 30 replicas as messages accumulate:

```azurecli
az containerapp create \
  --name order-processor \
  --resource-group rg-ecommerce \
  --environment my-environment \
  --image myregistry.azurecr.io/order-processor:v1 \
  --min-replicas 0 \
  --max-replicas 30 \
  --secrets "sb-connection=<SERVICE_BUS_CONNECTION_STRING>" \
  --scale-rule-name servicebus-scaling \
  --scale-rule-type azure-servicebus \
  --scale-rule-metadata "queueName=orders" \
                        "namespace=sb-ecommerce" \
                        "messageCount=5" \
  --scale-rule-auth "connection=sb-connection"
```

When using topic subscriptions instead of queues, replace `queueName` with `topicName` and add `subscriptionName` to specify which subscription to monitor. Each subscription maintains its own message count, so different consumer applications can scale independently based on their specific backlogs.

## Configure Azure Storage Queue scaling

Azure Storage Queue scaling provides a simpler alternative to Service Bus for basic queue-based workloads. The scaler monitors the approximate message count in a Storage Queue and adjusts replicas based on your configured threshold. Storage Queues offer lower cost than Service Bus but have fewer features and lower throughput limits.

The metadata parameters for Storage Queue scaling include `queueName`, `accountName`, and `queueLength`. The `queueLength` parameter functions similarly to `messageCount` in Service Bus scaling, defining the number of messages per replica that triggers scaling. You authenticate using either a connection string stored as a secret or a managed identity with appropriate permissions.

Choose Storage Queue scaling for straightforward queue processing scenarios where you don't need advanced features like sessions, dead-letter queues, or scheduled messages. For applications requiring these capabilities or higher throughput, use Service Bus instead.

## Configure Azure Event Hubs scaling

Azure Event Hubs scaling is designed for high-throughput streaming scenarios where events are processed in partitions. The scaler monitors the lag between the latest event in each partition and the checkpoint position of your consumer group. When unprocessed events accumulate, the scaler increases replica count to catch up with the event stream.

The metadata parameters for Event Hubs scaling include `consumerGroup`, `unprocessedEventThreshold`, and `checkpointStrategy`. The `unprocessedEventThreshold` sets the number of unprocessed events per partition that triggers scaling. The `checkpointStrategy` specifies how the scaler determines checkpoint positions, with `blobMetadata` being the recommended approach for applications using Azure Blob Storage for checkpointing.

Event Hubs partitions affect the maximum effective replica count. Since each partition can only be read by one consumer at a time within a consumer group, your application cannot benefit from more replicas than partitions. If your Event Hub has 32 partitions, setting `maxReplicas` higher than 32 provides no additional scaling benefit.

The following YAML configuration demonstrates Event Hubs scaling with checkpoint-based lag monitoring:

```yaml
# Code fragment - focus on Event Hubs scaler configuration
scale:
  minReplicas: 0
  maxReplicas: 32
  rules:
    - name: eventhubs-scaling
      custom:
        type: azure-eventhub
        metadata:
          consumerGroup: "$Default"
          unprocessedEventThreshold: "64"
          checkpointStrategy: "blobMetadata"
        auth:
          - secretRef: eh-connection
            triggerParameter: connection
```

## Authenticate scale rules

Custom scalers require authentication to access the event sources they monitor. Azure Container Apps supports two authentication methods: secrets-based authentication using connection strings or keys, and managed identity for passwordless authentication.

Secrets-based authentication stores connection strings or access keys as Container Apps secrets. You reference these secrets in the `--scale-rule-auth` parameter, mapping the secret name to the authentication parameter expected by the scaler. This approach works for all scenarios but requires managing and rotating secrets manually.

Managed identity authentication eliminates the need to store connection strings in your application. You assign a user-assigned managed identity to your container app and grant it appropriate permissions on the target resource (such as Azure Service Bus Data Receiver role for Service Bus). The scaler uses this identity to authenticate directly, improving security posture and simplifying credential management.

The following command creates a container app that uses managed identity to authenticate with Azure Storage Queue. No connection string secrets are required:

```azurecli
az containerapp create \
  --name queue-processor \
  --resource-group rg-ecommerce \
  --environment my-environment \
  --image myregistry.azurecr.io/queue-processor:v1 \
  --user-assigned <MANAGED_IDENTITY_RESOURCE_ID> \
  --min-replicas 0 \
  --max-replicas 20 \
  --scale-rule-name storage-queue-scaling \
  --scale-rule-type azure-queue \
  --scale-rule-metadata "accountName=stecommerce" \
                        "queueName=inventory-updates" \
                        "queueLength=10" \
  --scale-rule-identity <MANAGED_IDENTITY_RESOURCE_ID>
```

For production workloads, prefer managed identity authentication when the scaler supports it. Managed identity eliminates secret rotation requirements, reduces the risk of credential exposure, and aligns with Azure security best practices for service-to-service authentication.

## Best practices

- **Use managed identity for authentication:** Managed identity eliminates secret management overhead and improves security posture for production deployments. Assign the minimum required permissions to your identity using Azure RBAC.

- **Set message thresholds based on processing time:** If each message takes 10 seconds to process and you want 100 messages processed per minute, you need 10 replicas processing concurrently. Set your `messageCount` threshold to achieve the desired parallelism without over-provisioning.

- **Scale to zero for event-driven workloads:** Message queue processors are ideal candidates for scale-to-zero configurations since new messages trigger scale-up automatically. This approach minimizes costs during idle periods while ensuring processing capacity scales with demand.

- **Monitor queue depth alongside replica count:** Use Azure Monitor to correlate queue depth with replica scaling. If queue depth grows faster than replicas scale, consider lowering your message threshold. If replicas frequently sit idle, raise the threshold to improve efficiency.

## Additional resources

- [KEDA scalers documentation](https://keda.sh/docs/scalers/)
- [Azure Service Bus scaler](https://keda.sh/docs/scalers/azure-service-bus/)
- [Manage secrets in Azure Container Apps](/azure/container-apps/manage-secrets)
