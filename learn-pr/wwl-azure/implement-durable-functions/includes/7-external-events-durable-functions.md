

Orchestrator functions have the ability to wait and listen for external events. This feature of Durable Functions is often useful for handling human interaction or other external triggers.

## Wait for events

The `WaitForExternalEvent` (.NET), `waitForExternalEvent` (JavaScript), and `wait_for_external_event` (Python) methods of the orchestration trigger binding allows an orchestrator function to asynchronously wait and listen for an external event. The listening orchestrator function declares the *name* of the event and the *shape of the data* it expects to receive.

The following example listens for a specific single event and takes action when it's received.

```csharp
[FunctionName("BudgetApproval")]
public static async Task Run(
    [OrchestrationTrigger] IDurableOrchestrationContext context)
{
    bool approved = await context.WaitForExternalEvent<bool>("Approval");
    if (approved)
    {
        // approval granted - do the approved action
    }
    else
    {
        // approval denied - send a notification
    }
}
```

## Send events

The `RaiseEventAsync` (.NET) or `raiseEvent` (JavaScript) method of the orchestration client binding sends the events that `WaitForExternalEvent` (.NET) or `waitForExternalEvent` (JavaScript) waits for.  The `RaiseEventAsync` method takes *eventName* and *eventData* as parameters. The event data must be JSON-serializable.

Below is an example queue-triggered function that sends an "Approval" event to an orchestrator function instance. The orchestration instance ID comes from the body of the queue message.

```csharp
[FunctionName("ApprovalQueueProcessor")]
public static async Task Run(
    [QueueTrigger("approval-queue")] string instanceId,
    [DurableClient] IDurableOrchestrationClient client)
{
    await client.RaiseEventAsync(instanceId, "Approval", true);
}
```

Internally, `RaiseEventAsync` (.NET) or `raiseEvent` (JavaScript) enqueues a message that gets picked up by the waiting orchestrator function. If the instance is not waiting on the specified *event name,* the event message is added to an in-memory queue. If the orchestration instance later begins listening for that *event name,* it will check the queue for event messages.
