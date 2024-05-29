In this exercise, you use a planner to automatically invoke your plugin functions to accomplish a goal. The goal is to recommend an upcoming concert to a user based on their recently played music. To accomplish this goal, you need to make sure all of the steps are in place before the Handlebars planner can accurately plan the steps. First, let's create a plugin to retrieve upcoming concerts.

## Prepare your development environment

For these exercises, a starter project is available for you to use. Use the following steps to set up the starter project:

> [!IMPORTANT]
> You must have .NET Framework 8.0 installed and a Github account to complete these steps.

1. Open Visual Studio Code.

1. Under the Visual Studio Code **Start** section, select **Clone Git Repository**.

1. In the URL bar, enter `https://github.com/MicrosoftLearning/MSLearn-Develop-AI-Agents-with-Azure-OpenAI-and-Semantic-Kernel-SDK.git`

1. In the File Explorer, create a new folder in a location that is easy to find and remember, such as a folder in your Desktop.

1. Click the **Select as Repository Destination** button.

    You need to be signed in to GitHub to successfully clone the project.

1. Open the project in Visual Studio Code

1. In Explorer, right-click the **M04-use-intelligent-planners/M04-Project** folder and click **Open in Integrated Terminal**

1. Expand the **M04-use-intelligent-planners/M04-Project** folder

    You should see a "Program.cs" file.

1. Open the **Program.cs** file and update the following variables with your Azure OpenAI Services deployment name, API key, endpoint.

    ```csharp
    string yourDeploymentName = "";
    string yourEndpoint = "";
    string yourKey = "";
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
            string content = File.ReadAllText($"{dir}/concertdates.txt");
            return content;
        }
    ```

1. Create a new file in the 'M04-Project' folder called 'concertdates.txt' and paste the following content:

    ```json
    [
        {"artist": "Ly Hoa", "concerts": [
            { "location": "Los Angeles CA, USA", "date": "7/14/2024" },
            { "location": "London, UK", "date": "10/21/2024" },
            { "location": "Berlin, Germany", "date": "11/9/2024" },
            { "location": "Paris, France", "date": "11/23/2024" },
        ]},
        {"artist": "Lisa Taylor", "concerts": [
            { "location": "Portland OR, USA", "date": "2/14/2024" },
            { "location": "Seattle WA, USA", "date": "2/22/2024" },
            { "location": "New York City NY, USA", "date": "4/14/2024" },
            { "location": "Nashville TN, USA", "date": "5/10/2024" },
        ]},
        {"artist": "Henry", "concerts": [
            { "location": "Vancouver, Canada", "date": "2/2/2024" },
            { "location": "Seattle WA, USA", "date": "2/14/2024" },
            { "location": "Los Angeles CA, USA", "date": "3/1/2024" },
            { "location": "Austin TX, USA", "date": "3/10/2024" },
        ]},
        {"artist": "Gaby", "concerts": [
            { "location": "New York City NY, USA", "date": "2/14/2024" },
            { "location": "Chicago IL, USA", "date": "3/3/2024" },
            { "location": "Los Angeles CA, USA", "date": "5/6/2024" },
            { "location": "Barcelona, Spain", "date": "5/24/2024" },
        ]},
        { "artist": "Nanami", "concerts": [
            { "location": "Portland OR, USA", "date": "4/16/2024" },
            { "location": "Seattle WA, USA", "date": "4/20/2024" },
            { "location": "San Diego, USA", "date": "6/2/2024" },
            { "location": "Santa Monica CA, USA", "date": "6/10/2024" },
        ]}
    ]
    ```

    This file should be in the same directory as your 'Program.cs' file. Currently, the Handlebars planner can't complete large language model (LLM) prompts on its own. The planner can only select available prompts and functions to combine to achieve the goal. So next, you need to create a prompt to ask the LLM to suggest a concert.

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

    This prompt helps the LLM filter the user's input and retrieve just the destination from the text. Next, you invoke the planner to create a plan that combines the plugins together to accomplish the goal.

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

1. In the terminal, enter `dotnet run`

    You should see output similar to the following response:

    ```output
    Based on the user's recently played songs and their location in Redmond WA USA, a relevant concert recommendation would be the upcoming concert of Lisa Taylor in Seattle WA, USA on February 22, 2024. Lisa Taylor is an indie-folk artist, and her music genre aligns with the user's recently played songs, such as "Loanh Quanh" by Ly Hoa. Additionally, Seattle is close to Redmond, making it a convenient location for the user to attend the concert.
    ```

    Try tweaking your prompt and location to see what other results you can generate.

The Handlebars planner is useful when you have several steps required to accomplish a task. It can't run LLM prompts on its own, so you'll need to consider the different tasks a user might want to accomplish in your application.

> [!IMPORTANT]
> Be sure not to delete any of the code you wrote so far since it's needed for the next exercise.