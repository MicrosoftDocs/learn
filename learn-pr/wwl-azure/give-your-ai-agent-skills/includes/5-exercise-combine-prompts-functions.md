For this exercise, you combine your native functions with a prompt that asks the LLM to generate a recommended song for the user based on their recent plays. Let's get started!

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

2. Create a new file in the 'M03-Project' folder called 'musiclibrary.txt' and paste the following content:

    ```
    [
        { title: "See Tinh", artist: "Thach Ngoc", genre: "pop, Vietnamese pop" },
        { title: "Luv(sic)", artist: "Chishin", genre: "hiphop, rap, Japanese hiphop" },
        { title: "Kids", artist: "Omar Bennett", genre: "synthpop, alternative, indie" },
        { title: "Ana Negm", artist: "Dabir", genre: "pop, arabic hiphop, Egyptian rap" },
        { title: "Ladies that are Single", artist: "Sydney", genre: "pop, r&b" },
        { title: "Oblivion", artist: "Eugenia", genre: "alternative, indie, electropop" },
        { title: "1901", artist: "Andre", genre: "synthpop, alternative, indie" },
        { title: "Suisei", artist: "Mirai", genre: "pop, Japanese pop" },
        { title: "Sabry Aalil", artist: "Yasemin", genre: "pop, Egyptian pop" },
        { title: "From Eden", artist: "Henry", genre: "blues, soul, electropop" },
        { title: "Sofia", artist: "Gaby", genre: "alternative, indie, pop" },
        { title: "Strawberry Blond", artist: "Nanami", genre: "Indie, Alternative, Folk"},
        { title: "July", artist: "Lisa Taylor", genre: "indie, folk" }
    ]
    ```

3. Update your 'Program.cs' file with the following code:

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

4. To test your code, enter `dotnet run` in the terminal.

    You should see a response similar to the following output:

    ```output 
    Based on the user's recently played music, a suggested song to play next could be "Sabry Aalil" by Yasemin since the user seems to enjoy pop and Egyptian pop music.
    ```

    >[!NOTE] 
    >
    >The recommended song may be different than the one shown here.

You successfully combined your native functions with a semantic prompt. You have the beginnings of a music recommendation agent! Try playing around with the prompts and input files to see what other recommendations you can generate.
