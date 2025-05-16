Filters in Semantic Kernel empower developers to manage and secure function execution by enabling fine-grained control and visibility. They're instrumental in building responsible AI solutions that meet enterprise standards. Filters validate actions like user permissions or modify interactions with AI models to ensure compliance and reliability.

## Types of filters

Semantic Kernel offers three types of filters to enhance control and customization: **Function Invocation Filters** for managing function execution, **Prompt Render Filters** for modifying prompts before submission, and **Auto Function Invocation Filters** for directing multi-step workflows. Each filter type addresses specific needs, enabling developers to build secure and adaptable AI solutions.

### Function Invocation Filter

This filter runs every time a function is executed, whether it originates from a prompt or is implemented in C#. Its capabilities include:

- Accessing metadata about the function and its arguments.
- Logging or validating actions before and after execution.
- Overriding results or retrying operations using alternative AI models.

Here's an example of a function invocation filter that logs the invoked plugin function:

```c#
public sealed class LoggingFilter(ILogger logger) : IFunctionInvocationFilter
{
    public async Task OnFunctionInvocationAsync(FunctionInvocationContext context, Func<FunctionInvocationContext, Task> next)
    {
        logger.LogInformation("Invoking: {PluginName}.{FunctionName}", context.Function.PluginName, context.Function.Name);

        await next(context);

        logger.LogInformation("Executed: {PluginName}.{FunctionName}", context.Function.PluginName, context.Function.Name);
    }
}
```

### Prompt Render Filter

Triggered during prompt rendering, this filter provides control over how prompts are formatted and submitted to AI. It's ideal for tasks like modifying prompts for sensitive information (e.g., PII redaction) or enabling semantic caching.

Here's an example of a prompt render filter:

```c#
public class SafePromptFilter : IPromptRenderFilter
{
    public async Task OnPromptRenderAsync(PromptRenderContext context, Func<PromptRenderContext, Task> next)
    {
        await next(context);

        // Modify prompt before submission
        context.RenderedPrompt = "Safe and sanitized prompt.";
    }
}
```

### Auto Function Invocation Filter

This filter is invoked only during the automatic function calling process. It can adjust or even terminate workflows based on intermediate results.

Here's an example of a function invocation filter that terminates the function calling process:

```c#
public sealed class EarlyTerminationFilter : IAutoFunctionInvocationFilter
{
    public async Task OnAutoFunctionInvocationAsync(AutoFunctionInvocationContext context, Func<AutoFunctionInvocationContext, Task> next)
    {
        await next(context);

        var result = context.Result.GetValue<string>();
        if (result == "desired result")
        {
            context.Terminate = true;
        }
    }
}
```

### Integrate function filters

To integrate any of the function filters, you can use the following methods:

- **Dependency Injection**:
    
    Add the function to the KernelBuilder services:

    ```c#
    builder.Services.AddSingleton<IFunctionInvocationFilter, LoggingFilter>();
    ```

- **Kernel Properties**:

    Add the function to the kernel's `FunctionInvocationFilters` list:

    ```c#
    kernel.FunctionInvocationFilters.Add(new LoggingFilter(logger));
    ```

Always invoke the `next` delegate in your function filter to allow subsequent filters or the primary operation to execute. Skipping this step blocks the operation.

By integrating these filters thoughtfully, you can enhance both the functionality and security of your Semantic Kernel implementations, aligning with best practices for responsible AI development.