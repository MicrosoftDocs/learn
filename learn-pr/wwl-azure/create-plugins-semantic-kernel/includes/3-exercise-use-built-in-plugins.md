For this exercise, you add an existing plugin to your Semantic Kernel project and learn how to use your first plugin to accomplish a task. Let's get started!

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

1. In Explorer, right-click the **M02-create-plugins-for-semantic-kernel/M02-Project** folder and click **Open in Integrated Terminal**.

1. Expand the **M02-create-plugins-for-semantic-kernel/M02-Project** folder.

    You should see a "Program.cs" file.

1. Open the **Program.cs** file and update the following variables with your Azure Open AI Services deployment name, API key, endpoint.

    ```csharp
    string yourDeploymentName = "";
    string yourEndpoint = "";
    string yourKey = "";
    ```

Now you're ready to begin the exercise. Good luck!

## Get the user's intent

1. In the Integrated Terminal, add the Semantic Kernel Plugins. Core package to your project by running the following command:
    `dotnet add package Microsoft.SemanticKernel.Plugins.Core --version 1.2.0-alpha`

    > [!NOTE] 
    > Currently the package is a prerelease version. You may want to check for the latest version https://www.nuget.org/packages/Microsoft.SemanticKernel.Plugins.Core/1.2.0-alpha

1. Add the following code to your Program.cs file:

    ```c#
    builder.Plugins.AddFromType<ConversationSummaryPlugin>();
    var kernel = builder.Build();

    string input = @"I'm a vegan in search of new recipes. I love spicy food! 
    Can you give me a list of breakfast recipes that are vegan friendly?";

    var result = await kernel.InvokeAsync(
        "ConversationSummaryPlugin", 
        "GetConversationActionItems", 
        new() {{ "input", input }});

    Console.WriteLine(result);
    ```

    In this code, you import the `ConversationSummaryPlugin` from the `Core.Plugins` package. You create a new kernel builder and add the plugin to the builder. The `ConversationSummaryPlugin` supports several actions: `GetConversationActionItems`, `SummarizeConversation`, and `GetConversationTopics`.
    
    You create a string with a sample conversation, then call the plugin with the function name and pass in the conversation string. The plugin returns a summary of the conversation.

    > [!NOTE]
    > Since the plugin is still in preview, you may need to add suppress the warning by using `#pragma warning disable SKEXP0050` at the top of the file.

1. Run the code by entering `dotnet run` in the terminal. 

    You should see a response similar to the following output:

    ```output
    {
        "actionItems": [
            {
                "owner": "",
                "actionItem": "Provide a list of vegan-friendly spicy breakfast recipes",
                "dueDate": "",
                "status": "Open",
                "notes": ""
            }
        ]
    }
    ```

    Notice that the plugin was able to identify a simplified intent from the input string.

This example is just the beginning of what you can do with the Semantic Kernel SDK. In the next unit, you'll learn more ways to customize plugins and run functions.

> [!IMPORTANT]
> Be sure not to delete any of the code you wrote, you need it for the next exercises.