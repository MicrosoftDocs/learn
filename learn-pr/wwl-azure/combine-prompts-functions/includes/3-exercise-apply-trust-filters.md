For this exercise, you consume a previous chat conversation between the user and the assistant to generate a new response. To do this, you need to trust the function result. Let's get started!

## Prepare your development environment

For these exercises, a starter project is available for you to use. Use the following steps to set up the starter project:

> [!IMPORTANT]
> You must have Visual Studio Code and the .NET Framework 8.0 installed to complete these steps. 
> You may also need to install the Visual Studio Code C# Dev Kit extension.

1. Open Visual Studio Code.

1. Under the Visual Studio Code **Start** section, select **Clone Git Repository**.

1. In the URL bar, enter `https://github.com/MicrosoftLearning/MSLearn-Develop-AI-Agents-with-Azure-OpenAI-and-Semantic-Kernel-SDK.git`

1. In the File Explorer, create a new folder in a location that is easy to find and remember, such as a folder in your Desktop.

1. Click the **Select as Repository Destination** button.

    You need to be signed in to GitHub to successfully clone the project.

1. Open the project in Visual Studio Code.

1. Open the **appsettings.json** file and update the values with your Azure OpenAI Services model ID, endpoint, and API key.

    ```json
    {
        "modelId": "gpt-35-turbo-16k",
        "endpoint": "",
        "apiKey": ""
    }
    ```

1. In Explorer, right-click the **M04-apply-filters-on-functions/M04-Project** folder and click **Open in Integrated Terminal**.

1. Expand the **M04-apply-filters-on-functions/M04-Project** folder.

    You should see a "Program.cs" file.

Now you're ready to begin the exercise. Good luck!

## Trust a function call result

In this task, you register a plugin that reads the previous conversation between the user and assistant. 

1. In the **Program.cs** file, navigate to the `SyncPreviousChat` method.

1. Add the `PreviousChatPlugin` to the kernel with the following code:

    ```c#
    async Task SyncPreviousChat() {
        kernel.Plugins.AddFromType<PreviousChatPlugin>("PreviousChatPlugin");
    }
    ```

1. Create a chat prompt and a prompt template configuration with the following code:    

    ```c#
    async Task SyncPreviousChat() {
        kernel.Plugins.AddFromType<PreviousChatPlugin>("PreviousChatPlugin");

        var chatPrompt = @"{{PreviousChatPlugin.get_previous_conversation}}";
        var promptConfig = new PromptTemplateConfig(chatPrompt)
        {
            
        };
    }
    ```

1. Add the following code to trust all content in the prompt template:

    ```c#
    var promptConfig = new PromptTemplateConfig(chatPrompt)
    {
        AllowDangerouslySetContent = true
    };
    ```

1. Finally, add the code to create and invoke a function from the prompt template:

    ```c#
    async Task SyncPreviousChat() {
        kernel.Plugins.AddFromType<PreviousChatPlugin>("PreviousChatPlugin");

        var chatPrompt = @"{{PreviousChatPlugin.get_previous_conversation}}";
        var promptConfig = new PromptTemplateConfig(chatPrompt)
        {
            AllowDangerouslySetContent = true
        };

        var function = KernelFunctionFactory.CreateFromPrompt(promptConfig);
        var result = await kernel.InvokeAsync(function, []);
        Console.WriteLine(result);
    }
    ```

1. Enter `dotnet run` to run the code.

    You should see some destination recommendations for a romantic anniversary trip.

1. You can try modifying the prompt template to see the difference, for example:

    ```c#
    var chatPrompt = @"
        <message role='user'>I need some destination recommendations for a company event. Our budget is $21,000</message>
        {{PreviousChatPlugin.get_previous_conversation}}
        ";

    var promptConfig = new PromptTemplateConfig(chatPrompt);
    ```

    If you run the updated function, you should that the AI disregards the previous conversation and instead suggests company event recommendations.

Now you successfully practiced applying trust settings to your prompt templates. Great work! You can remove the `SyncPreviousChat` function call to prepare for the next exercise.