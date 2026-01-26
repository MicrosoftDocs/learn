Updating a container image is a core activity during AI application development. Image updates often include model version changes, dependency updates, and configuration changes that affect startup time and latency. In Azure Container Apps, a meaningful update typically results in a new revision, so the safest operational workflow connects image identity, revision health, and traffic management.

> [!NOTE]
> The examples in this unit are patterns. Validate flags and required fields against the current Azure CLI and Azure Container Apps documentation before using these commands in automation.

## Use tags and digests intentionally

Container image tags and image digests solve different problems. Tags are convenient for fast iteration because you can reuse a name like `dev` or `staging`, but tags can change over time. Digests are immutable identifiers, so they provide strong traceability for production releases.

For AI solutions, traceability matters because you often need to correlate operational behavior with a specific model build. When you reference a digest, you can prove which artifact served requests during an incident. When you reference a tag, you should treat the tag as a convenience rather than a guarantee of immutability.

## Update a container app to create a new revision

When you update the image for a container app, Container Apps creates a new revision with the updated template. You can then verify the revision’s health before you route traffic to it. This workflow helps you avoid sending production traffic to a revision that fails startup, fails probes, or crashes under load.

The following example updates the image reference. If you are using Azure Container Registry, your image name typically looks like `myregistry.azurecr.io/myapp@sha256:<digest>`.

```azurecli
az containerapp update \
  --name <app-name> \
  --resource-group <resource-group> \
  --image <registry>/<repo>@sha256:<digest>
```

After the update, inspect the container template to confirm the platform recorded the image you expect.

```azurecli
az containerapp show \
  --name <app-name> \
  --resource-group <resource-group> \
  --query properties.template.containers
```

## Understand revision modes and what “active” means

Revision mode determines how many revisions can be active at the same time. Single revision mode keeps only one active revision, which simplifies operations but limits advanced rollout strategies. Multiple revision mode enables canary rollouts and traffic splitting, which is useful when you want to validate a new model version with a small portion of traffic.

“Active” is an operational state that indicates a revision can receive traffic. A revision can exist without being active, and keeping inactive revisions can be valuable for investigation and rollback planning. During troubleshooting, you often deactivate a problematic revision first so it stops receiving traffic while you diagnose the issue.

## List, investigate, and manage revisions

Revisions are the unit you inspect during rollouts. Listing revisions helps you confirm which revision is active, and showing a specific revision helps you compare configuration between a working revision and a failing one.

```azurecli
az containerapp revision list \
  --name <app-name> \
  --resource-group <resource-group> \
  -o table
```

When you identify the revision you need to investigate, retrieve the details.

```azurecli
az containerapp revision show \
  --name <app-name> \
  --resource-group <resource-group> \
  --revision <revision-name>
```

If a revision is unhealthy or you want to pause it during investigation, deactivate it. Deactivation is a safer first step than deletion because it preserves evidence and keeps rollback options available.

```azurecli
az containerapp revision deactivate \
  --name <app-name> \
  --resource-group <resource-group> \
  --revision <revision-name>
```

After you resolve the incident and you no longer need older revisions for rollback, you can delete stale revisions as part of routine hygiene.

## Best practices for safe rollout and cleanup

Safe rollouts combine good artifact identity with clear revision controls. Cleanup practices help you maintain clarity during incidents and reduce operational overhead.

- **Use image digests for production:** Digests provide an immutable reference you can audit during incident review.
- **Verify revision health before shifting traffic:** Use revision status, probe signals, and logs to confirm readiness.
- **Deactivate before investigating:** Deactivation preserves evidence during troubleshooting and reduces risk.
- **Define a retention strategy:** Container Apps automatically purges inactive revisions when you exceed 100. You can adjust this threshold with the `--max-inactive-revisions` parameter.

## Additional resources

These resources expand on revision behavior and the CLI commands used to update images and manage revision state. Use them when you need the latest supported flags, constraints, and examples for production automation.

- [Azure Container Apps revisions](/azure/container-apps/revisions)
- [Azure Container Apps application lifecycle management](/azure/container-apps/application-lifecycle-management)
- [Azure CLI: az containerapp](/cli/azure/containerapp)
- [Azure CLI: az containerapp revision](/cli/azure/containerapp/revision)
