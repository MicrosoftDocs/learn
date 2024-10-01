In this exercise, you use the conversation history to provide context to the large language model (LLM). You also adjust the code so that it allows the user to continue the conversation, just like a real chatbot. Let's get started!

1. Modify the code to use a `do`-`while` loop to accept the user's input:

    ```c#
    string input;

    do 
    {
        Console.WriteLine("What would you like to do?");
        input = Console.ReadLine();

        // ...
    }
    while (!string.IsNullOrWhiteSpace(input));
    ```

    Now you can keep the conversation going until the user enters a blank line.

2. Capture details about the user's trip by modifying the `SuggestDestinations` case:

    ```c#
    case "SuggestDestinations":
        chatHistory.AppendLine("User:" + input);
        var recommendations = await kernel.InvokePromptAsync(input!);
        Console.WriteLine(recommendations);
        break;
    ```

3. Use the trip details in the `SuggestActivities` case with the following code:

    ```c#
     case "SuggestActivities":
        var chatSummary = await kernel.InvokeAsync(
            "ConversationSummaryPlugin", 
            "SummarizeConversation", 
            new() {{ "input", chatHistory.ToString() }});
        break;
    ```

    In this code, you use the built-in `SummarizeConversation` function to summarize the chat with the user. Next, let's use the summary to suggest activities at the destination.

4. Extend the `SuggestActivities` case with the following code:

    ```c#
    var activities = await kernel.InvokePromptAsync(
        input,
        new () {
            {"input", input},
            {"history", chatSummary},
            {"ToolCallBehavior", ToolCallBehavior.AutoInvokeKernelFunctions}
    });

    chatHistory.AppendLine("User:" + input);
    chatHistory.AppendLine("Assistant:" + activities.ToString());

    Console.WriteLine(activities);
    break;
    ```

    In this code, you add `input` and `chatSummary` as kernel arguments. Then the kernel invokes the prompt and routes it to the `SuggestActivities` plugin. You also append the user's input and the assistant's response to the chat history and display the results. Next, you need to add the `chatSummary` variable to the `SuggestActivities` plugin.

5. Navigate to **Prompts/SuggestActivities/config.json** and open the file in Visual Studio Code

6. Under `input_variables`, add a variable for the chat history:

    ```json
    "input_variables": [
      {
          "name": "history",
          "description": "Some background information about the user",
          "required": false
      },
      {
          "name": "destination",
          "description": "The destination a user wants to visit",
          "required": true
      }
      ]
    ```

7. Navigate to **Prompts/SuggestActivities/skprompt.txt** and open the file

8. Add a prompt to use the chat history:

    ```html 
    You are an experienced travel agent. 
    You are helpful, creative, and very friendly. 
    Consider the traveler's background: {{$history}}
    ```

Leave the rest of the prompt as is. Now the plugin uses the chat history to provide context to the LLM.


## Check your work

In this task, you run your application and verify the code is working correctly.

1. Compare your updated switch cases to the following code:

    ```c#
    case "SuggestDestinations":
            chatHistory.AppendLine("User:" + input);
            var recommendations = await kernel.InvokePromptAsync(input!);
            Console.WriteLine(recommendations);
            break;
    case "SuggestActivities":

        var chatSummary = await kernel.InvokeAsync(
            "ConversationSummaryPlugin", 
            "SummarizeConversation", 
            new() {{ "input", chatHistory.ToString() }});

        var activities = await kernel.InvokePromptAsync(
            input!,
            new () {
                {"input", input},
                {"history", chatSummary},
                {"ToolCallBehavior", ToolCallBehavior.AutoInvokeKernelFunctions}
        });

        chatHistory.AppendLine("User:" + input);
        chatHistory.AppendLine("Assistant:" + activities.ToString());
        
        Console.WriteLine(activities);
        break;
    ```

2. Enter `dotnet run` in the terminal. When prompted, enter some text similar to the following:

    ```output
    What would you like to do?
    How much is 60 USD in new zealand dollars?
    ```

3. You should receive some output similar to the following:

    ```output
    $60 USD is approximately $97.88 in New Zealand Dollars (NZD)
    What would you like to do?
    ```

4. Enter a prompt for destination suggestions with some context cues, for example:

    ```output
    What would you like to do?
    I'm planning an anniversary trip with my spouse, but they are currently using a wheelchair and accessibility is a must. What are some destinations that would be romantic for us?
    ```

5. You should receive some output with recommendations of accessible destinations.

6. Enter a prompt for activity suggestions, for example:

    ```output
    What would you like to do?
    What are some things to do in Barcelona?
    ```

7. You should receive recommendations that fit within the previous context, for example, accessible activities in Barcelona similar to the following:

    ```output
    1. Visit the iconic Sagrada Família: This breathtaking basilica is an iconic symbol of Barcelona's architecture and is known for its unique design by Antoni Gaudí.

    2. Explore Park Güell: Another masterpiece by Gaudí, this park offers stunning panoramic views of the city, intricate mosaic work, and whimsical architectural elements.

    3. Visit the Picasso Museum: Explore the extensive collection of artworks by the iconic painter Pablo Picasso, showcasing his different periods and styles.
    ```

    > [!NOTE]
    > If your code doesn't produce the output you expected, you can review the code in the **Solution** folder.

You can continue to test the application with different prompts and context cues. Great work! You've successfully provided context cues to the LLM and adjusted the code to allow the user to continue the conversation.