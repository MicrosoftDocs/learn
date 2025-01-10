To configure an application to use Managed Identity with Azure OpenAI Service, install the ``Azure.Identity NuGet`` package by running the following command:

```bash
dotnet add package Azure.Identity
```

Create the AzureOpenAIClient from the Azure SDK, providing the ``DefaultAzureCredential`` instance.

```csharp
AzureOpenAIClient azureClient = new(
    new Uri("https://your-azure-openai-resource.com"),
    new DefaultAzureCredential());
ChatClient chatClient = azureClient.GetChatClient("my-gpt-35-turbo-deployment");
```

Use the AzureOpenAIClient to perform a chat completion.

```csharp
ChatCompletion completion = chatClient.CompleteChat(
    [
        // System messages represent instructions or other guidance about how the assistant should behave
        new SystemChatMessage("You are a helpful assistant that talks like a pirate."),

        // User messages represent user input, whether historical or the most recent input
        new UserChatMessage("Hi, can you help me?"),

        // Assistant messages in a request represent conversation history for responses
        new AssistantChatMessage("Arrr! Of course, me hearty! What can I do for ye?"),
        new UserChatMessage("What's the best way to train a parrot?"),
    ]);
Console.WriteLine($"{completion.Role}: {completion.Content[0].Text}");
```
