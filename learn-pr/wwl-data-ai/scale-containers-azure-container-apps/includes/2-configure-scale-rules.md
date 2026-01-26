Azure Container Apps uses declarative scale rules to manage automatic horizontal scaling. You define the conditions that trigger scaling, and the platform handles creating and removing replicas to match demand. Understanding how to configure these rules is essential for building applications that respond efficiently to traffic patterns while controlling costs.

## Understand scale definitions

Scale definitions in Azure Container Apps consist of three components: limits, rules, and behavior. Limits define the minimum and maximum number of replicas allowed for your container app. Rules specify the triggers that determine when scaling occurs. Behavior describes how the platform makes scaling decisions over time, including timing parameters and algorithms.

Azure Container Apps is powered by [KEDA (Kubernetes Event-driven Autoscaling)](https://keda.sh/), which provides the underlying scaling infrastructure. When you configure scale rules, the platform translates your settings into KEDA specifications that monitor your defined triggers and adjust replica counts accordingly. Each replica is an instance of your container app that runs independently and can handle requests.

The default scale behavior creates up to 10 replicas with a minimum of zero when ingress is enabled and no custom rules are defined. If ingress is disabled and you don't specify a minimum replica count or custom scale rule, your container app scales to zero and cannot restart because there is no trigger to activate it. You can configure the minimum to one or more replicas to ensure your application remains available without waiting for scale-up.

Billing in Azure Container Apps depends on replica count. When your application scales to zero, you incur no compute charges. Replicas that are running but not actively processing requests are billed at a lower idle rate. Setting a minimum replica count of one or more ensures availability but increases costs compared to scale-to-zero configurations.

## Configure HTTP scale rules

HTTP scaling adjusts replica count based on concurrent HTTP requests to your container app. The platform calculates concurrent requests by counting the number of requests received in the past 15 seconds and dividing by 15. When this value exceeds your configured threshold, the platform creates additional replicas to handle the load.

The default HTTP concurrency threshold is 10 requests per replica. You can adjust this value based on your application's capacity and response time requirements. Lower thresholds trigger scaling earlier, providing more headroom but potentially creating more replicas than necessary. Higher thresholds maximize utilization of each replica but may cause latency increases before new replicas are available.

HTTP scaling is appropriate for synchronous API workloads and web applications where request volume directly correlates with resource needs. This scaling type supports scale-to-zero, meaning your application can have zero replicas when no requests arrive and automatically start replicas when traffic resumes. Container Apps jobs cannot use HTTP scaling rules because jobs do not expose HTTP endpoints.

The following command creates a container app with an HTTP scale rule that triggers scaling when concurrent requests exceed 50 per replica:

```azurecli
az containerapp create \
  --name order-api \
  --resource-group rg-ecommerce \
  --environment my-environment \
  --image myregistry.azurecr.io/order-api:v1 \
  --min-replicas 1 \
  --max-replicas 10 \
  --scale-rule-name http-scaling \
  --scale-rule-type http \
  --scale-rule-http-concurrency 50
```

## Configure TCP scale rules

TCP scaling adjusts replica count based on concurrent TCP connections to your container app. This scaling type is designed for applications that maintain persistent connections rather than short-lived HTTP request-response cycles. The platform counts active TCP connections and scales when the connection count exceeds your configured threshold.

TCP scaling is preferable to HTTP scaling for WebSocket servers, gRPC services, and applications that use database connection pools or other long-lived connections. The platform calculates concurrent connections using the same 15-second averaging window as HTTP scaling. You configure TCP scaling using the `--scale-rule-tcp-concurrency` parameter when creating or updating your container app.

Like HTTP scaling, TCP scaling supports scale-to-zero. When all TCP connections close, the platform can scale your application down to zero replicas after the cool-down period. New incoming connections trigger scale-up automatically.

## Configure CPU and memory scale rules

CPU and memory scaling adjust replica count based on resource utilization across your container app replicas. These rules are implemented as KEDA custom scalers and trigger scaling when average utilization exceeds your configured percentage threshold. CPU scaling monitors processor utilization, while memory scaling monitors memory consumption.

Resource-based scaling has a critical limitation: CPU and memory rules cannot scale your application to zero. The platform requires at least one running replica to measure utilization, so these scaling types always maintain a minimum of one replica regardless of your configured minimum. If you need scale-to-zero capability, combine resource scaling with HTTP or event-driven rules, or use HTTP scaling as your primary trigger.

CPU scaling is appropriate for compute-intensive workloads such as image processing, video transcoding, or machine learning inference where processor utilization directly indicates capacity needs. Memory scaling suits applications with memory-intensive operations like caching, data aggregation, or processing large datasets where memory consumption reflects workload intensity.

The following YAML configuration demonstrates combining HTTP and CPU scale rules. The application scales when either HTTP concurrency exceeds 100 requests or CPU utilization exceeds 70 percent:

```yaml
# Code fragment - focus on scale rules configuration
scale:
  minReplicas: 1
  maxReplicas: 20
  rules:
    - name: http-scaling
      http:
        metadata:
          concurrentRequests: "100"
    - name: cpu-scaling
      custom:
        type: cpu
        metadata:
          type: Utilization
          value: "70"
```

## Understand scale behavior

The scaling algorithm in Azure Container Apps uses several timing parameters that affect how quickly your application responds to load changes. Understanding these parameters helps you configure rules that balance responsiveness with stability.

The polling interval determines how frequently the platform checks your scale triggers. For custom scalers including CPU, memory, and event-driven triggers, the polling interval is 30 seconds. HTTP and TCP rules use a 15-second calculation window. This means changes in load may not trigger scaling for up to 30 seconds after they occur.

The cool-down period is how long the platform waits after the last scaling event before considering scale-down to zero replicas. The default cool-down period is 300 seconds (five minutes). This delay prevents rapid scale-down when traffic temporarily drops and helps avoid repeated scale-up and scale-down cycles for bursty workloads.

The scale-up stabilization window is zero seconds, meaning the platform can begin scaling up immediately when thresholds are exceeded. Scale-up proceeds in steps: 1, 4, 8, 16, 32, and so on, doubling each step until reaching the maximum replica count. This progressive scale-up prevents over-provisioning while still responding quickly to sustained load increases.

The scale-down stabilization window is 300 seconds, matching the cool-down period. The platform waits this duration after detecting that scale-down conditions are met before removing replicas. When scaling down, all replicas that need to shut down are removed at once rather than gradually.

## Best practices

- **Set appropriate minimum replicas:** Use at least one replica for production workloads to avoid cold start latency. Scale to zero only for development environments or truly intermittent workloads where cost savings outweigh the startup delay.

- **Choose HTTP scaling for API workloads:** HTTP scaling provides the most responsive scaling for synchronous request-response patterns and supports scaling to zero. Use HTTP rules as the primary trigger for web APIs and frontend applications.

- **Combine multiple scale rules:** When you define multiple rules, the platform scales out when any rule threshold is met. Combine HTTP scaling with CPU or memory rules to handle different traffic patterns and ensure your application scales appropriately for both request volume and resource utilization.

- **Account for cool-down periods:** The 300-second cool-down before scaling to zero can affect cost optimization for bursty workloads. If your application experiences short bursts followed by idle periods, the five-minute delay means replicas continue running and incurring charges during brief quiet periods.

## Additional resources

- [Set scaling rules in Azure Container Apps](/azure/container-apps/scale-app)
- [Tutorial: Scale a container app](/azure/container-apps/tutorial-scaling)
