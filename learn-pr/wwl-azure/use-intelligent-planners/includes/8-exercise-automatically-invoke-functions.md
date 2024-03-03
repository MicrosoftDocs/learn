The Semantic Kernel SDK allows you to automatically coordinate functions and prompts that are referenced in your kernel. Rather than manually invoking functions and prompts, this tool helps you save time and makes your applications smarter. Let's try it out!

1. Open the `Program.cs` file and modify it with the following code:

    ```c#
    kernel.ImportPluginFromType<MusicLibraryPlugin>();
    kernel.ImportPluginFromType<MusicConcertsPlugin>();
    kernel.ImportPluginFromPromptDirectory("Prompts");

    OpenAIPromptExecutionSettings settings = new()
    {
        ToolCallBehavior = ToolCallBehavior.AutoInvokeKernelFunctions
    };

    string prompt = @"I live in Portland OR USA. Based on my recently 
        played songs and a list of upcoming concerts, which concert 
        do you recommend?";

    var result = await kernel.InvokePromptAsync(prompt, new(settings));

    Console.WriteLine(result);
    ```

1. Enter `dotnet run` in the terminal

    You should see output similar to the following response:

    ```output
    Based on your recently played songs and your location in Portland, OR, I would recommend attending the upcoming concert of Lisa Taylor. She will be performing in Portland on April 16, 2024. This concert would be a great opportunity for you to enjoy live music and experience Lisa Taylor' beautiful songs.
    ```

    You can try using different prompts and importing other plugins to see how the output changes!

In previous exercises, you manually called functions or used the Handlebars planner to chain plugins together. The `AutoInvokeKernelFunctions` setting automatically calls functions and prompts that are referenced in your kernel. This tool can empower you to create dynamic, robust applications using less code.