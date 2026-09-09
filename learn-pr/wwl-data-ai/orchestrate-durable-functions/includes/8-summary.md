::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=bc9335b3-20a5-4e62-90e0-73716ff50fe7]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

In this module, you learned how Azure Durable Functions coordinates reliable, long-running AI workflows through persisted orchestration history. You explored why orchestrator functions must remain deterministic and why model calls, storage access, notifications, and other input/output operations belong in activity functions. You also learned how fan-out/fan-in runs independent document or media tasks in parallel and aggregates compact results. Additionally, you examined how external events and durable timers let a workflow wait for human approval without holding compute resources. Finally, you learned how bounded retries address transient failures. Idempotent activities make repeated execution safe. Explicit timeouts and compensation give failed, rejected, or expired workflow steps clear outcomes.

::: zone-end

## Additional resources

These resources provide deeper guidance for the durable workflow patterns covered in the module. You can use them when you design and operate a production AI application.

- [Durable Functions overview](/azure/azure-functions/durable/durable-functions-overview)
- [Orchestrator function code constraints](/azure/durable-task/common/durable-task-code-constraints)
- [Fan-out/fan-in pattern](/azure/durable-task/common/durable-task-fan-in-fan-out)
- [Human interaction pattern](/azure/durable-task/common/durable-task-human-interaction)
