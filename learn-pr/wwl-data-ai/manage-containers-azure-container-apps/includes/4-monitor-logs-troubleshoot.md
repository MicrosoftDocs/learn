Logs are the primary diagnostic signal in a managed container platform. In an AI solution, logs help you correlate requests with model versions, explain latency spikes, and identify dependency failures without needing shell access to containers. Azure Container Apps integrates with Azure Monitor, and you can also stream logs during an incident.

> [!NOTE]
> Log access depends on how your Container Apps environment is configured. Validate that your environment is connected to Log Analytics or that your operational workflow uses log streaming for real-time investigation.

## Use log streaming for real-time diagnosis

Log streaming is useful when you can reproduce an issue quickly, such as a request that triggers an exception or a startup crash loop for a new revision. Streaming lets you see events as they happen, which helps you confirm whether a configuration change improved the situation. In practice, you should pair streaming with structured logging so you can filter by request identifiers and revision identifiers.

The following command streams logs for a container app.

```azurecli
az containerapp logs show \
  --name <app-name> \
  --resource-group <resource-group> \
  --follow
```

## Design logs that support AI troubleshooting

AI services often behave differently for different inputs, and that makes troubleshooting harder if logs do not capture enough context. You want enough detail to debug safely, but you also want to avoid logging sensitive content. A balanced approach is to log identifiers and metadata rather than raw documents or prompts.

Recommended fields to include in application logs:

- **Request identifier:** A correlation ID that you propagate across services.
- **Revision or build identifier:** A value that matches your image tag or digest, or a version string baked into the image.
- **Model version:** The model deployment name or version used for the request.
- **Latency breakdown:** Total time and, when possible, key dependency timings.

## Troubleshoot revision-specific failures

Revision failures often fall into a few categories: startup failures, probe failures, configuration errors, or runtime exceptions. Logs help you identify which category you are facing. For example, an app might exit immediately due to a missing environment variable, or it might start successfully but fail readiness probes due to a wrong path.

During an incident, use a workflow that narrows scope quickly:

1. Confirm which revision is active and which revision is failing.
1. Stream logs while you reproduce the issue or while the failing revision starts.
1. Compare configuration between a working revision and a failing revision.
1. Apply a targeted fix and validate the next revision becomes ready.

## Additional resources

These resources explain how Container Apps integrates with Azure Monitor and how to use logs effectively during troubleshooting. Review them if you want to standardize your team’s operational workflow around centralized logging.

- [Azure Container Apps logging](/azure/container-apps/logging)
- [Azure Monitor Logs overview](/azure/azure-monitor/logs/data-platform-logs)
- [Azure CLI: az containerapp logs](/cli/azure/containerapp/logs)
