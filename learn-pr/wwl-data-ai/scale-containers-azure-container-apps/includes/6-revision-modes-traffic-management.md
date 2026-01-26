Revision modes in Azure Container Apps determine how your application handles deployments and how multiple versions can coexist. The revision mode you choose affects scaling behavior, traffic distribution, and deployment strategies. Understanding these modes helps you implement appropriate deployment patterns for your operational requirements.

## Understand revisions and scaling

A revision is an immutable snapshot of a container app version. Each time you deploy changes to certain configuration properties, Container Apps creates a new revision. Revisions cannot be modified after creation; to make changes, you deploy a new revision. This immutability provides a reliable rollback target if a new version has problems.

Changes to your container app fall into two categories. Revision-scope changes create a new revision and include modifications to container images, scale rules, environment variables, and other properties in the `template` section of the configuration. Application-scope changes do not create a new revision and include modifications to secrets, ingress settings, and traffic splitting rules.

Each active revision can scale independently based on its own scale rules. If you have two active revisions with the same scale rules and split traffic between them, each revision scales based on its share of traffic. This independent scaling means total resource consumption across all revisions may be higher than a single revision would require for the same total traffic.

Replicas are instances of a specific revision. When scaling occurs, the platform adds or removes replicas of the affected revision. Multiple revisions can have different replica counts simultaneously, depending on their individual traffic loads and scale rule thresholds.

## Configure single revision mode

Single revision mode is the default for new container apps. In this mode, only one revision is active at a time. When you deploy changes that create a new revision, Container Apps provisions the new revision and waits for it to become ready before shifting traffic from the old revision.

Zero-downtime deployment happens automatically in single revision mode. The platform keeps the existing revision running and receiving traffic while the new revision starts. Once the new revision passes its health checks and scales to match the previous revision's replica count, traffic shifts to the new revision. The old revision then deactivates and stops consuming resources.

Single revision mode is appropriate for straightforward deployments where you want each deployment to fully replace the previous version. You don't need to manage multiple active versions, configure traffic splitting, or manually deactivate old revisions. The platform handles the transition automatically, ensuring your application remains available during deployments.

The trade-off is that single revision mode doesn't support traffic splitting or gradual rollouts. All traffic goes to the current active revision. If you need to test a new version with a subset of traffic before full rollout, you must use multiple revision mode.

## Configure multiple revision mode

Multiple revision mode allows multiple revisions to be active simultaneously. Each active revision can receive traffic, scale independently, and remain operational until you explicitly deactivate it. This mode enables advanced deployment patterns like canary releases, blue-green deployments, and A/B testing.

You enable multiple revision mode using the `--revision-mode multiple` parameter when creating or updating a container app:

```azurecli
az containerapp update \
  --name order-api \
  --resource-group rg-ecommerce \
  --revision-mode multiple
```

In multiple revision mode, you control which revisions are active and how traffic is distributed among them. New deployments create new revisions, but don't automatically deactivate previous revisions. You decide when to shift traffic and when to deactivate old revisions.

Revisions have two states: active and inactive. Active revisions can receive traffic and scale based on their scale rules. Inactive revisions consume no resources and cannot receive traffic, but remain available for reactivation. Container Apps maintains up to 100 inactive revisions, automatically purging the oldest when you exceed this limit.

Multiple revision mode requires more operational attention than single revision mode. You must manage traffic distribution, monitor multiple revisions, and explicitly deactivate revisions when they're no longer needed. This overhead is justified when you need the flexibility of gradual rollouts or traffic splitting.

## Implement traffic splitting

Traffic splitting distributes incoming requests across active revisions based on percentage weights. You configure traffic weights that total 100 percent, and the platform routes each request to a revision based on these weights. This distribution is probabilistic; individual requests are randomly assigned, so actual percentages may vary slightly from configured values.

The following command configures traffic splitting between two revisions, sending 80 percent of traffic to the first version and 20 percent to the second:

