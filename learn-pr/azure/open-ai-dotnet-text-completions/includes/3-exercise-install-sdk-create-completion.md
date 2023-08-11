Now that we have an understanding of the different type of text completions, let's create a basic application that uses them.

You're working for an e-commerce company that sells pet products. Each product could have many reviews and you need to create an application that extracts insights from and localizes the reviews into different languages.

You decide you'll need to use classification and translation completions of the Azure OpenAI service to do so. Let's prototype things out using a .NET console application.

## Create the Azure OpenAI resource

The first step will be to create the Azure OpenAI resource and deploy the model. We'll work with the [GPT-3 Curie model](https://learn.microsoft.com/en-us/azure/cognitive-services/openai/concepts/models#curie) in this exercise. As the documentation notes, Curie works great for text sentiment and language translation which is what our application needs.

### Prerequisites

* An Azure subscription
* Access granted to Azure OpenAI in the desired subscription

    Currently, access to this service is granted only by application. You can apply for access to Azure OpenAI by completing the form at [https://aka.ms/oai/access](https://aka.ms/oai/access).
* [Azure CLI installed](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)

### Create a resource and deploying a model

Creating the resource and deploying the model is a multi-step process. We'll use the Azure CLI as it can be quicker than using the Azure portal. But note you can use the [Azure portal if you wish](https://learn.microsoft.com/azure/cognitive-services/openai/how-to/create-resource?pivots=web-portal).

1. Run the `az login` command to sign-in if you have not already.
1. When you create a new Azure resource, you have the option to create a new resource group or use an existing one. This command shows you how to create a new resource group. We'll use the name **LearnPetStore** but you can substitute the name of your choice, or use an existing group's name.

    ```azurecli
    az group create \
    --name LearnPetStore
    --location eastus
    ```

1. Run the following command to create an OpenAI resource in the **LearnPetStore** resource group. The name of the OpenAI resource will be **PetStoreOpenAI**.

    ```azurecli
    az cognitiveserices account create \
    -n PetStoreOpenAI
    -g LearnPetStore
    -l eastus
    --kind OpenAI \
    --sku s0
    ```

1. Next we want to deploy the Curie model to the OpenAI resource we just created. We'll call the model deployment **PetStoreCurieDeploy**. Note we're using **LearnPetStore** as the resource group name, **PetStoreOpenAI** as the OpenAI resource name, if you used different values make sure you substitute those.

    ```azurecli
    az cognitiveservices account deployment create \
    -g LearnPetStore \
    -n PetStoreOpenAI \
    --deployment-name PetStoreCurieDeploy \
    --model-name text-curie-001 \
    --model-version "1"
    --model-format OpenAI \
    --scale-settings-scale-type "Standard"
    ```

1. Once the resource and model have been created, we'll need to get the base URL and access keys so the .NET SDK can access the Azure OpenAI resource. Use these commands to get the endpoint and primary API keys and make note of them for later use:

    **The endpoint**

    ```azure cli
    az cognitiveservices account show \
    -g LearnPetStore \
    -n PetStoreOpenAI \
    | jq -r .properties.endpoint
    ```

    **The primary API key**

    ```azurecli
    az cognitiveservices account keys list \
    -g LearnPetStore \
    -n PetStoreOpenAI \
    | jq -r .key1
    ```

## Create the console application and add the OpenAI SDK

Next up we'll want to create a bare bones .NET Console application and add the Azure OpenAI SDK.

1. Run the following to create a new .NET application named **PetReviewAI**.

    ```dotnetcli
    dotnet new console -n PetReviewAI
    ```

1. Switch to the newly created **PetReviewAI** directory.

    ```powershell
    cd PetReviewAI
    ```

1. Then add the Azure Open AI SDK.

    ```dotnetcli
    dotnet add package Azure.AI.OpenAI --version 1.0.0-beta.5
    ```

1. Open the project in VS Code or Visual Studio.
1. In the **Program.cs** file, delete all the existing code.
1. Add `using Azure.AI.OpenAI;` to the top of **Program.cs**.
1. Add in 3 class-level variables that will hold references to the Azure OpenAI resource's endpoint, the primary API key, and the name of the model you deployed.

    ```csharp
    string openAIEndpoint = "<YOUR ENDPOINT URL VALUE>";
    readonly string openAIAPIKey = "<YOUR PRIMARY API KEY VALUE>";
    readonly string openAIDeploymentName = "PetStoreCurieDeploy";
    ```

    In the steps above we named the deployement **PetStoreCurieDeploy**, if you used a different value make sure you use that instead.
1. Finally, we'll instantiate the class needed to communicate with the Azure OpenAI resource.

    ```csharp
    var endpoint = new Uri(openAIEndpoint);
    var credentials = new Azure.AzureKeyCredential(openAIAPIKey);
    var openAIClient = new OpenAIClient(endpoint, credentials);
    ```

## Create the prompt

Let's create a prompt for the model that will show it how to classify product reviews.

1. The first step is to create a prompt that instructs the model that you'd like to classify the sentiment of a product review.

    ```csharp
    string exampleReview = "The cat never got into the catio-tent.";

    string prompt = $"""
    What is the sentiment of the following review? {exampleReview}
    """;
    ```

## Generate classification completions

Now let's have the model generate a sentiment.

1. To use the Azure OpenAI SDK, we first must define a `CompletionOptions` object that defines how we want the model to react. The exact meanings of the values of `CompletionOptions` are a bit out of scope for the module, but you can [learn more about them](https://learn.microsoft.com/dotnet/api/azure.ai.openai.completionsoptions?view=azure-dotnet-preview).

    ```csharp
    var completionOptions = new CompletionsOptions
    {
        Prompts={prompt},
        MaxTokens=64,
        Temperature=0f,
        FrequencyPenalty=0.0f,
        PresencePenalty=0.0f,
        NucleusSamplingFactor=1 // Top P
    };
    ```

1. Next call the `GetCompletionsAsync` function of the `OpenAIClient` class. You'll pass in the deployment name of the model you wish to use along with the `CompletionOptions`.

    ```csharp
    Completions response = await openAIClient.GetCompletionsAsync(openAIDeploymentName, completionOptions);
    ```

1. Then finally, read out the value the model has returned.

    ```csharp
    string sentiment = response.Choices[0].Text;

    Console.WriteLine(sentiment);
    ```

1. You can run the application by entering `dotnet run` into the terminal.
1. Experiment by changing the `exampleReview`'s value to see how the review may be classified differently.

In one example run, we received the following:

```console
The reviewer is not happy with the product.

The sentiment of this review is negative.
```

You may receive something different as the model is non-deterministic, or may produce a different output even with the same input.

## Generate translation completions

Ok, our proof-of-concept application is now successfully classifying product review sentiment. Let's translate the review into Spanish while we're at it.

1. We're using the same example review from above, but this time constructing the prompt to tell the model to translate it into Spanish.

    ```csharp
    string promptForTranslation = $"""
    Translate the following sentence into Spanish: {exampleReview}
    """;
    ```

1. Then we need to create a `CompletionsOptions` object, call the same `GetCompletionsAsync` function as before, and then read the result.

    ```csharp
    var translationCompletionOptions = new CompletionsOptions {
        Prompts = { promptForTranslation },
        MaxTokens = 64,
        Temperature = 0f,
        FrequencyPenalty=0.0f,
        PresencePenalty = 0.0f,
        NucleusSamplingFactor = 1
    
    };

    Completions translatedResponse = await openAIClient.GetCompletionsAsync(openAIDeploymentName, translationCompletionOptions);

    string translation = translatedResponse.Choices[0].Text;
    
    Console.WriteLine(translation);
    ```

The output we received this time (and yours may vary):

```console
El gato nunca entró en el catio-tent.
```

## Summary

We're now able to use the Azure OpenAI SDK along with the `text-curie-001` model to create completions that classify sentiment and translate languages of product reviews. Next up, let's see how we can improve the prompts that we send to the model.
