Resource sizing and scaling determine whether an AI service stays responsive and whether it stays within budget. Underprovisioned CPU can cause throttling and latency spikes, while underprovisioned memory can lead to restarts and repeated cold starts. In Azure Container Apps, you tune per-replica resources and scaling limits together so you can meet throughput goals without overpaying.

> [!NOTE]
> Resource and scaling options depend on your environment configuration and your workload type. Use these examples as patterns, and validate constraints and defaults in the current Azure Container Apps documentation.

## Understand the relationship between per-replica sizing and total cost

Container Apps scales by adding and removing replicas. Per-replica CPU and memory settings affect how much work each replica can perform, and they also affect the cost of each replica. Total cost is therefore a combination of per-replica sizing and the number of replicas required to handle peak load.

For AI APIs, you should measure latency under concurrency and watch for CPU throttling. For background workers, you should measure throughput and watch for memory pressure that causes restarts. These measurements help you pick a resource profile that matches your runtime behavior.

## Update CPU and memory settings

The following example updates CPU and memory for an app. After you apply a change, validate whether latency improves and whether the revision becomes stable under load.

```azurecli
az containerapp update \
  --name <app-name> \
  --resource-group <resource-group> \
  --cpu <cores> \
  --memory <size>
```

## Tune scaling for a synchronous API versus a background worker

Scaling strategies differ by workload. A synchronous API often needs stable readiness and predictable latency, so you might choose a minimum replica count to reduce cold starts. A background worker can often tolerate scale-to-zero if it's event-driven and can drain work safely when replicas scale down.

When you adjust scaling, consider the implications for revision rollouts. A rollout that creates a new revision might start new replicas, and if your service has slow warmup, those new replicas can stay unready for longer. Align scaling configuration with probe configuration so rollouts don't appear to fail simply because warmup takes time.

## Best practices for cost and performance

Optimization is iterative. You use logs and metrics to identify bottlenecks, then you change one variable at a time.
This approach reduces the risk of masking the root cause and makes it easier to understand which change improved throughput or latency.

- **Size for the bottleneck:** Increase CPU when you see throttling, and increase memory when you see out-of-memory restarts.
- **Align concurrency with CPU:** If your API uses high concurrency, validate that the per-replica CPU can support it without latency spikes.
- **Use minimum replicas intentionally:** Minimum replicas reduce cold starts, but they also increase baseline cost.
- **Reassess after model changes:** Model versions can change startup time, memory usage, and request latency.

## Additional resources

Use these resources to learn how scaling behaves in Container Apps and which settings influence replica counts. They also help you validate defaults and constraints for CPU, memory, and scaling policies.

- [Azure Container Apps scale applications](/azure/container-apps/scale-app)
- [Azure Container Apps manage applications](/azure/container-apps/manage)
