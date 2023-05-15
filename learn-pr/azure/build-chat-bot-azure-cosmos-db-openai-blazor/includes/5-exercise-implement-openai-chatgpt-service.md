Let's start with the simplest service to implement, `OpenAiService`. This service only contains two methods that we need to implement so we can implement basic prompts and completions right away. We're not implementing our Azure Cosmos DB for NoSQL data service until later, so we can't persist our sessions across debugging sessions yet.

In this exercise, we have a few key requirements:

- Send sets of prompts to the AI model deployment and parse various completions.
- Send a question from the user to the AI assistant and ask for a response.
- Send a series of prompts to the AI assistant and ask for a summarization of the conversation.

## Ask the AI model a question

First, implement a question-answer conversation by sending a system prompt, a question, and session ID so the AI model can provide an answer in the context of the current conversation. Make sure you parse the number of tokens it takes to parse the prompt and return a response (or completion in this context).

1. Open the **Services/OpenAiService.cs** file.

1. Within the `AskAsync` method, remove any existing placeholder code:

    ```csharp
    public async Task<(string response, int promptTokens, int responseTokens)> AskAsync(string sessionId, string prompt)
    {
    }
    ```

1. Create a new variable of type `ChatMessage` named `systemPrompt`. Set the role of the message to `ChatRole.System` and pass in the static `_systemPromptText` variable as the body of the message.

    ```csharp
    ChatMessage systemPrompt = new(ChatRole.System, _systemPromptText);
    ```

1. Create another `ChatMessage` variable named `userPrompt`. For this variable, the role should be `ChatRole.User` and use the `prompt` constructor parameter for the message's content.

    ```csharp
    ChatMessage userPrompt = new(ChatRole.User, prompt);
    ```

1. Create a new variable named `options` of type `ChatCompletionsOptions`. Add the two message variables to the `Messages` list, set the value of `User` to the `sessionId` constructor parameter, set `MaxTokens` to the `_maxTokens` variable, and set the remaining properties to the recommended values here.

    ```csharp
    ChatCompletionsOptions options = new()
    {
        Messages = {
            systemPrompt,
            userPrompt
        },
        User = sessionId,
        MaxTokens = _maxTokens,
        Temperature = 0.5f,
        NucleusSamplingFactor = 0.95f,
        FrequencyPenalty = 0,
        PresencePenalty = 0
    };
    ```

1. Asynchronously invoke the `GetChatCompletionsAsync` method of the Azure OpenAI client variable (`_client`). Pass in the name of the deployment (`_deploymentName`) and the `options` variable you created. Store the result in a variable named `completions` of type `ChatCompletions`.

    ```csharp
    ChatCompletions completions = await _client.GetChatCompletionsAsync(_deploymentName, options);
    ```

    > [!TIP]
    > The `GetChatCompletionsAsync` method returns an object of type `Task<Response<ChatCompletions>>`. The `Response<T>` class contains a implicit conversion to type `T` allowing you to select a type based on your application's needs. You can store the result as either `Response<ChatCompletions>` to get the full metadata from the response or just `ChatCompletions` if you only care about the content of the result itself.

1. Finally, return a tuple as the result of the `AskAsync` method with the content of the completion as a string, the number of tokens associated with the prompt, and the number of tokens for the response.

    ```csharp
    return (
        response: completions.Choices[0].Message.Content,
        promptTokens: completions.Usage.PromptTokens,
        responseTokens: completions.Usage.CompletionTokens
    );
    ```

## Ask the AI model to summarize a conversation

Now, send the AI model a different system prompt, your current conversation, and session ID so the AI model can summarize the conversation in a couple of words.

1. Within the `SummarizeAsync` method, remove any existing placeholder code:

    ```csharp
    public async Task<string> SummarizeAsync(string sessionId, string prompt)
    {
    }
    ```

1. Create a `ChatMessage` variable named `summarizePrompt`. For this variable, use the `User` role and the `_summarizePromptText` variable for content.

    ```csharp
    ChatMessage summarizePrompt = new(ChatRole.User, _summarizePromptText);
    ```

1. Create another `ChatMessage` variable named `userPrompt`. Use the `User` role again and use the `prompt` constructor parameter for the message's content.

    ```csharp
    ChatMessage userPrompt = new(ChatRole.User, prompt);
    ```

