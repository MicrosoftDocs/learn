In keyless authentication to Azure OpenAI for JavaScript, you use a managed identity (for Azure-hosted code) or your developer Microsoft Entra ID identity (for local development) to authenticate instead of hardcoding API keys. This is done through the `DefaultAzureCredential` or `ManagedIdentityCredential` class from the `@azure/identity` library, which provides a secure way to obtain the bearer tokens needed for authenticating to Azure services. Here's how it works in practice:

1. **Set up the Azure environment.** Ensure your Azure OpenAI resource is created and that your developer identity (for local development) or managed identity (for Azure-hosted code) is granted an Azure OpenAI RBAC role (for example, **Cognitive Services OpenAI User**) on the resource.
2. **Initialize credentials.** Use the `DefaultAzureCredential` class or `ManagedIdentityCredential` class from `@azure/identity` to obtain a token automatically.
3. **Create the client instance.** Instantiate `AzureOpenAI` from the `openai` package with the `endpoint`, `deployment`, `apiVersion`, and the token provider returned by `getBearerTokenProvider`.
4. **Make API calls.** Use the client (for example, `client.chat.completions.create`) to interact with Azure OpenAI securely, without handling secrets in code.

The following sample shows all four steps together:

```javascript
import { AzureOpenAI } from 'openai';
import { getBearerTokenProvider, DefaultAzureCredential } from '@azure/identity';

// Set AZURE_OPENAI_ENDPOINT to the endpoint of your Azure OpenAI resource,
// for example: https://YOUR-RESOURCE-NAME.openai.azure.com/
const endpoint = process.env.AZURE_OPENAI_ENDPOINT;
if (!endpoint) {
  throw new Error("Set the AZURE_OPENAI_ENDPOINT environment variable to your Azure OpenAI resource endpoint.");
}
const deployment = '<your Azure OpenAI deployment name>';
const apiVersion = '2024-10-21';

const credential = new DefaultAzureCredential();
const scope = 'https://cognitiveservices.azure.com/.default';
const azureADTokenProvider = getBearerTokenProvider(credential, scope);

// Create an Azure OpenAI client.
const client = new AzureOpenAI({ azureADTokenProvider, endpoint, deployment, apiVersion });

// Call the chat completions API. In the Azure OpenAI client, `model` is the
// name of the deployment, not the underlying model name.
const result = await client.chat.completions.create({
  model: deployment,
  messages: [{ role: 'user', content: 'Say hello!' }],
});

console.log(result.choices[0].message?.content);
```

## Local development versus Azure-hosted execution

`DefaultAzureCredential` is designed to work in both local development and Azure-hosted environments. The credential tries a chain of credential types until one succeeds:

- **Local development:** It picks up the signed-in developer identity through credentials such as `AzureCliCredential` (after `az login`), `AzurePowerShellCredential`, and supported IDE credentials. The developer identity must be granted an Azure OpenAI RBAC role on the target resource.
- **Azure-hosted environments:** When the same code runs on resources such as Azure App Service, Azure Functions, Azure Container Apps, or Azure Virtual Machines, `DefaultAzureCredential` uses `ManagedIdentityCredential` to obtain a token for the managed identity assigned to that resource. The managed identity must be granted an Azure OpenAI RBAC role on the target resource.

For a user-assigned managed identity, set the `AZURE_CLIENT_ID` environment variable (or pass `managedIdentityClientId` in the credential options) to the client ID of that user-assigned identity. A system-assigned managed identity doesn't require a client ID; on an Azure-hosted resource, the parameterless `new DefaultAzureCredential()` is sufficient.
