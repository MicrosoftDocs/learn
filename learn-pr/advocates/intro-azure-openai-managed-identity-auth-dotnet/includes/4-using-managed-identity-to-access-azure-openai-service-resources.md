To configure an application to use managed identity with Azure OpenAI in Microsoft Foundry Models, install the ``Azure.AI.OpenAI`` and ``Azure.Identity`` NuGet packages by running the following commands. ``Azure.AI.OpenAI`` provides the Azure OpenAI client, and ``Azure.Identity`` provides the credential types used for Microsoft Entra ID authentication.

```bash
dotnet add package Azure.AI.OpenAI
dotnet add package Azure.Identity
```

Create the ``AzureOpenAIClient`` from the Azure SDK, providing a credential. For local development or Azure-hosted apps where a chain of credential sources is acceptable, use ``DefaultAzureCredential``. Replace the endpoint with your Azure OpenAI resource endpoint (or read it from the ``AZURE_OPENAI_ENDPOINT`` environment variable) and replace the deployment name with the name of a model deployment in your resource.

```csharp
using Azure.AI.OpenAI;
using Azure.Identity;
using OpenAI.Chat;

AzureOpenAIClient azureClient = new(
    new Uri("https://<your-resource-name>.openai.azure.com/"),
    new DefaultAzureCredential());
ChatClient chatClient = azureClient.GetChatClient("<your-deployment-name>");
```

In production on Azure, prefer an explicit credential such as ``ManagedIdentityCredential``. For a user-assigned managed identity, pass the identity's client ID:

```csharp
AzureOpenAIClient azureClient = new(
    new Uri("https://<your-resource-name>.openai.azure.com/"),
    new ManagedIdentityCredential(ManagedIdentityId.FromUserAssignedClientId("<user-assigned-client-id>")));
```

Use the ``ChatClient`` to perform a chat completion. The ``CompleteChat`` method is synchronous; ``CompleteChatAsync`` is the asynchronous equivalent.

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
