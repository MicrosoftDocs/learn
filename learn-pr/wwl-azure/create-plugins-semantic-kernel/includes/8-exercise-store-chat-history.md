Suppose you want to create a travel agent that suggests destinations and recommends activities for a user. In this exercise, you use the chat history to provide tailored recommendations to the user.

1. Open the Visual Studio Code project you created in the previous exercise.

1. Open the **Program.cs** file.

    You can clear the code you added from the previous exercise.

1. Get the chat completion service and create a chat history object by adding the following code:

    ```c#
    // Build the kernel
    Kernel kernel = builder.Build();

    // Get chat completion service.
    var chatCompletionService = kernel.GetRequiredService<IChatCompletionService>();

    // Create a chat history object
    ChatHistory chatHistory = [];
    ```

1. Add the following code to create helper functions to append to the console and chat history:

    ```c#
    void AddMessage(string msg) {
        Console.WriteLine(msg);
        chatHistory.AddAssistantMessage(msg);
    }

    void GetInput() {
        string input = Console.ReadLine()!;
        chatHistory.AddUserMessage(input);
    }
    ```

    Now the assistant and user messages can be appended easily without rewriting code.

1. Add a helper function to retrieve the reply:

    ```c#
    async Task GetReply() {
        ChatMessageContent reply = await chatCompletionService.GetChatMessageContentAsync(
            chatHistory,
            kernel: kernel
        );
        Console.WriteLine(reply.ToString());
        chatHistory.AddAssistantMessage(reply.ToString());
    }
    ```

    This code uses the chat completion service with the chat history to process the response from the LLM. Now you're ready to build the travel agent prompts.

1. Add the following code to prompt the LLM and retrieve the user input.

    ```c#
    // Prompt the LLM
    chatHistory.AddSystemMessage("You are a helpful travel assistant.");
    chatHistory.AddSystemMessage("Recommend a destination to the traveler based on their background and preferences.");

    // Get information about the user's plans
    AddMessage("Tell me about your travel plans.");
    GetInput();
    await GetReply();
    ```

1. Offer activity recommendations and language tips with the following code:

    ```c#
    // Offer recommendations
    AddMessage("Would you like some activity recommendations?");
    GetInput();
    await GetReply();

    // Offer language tips
    AddMessage("Would you like some helpful phrases in the local language?");
    GetInput();
    await GetReply();
    ```

    Now your travel agent is ready for testing. Let's add some code to view the chat history object.

1. Add the following code to observe your chat history object:

    ```c#
    Console.WriteLine("Chat Ended.\n");
    Console.WriteLine("Chat History:");

    for (int i = 0; i < chatHistory.Count; i++)
    {
        Console.WriteLine($"{chatHistory[i].Role}: {chatHistory[i]}");
    }
    ```
1. Run the code by entering `dotnet run` in the terminal.

1. Enter some travel plans such as "I want to plan a romantic holiday with my partner in November. They need wheelchair accessibility."

    The LLM should provide you with a destination suggestion. Afterwards you should see the message for activity recommendations.

1. Enter "Yes" in the terminal.

    The LLM should provide you with some activity recommendations. Afterwards you should see the message for language tips.

1. Enter "Yes" in the terminal.

    The LLM should provide some phrases in the local language. Afterwards you should see the contents of the chat history object.

Now you created the beginnings of an AI travel assistant! Try changing the input to see how the LLM responds.