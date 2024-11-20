The Azure Container Apps application lifecycle revolves around revisions.

When you deploy a container app, the first revision is automatically created. More revisions are created as containers change, or any adjustments are made to the template section of the configuration.

A container app flows through four phases: deployment, update, deactivation, and shut down.

## Deployment

As a container app is deployed, the first revision is automatically created.

![Diagram showing the deployment phase of a container app instance.](../media/azure-container-apps-lifecycle-deployment.png)

## Update

As a container app is updated with a revision scope-change, a new revision is created. You can choose whether to automatically deactivate old revisions (single revision mode), or allow them to remain available (`Multiple` revision mode).

![Diagram showing the update phase of a container app instance.](../media/azure-container-apps-lifecycle-update.png)

### Zero downtime deployment

In single revision mode, Container Apps automatically ensures your app doesn't experience downtime when creating a new revision. The existing active revision isn't deactivated until the new revision is ready. If ingress is enabled, the existing revision continues to receive 100% of the traffic until the new revision is ready.

> [!NOTE]
> A new revision is considered ready when one of its replicas starts and becomes ready. A replica is ready when all of its containers start and pass their startup and readiness probes.

In `Multiple` revision mode, you control when revisions are activated or deactivated and which revisions receive ingress traffic. If a traffic splitting rule is configured with `latestRevision` set to `true`, traffic doesn't switch to the latest revision until it's ready.

## Deactivate

Once a revision is no longer needed, you can deactivate a revision with the option to reactivate later. During deactivation, containers in the revision are shut down.

![Diagram showing the deactivate phase of a container app instance.](../media/azure-container-apps-lifecycle-deactivate.png)

## Shutdown

The containers are shut down in the following situations:

- As a container app scales in
- As a container app is being deleted
- As a revision is being deactivated

When a shutdown is initiated, the container host sends a `SIGTERM` message to your container. The code implemented in the container can respond to this operating system-level message to handle termination.

If your application doesn't respond within 30 seconds to the `SIGTERM` message, then `SIGKILL` terminates your container.

Additionally, make sure your application can gracefully handle shutdowns. Containers restart regularly, so don't expect state to persist inside a container. Instead, use external caches for expensive in-memory cache requirements.
