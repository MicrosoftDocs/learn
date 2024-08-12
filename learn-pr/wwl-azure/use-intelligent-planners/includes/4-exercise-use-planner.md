In this exercise, you use a planner to automatically invoke your plugin functions to accomplish a goal. The goal is to recommend an upcoming concert to a user based on their recently played music. To accomplish this goal, you need to make sure all of the functions are in place before the Handlebars planner can accurately plan the steps. First, let's create a plugin to retrieve upcoming concerts.

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

1. In Explorer, right-click the **M05-use-intelligent-planners/M05-Project** folder and click **Open in Integrated Terminal**

1. Expand the **M0-5use-intelligent-planners/M05-Project** folder

    You should see a "Program.cs" file.

1. Open the **Program.cs** file and update the following variables with your Azure OpenAI Services deployment name, API key, endpoint.

    ```csharp
    string yourDeploymentName = "";
    string yourEndpoint = "";
    string yourAPIKey = "";
    ```

Now you're ready to begin the exercise. Good luck!

## Create a concert suggestion plan

1. Install the Handlebars planner by entering the following in the terminal:

    `dotnet add package Microsoft.SemanticKernel.Planners.Handlebars --version 1.2.0-preview`

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

    This prompt asks the LLM to suggest a concert based on the user's recently played songs and location. Next, you invoke the planner to create a plan that combines the plugins together to accomplish the goal.

1. Open your 'Program.cs' file and update it with the following code:

    ```c#
    var kernel = builder.Build();
    kernel.ImportPluginFromType<MusicLibraryPlugin>();
    kernel.ImportPluginFromType<MusicConcertPlugin>();
    kernel.ImportPluginFromPromptDirectory("Prompts");

    var planner = new HandlebarsPlanner(new HandlebarsPlannerOptions() { AllowLoops = true });

    string location = "Redmond WA USA";
    string goal = @$"Based on the user's recently played music, suggest a 
        concert for the user living in ${location}";

    var plan = await planner.CreatePlanAsync(kernel, goal);
    var result = await plan.InvokeAsync(kernel);

    Console.WriteLine($"Results: {result}");
    ```

    In this code, you import the 'MusicLibraryPlugin' and 'MusicConcertPlugin' plugins and the 'SuggestConcert' prompt. You then create a Handlebars planner and use it to create a plan that suggests a concert based on the user's information. Finally, you invoke the plan and print the result.

1. In the terminal, enter `dotnet run`

    You should see a generated concert suggestion based on the user's recently played music and location. Try modifying the location to see how the recommendation changes.

The Handlebars planner is useful when you have several steps required to accomplish a task, or when you have many plugins that can be combined in different ways to accomplish a goal.

> [!IMPORTANT]
> Be sure not to delete any of the code you wrote so far since it's needed for the next exercise.