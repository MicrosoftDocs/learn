Resource allocation decisions in Azure Container Apps affect both application performance and operating costs. Each container app replica consumes CPU and memory resources, and the combination of per-replica resources and replica count determines your total capacity and cost. Understanding how to configure these resources helps you build applications that meet performance requirements without overspending.

## Understand resource allocation

Azure Container Apps allocates CPU and memory resources per container. You specify CPU in cores (or fractions of cores) and memory in gibibytes (GiB). Each replica of your container app receives the configured resources, and the platform enforces these limits to prevent resource contention between applications in the same environment.

The relationship between CPU and memory follows a constraint: memory must be at least twice the CPU value in GiB. For example, if you allocate 0.5 CPU cores, you must allocate at least 1.0 GiB of memory. This constraint reflects the typical resource balance needed for containerized workloads and simplifies capacity planning.

Resource allocation affects billing directly. Container Apps charges based on vCPU-seconds and GiB-seconds consumed. Larger resource allocations per replica increase per-replica costs, but might reduce the total replica count needed to handle your workload. Finding the right balance requires understanding your application's actual resource requirements under load.

When a replica exceeds its memory limit, the platform terminates and restarts that replica. CPU limits work differently; when a replica exceeds its CPU allocation, the platform throttles the replica rather than terminating it. This difference means memory limits cause hard failures while CPU limits cause performance degradation.

## Configure container resources

You configure CPU and memory for containers using the `--cpu` and `--memory` parameters when creating or updating a container app. The default allocation is 0.25 cores and 0.5 GiB memory per container, which suits lightweight applications with modest resource requirements. Maximum values depend on your environment type and workload profile selection.

In the Consumption plan, the maximum allocation per container is 4 cores and 8 GiB memory. These limits apply per container, not per replica. If your container app includes multiple containers (such as a main application container and a sidecar), each container has its own resource allocation that counts against the environment limits.

The following command creates a container app with custom resource allocation. This configuration provides 0.5 cores and 1.0 GiB memory to each replica:

```azurecli
az containerapp create \
  --name order-api \
  --resource-group rg-ecommerce \
  --environment my-environment \
  --image myregistry.azurecr.io/order-api:v1 \
  --cpu 0.5 \
  --memory 1.0Gi \
  --min-replicas 2 \
  --max-replicas 20
```

Total capacity equals per-replica resources multiplied by replica count. In this example, with 20 maximum replicas at 0.5 cores each, the application can scale up to 10 total cores of processing capacity. Plan your maximum replica count and per-replica resources to handle peak load requirements.

## Choose workload profiles

Azure Container Apps environments support two types: Consumption-only and Workload profiles. Your environment type determines the compute options available to your container apps and affects both performance characteristics and billing models.

Consumption-only environments use a serverless billing model where you pay only for the resources your replicas consume while running. The platform handles all infrastructure provisioning, and your applications share compute resources with other tenants. This model works well for variable workloads where demand fluctuates significantly and scale-to-zero provides meaningful cost savings.

Workload profile environments offer additional compute options. The Consumption profile within a Workload profiles environment provides the same serverless billing as Consumption-only environments. Dedicated profiles provision specific VM sizes reserved for your workloads, providing consistent performance and supporting larger resource allocations. Dedicated profiles are required for GPU workloads and scenarios requiring more than 4 cores or 8 GiB memory per container.

For most web APIs and background processing applications, the Consumption plan provides cost efficiency without requiring capacity planning. Choose Dedicated profiles when you need consistent latency (serverless might have higher variability), require GPU compute, need larger resource allocations, or have compliance requirements that mandate dedicated infrastructure.

## Optimize for cost efficiency

Cost optimization starts with understanding what you're paying for. Container Apps bills for active replicas based on their resource allocation. Replicas that are running but not processing requests incur an idle rate that's lower than the active rate. When replicas scale to zero, you incur no compute charges for that container app.

