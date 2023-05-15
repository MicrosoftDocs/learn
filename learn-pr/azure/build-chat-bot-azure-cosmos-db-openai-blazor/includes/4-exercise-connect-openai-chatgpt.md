The `OpenAiService` class contains a stub implementation of a service that can send prompts to an AI assistant and parse the responses.

There are a few key requirements we try to tackle in this exercise:

- Import the .NET SDK for Azure OpenAI
- Add the Azure OpenAI endpoint and key to the application settings
- Modify the service class with various members and a client instance

## Import the .NET SDK

The [`Azure.AI.OpenAI`](https://www.nuget.org/packages/Azure.AI.OpenAI/1.0.0-beta.5) package on NuGet provides a typed SDK to access various model deployments from your account endpoint.

1. Open a new terminal.

1. Use [`dotnet add package`](/dotnet/core/tools/dotnet-add-package) to import the `Azure.AI.OpenAI` package from NuGet specifying version `1.0.0-beta.5`.

    ```bash
    dotnet add package Azure.AI.OpenAI --version 1.0.0-beta.5
    ```

1. Build the .NET project again.

    ```bash
    dotnet build
    ```

1. Open the `cosmoschatgpt.csproj` project file.

1. Observe the entry that was created for the `Azure.AI.OpenAI` package:

    ```xml
    <ItemGroup>
      <PackageReference Include="Azure.AI.OpenAI" Version="1.0.0-beta.5" />
      ...
    </ItemGroup>
    ```

1. Close the terminal.

## Add application settings

In a .NET application, it's common to use the configuration providers to inject new settings into your application. For this application, we use the `appsettings.Development.json` file to provide the most current values for our Azure OpenAI endpoint and key.

1. In the root of the project, create a new file named **appsettings.Development.json**.

    > [!IMPORTANT]
    > On Linux, files are case-sensitive. The .NET environment for this project is named **Development** and the filename must match that environment name to work.

1. Within the file, create a new JSON object with a placeholder property for `OpenAi` settings.

    ```json
    {
      "OpenAi": {            
      }
    }
    ```

1. Within the `OpenAi` property, create two new properties for the `Endpoint` and `Key`. Use the Azure OpenAI endpoint and key settings you recorded earlier in this project.

    ```json
    {
      "OpenAi": {
        "Endpoint": "<your-azure-openai-endpoint>",
        "Key": "<your-azure-openai-key>"
      }
    }
    ```

    Assuming the name of the Azure OpenAI account is **nybncrsna76fo-openai** and the key is `4bf98cb194cdf0f9001eae3259a76ed8`, you would configure the JSON object like this example. The key in this example is fictitious.

    ```json
    {
      "OpenAi": {
        "Endpoint": "https://nybncrsna76fo-openai.openai.azure.com/",
        "Key": "4bf98cb194cdf0f9001eae3259a76ed8"
      }
    }
    ```

1. Save the **appsettings.Development.json** file.

## Add required members and a client instance

Finally, we can implement the class variables required to use the Azure OpenAI client. At this step, implement a few static prompts and create a new instance of the `OpenAIClient` class.

1. Open the **Services/OpenAiService.cs** file.

1. Add using directives for the `Azure` and `Azure.AI.OpenAI` namespaces.

    ```csharp
    using Azure;
    using Azure.AI.OpenAI;
    ```

1. Within the `OpenAiService` class, add a new variable named `_client` that's of type [`OpenAIClient`](/dotnet/api/azure.ai.openai.openaiclient).

    ```csharp
    private readonly OpenAIClient _client;
    ```

1. Create a new string variable named `_systemPromptText` with a static block of text to send to the AI assistant before each prompt.

    ```csharp
    private readonly string _systemPromptText = @"
        You are an AI assistant that helps people find information.
        Provide concise answers that are polite and professional.
        If you do not know an answer, reply with ""I do not know the answer to your question.""
    ";
    ```

1. Create another new string variable named `_summarizePromptText` with a static block of text to send to the AI assistant with instructions on how to summarize a conversation.

    ```csharp
    private readonly string _summarizePromptText = @"Please summarize the following text into two words.";
    ```

1. Within the constructor of the class, add two extra lines of code to check if the endpoint or key is null. Use `ArgumentNullException.ThrowIfNullOrEmpty` to throw an error early if either of these values are null.

    ```csharp
    ArgumentNullException.ThrowIfNullOrEmpty(endpoint);
    ArgumentNullException.ThrowIfNullOrEmpty(key);
    ```

    > [!TIP]
    > When you run the application, this will throw an error right away if either of these settings don't have a valid value provided through the **appsettings.Development.json** file.

1. Next, take the deployment name that is a parameter of the constructor and save it to the `_deploymentName` variable.

    ```csharp
    _deploymentName = deploymentName;
    ```

1. Now, let's look at the string constructor parameter that specifies the max number of tokens. This parameter needs to be parsed into an integer and saved in the `_maxTokens` variable. If it's not parsed successfully, default to a value of `3000`.

    ```csharp
    _maxTokens = Int32.TryParse(maxTokens, out _maxTokens) ? _maxTokens : 3000;
    ```

    > [!TIP]
    > This block of code takes advantage of a ternary operator to return a value whether the max tokens count is parsed from configuration or not.

1. Finally, create a new instance of the `OpenAIClient` class using the endpoint to build a `Uri` and the key to build an `AzureKeyCredential`.

    ```csharp
    Uri uri = new(endpoint);
    AzureKeyCredential credential = new(key);
    _client = new(
        endpoint: uri,
        keyCredential: credential
    );
    ```

1. Save the **Services/OpenAiService.cs** file.

## Check your work

At this point, your constructor should include enough logic to create a client instance. Since the class doesn't do anything with the client yet, there's no point in running the web application, but there's value in building the application to make sure your code doesn't have any omissions or errors.

### [Validate application](#tab/validate-app)

1. Open a new terminal.

1. Build the .NET project.

    ```bash
    dotnet build
    ```

1. Observe the build output and check to make sure there aren't any build errors.

    ```output
    MSBuild version 17.5.1+f6fdcf537 for .NET
      Determining projects to restore...
      All projects are up-to-date for restore.
    /workspaces/cosmosdb-chatgpt/Services/OpenAiService.cs(19,29): warning CS0414: The field 'OpenAiService._summarizePromptText' is assigned but its value is never used [/workspaces/cosmosdb-chatgpt/cosmoschatgpt.csproj]
    /workspaces/cosmosdb-chatgpt/Services/OpenAiService.cs(14,29): warning CS0414: The field 'OpenAiService._systemPromptText' is assigned but its value is never used [/workspaces/cosmosdb-chatgpt/cosmoschatgpt.csproj]
      cosmoschatgpt -> /workspaces/cosmosdb-chatgpt/bin/Debug/net7.0/cosmoschatgpt.dll
    Build succeeded.

    /workspaces/cosmosdb-chatgpt/Services/OpenAiService.cs(19,29): warning CS0414: The field 'OpenAiService._summarizePromptText' is assigned but its value is never used [/workspaces/cosmosdb-chatgpt/cosmoschatgpt.csproj]
    /workspaces/cosmosdb-chatgpt/Services/OpenAiService.cs(14,29): warning CS0414: The field 'OpenAiService._systemPromptText' is assigned but its value is never used [/workspaces/cosmosdb-chatgpt/cosmoschatgpt.csproj]
        2 Warning(s)
        0 Error(s)
    
    Time Elapsed 00:00:05.66
    ```

    > [!IMPORTANT]
    > At this point, you will see two new build warnings that we are not using our static string variables. We will resolve these warnings in the next exercise.

1. Close the terminal.

### [Review code](#tab/review-code)

1. Review the *OpenAiService.cs* code file to make sure that your code matches this sample.

    ```csharp
    using Azure;
    using Azure.AI.OpenAI;
    
    namespace Cosmos.Chat.GPT.Services;
    
    public class OpenAiService
    {
        private readonly string _deploymentName = String.Empty;
        private readonly int _maxTokens = default;
        private readonly OpenAIClient _client;
        private readonly string _systemPromptText = @"
            You are an AI assistant that helps people find information.
            Provide concise answers that are polite and professional.
            If you do not know an answer, reply with ""I do not know the answer to your question.""
        ";
        private readonly string _summarizePromptText = @"Please summarize the following text into two words.";

        public int MaxTokens
        {
            get => _maxTokens;
        }

        public OpenAiService(string endpoint, string key, string deploymentName, string maxTokens)
        {
            // Implementation removed for brevity
        }

        // Other methods removed for brevity
    }
    ```

1. Within the **OpenAiService.cs** code file, review the constructor to make sure that your code matches this sample.

    ```csharp
    ArgumentNullException.ThrowIfNullOrEmpty(deploymentName);
    ArgumentNullException.ThrowIfNullOrEmpty(maxTokens);
    ArgumentNullException.ThrowIfNullOrEmpty(endpoint);
    ArgumentNullException.ThrowIfNullOrEmpty(key);

    _deploymentName = deploymentName;
    _maxTokens = Int32.TryParse(maxTokens, out _maxTokens) ? _maxTokens : 3000;

    Uri uri = new(endpoint);
    AzureKeyCredential credential = new(key);
    _client = new(
        endpoint: uri,
        keyCredential: credential
    );
    ```

1. Review the **appsettings.Development.json** file to ensure you have valid credentials for the Azure OpenAI service.

    ```json
    {
      "OpenAi": {
        "Endpoint": "<your-azure-openai-endpoint>",
        "Key": "<your-azure-openai-key>"
      }
    }
    ```

---
