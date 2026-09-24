::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=2bcb9b1d-287a-4f15-b2c3-3e981b503504]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

In this module, you learned why AI-generated and user-submitted code needs an execution boundary outside the AI application's process. You compared the platform-managed code interpreter with custom container session pools and selected a pool from the workload's runtime requirements. You also compared direct REST API access with the `langchain-azure-dynamic-sessions` adapter for LangChain agents. Additionally, you explored how maximum concurrency, ready instances, cooldown, and outbound network access affect security, latency, and resource use. You authenticated a backend with Microsoft Entra ID and used application-controlled session identifiers to execute code and exchange files. You treated session state as temporary and separated transport, execution, and validation failures. Finally, you applied deadlines, safe retry decisions, explicit cleanup, and controlled error responses to a dynamic session workflow.

::: zone-end

## Additional resources

These resources provide current details about session pool configuration and application integration. You can use them as you design isolated code execution for your own AI solutions.

- [Dynamic sessions in Azure Container Apps](/azure/container-apps/sessions) explains session architecture, benefits, and supported pool types.
- [Use session pools in Azure Container Apps](/azure/container-apps/session-pool) describes capacity, lifecycle, network, and management endpoint configuration.
- [Serverless code interpreter sessions](/azure/container-apps/sessions-code-interpreter) documents code execution and file operations for the built-in interpreter.
- [Use dynamic sessions securely](/azure/container-apps/sessions-usage#security) explains authentication, identifier protection, network access, and sensitive-data considerations.
