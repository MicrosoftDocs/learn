Managing the container app lifecycle is a day-two skill that supports both cost control and incident response. In an AI solution, you sometimes need to pause a service during an upstream outage, restart after a configuration change, or reduce blast radius while you investigate a failing revision. Azure Container Apps provides lifecycle actions that work alongside revisions and scaling.

> [!NOTE]
> The examples in this unit use Azure CLI patterns. Validate command behavior in a non-production environment before you run lifecycle actions as part of an automated incident response workflow.

## Decide between stop, restart, and scaling to zero

Container Apps supports scaling to zero based on your scaling configuration, which can be appropriate for event-driven services or workloads with intermittent traffic. Stopping an app is different. Stopping is an explicit operational action, and it is useful when you want to guarantee the app does not start replicas while you are mitigating an incident.

Restart sits between those two actions. Restart is useful when configuration changes should take effect immediately, or when a process is stuck due to a deadlock or a transient dependency issue. For AI services that load large models at startup, restarting too aggressively can increase cold start frequency, so you should use restart with intent.

## Start and stop a container app

Starting and stopping are app-level actions. They affect the container app as a whole and therefore can be too broad if the problem is limited to one revision. When you are isolating a single bad release, revision deactivation is often the safer first step.

```azurecli
az containerapp stop \
  --name <app-name> \
  --resource-group <resource-group>
```

```azurecli
az containerapp start \
  --name <app-name> \
  --resource-group <resource-group>
```

## Restart an app to recover from a bad runtime state

Restarting forces replicas to restart and can clear transient failure states. Restart is not a substitute for understanding the root cause. You should pair restart with log inspection so you can determine whether the restart fixed the issue or simply delayed the next failure.

```azurecli
az containerapp restart \
  --name <app-name> \
  --resource-group <resource-group>
```

## Diagnose a failing revision with a repeatable checklist

When a revision fails, a consistent checklist helps you converge quickly. The best first step is to confirm which revision is failing and whether the platform reports a health state that aligns with what you observe in logs.

Common failure patterns to validate:

- **Image pull failures:** The registry credentials are missing or invalid, or the image reference is incorrect.
- **Port mismatches:** The container listens on a different port than the Container Apps ingress configuration expects.
- **Missing configuration:** Environment variables or secrets that the app requires are missing or misnamed.
- **Probe failures:** Liveness or readiness probes target the wrong path or do not allow enough startup time for model loading.
- **Resource pressure:** The container starts but is killed due to memory limits or becomes slow due to CPU throttling.

The following query is a useful starting point to compare revision status at a glance.

```azurecli
az containerapp revision list \
  --name <app-name> \
  --resource-group <resource-group> \
  --query "[].{name:name,active:properties.active,health:properties.healthState}" \
  -o table
```

## Additional resources

Use these links to review how lifecycle actions fit into the broader Container Apps operational model. They are also useful when you build runbooks and want a single place to confirm current CLI syntax.

- [Azure Container Apps manage applications](/azure/container-apps/manage)
- [Azure Container Apps revisions](/azure/container-apps/revisions)
- [Azure CLI: az containerapp](/cli/azure/containerapp)
