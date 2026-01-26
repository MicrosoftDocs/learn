Verification closes the loop between deployment intent and what actually runs in production. For AI services, verification is especially important because startup failures can look like model connectivity problems, missing secrets, or registry authentication errors. In Azure Container Apps, you can verify deployments through logs, revisions, and replica status.

> [!NOTE]
> Container Apps logs can include console logs from your container and system logs from the platform. These two log types answer different questions, so choose the one that matches the symptom you are investigating.

## Confirm app configuration and ingress

Before you dive into logs, confirm the app configuration and ingress settings. This helps you detect obvious issues, such as internal ingress when you expected external ingress. It also helps you retrieve the FQDN so you can send a health check request.

You can inspect the container app with `az containerapp show`.

```azurecli
az containerapp show -n ai-api -g rg-aca-demo
```

## Investigate container logs

Container logs are usually the fastest way to understand why a revision fails. They commonly show errors such as missing environment variables, connection failures, or application crashes. When you are deploying an AI API, logs often show HTTP binding issues, dependency endpoint issues, or authentication failures when calling model providers.

You can view recent console logs using `az containerapp logs show`. By default, this command returns a limited number of lines.

```azurecli
az containerapp logs show -n ai-api -g rg-aca-demo
```

If you need to tail logs while traffic is flowing, you can follow logs in real time and increase the tail count.

```azurecli
az containerapp logs show -n ai-api -g rg-aca-demo \
    --follow --tail 30
```

If you suspect a platform-level issue, you can also request system logs.

```azurecli
az containerapp logs show -n ai-api -g rg-aca-demo \
    --type system
```

## Check revisions to confirm which version is active

Revisions represent versioned changes to your container app configuration. This revision model is useful for safe rollouts because you can see which revision is active and which revisions are inactive. When you update a container app, listing revisions helps you confirm that the update created a new revision and that the revision reached a healthy state.

You can list revisions with the following command.

```azurecli
az containerapp revision list -n ai-api -g rg-aca-demo
```

If you need to include inactive revisions for deeper debugging, you can include the `--all` flag.

```azurecli
az containerapp revision list -n ai-api -g rg-aca-demo --all
```

## Check replicas to understand scaling and availability

Replicas are the running instances of a revision. For request-driven AI workloads, replica behavior affects latency and throughput because cold starts and scale-out events can add delay. Listing replicas helps you determine whether the app is running and whether it is scaling as expected.

You can list replicas for the latest revision, or you can provide a revision name.

```azurecli
az containerapp replica list -n ai-api -g rg-aca-demo
```

```azurecli
az containerapp replica list -n ai-api -g rg-aca-demo \
    --revision MyRevision
```

## Best practices for verification

Verification is most effective when it is consistent and repeatable. You can use the following practices to reduce time-to-diagnosis for AI services.

- **Start with logs:** Use `az containerapp logs show` first to capture startup and runtime errors.
- **Use revisions for rollout validation:** List revisions after updates to confirm a new revision exists and becomes active.
- **Inspect replicas during incidents:** Check replicas to detect scale-to-zero, crash loops, or missing traffic.
- **Prefer automation-friendly outputs:** Use `--query` to extract fields you commonly validate, such as ingress FQDN or revision status.

## Additional resources

These resources help you go deeper on day-two verification and troubleshooting for Container Apps. Use the CLI reference pages to confirm flags for targeting specific revisions and replicas when you are narrowing down an incident. You can also use these references to build automation that extracts the exact fields you validate in deployment pipelines.

- [Azure CLI: az containerapp logs](/cli/azure/containerapp/logs?view=azure-cli-latest)
- [Azure CLI: az containerapp revision](/cli/azure/containerapp/revision?view=azure-cli-latest)
- [Azure CLI: az containerapp replica](/cli/azure/containerapp/replica?view=azure-cli-latest)
