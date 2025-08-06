Filters in Semantic Kernel empower developers to manage and secure function execution by enabling fine-grained control and visibility. They're instrumental in building responsible AI solutions that meet enterprise standards. Filters validate actions like user permissions or modify interactions with AI models to ensure compliance and reliability.

## Types of filters

Semantic Kernel offers three types of filters to enhance control and customization: **Function Invocation Filters** for managing function execution, **Prompt Render Filters** for modifying prompts before submission, and **Auto Function Invocation Filters** for directing multi-step workflows. Each filter type addresses specific needs, enabling developers to build secure and adaptable AI solutions.

### Function Invocation Filter

This filter runs every time a function is executed, whether it originates from a prompt or is implemented in C#. Its capabilities include:

- Accessing metadata about the function and its arguments.
- Logging or validating actions before and after execution.
- Overriding results or retrying operations using alternative AI models.

Here's an example of a function invocation filter that logs the invoked plugin function:

::: zone pivot="csharp"

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

::: zone-end

::: zone pivot="python"

```python
# Python example: Function invocation filter using a decorator

from semantic_kernel.functions.kernel_function_decorator import kernel_function

def logging_filter(func):
    def wrapper(*args, **kwargs):
        print(f"Invoking: {func.__qualname__}")
        result = func(*args, **kwargs)
        print(f"Executed: {func.__qualname__}")
        return result
    return wrapper

class WeatherForecastUtils:
    @kernel_function(name="GetWeatherForCity", description="Gets the weather for a given city.")
    @logging_filter
    def get_weather_for_city(self, city: str) -> str:
        return "Sunny"
```

::: zone-end

### Prompt Render Filter

Triggered during prompt rendering, this filter provides control over how prompts are formatted and submitted to AI. It's ideal for tasks like modifying prompts for sensitive information (e.g., PII redaction) or enabling semantic caching.

Here's an example of a prompt render filter:

::: zone pivot="csharp"

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

::: zone-end

::: zone pivot="python"

```python
# Python example: Prompt render filter using a decorator

def safe_prompt_filter(render_func):
    def wrapper(*args, **kwargs):
        prompt = render_func(*args, **kwargs)
        # Modify prompt before submission
        return "Safe and sanitized prompt."
    return wrapper

@safe_prompt_filter
def render_prompt(user_input):
    return f"User prompt: {user_input}"

# Example usage
print(render_prompt("Sensitive information here"))
```

::: zone-end

### Auto Function Invocation Filter

This filter is invoked only during the automatic function calling process. It can adjust or even terminate workflows based on intermediate results.

Here's an example of a function invocation filter that terminates the function calling process:

::: zone pivot="csharp"

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

::: zone-end

::: zone pivot="python"

```python
# Python example: Auto function invocation filter using a decorator

def early_termination_filter(func):
    def wrapper(*args, **kwargs):
        result = func(*args, **kwargs)
        # Simulate checking the result and terminating if needed
        if result == "desired result":
            print("Terminating workflow early.")
            return result
        return result
    return wrapper

@early_termination_filter
def auto_function():
    # Simulate function logic
    return "desired result"

# Example usage
auto_function()
```

::: zone-end

### Integrate function filters

::: zone pivot="csharp"

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

::: zone-end

::: zone pivot="python"

To integrate filters in Python, apply decorators to your plugin methods or prompt rendering functions as shown above.  
Register your plugin class with the kernel as usual:

```python
kernel.add_plugin(WeatherForecastUtils(), "WeatherForecastUtils")
```

The decorated methods will have the filter logic applied automatically.

::: zone-end

Always invoke the `next` delegate in your function filter to allow subsequent filters or the primary operation to execute. Skipping this step blocks the operation.

By integrating prompt render filters, you make your Semantic Kernel solutions safer and more reliable. Prompt filters let you sanitize prompts before they reach the AI. Auto-invocation filters let you control function execution, enabling early termination or custom logic based on results.
