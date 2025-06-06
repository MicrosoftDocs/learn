Using the Semantic Kernel SDK takes minimal setup. To begin creating your own AI agent, you just need the SDK package and an endpoint for the large language model (LLM) service. The SDK uses this endpoint to connect to the LLM and run prompts. The Semantic Kernel SDK supports HuggingFace, OpenAI, and Azure OpenAI LLMs. For this example, we use Azure OpenAI.

The steps to get started using the Semantic Kernel SDK are:

1. Install the Semantic Kernel SDK.

    In Visual Studio Code, you can use the command: `dotnet add package Microsoft.SemanticKernel --version 1.30.0`

2. Navigate to the Azure portal.

3. Create a new Azure OpenAI resource if you don't already have one.

4. Create a deployment for the model you want to use.

5. Retrieve your key and endpoint.

6. Add your key and endpoint to the kernel builder service.

::: zone pivot="csharp"

```c#
using Microsoft.SemanticKernel;

// Populate values from your OpenAI deployment
var modelId = "";
var endpoint = "";
var apiKey = "";

// Create a kernel with Azure OpenAI chat completion
var builder = Kernel.CreateBuilder().AddAzureOpenAIChatCompletion(modelId, endpoint, apiKey);

// Build the kernel
Kernel kernel = builder.Build();
```

::: zone-end

::: zone pivot="python"

```python
from semantic_kernel import Kernel
from semantic_kernel.connectors.ai.open_ai import AzureChatCompletion

# Populate values from your OpenAI deployment
model_id = ""
endpoint = ""
api_key = ""

# Create a kernel and add Azure OpenAI chat completion
kernel = Kernel()
kernel.add_service(
    AzureChatCompletion(
        deployment_name=model_id,
        endpoint=endpoint,
        api_key=api_key
    )
)
kernel.add_service(chatcompletion)
```

::: zone-end

In the following exercises, you can practice setting up your own semantic kernel project.
