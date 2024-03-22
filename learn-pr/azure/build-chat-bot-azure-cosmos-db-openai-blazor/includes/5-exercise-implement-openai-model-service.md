Let's start with the simplest service, `OpenAiService`. This service only contains two methods that we need to implement so we can implement basic prompts and completions right away. We're not implementing our Azure Cosmos DB for NoSQL data service until later, so we can't persist our sessions across debugging sessions yet.

In this exercise, we have a few key requirements:

- Send a question from the user to the AI assistant and ask for a response.
- Send a series of prompts to the AI assistant and ask for a summarization of the conversation.

## Ask the AI model a question

First, implement a question-answer conversation by sending a system prompt, a question, and session ID so the AI model can provide an answer in the context of the current conversation. Make sure you measure the number of tokens it takes to parse the prompt and return a response (or completion in this context).

1. Open the **Services/OpenAiService.cs** file.

1. Within the `GetChatCompletionAsync` method, remove any existing placeholder code.

    ```csharp
    public async Task<(string completionText, int completionTokens)> GetChatCompletionAsync(string sessionId, string userPrompt)
    {
    }
    ```

1. Create a `ChatRequestSystemMessage` variable named `systemMessage`. For this variable, use the `User` role and the `_systemPrompt` variable for content.

    ```csharp
    ChatRequestSystemMessage systemMessage = new(_systemPrompt);
    ```

1. Create a `ChatRequestUserMessage` variable named `userMessage`. For this variable, the role should be `ChatRole.User` and use the `userPrompt` constructor parameter for the message's content.

    ```csharp
    ChatRequestUserMessage userMessage = new(userPrompt);
    ```

1. Create a new variable named `options` of type `ChatCompletionsOptions`. Add the two message variables to the `Messages` list, set the value of `User` to the `sessionId` constructor parameter, set `MaxTokens` to `4000`, and set the remaining properties to the recommended values here.

    ```csharp
    ChatCompletionsOptions options = new()
    {
        DeploymentName = _modelName,
        Messages = {
            systemMessage,
            userMessage
        },
        User = sessionId,
        MaxTokens = 4000,
        Temperature = 0.3f,
        NucleusSamplingFactor = 0.5f,
        FrequencyPenalty = 0,
        PresencePenalty = 0
    };
    ```

    > [!TIP]
    > **4096** is the maximum number of tokens for the **gpt-35-turbo** model. We're just rounding down here to simplify things.

1. Asynchronously invoke the `GetChatCompletionsAsync` method of the Azure OpenAI client variable (`_client`). Pass in the `options` variable you created. Store the result in a variable named `completions` of type `ChatCompletions`.

    ```csharp
    ChatCompletions completions = await _client.GetChatCompletionsAsync(options);
    ```

    > [!TIP]
    > The `GetChatCompletionsAsync` method returns an object of type `Task<Response<ChatCompletions>>`. The `Response<T>` class contains a implicit conversion to type `T` allowing you to select a type based on your application's needs. You can store the result as either `Response<ChatCompletions>` to get the full metadata from the response or just `ChatCompletions` if you only care about the content of the result itself.

1. Finally, return a tuple as the result of the `GetChatCompletionAsync` method with the content of the completion as a string, the number of tokens associated with the prompt, and the number of tokens for the response.

    ```csharp
    return (
        response: completions.Choices[0].Message.Content,
        promptTokens: completions.Usage.PromptTokens,
        responseTokens: completions.Usage.CompletionTokens
    );
    ```

1. Save the **Services/OpenAiService.cs** file.

## Ask the AI model to summarize a conversation

Now, send the AI model a different system prompt, your current conversation, and session ID so the AI model can summarize the conversation in a couple of words.

1. Within the `SummarizeAsync` method, remove any existing placeholder code.

    ```csharp
    public async Task<string> SummarizeAsync(string sessionId, string conversationText)
    {
    }
    ```

1. Create a `ChatRequestSystemMessage` variable named `systemMessage`. For this variable, use the `User` role and the `_summarizePrompt` variable for content.

    ```csharp
    ChatRequestSystemMessage systemMessage = new(_summarizePrompt);
    ```

