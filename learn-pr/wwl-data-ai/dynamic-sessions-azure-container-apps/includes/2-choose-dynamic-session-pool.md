::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=e7ca7f8c-6642-4bf3-8237-d912a61d944f]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

Azure Container Apps dynamic sessions provide fast access to isolated execution environments for code and applications. For an AI solution, the main design decision is whether the platform-managed code interpreter meets the workload's needs or whether the workload requires a custom container.

> [!NOTE]
> The code and configuration examples in this unit are patterns that you can adapt to your application. Confirm supported session types and API versions in the [Azure Container Apps dynamic sessions documentation](/azure/container-apps/sessions) before you deploy a production workload.

## Understand the session execution boundary

A session pool contains prewarmed environments that Azure Container Apps can allocate in milliseconds. Each allocated session runs in its own Hyper-V-isolated sandbox, which separates its processes and file system from the host and from other sessions. This boundary lets an AI backend execute code without running the code in the backend process.

The following flow shows how the backend retains control of access while the session pool manages isolated compute:

```text
User request
    |
    v
AI application ---- model or orchestration layer
    |
    | validated code, files, and application-generated identifier
    v
Dynamic session pool
    |
    v
Isolated session ---- execution result and generated files
```

The backend authenticates to the pool and submits work on behalf of the user. End users don't receive pool access tokens or choose identifiers that could address another user's session. The session holds temporary execution state, while the application stores durable inputs and results outside the pool.

A long-running application container isn't an equivalent boundary. If generated code runs beside the API, the code can compete for the API's CPU and memory and might access its files, environment variables, or credentials. Creating a separate container app for every request improves separation, but it adds startup and lifecycle management that the session pool already provides.

## Choose the built-in code interpreter

The built-in code interpreter provides a platform-managed runtime and API for common code execution. You don't build an image or implement an execution service. Your application can submit code, upload input files, and download output files through the pool's management API.

Choose a built-in interpreter when the supported runtime can complete the task without custom system dependencies. Typical AI scenarios include analyzing CSV data, performing calculations, creating visualizations, and executing short scripts proposed by an agent. The managed environment reduces the operational work required to keep an execution image patched and available.

The built-in API exposes operations for the common workflow:

```http
POST <POOL_MANAGEMENT_ENDPOINT>/executions?api-version=<API_VERSION>&identifier=<SESSION_ID>
POST <POOL_MANAGEMENT_ENDPOINT>/files?api-version=<API_VERSION>&identifier=<SESSION_ID>
GET <POOL_MANAGEMENT_ENDPOINT>/files/<FILE_NAME>/content?api-version=<API_VERSION>&identifier=<SESSION_ID>
```

The API surface is intentionally constrained. If the application requires an unsupported language, native executable, proprietary library, or custom protocol, the built-in interpreter isn't the right choice.

## Choose an application integration

After you select the built-in code interpreter, decide whether the application should call its REST API directly or use an adapter for an AI orchestration framework. Direct API access provides explicit control over authentication, session identifiers, execution requests, and file operations. A framework adapter reduces integration code when the framework's tool model already matches the application's orchestration design.

For a LangChain agent, the [`langchain-azure-dynamic-sessions` integration](/azure/container-apps/sessions-tutorial-langchain) provides `SessionsPythonREPLTool`. The tool lets an agent execute Python in a code interpreter session without implementing each REST request. The adapter doesn't create a different pool type or security boundary. It uses the same built-in code interpreter sessions, so the application still needs an identity with access to the pool and a tenant-safe strategy for tool instances and session state.

Choose direct REST calls when the backend needs complete control of file exchange, response handling, or session identifier mapping. Choose the LangChain integration when an existing LangChain agent primarily needs a Python execution tool. Understanding the REST contract remains useful for troubleshooting authentication, isolation, lifecycle, and execution failures that a framework adapter reports.

## Choose a custom container

A custom container session pool uses an image that you supply. Azure Container Apps still provides the pool, rapid allocation, Hyper-V isolation, and automatic cleanup, but your image defines the runtime and the API that receives requests. This option provides flexibility at the cost of additional development and maintenance.

Choose a custom container when the workload requires specialized system packages, proprietary document tools, a language unavailable in the built-in interpreter, or a service with its own protocol. A custom container session pool requires a workload profiles-enabled Azure Container Apps environment. You're responsible for these parts of the custom environment:

- **Image maintenance:** Build and maintain the container image.
- **Application ingress:** Expose the application on the configured target port.
- **Logging:** Write application logs to standard output or standard error.
- **Health checks:** Provide endpoints that indicate whether the container can accept work.

The following fragment shows the parts of a custom container definition that establish the application port and health checks. A startup probe allows a runtime with a longer initialization phase to become ready. A liveness probe removes an environment that becomes unhealthy after startup.

```json
{
  "properties": {
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

Custom containers accept requests through the pool management endpoint. Azure Container Apps forwards the path after the endpoint to the container's target port. For example, a request to `/api/convert` reaches the same path in the allocated session container.

## Match the pool to the workload

The best pool type is the least complex option that satisfies the execution contract. Isolation alone doesn't require a custom image because both pool types provide isolated sessions. Runtime and protocol requirements usually determine the choice.

Use these scenarios to guide the decision:

- **Analyze an uploaded CSV:** Choose the built-in Python interpreter when its available packages support the required analysis and chart generation.
- **Run a proprietary converter:** Choose a custom container when the converter requires native binaries or licensed dependencies that you must package.
- **Provide an isolated tenant workspace:** Choose a custom container when each tenant needs a specialized application or development environment rather than the interpreter API.
- **Execute an agent's calculation code:** Choose the built-in interpreter when the agent produces short code fragments and the application only needs execution results and files.

Regardless of pool type, treat the session as ephemeral. A session can preserve files and process state for related calls, but the cooldown eventually removes the environment. Store source documents, accepted results, and audit records in durable application storage.

::: zone-end

## Additional resources

These resources provide more detail about session architecture and the available pool types. You can use them to evaluate runtime support and management responsibilities for your AI solution.

- [Dynamic sessions in Azure Container Apps](/azure/container-apps/sessions)
- [Serverless code interpreter sessions](/azure/container-apps/sessions-code-interpreter)
- [Custom container sessions](/azure/container-apps/sessions-custom-container)
