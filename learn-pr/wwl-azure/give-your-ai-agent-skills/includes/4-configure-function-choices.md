Function advertising and function choice behavior allow developers to control how the AI model accesses and invokes external functions during execution. These lets you tailor the AI's responses based on specific scenarios, such as integrating with APIs for real-time data, restricting functionality for privacy or security, or enhancing the relevance of responses by narrowing the available functions. By strategically managing these behaviors, developers can optimize their AI application's performance.

## Function Advertising

Function advertising means providing specific functions to the AI model so it can invoke them. By default, all of the functions from registered plugins are available unless a list of functions is explicitly provided. You can advertise all registered functions, limit availability to specific ones, or disable function calling entirely to rely solely on the language model's reasoning.

### Advertising All Functions

By using `AddFromType`, all of the functions from the specified classes are registered to the kernel. The AI model can then automatically choose from any of these functions based on the prompt.

```c#
using Microsoft.SemanticKernel;

IKernelBuilder builder = Kernel.CreateBuilder();
builder.AddOpenAIChatCompletion("<model-id>", "<api-key>");
builder.Plugins.AddFromType<WeatherForecastUtils>();
builder.Plugins.AddFromType<DateTimeUtils>();

Kernel kernel = builder.Build();

PromptExecutionSettings settings = new() { FunctionChoiceBehavior = FunctionChoiceBehavior.Auto() };

await kernel.InvokePromptAsync("What is the likely color of the sky in Boston?", new(settings));
```

### Advertising Selected Functions

Instead of making all functions available, you can explicitly select and advertise just the required ones using `Plugins.GetFunction`. This approach offers more control and limits the functions the model can use.

```c#
KernelFunction getWeatherForCity = kernel.Plugins.GetFunction("WeatherForecastUtils", "GetWeatherForCity");
KernelFunction getCurrentTime = kernel.Plugins.GetFunction("DateTimeUtils", "GetCurrentUtcDateTime");

PromptExecutionSettings settings = new() { FunctionChoiceBehavior = FunctionChoiceBehavior.Auto(functions: [getWeatherForCity, getCurrentTime]) };

await kernel.InvokePromptAsync("What is the likely color of the sky in Boston?", new(settings));
```

### Disabling Function Calling

You can prevent the AI model from invoking any functions By setting the `FunctionChoiceBehavior` to use an empty list of functions. Doing this forces the language model to process the prompt instead.

```c#
PromptExecutionSettings settings = new() { FunctionChoiceBehavior = FunctionChoiceBehavior.Auto(functions: []) };

await kernel.InvokePromptAsync("What is the likely color of the sky in Boston?", new(settings));
```

## Using Function Choice Behaviors

Function choice behaviors in the Semantic Kernel allow developers to configure how functions are advertised and selected for invocation by the AI model. 

The `FunctionChoiceBehavior` class provides three static methods to configure these behaviors:

- **`Auto`**: The model can choose from zero or more functions.
- **`Required`**: Forces the model to choose at least one function.
- **`None`**: Prevents the model from choosing any functions.


### Auto Behavior

The `Auto` behavior allows the model to select zero or more functions. It’s useful for scenarios where the AI dynamically determines which functions to invoke.

```c#
PromptExecutionSettings settings = new() { FunctionChoiceBehavior = FunctionChoiceBehavior.Auto() };

await kernel.InvokePromptAsync("What is the likely color of the sky in Boston?", new(settings));
```

### Required Behavior

The `Required` behavior enforces the model to choose at least one function. This is helpful when specific functions must be invoked to get the necessary data.

```c#
KernelFunction getWeatherForCity = kernel.Plugins.GetFunction("WeatherForecastUtils", "GetWeatherForCity");

PromptExecutionSettings settings = new() { FunctionChoiceBehavior = FunctionChoiceBehavior.Required(functions: [getWeatherForCity]) };

await kernel.InvokePromptAsync("What is the likely color of the sky in Boston?", new(settings));
```

### None Behavior

The `None` behavior prevents the model from choosing functions for invocation. Instead, it simulates function selection and provides insights into which functions would have been chosen.

```c#
PromptExecutionSettings settings = new() { FunctionChoiceBehavior = FunctionChoiceBehavior.None() };

await kernel.InvokePromptAsync("Specify which provided functions are needed to determine the sky’s color in Boston.", new(settings));
```

Function choice behaviors provide developers with flexible options for controlling how functions are advertised and invoked by AI models. By understanding and leveraging these behaviors, you can fine-tune AI interactions to suit specific application requirements.

