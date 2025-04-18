Now that we have an understanding of text and chat completions, let's create a basic application that uses them.

You work for an organization that helps hikers explore the outdoors by recommending trails. You're considering adding a conversational AI to the recommendation functionality and would like to create a prototype.

You decide you need to use the Chat Completion API provided by the GPT-35-Turbo model.

## Create the Azure OpenAI resource

The first step is to create the Azure OpenAI resource and deploy the model. Let's use the [GPT-3 Turbo model](/azure/cognitive-services/openai/concepts/models#gpt-35) in this exercise. As the documentation notes, GPT-3.5 Turbo uses the Chat Completions API and is great for our use case.

### Prerequisites

* An Azure subscription
* Access granted to Azure OpenAI in the desired subscription

    Currently, you can gain access to this service only by application. You can apply for access to Azure OpenAI by completing the form at [https://aka.ms/oai/access](https://aka.ms/oai/access).
* [Azure CLI installed](/cli/azure/install-azure-cli)

### Create a resource and deploying a model

Creating the resource and deploying the model is a multi-step process. Use the Azure CLI as it can be quicker than using the Azure portal. But note you can use the [Azure portal if you wish](/azure/cognitive-services/openai/how-to/create-resource?pivots=web-portal).

1. Run the `az login` command to sign-in if you haven't already.
1. When you create a new Azure resource, you can create a new resource group or use an existing one. This command shows you how to create a new resource group. Use the name **HikingConversations-RG**, substitute the name of your choice, or use an existing group's name.

    ::: zone pivot="cli"

    ```azurecli
    az group create \
    --name HikingConversations-RG \
    --location eastus
    ```

    ::: zone-end

    ::: zone pivot="powershell"

    ```powershell
    az group create `
    --name HikingConversations-RG `
    --location eastus
    ```

    ::: zone-end

1. Run the following command to create an OpenAI resource in the **HikingConversations-RG** resource group. Name the OpenAI resource **HikingConversationsAI**.

    ::: zone pivot="cli"

    ```azurecli
    az cognitiveservices account create \
    -n HikingConversationsAI \
    -g HikingConversations-RG \
    -l eastus \
    --kind OpenAI \
    --sku s0
    ```

    ::: zone-end

    ::: zone pivot="powershell"

    ```powershell
    az cognitiveservices account create `
    -n HikingConversationsAI `
    -g HikingConversations-RG `
    -l eastus `
    --kind OpenAI `
    --sku s0
    ```

    ::: zone-end

1. Next we want to deploy the GPT-35-Turbo model to the OpenAI resource we created. Call the model deployment **HikingRecommendationTurbo**. Note we're using **HikingConversations-RG** as the resource group name and **HikingConversationsAI** as the OpenAI resource name. If you used different values, make sure you substitute those values.

    ::: zone pivot="cli"

    ```azurecli
    az cognitiveservices account deployment create \
    -g HikingConversations-RG \
    -n HikingConversationsAI \
    --deployment-name HikingRecommendationTurbo \
    --model-name gpt-35-turbo \
    --model-version "0125" \
    --model-format OpenAI \
    --sku-capacity 1
    --sku-name "Standard"
    ```

    ::: zone-end

    ::: zone pivot="powershell"

    ```powershell
    az cognitiveservices account deployment create `
    -g HikingConversations-RG `
    -n HikingConversationsAI `
    --deployment-name HikingRecommendationTurbo `
    --model-name gpt-35-turbo `
    --model-version "0125"
    --model-format OpenAI `
    --sku-capacity 1
    --sku-name "Standard"
    ```

    ::: zone-end

1. Once the resource and model have been created, we need to get the base URL and access keys so the .NET SDK can access the Azure OpenAI resource. Use these commands to get the endpoint and primary API keys, and make note of them for later use:

    **The endpoint**

    ::: zone pivot="cli"

    ```azurecli
    az cognitiveservices account show \
    -g HikingConversations-RG \
    -n HikingConversationsAI \
    --query "properties.endpoint"
    ```

    ::: zone-end

    ::: zone pivot="powershell"

    ```powershell
    az cognitiveservices account show `
    -g HikingConversations-RG `
    -n HikingConversationsAI `
    --query "properties.endpoint"
    ```

    ::: zone-end

    **The primary API key**

    ::: zone pivot="cli"

    ```azurecli
    az cognitiveservices account keys list \
    -g HikingConversations-RG \
    -n HikingConversationsAI \
    --query "key1"
    ```

    ::: zone-end

    ::: zone pivot="powershell"

    ```powershell
    az cognitiveservices account keys list `
    -g HikingConversations-RG `
    -n HikingConversationsAI `
    --query "key1"
    ```

    ::: zone-end

## Create the console application and add the OpenAI SDK

Next up we want to create a bare bones .NET Console application and add the Azure OpenAI SDK.

1. Run the following to create a new .NET application named **HikingConversationsAI**.

    ```dotnetcli
    dotnet new console -n HikingConversationsAI
    ```

1. Switch to the newly created **HikingConversationsAI** directory.

    ```powershell
    cd HikingConversationsAI
    ```

1. Then add the Azure OpenAI SDK.

    ```dotnetcli
    dotnet add package Azure.AI.OpenAI --prerelease
    ```

1. Open the project in VS Code or Visual Studio.
1. In the **Program.cs** file, delete all the existing code.
1. Add `using Azure.AI.OpenAI;` to the top of **Program.cs**.
1. Add `using Azure;` to the top of **Program.cs**.
1. Add in three class-level variables that hold references to the Azure OpenAI resource's endpoint, the primary API key, and the name of the model you deployed.

    ```csharp
    string openAIEndpoint = "<YOUR ENDPOINT URL VALUE>";
    string openAIAPIKey = "<YOUR PRIMARY API KEY VALUE>";
    string openAIDeploymentName = "HikingRecommendationTurbo";
    ```

    In the preceding steps, we named the deployment **HikingRecommendationTurbo**. If you used a different value, make sure you use that instead.
1. Finally, instantiate the class needed to communicate with the Azure OpenAI resource.

    ```csharp
    var endpoint = new Uri(openAIEndpoint);
    var credentials = new AzureKeyCredential(openAIAPIKey);
    var openAIClient = new AzureOpenAIClient(endpoint, credentials);
    ```

## Create the system prompt

Let's create the initial system role prompt that will provide the initial instructions to the model.

1. First create the prompt that instructs the model how you'd like it to act during the conversation when recommending hikes.

    ```csharp
    var systemPrompt = 
    """
    You are a hiking enthusiast who helps people discover fun hikes. You are upbeat and friendly. 
    You ask people what type of hikes they like to take and then suggest some.
    """;
    ```

1. Next create a `List<ChatMessage>` to hold all messages that will be sent to and from the model.

    ```csharp
    List<ChatMessage> chatHistory = new();
    ```

1. Then create a new `SystemChatMessage` object, and add it to the `chatHistory` list. We'll be setting the `ChatMessage` to be coming from the System role.

    ```csharp
    SystemChatMessage systemMessage = ChatMessage.CreateSystemMessage(systemPrompt);

    chatHistory.Add(systemMessage);
    ```

## Initiate the conversation

Next we'll send the first message to the model, initiating the conversation.

1. Create a prompt for the user, and add it to the `chatHistory` as a user message.

    ```csharp
    string userGreeting = """
    Hi there hiking recommendation bot! 
    Can't wait to hear what you have in store for me!
    """;

    UserChatMessage userGreetingMessage = ChatMessage.CreateUserMessage(userGreeting);
    chatHistory.Add(userGreetingMessage);

    Console.WriteLine($"User >>> {userGreeting}");
    ```

1. Now you'll need to get a reference to the `ChatClient` object. This object is responsible for facilitating chat conversations with the model. As such, you'll need to tell the Azure OpenAI Client object which model that you deployed you want to use.

    ```csharp
    var chatClient = openAIClient.GetChatClient(openAIDeploymentName);
    ```

1. Next call the `CompleteChatAsync` function of the `ChatClient` class passing in the `chatHistory`.

    ```csharp
    var response = await chatClient.CompleteChatAsync(chatHistory);
    ```

1. Then finally, read out the value the model has returned.

    ```csharp
    Console.WriteLine($"AI >>> {response.Value.Content.Last().Text}");
    ```

1. Let's see what we have so far. You can run the application by entering `dotnet run` into the terminal.
1. Experiment by changing the `userGreetingMessage`'s value to see how the model may respond differently.

In one example run, we received the following:

```console
Hello! Great to hear from you. What type of hikes are you interested in? Do you enjoy easy scenic walks, challenging trails, or something in between? Do you prefer hikes with waterfalls, mountain views, or unique geological formations?
```

You may receive something different as the model is nondeterministic, or it may produce a different output even with the same input.

## Continuing the conversation

Let's continue on by responding to the conversation and then outputting the response.

1. Make sure that we retain context of the conversation, so add the response that came back directly to the `chatHistory` list.

    ```csharp
    var assistantMessage = ChatMessage.CreateAssistantMessage(response.Value.Content.Last().Text);

    chatHistory.Add(assistantMessage); 
    ```

1. Next create another user prompt, and send it to the model.

    ```csharp
    var hikeRequest = 
    """
    I would like a strenuous hike near where I live that ends with
    a view that is amazing.
    """;

    Console.WriteLine($"User >>> {hikeRequest}");

    UserChatMessage hikeMessage = ChatMessage.CreateUserMessage(hikeRequest);

    chatHistory.Add(hikeMessage);

    response = await chatClient.CompleteChatAsync(chatHistory); 

    Console.WriteLine($"AI >>> {response.Value.Content.Last().Text}");
    ```

1. You can experiment by changing the `hikeRequest` variable to request different types of hikes. In one example run we received:

    ```console
    Great choice! If you're up for a challenge, I recommend checking out the hike to Poo Poo Point in Issaquah, Washington. The hike is 7.2 miles roundtrip, with an elevation gain of 1,858 feet, so it's definitely a workout. But the stunning views of Mount Rainier and the Cascade Mountains make it all worthwhile. Plus, you'll get to see paragliders taking off from Poo Poo Point. It's a popular hike, so I recommend going early to avoid crowds. Let me know if you need more information!
    ```

## Summary

We're now able to use the Azure OpenAI SDK along with the `gpt-35-turbo` model to create conversations that help provide hiking recommendations. Next up, let's see how we can improve the prompts that we send to the model.
