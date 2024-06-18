For this exercise, you combine your native functions with a prompt that asks the LLM to generate a recommended song for the user based on their recent plays. Let's get started!

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

1. In Explorer, right-click the **M04-combine-prompts-and-functions/M04-Project** folder and click **Open in Integrated Terminal**.

1. Expand the **M04-combine-prompts-and-functions/M04-Project** folder.

    You should see a "Program.cs" file.

1. Open the **Program.cs** file and update the following variables with your Azure OpenAI Services deployment name, API key, endpoint.

    ```csharp
    string yourDeploymentName = "";
    string yourEndpoint = "";
    string yourKey = "";
    ```

Now you're ready to begin the exercise. Good luck!

## Provide personalized song recommendations

1. In your `MusicLibraryPlugin.cs` file, add the following function:

    ```c#
    [KernelFunction, Description("Get a list of music available to the user")]
    public static string GetMusicLibrary()
    {
        string dir = Directory.GetCurrentDirectory();
        string content = File.ReadAllText($"{dir}/musiclibrary.txt");
        return content;
    }
    ```

1. Update your 'Program.cs' file with the following code:

    ```c#
    var kernel = builder.Build();
    kernel.ImportPluginFromType<MusicLibraryPlugin>();

    string prompt = @"This is a list of music available to the user:
        {{MusicLibraryPlugin.GetMusicLibrary}} 

        This is a list of music the user has recently played:
        {{MusicLibraryPlugin.GetRecentPlays}}

        Based on their recently played music, suggest a song from
        the list to play next";

    var result = await kernel.InvokePromptAsync(prompt);
    Console.WriteLine(result);
    ```

    In this code, you combine your native functions with a semantic prompt. The native functions are able to retrieve user data that the large language model (LLM) couldn't access on its own, and the LLM is able to generate a song recommendation based on the text input.

1. To test your code, enter `dotnet run` in the terminal.

    You should see a response similar to the following output:

    ```output 
    Based on the user's recently played music, a suggested song to play next could be "Sabry Aalil" since the user seems to enjoy pop and Egyptian pop music.
    ```

    >[!NOTE] 
    >Your generated song recommendation may be different than the one shown here.

You successfully combined your native functions with a semantic prompt. You have the beginnings of a music recommendation agent! Try playing around with the prompts and input files to see what other recommendations you can generate.
