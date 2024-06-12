The templating language of the Semantic Kernel SDK allows you to create dynamic prompts. The language supports three features:

1. Using variables.
1. Calling external functions.
1. Passing arguments to functions.

To embed expressions in your prompts, the templating language uses curly brackets `{{...}}` and variables are denoted by a dollar sign `$`. The functions you call must be part of the plugins you load into the kernel. For example, if you want to call a function within a prompt, you can use the following syntax:

`{{plugin.functionName $argument}}`

You must ensure that the plugin containing the function is loaded into the kernel before you call the function in your prompt. Nesting functions within prompts can help you reduce the number of tokens used in a prompt, or provide additional context to the model for improved results. 

Suppose you have a prompt to recommend a list of recipes based on some user information:


```c#
string history = @"In the heart of my bustling kitchen, I have embraced the challenge 
    of satisfying my family's diverse taste buds and navigating their unique tastes. 
    With a mix of picky eaters and allergies, my culinary journey revolves around 
    exploring a plethora of vegetarian recipes.

    One of my kids is a picky eater with an aversion to anything green,  while another 
    has a peanut allergy that adds an extra layer of complexity to meal planning. 
    Armed with creativity and a passion for wholesome cooking, I've embarked on a 
    flavorful adventure, discovering plant-based dishes that not only please the 
    picky palates but are also heathy and delicious.";

string prompt = @"This is some information about the user's background: {{$history}}
    Given this user's background, provide a list of relevant recipes.";

var result = await kernel.InvokePromptAsync(suggestRecipes, new() { "history", history });
Console.WriteLine(result);
```

You could call a function to summarize the user's lengthy background information before providing a list of recipes. Here's an example of how you can use functions in prompts:

```c#
 kernel.ImportPluginFromType<ConversationSummaryPlugin>();

string prompt = @"User information: 
    {{ConversationSummaryPlugin.SummarizeConversation $history}}

    Given this user's background information, provide a list of relevant recipes.";

var result = await kernel.InvokePromptAsync(suggestRecipes, new() { "history", history });
Console.WriteLine(result);
```

In this example, the prompt calls `ConversationSummaryPlugin.SummarizeConversation` on the provided `$history` input. The function takes the user's background information and summarizes it, and the result is used to retrieve the list of relevant recipes. The `ConversationSummaryPlugin` plugin must be added to the kernel builder for the prompt to work correctly.

Here's the example output:

```output
1. Lentil and vegetable soup - a hearty, filling soup that is perfect for a cold day. This recipe is vegetarian and can easily be adapted to accommodate allergies.

2. Cauliflower "steaks" - a delicious and healthy main course that is sure to satisfy even the pickiest of eaters. This recipe is vegetarian and can easily be made vegan.

3. Quinoa salad with roasted vegetables - a healthy and filling salad that is perfect for any occasion. This recipe is vegetarian and can easily be adapted to accommodate allergies.

4. Peanut-free pad Thai - a classic dish made without peanut sauce, perfect for those with peanut allergies. This recipe is vegetarian and can easily be made vegan.

5. Black bean and sweet potato enchiladas - a delicious and healthy twist on traditional enchiladas. This recipe is vegetarian and can easily be made vegan.
```

Using variables and functions in prompts allows you to create reusable templates that can be dynamically populated with different inputs. Reusing prompts is especially useful when you need to perform the same task with different inputs, or provide context to the model for improved results.