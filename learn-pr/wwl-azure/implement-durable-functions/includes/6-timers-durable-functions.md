
Durable Functions provides *durable timers* for use in orchestrator functions to implement delays or to set up timeouts on async actions. Durable timers should be used in orchestrator functions instead of `Thread.Sleep` and `Task.Delay` (C#), or `setTimeout()` and `setInterval()` (JavaScript), or `time.sleep()` (Python).

You create a durable timer by calling the `CreateTimer` (.NET) method or the `createTimer` (JavaScript) method of the orchestration trigger binding. The method returns a task that completes on a specified date and time.

## Timer limitations

When you create a timer that expires at 4:30 pm, the underlying Durable Task Framework enqueues a message that becomes visible only at 4:30 pm. When running in the Azure Functions Consumption plan, the newly visible timer message will ensure that the function app gets activated on an appropriate VM.

## Usage for delay

The following example illustrates how to use durable timers for delaying execution. The example is issuing a billing notification every day for 10 days.

```csharp
[FunctionName("BillingIssuer")]
public static async Task Run(
    [OrchestrationTrigger] IDurableOrchestrationContext context)
{
    for (int i = 0; i < 10; i++)
    {
        DateTime deadline = context.CurrentUtcDateTime.Add(TimeSpan.FromDays(i + 1));
        await context.CreateTimer(deadline, CancellationToken.None);
        await context.CallActivityAsync("SendBillingEvent");
    }
}
```

## Usage for timeout

This example illustrates how to use durable timers to implement timeouts.

```csharp
[FunctionName("TryGetQuote")]
public static async Task<bool> Run(
    [OrchestrationTrigger] IDurableOrchestrationContext context)
{
    TimeSpan timeout = TimeSpan.FromSeconds(30);
    DateTime deadline = context.CurrentUtcDateTime.Add(timeout);

    using (var cts = new CancellationTokenSource())
    {
        Task activityTask = context.CallActivityAsync("GetQuote");
        Task timeoutTask = context.CreateTimer(deadline, cts.Token);

        Task winner = await Task.WhenAny(activityTask, timeoutTask);
        if (winner == activityTask)
        {
            // success case
            cts.Cancel();
            return true;
        }
        else
        {
            // timeout case
            return false;
        }
    }
}
```

> [!WARNING]
> Use a `CancellationTokenSource` to cancel a durable timer (.NET) or call `cancel()` on the returned `TimerTask` (JavaScript) if your code will not wait for it to complete. The Durable Task Framework will not change an orchestration's status to "completed" until all outstanding tasks are completed or canceled.

This cancellation mechanism doesn't terminate in-progress activity function or sub-orchestration executions. It simply allows the orchestrator function to ignore the result and move on. 

