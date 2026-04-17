Function advertising and function choice behavior allow developers to control how the AI model accesses and invokes external functions during execution. These Advertized Functions let you tailor the AI's responses based on specific scenarios, such as integrating with APIs for real-time data, restricting functionality for privacy or security, or enhancing the relevance of responses by narrowing the available functions. By strategically managing Function advertising behaviors, developers can optimize their AI application's performance.

## Function Advertising

Function advertising means providing specific functions to the AI model so it can invoke them. By default, all of the functions from registered plugins are available unless a list of functions is explicitly provided. You can advertise all registered functions, limit availability to specific ones, or disable function calling entirely to rely solely on the language model's reasoning.

### Advertising All Functions

By using `AddFromType`, all of the functions from the specified classes are registered to the kernel. The AI model can then automatically choose from any of these functions based on the prompt.

::: zone pivot="csharp"

By registering your plugin classes with the kernel, all of their functions become available to the AI model. The model can then automatically choose from any of these functions based on the prompt. Use `AddFromType` to register all functions from a class as plugins.

```csharp
using Microsoft.SemanticKernel;

IKernelBuilder builder = Kernel.CreateBuilder();
builder.AddOpenAIChatCompletion("<model-id>", "<api-key>");
builder.Plugins.AddFromType<WeatherForecastUtils>();
builder.Plugins.AddFromType<DateTimeUtils>();

Kernel kernel = builder.Build();

PromptExecutionSettings settings = new() { FunctionChoiceBehavior = FunctionChoiceBehavior.Auto() };

await kernel.InvokePromptAsync("What is the likely color of the sky in Boston?", new(settings));
```

::: zone-end

::: zone pivot="python"

When you register plugin classes with the kernel, all of their functions become available to the AI model. The model can then automatically choose from any of these functions based on the prompt. In Python, use `add_plugin` to register your plugin classes and their functions.

```python
import os
from semantic_kernel import Kernel
from semantic_kernel.connectors.ai.open_ai import AzureChatCompletion, OpenAIPromptExecutionSettings
from semantic_kernel.functions.kernel_function_decorator import kernel_function
from semantic_kernel.contents.chat_history import ChatHistory

class WeatherForecastUtils:
    @kernel_function(name="GetWeatherForCity", description="Gets the weather for a given city.")
    def get_weather_for_city(self, city: str) -> str:
        return "Sunny"  # Stub for demo

class DateTimeUtils:
    @kernel_function(name="GetCurrentUtcDateTime", description="Gets the current UTC date and time.")
    def get_current_utc_date_time(self) -> str:
        import datetime
        return datetime.datetime.utcnow().isoformat()

deployment_name = os.getenv("DEPLOYMENT_NAME")
endpoint = os.getenv("PROJECT_ENDPOINT")
api_key = os.getenv("PROJECT_KEY")

kernel = Kernel()
chat_service = AzureChatCompletion(
    deployment_name=deployment_name,
    endpoint=endpoint,
    api_key=api_key
)
kernel.add_service(chat_service, "chat_completion")
kernel.add_plugin(WeatherForecastUtils(), "WeatherForecastUtils")
kernel.add_plugin(DateTimeUtils(), "DateTimeUtils")

settings = OpenAIPromptExecutionSettings()
chat_history = ChatHistory()
chat_history.add_user_message("What is the likely color of the sky in Boston?")

result = chat_service.get_chat_message_content(
    chat_history=chat_history,
    kernel=kernel,
    settings=settings
)
print(result)
```

::: zone-end

### Advertising Selected Functions

Instead of making all functions available, you can explicitly select and advertise just the required ones. This approach offers more control and limits the functions the model can use.

::: zone pivot="csharp"

Use `Plugins.GetFunction` to select specific functions to advertise to the model. You can then pass these to `FunctionChoiceBehavior.Auto(functions: ...)` in your settings.

```csharp
KernelFunction getWeatherForCity = kernel.Plugins.GetFunction("WeatherForecastUtils", "GetWeatherForCity");
KernelFunction getCurrentTime = kernel.Plugins.GetFunction("DateTimeUtils", "GetCurrentUtcDateTime");

PromptExecutionSettings settings = new() { FunctionChoiceBehavior = FunctionChoiceBehavior.Auto(functions: [getWeatherForCity, getCurrentTime]) };

await kernel.InvokePromptAsync("What is the likely color of the sky in Boston?", new(settings));
```

::: zone-end

::: zone pivot="python"

You control which functions are available by only registering the plugins you want the model to access. The SDK doesn't currently support restricting advertised functions directly in settings.

```python
# As of SK 1.31, Python SDK does not support restricting advertised functions directly in settings.
# The closest approach is to only register the plugins you want available.

kernel = Kernel()
chat_service = AzureChatCompletion(
    deployment_name=deployment_name,
    endpoint=endpoint,
    api_key=api_key
)
kernel.add_service(chat_service, "chat_completion")
kernel.add_plugin(WeatherForecastUtils(), "WeatherForecastUtils")
# Only add DateTimeUtils if you want it available:
# kernel.add_plugin(DateTimeUtils(), "DateTimeUtils")

settings = OpenAIPromptExecutionSettings()
chat_history = ChatHistory()
chat_history.add_user_message("What is the likely color of the sky in Boston?")

result = chat_service.get_chat_message_content(
    chat_history=chat_history,
    kernel=kernel,
    settings=settings
)
print(result)
```

::: zone-end

### Disabling Function Calling

You can prevent the AI model from invoking any functions, forcing it to rely solely on its language model capabilities to process the prompt.

::: zone pivot="csharp"

Set the `FunctionChoiceBehavior` to use an empty list of functions to disable function calling.

```csharp
PromptExecutionSettings settings = new() { FunctionChoiceBehavior = FunctionChoiceBehavior.Auto(functions: []) };

await kernel.InvokePromptAsync("What is the likely color of the sky in Boston?", new(settings));
```

::: zone-end

::: zone pivot="python"

In Python, don't register any plugins with the kernel to disable function calling.

```python
# In Python, you can disable function calling by not registering any plugins,
# or by using settings that prevent tool/function use if supported in your SDK version.
# As of SK 1.31, you can use the following pattern:

settings = OpenAIPromptExecutionSettings()  # No plugins registered, so no functions available

kernel = Kernel()
chat_service = AzureChatCompletion(
    deployment_name=deployment_name,
    endpoint=endpoint,
    api_key=api_key
)
kernel.add_service(chat_service, "chat_completion")
# Do NOT add any plugins

chat_history = ChatHistory()
chat_history.add_user_message("What is the likely color of the sky in Boston?")

result = chat_service.get_chat_message_content(
    chat_history=chat_history,
    kernel=kernel,
    settings=settings
)
print(result)
```

::: zone-end

## Using Function Choice Behaviors

The Semantic Kernel SDK provides several ways to configure how functions are advertised and selected for invocation by the AI model:

- **Auto**: The model can choose from zero or more functions.
- **Required**: The model is encouraged or required to choose at least one function.
- **None**: The model can't choose any functions.

::: zone pivot="csharp"

Use the `FunctionChoiceBehavior` class to configure these behaviors in C#.

::: zone-end

::: zone pivot="python"

In Python, these function behaviors are controlled by which plugins you register and, in some cases, by prompt engineering. The SDK doesn't currently provide direct equivalents for all C# behaviors.

::: zone-end

Function choice behaviors provide developers with flexible options for controlling how functions are advertised and invoked by AI models. By understanding and using these behaviors, you can fine-tune AI interactions to suit specific application requirements.
