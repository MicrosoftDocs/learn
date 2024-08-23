The Semantic Kernel SDK supports a powerful automatic function calling feature. Enabling automatic function calling allows the kernel to automatically select which functions and prompts to use on some provided input. This feature can help you save time manually invoke functions and prompts and make your applications smarter.

To use automatic function calling, you must use an OpenAI model that supports it. Currently, these models include GPT-3.5-turbo and GPT-4 models that are version 0613 or newer.

To enable auto function calling, you must set the `ToolCallBehavior` property of the `OpenAIPromptExecutionSettings` object to `AutoInvokeKernelFunctions`. 

For example, suppose you have some ingredient plugins that support the following functions:

    - `GetIngredients`: Gets a list of the user's available ingredients
    - `GetRecipe`: Gets a list of ingredients for a given recipe
    - `GetMissingIngredients`: Gets a list of ingredients that are missing from the user's kitchen for a given recipe

You can use the `AutoInvokeKernelFunctions` behavior to automatically run a function based on a prompt. For example:

```c#
using Microsoft.SemanticKernel;
using Microsoft.SemanticKernel.Connectors.OpenAI;

var builder = Kernel.CreateBuilder();
builder.AddAzureOpenAIChatCompletion(
    "your-deployment-name",
    "your-endpoint",
    "your-api-key",
    "deployment-model");

kernel.ImportPluginFromType<IngredientsPlugin>();
kernel.ImportPluginFromPromptDirectory("Prompts/IngredientPrompts");

// Set the ToolCallBehavior property
OpenAIPromptExecutionSettings settings = new()
{
    ToolCallBehavior = ToolCallBehavior.AutoInvokeKernelFunctions
};

string prompt = @"What ingredients am I missing from my current list of ingredients 
    to make a recipe for aloo jeera?";

// Use the settings to automatically invoke plugins based on the prompt
var result = await kernel.InvokePromptAsync(prompt, new(settings));

Console.WriteLine(result);
```

Depending on your ingredients and function details, the output of this code might be similar to the following response:

```output
Based on the list of ingredients for aloo jeera, you are missing the following items:

- Cumin seeds
- Green chilies
- Ginger
- Turmeric powder
- Red chili powder
- Coriander powder
- Fresh coriander leaves
- Salt
- Oil
```

The `AutoInvokeKernelFunctions` setting automatically calls the necessary plugins to run the prompt, making your application dynamic and robust with less code. This feature can help you create more complex applications that can handle a variety of scenarios.