Scale-to-zero is the most effective cost optimization for intermittent workloads. If your application experiences extended idle periods where no requests or messages arrive, configuring zero minimum replicas eliminates cost during those periods. Combine scale-to-zero with event-driven triggers that reliably restart replicas when work arrives.

Right-sizing container resources based on actual utilization prevents over-provisioning. Start with default allocations (0.25 cores, 0.5 GiB memory) and monitor actual CPU and memory usage during representative workloads. Increase allocations only when you observe throttling, out-of-memory errors, or performance degradation that correlates with resource constraints.

The Consumption plan is typically more cost-efficient for variable traffic patterns than Dedicated profiles. You pay only for what you use, and the platform handles scaling without requiring you to maintain baseline capacity. Dedicated profiles make sense when consistent utilization justifies reserved capacity or when your workload characteristics require dedicated infrastructure.

## Optimize for performance

Performance optimization focuses on ensuring your application has sufficient resources to meet response time and throughput requirements. Under-provisioned applications exhibit increased latency, request timeouts, and degraded user experience during peak load.

Allocate sufficient CPU and memory to handle request processing without throttling. If your application performs CPU-intensive work like JSON serialization, image processing, or complex calculations, allocate more CPU cores. Memory-intensive applications that maintain caches, process large payloads, or aggregate data benefit from larger memory allocations.

Set minimum replicas to eliminate cold start latency for latency-sensitive workloads. When a container app scales from zero, the first request experiences a delay while the platform provisions and starts a replica. For applications where this delay is unacceptable, maintain at least one replica to ensure immediate availability.

Dedicated workload profiles provide more consistent performance than Consumption because resources aren't shared with other tenants. If your application has strict latency requirements or experiences performance variability under the Consumption model, Dedicated profiles might provide the consistency you need.

Monitor resource utilization to identify bottlenecks before they affect users. Azure Monitor provides metrics for CPU and memory utilization across your replicas. Watch for sustained high utilization that indicates resource pressure, or low utilization that suggests over-provisioning.

## Balance scaling limits with resources

The relationship between per-replica resources, maximum replica count, and total capacity requires careful planning. Your scaling configuration determines both peak capacity and cost ceiling for your application.

Total capacity equals per-replica resources multiplied by maximum replica count. If each replica can handle 100 requests per second with 0.5 cores, and you expect peak load of 2000 requests per second, you need 20 replicas maximum. Setting `--max-replicas 20` with `--cpu 0.5` provides this capacity.

There's a trade-off between replica size and scaling granularity. Larger replicas (more CPU and memory each) mean fewer replicas are needed for the same total capacity, which reduces scaling frequency and overhead. However, larger replicas provide coarser granularity; you might provision more capacity than needed between scaling steps. Smaller replicas scale more precisely but incur more scaling events and management overhead.

The maximum replica count in Azure Container Apps is 1000 per revision. For most applications, you hit practical limits based on your workload characteristics before reaching this limit. Ensure your per-replica resources and maximum count together provide sufficient peak capacity for your requirements.

## Best practices

- **Start with default resources and scale:** Begin with 0.25 cores and 0.5 GiB memory, then increase based on observed utilization and performance metrics. Avoid pre-optimizing before you have data about actual resource consumption.

- **Use Consumption plan for most workloads:** The pay-per-use model provides cost efficiency for variable traffic patterns without requiring capacity planning. Reserve Dedicated profiles for workloads that genuinely require dedicated infrastructure or larger resource allocations.

- **Monitor actual resource utilization:** Use Azure Monitor to track CPU and memory usage over time. Over-provisioned containers waste money; under-provisioned containers cause performance problems. Regular monitoring helps you tune resource allocation to actual needs.

- **Consider total cost of scaling:** Smaller containers that scale more frequently might incur more scaling overhead and potential request impact during scale operations. Balance per-replica size against scaling responsiveness and your application's ability to handle replica additions and removals gracefully.

## Additional resources

- [Billing in Azure Container Apps](/azure/container-apps/billing)
- [Workload profiles in Azure Container Apps](/azure/container-apps/workload-profiles-overview)