```azurecli
az containerapp ingress traffic set \
  --name order-api \
  --resource-group rg-ecommerce \
  --revision-weight order-api--v1=80 order-api--v2=20
```

Traffic splitting enables canary deployments where you send a small percentage of traffic to a new version to validate its behavior in production. Start with a low percentage (such as 5 or 10 percent), monitor for errors and performance degradation, then gradually increase traffic to the new version. If problems occur, you can quickly shift traffic back to the stable version.

You can also configure traffic splitting to target the latest revision automatically. By setting a weight for `latest` instead of a specific revision name, new deployments automatically receive that traffic percentage without requiring you to update traffic rules. This approach simplifies continuous deployment pipelines.

## Use revision labels for direct access

Revision labels provide named endpoints that route directly to specific revisions regardless of traffic splitting configuration. Labels enable testing specific revisions without affecting the traffic distribution that other users experience. Each label creates a unique URL that always routes to the labeled revision.

Labels are useful for several scenarios. During canary deployments, you can assign a label to the new revision and share the label URL with testers for validation before adding the revision to traffic splitting. For blue-green deployments, labels identify the "blue" (production) and "green" (staging) revisions, and you switch production traffic by moving the label rather than reconfiguring traffic weights.

Label names must start with a letter, contain only lowercase alphanumeric characters and dashes, not contain consecutive dashes, and not exceed 64 characters. Each label can point to only one revision at a time, but you can move labels between revisions. Moving a label is an atomic operation that immediately redirects traffic for that label URL.

Labels work independently of traffic splitting. Traffic to the main application URL follows traffic splitting rules. Traffic to a label URL always goes to the labeled revision. You can use both mechanisms together; traffic splitting for gradual production rollouts and labels for directed testing.

## Scaling considerations with multiple revisions

When multiple revisions are active, each scales independently based on its own scale rules and traffic share. This independence has implications for resource consumption and cost. Two revisions receiving 50 percent traffic each may together consume more resources than a single revision receiving 100 percent traffic, because each revision maintains its own minimum replicas and scales based on its own metrics.

Consider a scenario where you have two revisions with `minReplicas: 1` and split traffic 50/50. Each revision maintains at least one replica, so you have at least two replicas total. If your scale rules would trigger a third replica at full traffic, each revision independently may not trigger scaling because each sees only half the traffic. This behavior can lead to different performance characteristics during traffic transitions.

To manage resource consumption during deployments, plan your traffic splitting transitions carefully. Rather than maintaining 50/50 splits for extended periods, move through traffic percentages relatively quickly: deploy, validate with 10 percent traffic, increase to 50 percent briefly, then complete at 100 percent. Deactivate old revisions promptly after completing transitions to free resources.

Monitor each revision separately during traffic splitting. Use Azure Monitor to track replica counts, resource utilization, and error rates per revision. Differences between revisions may indicate problems with the new version that warrant investigation before increasing its traffic share.

## Best practices

- **Use single revision mode for simple deployments:** Single revision mode provides zero-downtime deployments automatically without configuration complexity. Choose this mode unless you specifically need traffic splitting, canary releases, or other multi-revision capabilities.

- **Enable multiple revision mode for canary releases:** When you need to validate new versions with production traffic before full rollout, multiple revision mode provides the necessary traffic control. Plan your validation process and traffic percentages in advance.

- **Deactivate old revisions promptly:** Active revisions scale independently and consume resources. After completing a traffic transition, deactivate the old revision to prevent ongoing resource consumption. Inactive revisions remain available for reactivation if you need to roll back.

- **Test with labels before traffic splitting:** Use revision labels to validate new revisions through direct access before adding them to traffic distribution. This approach lets testers validate the new revision without affecting production traffic. Once validation completes, add the revision to traffic splitting.

## Additional resources

- [Update and deploy changes in Azure Container Apps](/azure/container-apps/revisions)
- [Traffic splitting in Azure Container Apps](/azure/container-apps/traffic-splitting)
- [Blue-green deployment in Azure Container Apps](/azure/container-apps/blue-green-deployment)
