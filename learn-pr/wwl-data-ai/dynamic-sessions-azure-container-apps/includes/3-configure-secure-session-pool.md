::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=c31f98ce-18d2-486e-9c5c-bbba253bab4b]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

A session pool's configuration determines how many AI requests can execute concurrently, how long temporary state remains available, and whether executed code can reach external networks. You should select these settings from the application's workload and threat model rather than treating them as infrastructure defaults.

> [!NOTE]
> The commands and configuration examples in this unit are patterns that you can adapt to your application. Session pool limits, supported regions, API versions, and billing details change regularly. For current values, see [Use session pools in Azure Container Apps](/azure/container-apps/session-pool) and [Azure Container Apps pricing](/azure/container-apps/billing).

## Set pool capacity

The maximum concurrent sessions setting limits the number of allocated sessions that can run at the same time. Each active user or agent conversation can require its own session, so the correct value depends on expected concurrency rather than total registered users. The limit also provides a safety boundary for cost and downstream resource use.

For the document-analysis application, estimate concurrent sessions from active requests during the busiest interval. If 50 users are online but only 10 typically analyze documents at once, a starting maximum near 10 is more representative than 50. Load testing can reveal whether requests wait or fail when the pool reaches that boundary.

A custom container pool can also maintain ready session instances. Ready instances reduce allocation latency because the custom image and application are already running. A higher ready count improves responsiveness but retains more compute while demand is low, so you should measure startup time and interactive latency before increasing it.

The following configuration fragment keeps two custom environments ready while allowing up to 20 concurrent sessions. Startup and liveness probes help the pool count only healthy environments as ready.

```json
{
  "properties": {
    "scaleConfiguration": {
      "maxConcurrentSessions": 20,
      "readySessionInstances": 2
    },
    "customContainerTemplate": {
      "containers": [
        {
          "name": "document-executor",
          "image": "contoso.azurecr.io/document-executor:1.0",
          "probes": [
            {
              "type": "Startup",
              "httpGet": {
                "path": "/ready",
                "port": 8080
              },
              "periodSeconds": 5,
              "failureThreshold": 30
            },
            {
              "type": "Liveness",
              "httpGet": {
                "path": "/health",
                "port": 8080
              },
              "periodSeconds": 10,
              "failureThreshold": 3
            }
          ]
        }
      ],
      "ingress": {
        "targetPort": 8080
      }
    }
  }
}
```

## Choose a session cooldown

The timed lifecycle removes a session after it receives no requests for the configured cooldown period. Every request resets the idle timer. A longer cooldown gives a multi-step AI interaction more time to reuse files and state, while a shorter cooldown releases capacity and removes temporary data sooner.

Choose the cooldown from the expected pause between related operations. A document-analysis conversation might need several minutes for a user to review a result and request another chart. The application shouldn't rely on the cooldown as durable retention because the session can still disappear after inactivity or an unexpected failure.

For untrusted code, shorter retention usually reduces risk. Persist the source document and accepted outputs in application-controlled storage so the backend can restore required inputs when a later request receives a new empty session.

## Control outbound network access

Sessions block outbound network traffic by default. This default prevents generated code from downloading additional programs, sending uploaded content to an external destination, or using the session in a denial-of-service attack. Keep egress disabled when the task can operate entirely on supplied code and uploaded files.

Enable egress only when the workload has a specific external dependency and the risk is acceptable. Egress is a pool-level choice, so enabling it affects every session in that pool. Consider separating trusted workloads that require network access from untrusted workloads rather than weakening a shared pool.

The following command creates a Python code interpreter pool for a modest interactive workload. The command limits concurrency to 20 sessions, and removes an idle session after 300 seconds. The command also keeps outbound network traffic disabled.

```azurecli
az containerapp sessionpool create \
    --name ai-document-sessions \
    --resource-group <RESOURCE_GROUP> \
    --location <LOCATION> \
    --container-type PythonLTS \
    --max-sessions 20 \
    --cooldown-period 300 \
    --network-status EgressDisabled
```

You can retrieve the management endpoint after Azure creates the pool. Application code uses this endpoint to execute code and work with session files.

```azurecli
az containerapp sessionpool show \
    --name ai-document-sessions \
    --resource-group <RESOURCE_GROUP> \
    --query "properties.poolManagementEndpoint" \
    --output tsv
```

## Protect identities and session data

Hyper-V isolation separates sessions, but code within one session can access that session's files, environment variables, and available credentials. Only place a secret or document in a session when you allow the session's code to access that data. Isolation between sessions doesn't make data inside a session safe from the code you're executing.

The backend identity and the session identity have different purposes. The backend uses the Azure ContainerApps Session Executor role to call the pool management API. End users never receive that identity's token, and generated code doesn't need access to it.

A custom container pool can use a managed identity to pull its image or access Microsoft Entra-protected resources. Runtime access carries more risk because untrusted code in the session can request tokens for that identity. If runtime access is unavoidable, use a separate identity with the smallest possible scope and don't reuse the backend's broader identity.

Apply these practices when you configure production pools:

- **Separate trust levels:** Use different pools for code with different egress, identity, or data-access requirements.
- **Minimize session data:** Upload only the files needed for the current task and persist approved results elsewhere.
- **Constrain concurrency:** Set a maximum that protects cost and downstream systems when traffic spikes.
- **Prefer disabled egress:** Allow outbound access only for a justified workload that you have evaluated.
- **Use narrow identities:** Grant only the roles and scopes that the session or backend requires.
- **Monitor utilization:** Track executing, creating, and ready session counts for custom pools to validate capacity choices.

::: zone-end

## Additional resources

These resources provide current configuration values and security guidance for session pools. Review them when you select limits, lifecycle behavior, network access, and identity settings for your AI application.

- [Use session pools in Azure Container Apps](/azure/container-apps/session-pool)
- [Use dynamic sessions in Azure Container Apps](/azure/container-apps/sessions-usage)
- [Managed identities in Azure Container Apps](/azure/container-apps/managed-identity)
