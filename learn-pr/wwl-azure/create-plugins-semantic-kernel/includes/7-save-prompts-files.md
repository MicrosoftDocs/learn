In the previous units, you learned how to create reusable prompts by calling `kernel.CreateFunctionFromPrompt`. For example:

```c#
var generateNames = kernel.CreateFunctionFromPrompt(prompt);
Console.WriteLine(
    await kernel.InvokeAsync(generateNames, new() {{"input", "fantasy character" }})
);
```

Creating inline prompts is useful, but for larger projects, you may want to organize your prompts into separate files and import them into the kernel. This is similar to the way built in plugins are used. To create your own prompt plugins, a best practice is to create separate folders for your prompts.

For example, suppose you want to create a prompt to recommend chords to add to a potential chord progression. The user can provide starting chords and the plugin recommends chords that would be a good fit.

You would first create a 'Prompts' folder in your project. Then a subfolder called 'SuggestChords.' Afterwards, there are two files needed for the prompt plugin: 'skprompt.txt' and 'config.json.' The skprompt.txt file contains the prompt sent to the large language model (LLM). The config.json file contains the configuration along with a description of what the prompt does.

```html
<!-- Prompts/SuggestChords/skprompt.txt -->

<message role="system">Instructions: You are a helpful music 
theory assistant. Provide the user with several chords that 
they could add to a chord progression based on some starting
chords they provide</message>
<message role="user">Am Em</message>
<message role="assistant">
C major, F major, G major, D major, E major, B minor
</message>

<message role="user"> {{$startingChords}}</message>
```

Semantic Kernel SDK supports a prompt templating language with some simple syntax rules. You don't need to write code or import any external libraries, just use the curly braces {{...}} to embed expressions in your prompts. Semantic Kernel parses your template and runs the logic behind it. The language supports adding variables, calling external functions, and passing parameters to functions. In this example, we're using a variable `startingChords` to pass the starting chords to the prompt.

The config.json file contains configuration details for the prompt. It should be placed in the same folder as the skprompt.txt file. The config file supports the following parameters: 

- `type`: The type of prompt. In this case, we're using the chat completion type.
- `description`: A description of what the prompt does. This description can be used by the kernel to automatically invoke the prompt.
- `input_variables`: Defines the variables that are used inside of the prompt.
- `execution_settings`: The settings for completion models. For OpenAI models, these settings include the `max_tokens` and `temperature` properties.

```json
{
    "schema": 1,
    "type": "completion",
    "description": "Recommends chords to the user based on starting chords",
    "execution_settings": {
        "default": {
            "max_tokens": 1000,
            "temperature": 0
        }
    },
    "input_variables": [
        {
            "name": "startingChords",
            "description": "The starting chords provided by the user",
            "required": true
        },
    ]
}
```

In this example, the `temperature` is a parameter that controls how much to randomize the generated text. The values must be between 0 and 2. A lower temperature results in more focused and precise output. A higher temperature results in more diverse and creative output. 

In the current model, requests can use up to 4,097 tokens shared between prompt and completion. Meaning if the prompt is 4,000 tokens, the chat completion can be 97 tokens at most. You can find more info on fine tuning parameters in the documentation of your LLM. 

To use the newly created prompt, you can import it into your project by adding the following code to your Program.cs file:

```c#
var prompts = kernel.CreatePluginFromPromptDirectory("Prompts");
string input = "G, C";

var result = await kernel.InvokeAsync(
    prompts["SuggestChords"],
    new() {
        { "startingChords", input },
    }
);
Console.WriteLine(result);
```

In this example, `CreatePluginFromPromptDirectory` returns a `KernelPlugin` object. This object represents a collection of functions. `CreatePluginFromPromptDirectory` accepts the path of a plugin directory, and each subdirectory's name is used as the function name. For example, if you nested 'SuggestChords' inside a folder called 'ChordProgressions,' you would use the prompt directory 'Prompts/ChordProgressions' and the function name would stay the same.

Running this code should produce a response similar to the following output:

```output
D major, A minor, E minor, B minor, F major, G7
```

Saving your prompts to files is a great way to organize your code and make it more maintainable. The configuration files also allow you to further tune your prompts for a more predictable user experience.