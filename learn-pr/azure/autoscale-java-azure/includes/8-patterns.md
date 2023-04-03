In this unit, we'll look at patterns for autoscaling.

Autoscaling isn't an instant solution. Simply adding resources to a system or running more instances of a process doesn't guarantee that the performance of the system will improve. Consider the following points when designing an autoscaling strategy:

## Recommendations

**Identify bottlenecks**: Scaling out isn't a magic fix for every performance issue. For example, if your backend database is the bottleneck, it won't help to add more web servers. Identify and resolve the bottlenecks in the system before throwing more instances at the problem. Stateful parts of the system are the most likely cause of bottlenecks.

**Decompose workloads by scalability requirements**: Applications often consist of multiple workloads with different requirements for scaling. For example, an application might have a public-facing site and a separate administration site. The public site may experience sudden surges in traffic, while the administration site has a smaller, more predictable load.

**Offload resource-intensive tasks**: Tasks that require many CPU or I/O resources should be moved to background jobs when possible to minimize the load on the front end that's handling user requests.

**Use built-in autoscaling features**: If the application has a predictable, regular workload, scale out on a schedule. For example, scale out during business hours. Otherwise, if the workload isn't predictable, use performance metrics such as CPU or request queue length to trigger autoscaling.

**Consider aggressive autoscaling for critical workloads**: For critical workloads, you want to keep ahead of demand. It's better to add new instances quickly under heavy load to handle the other traffic, and then gradually scale back.

**Design for scale in**: Remember that with elastic scale, the application will have periods of scale in, when instances get removed. The application must gracefully handle instances being removed. Here are some ways to handle scale-in:

- Listen for shutdown events (when available) and shut down cleanly.
- Clients/consumers of a service should support transient fault handling and retry.
- For long-running tasks, consider breaking up the work.
- Put work items on a queue so that another instance can pick up the work if an instance is removed in the middle of processing.

## Notifications

- All autoscale failures are logged to the Activity Log. You can then configure an activity-log alert so that you can be notified via email, SMS, or webhooks whenever there's an autoscale failure.
- Similarly, all successful scale actions are posted to the Activity Log. You can then configure an activity-log alert so that you can be notified via email, SMS, or webhooks whenever there's a successful autoscale action. You can also configure email or webhook notifications to get notified for successful scale actions via the **Notifications** tab on the autoscale setting.

:::image type="content" source="../media/flow.png" alt-text="Diagram of a webhook process flow." lightbox="../media/flow.png":::

## Common patterns to scale your resource in Azure

### Scale based on demand

You can automatically scale out the number of service instances at the start of the work day when customer demand increases. At the end of the work day, automatically scale in the number of application instances to minimize resource costs overnight when application use is low.

### Scale differently on weekdays vs weekends

On an evening or weekend, your application demand may lower. If this load is consistent over a period of time, you can configure autoscale rules to lower the number of service instances in the scale set. This scale-in action reduces the cost to run your scale set because you only run the number of instances required to meet the current demand.

### Scale differently during holidays

If you have heavy usage for a service at certain parts of the month or fiscal cycle, you can automatically scale the number of service instances to accommodate their extra demands. When there's a marketing event, promotion, or holiday sale, you can automatically scale the number of service instances ahead of expected customer demand.

### Scale based on custom metric

Finally, it's best to define your autoscaling rules carefully. For example, a Denial of Service (DoS) attack will likely result in a large-scale influx of incoming traffic. Trying to handle a surge in requests caused by a DoS attack would be fruitless and expensive. These requests aren't genuine, and should be discarded rather than processed. A better solution is to implement detection and filtering of requests that occur during such an attack before they reach your service.

After configuring the autoscaling rules, monitor the performance of your application over time. Use the results of this monitoring to adjust the pattern in which the system scales, if necessary.
