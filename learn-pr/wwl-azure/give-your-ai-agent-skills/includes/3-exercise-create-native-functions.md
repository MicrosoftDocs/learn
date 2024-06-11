In this exercise, you create a native function that adds a song to a user's "Recently Played" list. Later, you can use the list of recently played songs to provide customized recommendations. Let's get started!

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

1. In Explorer, right-click the **M03-give-your-ai-agent-skills/M03-Project** folder and click **Open in Integrated Terminal**.

1. Expand the **M03-give-your-ai-agent-skills/M03-Project** folder.

    You should see a "Program.cs" file.

1. Open the **Program.cs** file and update the following variables with your Azure Open AI Services deployment name, API key, endpoint.

    ```csharp
    string yourDeploymentName = "";
    string yourEndpoint = "";
    string yourKey = "";
    ```

Now you're ready to begin the exercise. Good luck!

## Create a music library plugin

1. Create a new folder in the 'Project' directory and name it 'Plugins.'

1. In the 'Plugins' folder, create a new file 'MusicLibrary.cs'

1. Enter the following code:

    ```c#
    using System.ComponentModel;
    using System.Text.Json;
    using System.Text.Json.Nodes;
    using Microsoft.SemanticKernel;

    public class MusicLibraryPlugin
    {
        [KernelFunction, 
        Description("Get a list of music recently played by the user")]
        public static string GetRecentPlays()
        {
            string dir = Directory.GetCurrentDirectory();
            string content = File.ReadAllText($"{dir}/data/recentlyplayed.txt");
            return content;
        }
    }
    ```

    In this code, you use the `KernelFunction` decorator to declare your native function. You also use the `Description` decorator to add a description of what the function does. For now, you can assume that the user's list of recent plays is stored in a text file called 'recentlyplayed.txt'. Next, you can add code to add a song to the list.

1. Add the following code to your `MusicLibraryPlugin` class:

    ```c#
    [KernelFunction, Description("Add a song to the recently played list")]
    public static string AddToRecentlyPlayed(
        [Description("The name of the artist")] string artist, 
        [Description("The title of the song")] string song, 
        [Description("The song genre")] string genre)
    {
        // Read the existing content from the file
        string filePath = "data/recentlyplayed.txt";
        string jsonContent = File.ReadAllText(filePath);
        var recentlyPlayed = (JsonArray) JsonNode.Parse(jsonContent);

        var newSong = new JsonObject
        {
            ["title"] = song,
            ["artist"] = artist,
            ["genre"] = genre
        };

        recentlyPlayed.Insert(0, newSong);
        File.WriteAllText(filePath, JsonSerializer.Serialize(recentlyPlayed,
            new JsonSerializerOptions { WriteIndented = true }));

        return $"Added '{song}' to recently played";
    }
    ```

    In this code, you create a function accepts the artist, song, and genre as strings. In addition to the `Description` of the function, you also add descriptions of the input variables. This code reads the existing content from the file, parses it, and adds the new song to the list. Afterwards, the updated list is written back to the file. Next you'll create the 'recentlyplayed.txt' file with some sample data.

1. Create a new folder 'data' in the 'M03-Project' folder.

1. Create a new file 'recentlyplayed.txt' in the 'data' folder, then paste the following content:

    ```json
    [
        {
            "title": "Loanh Quanh",
            "artist": "Ly Hoa",
            "genre": "indie, folk"
        },
        {
            "title": "Kalam Eineh",
            "artist": "Yasemin",
            "genre": "pop, Egyptian pop"
        },
        {
            "title": "I Miss You",
            "artist": "Chishin",
            "genre": "hiphop, rap"
        },
        {
            "title": "4EVER",
            "artist": "Gaby",
            "genre": "alternative, indie"
        }
    ]
    ```

    Next, let's modify the list by importing and invoking your new plugin.

1. Update your 'Program.cs' file with the following code:

    ```c#
    var kernel = builder.Build();
    kernel.ImportPluginFromType<MusicLibraryPlugin>();

    var result = await kernel.InvokeAsync(
        "MusicLibraryPlugin", 
        "AddToRecentlyPlayed", 
        new() {
            ["artist"] = "Tiara", 
            ["song"] = "Danse", 
            ["genre"] = "French pop, electropop, pop"
        }
    );
    
    Console.WriteLine(result);
    ```

    In this code, you import the `MusicLibraryPlugin` to the kernel using `ImportPluginFromType`. Then you call `InvokeAsync` with the name of the plugin you want to use and the function you want to call. You also pass in the artist, song, and genre as arguments.

1. Run the code by entering `dotnet run` in the terminal.

    You should see the following output:

    ```output
    Added 'Danse' to recently played
    ```

    Open up 'recentlyplayed.txt' and you should see the new song added to the list. Great work!