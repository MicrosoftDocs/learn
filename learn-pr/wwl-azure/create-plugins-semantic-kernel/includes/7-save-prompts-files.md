In the previous units, you learned how to create reusable prompts by calling `kernel.InvokePromptAsync`. For example:

```c#
Console.WriteLine(
    await kernel.InvokePromptAsync(generateNamesOfPrompt, new() {{ "input", "fantasy characters" }})
);
```

Creating inline prompts is useful, but for larger projects, you may want to organize your prompts into separate files and import them into the kernel. This is similar to the way built in plugins are used. To create your own prompt plugins, a best practice is to create separate folders for your prompts.''

## How to create semantic plugins

Semantic Kernel SDK supports a prompt templating language with some simple syntax rules. You don't need to write code or import any external libraries, just use the curly braces {{...}} to embed expressions in your prompts.

To create a semantic plugin, you need a folder containing two files: a `skprompt.txt` file and a `config.json` file. The `skprompt.txt` file contains the prompt to the large language model (LLM), similar to all the prompts you wrote so far. The `config.json` file contains the configuration details for the prompt. 

The `config.json` file supports the following parameters: 
- `type`: The type of prompt. You typically use the chat completion prompt type.
- `description`: A description of what the prompt does. This description can be used by the kernel to automatically invoke the prompt.
- `input_variables`: Defines the variables that are used inside of the prompt.
- `execution_settings`: The settings for completion models. For OpenAI models, these settings include the `max_tokens` and `temperature` properties.

For example, suppose you want to create a music tutor agent. You may want to support a feature that suggests chords to add to a potential chord progression. In this case, the user provides starting chords and the plugin recommends chords that would be a good fit.

To create this plugin, you would first create a 'Prompts' folder in your project, then a subfolder called 'SuggestChords.' Afterwards, you add the 'skprompt.txt' and 'config.json'  files to your 'SuggestChords' folder.

Example of 'skprompt.txt' file:
```html
<message role="system">Instructions: You are a helpful music theory assistant. 
Provide the user with several chords that they could add to a chord progression 
based on some starting chords they provide</message>
<message role="user">Am Em</message>
<message role="assistant">
C major, F major, G major, D major, E major, B minor
</message>

<message role="user"> {{$startingChords}}</message>
```

Example of 'config.json' file:
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

In this example, the `temperature` is a parameter that controls how much to randomize the generated text. The values must be between 0 and 2. A lower temperature results in more focused and precise output, and a higher temperature results in more diverse and creative output. 

In the current model, requests can use up to 4,097 tokens shared between prompt and completion. This means if the prompt is 4,000 tokens, the chat completion can be 97 tokens at most. You can find more info on fine tuning parameters in the documentation of your LLM. 

To use your custom semantic plugin, you import the prompt directory into the kernel and call the plugin by its folder name. For example:

```c#
var plugins = kernel.CreatePluginFromPromptDirectory("Prompts");
string input = "G, C";

var result = await kernel.InvokeAsync(
    plugins["SuggestChords"],
    new() {{ "startingChords", input }});

Console.WriteLine(result);
```

In this example, `CreatePluginFromPromptDirectory` returns a `KernelPlugin` object. This object represents a collection of functions. `CreatePluginFromPromptDirectory` accepts the path of your designated plugin directory, and each subfolder's name is used as a function name. 

For example, if you nested 'SuggestChords' inside a folder called 'ChordProgressions,' you would use the prompt directory 'Prompts/ChordProgressions' and the function name would stay the same. Alternatively, you could use the 'Prompt' directory and reference 'ChordProgressions/SuggestChords' as the function name.

```c#
// Example of nested prompt folders
var chordProgressionPlugin = kernel.CreatePluginFromPromptDirectory("Prompts/ChordProgressions");
string input = "G, C";

var result = await kernel.InvokeAsync(
    chordProgressionPlugin["SuggestChords"],
    new() {{ "startingChords", input }});

Console.WriteLine(result);
```

Running this code should produce a response similar to the following output:

```output
D major, A minor, E minor, B minor, F major, G7
```

Saving your prompts to files is a great way to organize your code and make it more maintainable. The configuration files also allow you to further tune your prompts for a more predictable user experience.