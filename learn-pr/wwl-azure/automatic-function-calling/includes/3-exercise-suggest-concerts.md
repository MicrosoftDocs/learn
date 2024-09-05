The Semantic Kernel SDK allows you to automatically coordinate functions and prompts that are referenced in your kernel. Rather than manually invoking functions and prompts, this tool helps you save time and makes your applications smarter. Let's try it out!

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

1. Open the project in Visual Studio Code

1. In Explorer, right-click the **M05-auto-invoke-functions/M05-Project** folder and click **Open in Integrated Terminal**

1. Expand the **M05-auto-invoke-functions/M05-Project** folder

    You should see a "Program.cs" file.

1. Open the **Program.cs** file and update the following variables with your Azure OpenAI Services deployment name, API key, endpoint.

    ```csharp
    string yourDeploymentName = "";
    string yourEndpoint = "";
    string yourAPIKey = "";
    ```

Now you're ready to begin the exercise. Good luck!

## Suggest concerts to the user

1. In the 'Plugins' folder, create a new file named 'MusicConcertPlugin.cs'

1. In the MusicConcertPlugin' file, add the following code:

    ```c#
    using System.ComponentModel;
    using Microsoft.SemanticKernel;

    public class MusicConcertPlugin
    {
        [KernelFunction, Description("Get a list of upcoming concerts")]
        public static string GetTours()
        {
            string dir = Directory.GetCurrentDirectory();
            string content = File.ReadAllText($"{dir}/data/concertdates.txt");
            return content;
        }
    }
    ```

    The `GetTours` function reads a file named 'concertdates.txt' and returns the content. This function will be used to retrieve a list of upcoming concerts.

    Next, create a prompt to ask the LLM to suggest a concert based on the user's recently played music.

1. In the 'Prompts' folder, create a new folder named 'SuggestConcert'

1. Create a 'config.json' file in the 'SuggestConcert' folder with the following content:

    ```json
    {
        "schema": 1,
        "type": "completion",
        "description": "Suggest a concert to the user",
        "execution_settings": {
            "default": {
                "max_tokens": 4000,
                "temperature": 0
            }
        },
        "input_variables": [
            {
                "name": "upcomingConcerts",
                "description": "A list of artist's upcoming concerts",
                "required": true
            },
            {
                "name": "recentlyPlayedSongs",
                "description": "A list of songs recently played by the user",
                "required": true
            },
            {
                "name": "location",
                "description": "The user's location",
                "required": true
            }
        ]
    }
    ```

1. Create a 'skprompt.txt' file in the 'SuggestConcert' folder with the following content:

    ```output
    Based on the user's recently played songs:
    {{$recentlyPlayedSongs}}

    And a list of upcoming concerts:
    {{$upcomingConcerts}}

    Suggest an upcoming concert. The user lives in {{$location}}, 
    please recommend a relevant concert that is close to their location.
    ```

    This prompt asks the LLM to suggest a concert based on the user's recently played songs and location. Next, you enable the automatic function calling setting.

1. Open the `Program.cs` file and the following using statement:

    ```c#
    using Microsoft.SemanticKernel.Connectors.OpenAI;
    ```

    This package will allow you to use the automatic function calling setting.

1. Update the `Program.cs` file it with the following code:

    ```c#
    kernel.ImportPluginFromType<MusicLibraryPlugin>();
    kernel.ImportPluginFromType<MusicConcertPlugin>();
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

    The generated suggestion should recommend a concert based on the recently played songs and location. The output might be similar to the following response:
    
    ```output
    Based on your recently played songs and your location in Portland, OR, I would recommend attending the upcoming concert of Lisa Taylor. She will be performing in Portland on April 16, 2024. This concert would be a great opportunity for you to enjoy live music and experience Lisa Taylor' beautiful songs.
    ```

    The semantic kernel automatically detects the appropriate plugin function to use and passes in the correct parameters. You can try modifying the location to see how the recommendation changes. You can also try changing the prompt to tell the LLM to suggest a song from the library.

The `AutoInvokeKernelFunctions` setting allows the semantic kernel to automatically call functions and prompts that are added to your kernel. This tool can empower you to create dynamic, robust applications using less code.