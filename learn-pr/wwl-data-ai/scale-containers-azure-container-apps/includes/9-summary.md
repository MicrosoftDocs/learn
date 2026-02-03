In this module, you learned how to configure automatic horizontal scaling for containerized applications in Azure Container Apps. You explored the scale definition components including limits, rules, and behaviors that determine how your application responds to changing demand. You configured HTTP, TCP, CPU, and memory scale rules to handle synchronous API traffic and compute-intensive workloads. You implemented event-driven scaling using KEDA scalers for Azure Service Bus, Storage Queues, Event Hubs, and custom event sources like Apache Kafka. You learned to authenticate scale rules using both secrets and managed identity for improved security. You examined compute resource allocation strategies to balance performance requirements with cost efficiency, including when to use Consumption versus Dedicated workload profiles. Finally, you applied revision modes and traffic splitting to control how scaling affects deployment rollouts, enabling canary releases and gradual migrations between application versions.

## Additional resources

- [Set scaling rules in Azure Container Apps](/azure/container-apps/scale-app)
- [Update and deploy changes in Azure Container Apps](/azure/container-apps/revisions)
- [KEDA scalers documentation](https://keda.sh/docs/scalers/)
- [Billing in Azure Container Apps](/azure/container-apps/billing)