1. Create a `ChatCompletionsOptions` variable named `options` with the two message variables in the `Messages` list, `User` set to the `sessionId` constructor parameter, `MaxTokens` set to the `_maxTokens` variable, and the remaining properties to the recommended values here:

    ```csharp
    ChatCompletionsOptions options = new()
    {
        Messages = {
            summarizePrompt,
            userPrompt
        },
        User = sessionId,
        MaxTokens = _maxTokens,
        Temperature = 0.5f,
        NucleusSamplingFactor = 0.95f,
        FrequencyPenalty = 0,
        PresencePenalty = 0
    };
    ```

1. Invoke `_client.GetChatCompletionsAsync` asynchronously with the deployment name (`_deploymentName`) and the `options` variable as parameters. Store the result in a variable named `completions` of type `ChatCompletions`.

    ```csharp
    ChatCompletions completions = await _client.GetChatCompletionsAsync(_deploymentName, options);
    ```

1. Return the content of the completion as a string as the result of the `SummarizeAsync` method. Use `String.TrimEnd` to remove extra punctuation from the end of the summary.

    ```csharp
    return completions.Choices[0].Message.Content.TrimEnd('.');
    ```

1. Save the **Services/OpenAiService.cs** file.

## Check your work

At this point, your application should have a thorough enough implementation of the Azure OpenAI service that you can test the application. Remember, you haven't implemented a data store yet, so your conversations aren't persisted between debugging sessions.

### [Validate application](#tab/validate-app)

1. Open a new terminal.

1. Start the application with hot reloads enabled using [`dotnet watch`](/dotnet/core/tools/dotnet-watch)

    ```bash
    dotnet watch run --non-interactive
    ```

1. Visual Studio Code launches the in-tool simple browser again with the web application running. In the web application, create a new chat session and ask the AI assistant a question. The AI assistant now responds with a completion created by the model. You should also notice that the *token* UI fields are now populated with real-world token usage for each completion and prompt.

    :::image type="content" source="../media/openai-implemented-application.png" lightbox="../media/openai-implemented-application.png" alt-text="Screenshot of the application running with a connection Azure OpenAI.":::

1. Close the terminal.

### [Review code](#tab/review-code)

1. Review the `AskAsync` method of the *OpenAiService.cs* code file to make sure that your code matches this sample.

    ```csharp
    public async Task<(string response, int promptTokens, int responseTokens)> AskAsync(string sessionId, string prompt)
    {
        ChatMessage systemPrompt = new(ChatRole.System, _systemPromptText);
        ChatMessage userPrompt = new(ChatRole.User, prompt);

        ChatCompletionsOptions options = new()
        {
            Messages = {
                systemPrompt,
                userPrompt
            },
            User = sessionId,
            MaxTokens = _maxTokens,
            Temperature = 0.5f,
            NucleusSamplingFactor = 0.95f,
            FrequencyPenalty = 0,
            PresencePenalty = 0
        };
    
        ChatCompletions completions = await _client.GetChatCompletionsAsync(_deploymentName, options);

        return (
            response: completions.Choices[0].Message.Content,
            promptTokens: completions.Usage.PromptTokens,
            responseTokens: completions.Usage.CompletionTokens
        );
    }
    ```

1. Review the `SummarizeAsync` method of the *OpenAiService.cs* code file to make sure that your code matches this sample.

    ```csharp
    public async Task<string> SummarizeAsync(string sessionId, string prompt)
    {
        ChatMessage summarizePrompt = new(ChatRole.User, _summarizePromptText);
        ChatMessage userPrompt = new(ChatRole.User, prompt);

        ChatCompletionsOptions options = new()
        {
            Messages = {
                summarizePrompt,
                userPrompt
            },
            User = sessionId,
            MaxTokens = _maxTokens,
            Temperature = 0.5f,
            NucleusSamplingFactor = 0.95f,
            FrequencyPenalty = 0,
            PresencePenalty = 0
        };
    
        ChatCompletions completions = await _client.GetChatCompletionsAsync(_deploymentName, options);
        
        return completions.Choices[0].Message.Content.TrimEnd('.');
    }
    ```
