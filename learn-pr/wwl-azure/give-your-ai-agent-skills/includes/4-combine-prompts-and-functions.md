Plugins can consist of both native code and semantic prompts to the large language model (LLM). By combining native functions and prompts to the LLM, you can quickly create intelligent applications.

You can call your own plugin functions inside your custom prompts. The flexibility provided by the Semantic Kernel SDK allows you to create prompts that can call any other plugins. This means that you can create prompts that call other prompts, or prompts that call your own custom functions!

For example, suppose you want the LLM to suggest a recipe based on some ingredients the user has in their pantry. You could create a native function that retrieves a list of ingredients from the user. Then create a prompt that calls your function and requests a recipe from the LLM. Let's see how this works.

Suppose this list contains the user's ingredients stored in ingredients.txt:
```json
[
    "sugar",
    "eggs",
    "milk",
    "cocoa powder",
    "flour",
    "baking powder",
    "butter",
    "vanilla extract",
    "salt",
    "chocolate chips",
    "walnuts",
    "pecans",
    "cinnamon",
    "nutmeg",
    "sweet potatoes"
]
```

Then your plugin to retrieve the ingredients might be similar to this code:
```c#
public class IngredientsPlugin
{
    [KernelFunction, Description("Get a list of the user's ingredients")]
    public static string GetIngredients()
    {
        string dir = Directory.GetCurrentDirectory();
        string content = File.ReadAllText($"{dir}/ingredients.txt");
        return content;
    }
}
```

And your prompt might look like this:
```c#
kernel.ImportPluginFromType<IngredientsPlugin>();

string prompt = @"This is a list of ingredients available to the user:
    {{IngredientsPlugin.GetIngredients}} 
    
    Please suggest a recipe the user could make with 
    some of the ingredients they have available";

var result = await kernel.InvokePromptAsync(prompt);
Console.WriteLine(result);
```

In the next unit, you'll practice combining prompts and functions!