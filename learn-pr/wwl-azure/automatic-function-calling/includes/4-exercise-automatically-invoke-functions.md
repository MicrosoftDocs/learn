In this exercise, you practice using prompts to automatically call functions that can recommend songs to the user, or add a song to the list of recently played music. Let's get started!

1. Open the Visual Studio Code project you used in the previous exercise.

1. Update your 'Program.cs' file with the following code:

    ```c#
    OpenAIPromptExecutionSettings settings = new()
    {
        ToolCallBehavior = ToolCallBehavior.AutoInvokeKernelFunctions
    };

    var songSuggesterFunction = kernel.CreateFunctionFromPrompt(
        promptTemplate: @"Based on the user's recently played music:
            {{$recentlyPlayedSongs}}
            recommend a song to the user from the music library:
            {{$musicLibrary}}",
        functionName: "SuggestSong",
        description: "Recommend a song from the library"
    );

    kernel.Plugins.AddFromFunctions("SuggestSong", [songSuggesterFunction]);

    string prompt = @"Can you recommend a song from the music library?";

    var result = await kernel.InvokePromptAsync(prompt, new(settings));

    Console.WriteLine(result);
    ```

    In this code, you create a function from a prompt that tells the LLM how to suggest a song. Afterwards, you invoke a prompt with the auto function calling setting enabled. The kernel is able to run the function and supply the correct parameters to complete the prompt.

1. In the terminal, enter `dotnet run` to run your code.

    The output generated should recommend a song to the user based on their recently played music. Your response may look similar to the following output:
    
    ```
    Based on your recently played music, I recommend you listen to the song "Luv(sic)". It falls under the genres of hiphop and rap, which aligns with some of your recently played songs. Enjoy!  
    ```

    Next, let's try a prompt to update the recently played songs list.

1. Update your 'Program.cs' file with the following code:

    ```c#
    string prompt = @"Add this song to the recently played songs list:  title: 'Touch', artist: 'Cat's Eye', genre: 'Pop'";

    var result = await kernel.InvokePromptAsync(prompt, new(settings));

    Console.WriteLine(result);
    ```

1. Enter `dotnet run` in the terminal

    The output should be similar to the following:

    ```
    I have added the song 'Touch' by Cat's Eye to the recently played songs list.
    ```

    When you open the recentlyplayed.txt file, you should see the new song added to the top of the list.
    

Using the `AutoInvokeKernelFunctions` setting allows you to focus on building plugins to suit your user's needs. 
