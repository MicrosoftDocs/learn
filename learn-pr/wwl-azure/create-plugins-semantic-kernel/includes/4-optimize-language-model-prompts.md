The Semantic Kernel SDK also supports a templating language that allows you to complete a task using natural language prompts. Prompts are conversational cues you give to large language models (LLMs), shaping responses based on your queries or instructions. For example, you can prompt LLMs to convert a sentence from English to French, or to generate a summary of a text.

In the previous unit, you created the prompt as the input string:

```c#
    string input = @"I'm a vegan in search of new recipes. 
    I love spicy food! Can you give me a list of breakfast 
    recipes that are vegan friendly?";
```

Prompting involves crafting clear, context rich instructions to guide the model to generate a desired response. To craft an effective prompt, precision and clarity are key. You may need to experiment and adjust your prompts for accurate results. 

## Tips for crafting prompts

- **Specific Inputs Yield Specific Outputs**: LLMs respond based on the input they receive. Crafting clear and specific prompts is crucial to get the desired output.

- **Experimentation is Key**: You may need to iterate and experiment with different prompts to understand how the model interprets and generates responses. Small tweaks can lead to significant changes in outcomes.

- **Context Matters**: LLMs consider the context provided in the prompt. You should ensure that the context is well-defined and relevant to obtain accurate and coherent responses.

- **Handle Ambiguity**: Bear in mind that LLMs may struggle with ambiguous queries. Provide context or structure to avoid vague or unexpected results.

- **Length of Prompts**: While LLMs can process both short and long prompts, you should consider the trade-off between brevity and clarity. Experimenting with prompt length can help you find the optimal balance.

## Create prompt templates

The templating language of the Semantic Kernel SDK allows you to create reusable prompts. Using tokens, you can dynamically replace the input parameters of a prompt. You can also call functions within the prompt to perform operations on the input parameters. To embed expressions in your prompts, the templating language uses curly brackets `{{...}}`.

```c#
using Microsoft.SemanticKernel;
using Microsoft.SemanticKernel.Plugins.Core;

var builder = Kernel.CreateBuilder();
    builder.Services.AddAzureOpenAIChatCompletion(
        "your-resource-name",
        "your-endpoint",
        "your-resource-key",
        "deployment-model");

builder.Plugins.AddFromType<ConversationSummaryPlugin>();
var kernel = builder.Build();

string history = @"In the heart of my bustling kitchen, I have embraced 
    the challenge of satisfying my family's diverse taste buds and 
    navigating their unique tastes. With a mix of picky eaters and 
    allergies, my culinary journey revolves around exploring a plethora 
    of vegetarian recipes.

    One of my kids is a picky eater with an aversion to anything green, 
    while another has a peanut allergy that adds an extra layer of complexity 
    to meal planning. Armed with creativity and a passion for wholesome 
    cooking, I've embarked on a flavorful adventure, discovering plant-based 
    dishes that not only please the picky palates but are also heathy and 
    delicious.";

string functionPrompt = @"User background: 
    {{ConversationSummaryPlugin.SummarizeConversation $history}}
    Given this user's background, provide a list of relevant recipes.";

var suggestRecipes = kernel.CreateFunctionFromPrompt(functionPrompt);
var result = await kernel.InvokeAsync(suggestRecipes, 
    new KernelArguments() {
        { "history", history }
    });

Console.WriteLine(result);
```

In this example, `functionPrompt` is a prompt template that calls `ConversationSummaryPlugin.SummarizeConversation` on some input, denoted by `$history`. The prompt tells the model to use this input to provide a list of recipes. `kernel.CreateFunctionFromPrompt` returns a `KernelFunction` that can be invoked with the required input. 

Here's the example output:

```output
1. Lentil and vegetable soup - a hearty, filling soup that is perfect for a cold day. This recipe is vegetarian and can easily be adapted to accommodate allergies.

2. Cauliflower "steaks" - a delicious and healthy main course that is sure to satisfy even the pickiest of eaters. This recipe is vegetarian and can easily be made vegan.

3. Quinoa salad with roasted vegetables - a healthy and filling salad that is perfect for any occasion. This recipe is vegetarian and can easily be adapted to accommodate allergies.

4. Peanut-free pad Thai - a classic dish made without peanut sauce, perfect for those with peanut allergies. This recipe is vegetarian and can easily be made vegan.

5. Black bean and sweet potato enchiladas - a delicious and healthy twist on traditional enchiladas. This recipe is vegetarian and can easily be made vegan.
```

Using variables and functions in prompts allows you to create reusable templates that can be dynamically populated with different inputs. Reusing prompts is especially useful when you need to perform the same task with different inputs, or provide context to the model for improved results.