1. Create another `ChatRequestUserMessage` variable named `userMessage`. Use the `User` role again and use the `conversationText` constructor parameter for the message's content.

    ```csharp
    ChatRequestUserMessage userMessage = new(conversationText);
    ```

1. Create a `ChatCompletionsOptions` variable named `options` with the two message variables in the `Messages` list, `User` set to the `sessionId` constructor parameter, `MaxTokens` set to `200`, and the remaining properties to the recommended values here.

    ```csharp
    ChatCompletionsOptions options = new()
    {
        DeploymentName = _modelName,
        Messages = {
            systemMessage,
            userMessage
        },
        User = sessionId,
        MaxTokens = 200,
        Temperature = 0.0f,
        NucleusSamplingFactor = 1.0f,
        FrequencyPenalty = 0,
        PresencePenalty = 0
    };
    ```

1. Invoke `_client.GetChatCompletionsAsync` asynchronously using the `options` variable as a parameter. Store the result in a variable named `completions` of type `ChatCompletions`.

    ```csharp
    ChatCompletions completions = await _client.GetChatCompletionsAsync(options);
    ```

1. Return the content of the completion as a string as the result of the `SummarizeAsync` method.

    ```csharp
    return completions.Choices[0].Message.Content;
    ```

1. Save the **Services/OpenAiService.cs** file.

## Check your work

At this point, your application should have a thorough enough implementation of the Azure OpenAI service that you can test the application. Remember, you don't have a data store implementation yet, so your conversations aren't persisted between debugging sessions.

### [Validate application](#tab/validate-app)

1. Open a new terminal.

1. Start the application with hot reloads enabled using `dotnet watch`.

    ```bash
    dotnet watch run --non-interactive
    ```

    > [!TIP]
    > The **Hot Reload** feature is enabled here if you need to make a small correction to the application's code. For more information, see [.NET Hot Reload support for ASP.NET Core](/aspnet/core/test/hot-reload).

1. Visual Studio Code launches the in-tool simple browser again with the web application running. In the web application, create a new chat session and ask the AI assistant a question. The AI assistant now responds with a completion created by the model. You should also notice that the *token* UI fields are now populated with real-world token usage for each completion and prompt.

    :::image type="content" source="../media/openai-implemented-application.png" lightbox="../media/openai-implemented-application.png" alt-text="Screenshot of the application running with a connection Azure OpenAI.":::

1. Close the terminal.

### [Review code](#tab/review-code)

1. Make sure that your code matches this sample by reviewing the `AskAsync` method of the *OpenAiService.cs* code file.

    ```csharp
    public async Task<(string completionText, int completionTokens)> GetChatCompletionAsync(string sessionId, string userPrompt)
    {
        ChatRequestSystemMessage systemMessage = new(_systemPrompt);
        ChatRequestUserMessage userMessage = new(userPrompt);
    
        ChatCompletionsOptions options = new()
        {
            DeploymentName = _modelName,
            Messages =
            {
                systemMessage,
                userMessage
            },
            User = sessionId,
            MaxTokens = 4000,
            Temperature = 0.3f,
            NucleusSamplingFactor = 0.5f,
            FrequencyPenalty = 0,
            PresencePenalty = 0
        };
    
        ChatCompletions completions = await _client.GetChatCompletionsAsync(options);
    
        return (
            completionText: completions.Choices[0].Message.Content,
            completionTokens: completions.Usage.CompletionTokens
        );
    }
    ```

1. Make sure that your code matches this sample by reviewing the `SummarizeAsync` method of the *OpenAiService.cs* code file.

    ```csharp
    public async Task<string> SummarizeAsync(string sessionId, string conversationText)
    {
        ChatRequestSystemMessage systemMessage = new(_summarizePrompt);
        ChatRequestUserMessage userMessage = new(conversationText);
    
        ChatCompletionsOptions options = new()
        {
            DeploymentName = _modelName,
            Messages =
            {
                systemMessage,
                userMessage
            },
            User = sessionId,
            MaxTokens = 200,
            Temperature = 0.0f,
            NucleusSamplingFactor = 1.0f,
            FrequencyPenalty = 0,
            PresencePenalty = 0
        };
    
        ChatCompletions completions = await _client.GetChatCompletionsAsync(options);
    
        return completions.Choices[0].Message.Content;
    }
    ```

---
