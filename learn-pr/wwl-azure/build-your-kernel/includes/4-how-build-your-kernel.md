Using the Semantic Kernel SDK takes minimal setup. To begin creating your own AI agent, you just need the SDK package and an endpoint for the large language model (LLM) service. The SDK uses this endpoint to connect to the LLM and run prompts. The Semantic Kernel SDK supports HuggingFace, OpenAI, and Azure Open AI LLMs. For this example, we use Azure Open AI.

The steps to get started using the Semantic Kernel SDK are:

1. Install the Semantic Kernel SDK.

    In Visual Studio Code, you can use the command: `dotnet add package Microsoft.SemanticKernel --version 1.2.0`

2. Navigate to the Azure portal.

3. Create a new Azure Open AI resource if you don't already have one.

4. Create a deployment for the model you want to use.

5. Retrieve your key and endpoint.

6. Add your key and endpoint to the kernel builder service.

    ```c#
    using Microsoft.SemanticKernel;

    // Create kernel
    var builder = Kernel.CreateBuilder();
    builder.AddAzureOpenAIChatCompletion(
        deploymentName: "[The name of your deployment]",
        endpoint: "[Your Azure endpoint]",
        apiKey: "[Your Azure OpenAI API key]",
        modelId: "[The name of the model]" // optional
    );
    var kernel = builder.Build();
    ```

In the following exercises, you can practice setting up your own semantic kernel project.