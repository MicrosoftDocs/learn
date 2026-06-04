When you authenticate by using a user-assigned managed identity, you need to tell `DefaultAzureCredential` or `ManagedIdentityCredential` in your JavaScript application which identity to use. You do this by setting the `AZURE_CLIENT_ID` environment variable (or by passing `managedIdentityClientId` in the credential options) to the client ID of the user-assigned managed identity. A system-assigned managed identity doesn't require a client ID; on an Azure-hosted resource, the parameterless `new DefaultAzureCredential()` is sufficient.

At first glance, it might seem that this is the only vital piece of information required for the connection, aside from the endpoint URL.

```javascript
import { DefaultAzureCredential, getBearerTokenProvider } from "@azure/identity";
import { AzureOpenAI } from "openai";

// For a user-assigned managed identity, set the AZURE_CLIENT_ID environment variable
// to the client ID of the user-assigned managed identity. For a system-assigned
// managed identity, no client ID is required.
const credential = new DefaultAzureCredential();
const scope = "https://cognitiveservices.azure.com/.default";
const azureADTokenProvider = getBearerTokenProvider(credential, scope);

const endpoint = process.env["AZURE_OPENAI_ENDPOINT"];
if (!endpoint) {
  throw new Error("Set the AZURE_OPENAI_ENDPOINT environment variable to your Azure OpenAI resource endpoint.");
}
const deployment = "<your Azure OpenAI deployment name>";
const apiVersion = "2024-10-21";
const options = { azureADTokenProvider, deployment, apiVersion, endpoint }

const client = new AzureOpenAI(options);

```

Let's evaluate the impact of a leaked client ID versus a leaked API key.

An API key functions similarly to a regular password. If it's compromised, anyone with the key can access the resource. For Azure OpenAI, this means unrestricted use of any model deployed to that resource (for example, `gpt-4.1`, `gpt-4o`, or `gpt-5.1`). If the network is publicly accessible, the security impact could be even greater.

Conversely, if the client ID is leaked, the risks are minimal. A client ID alone can't be used to obtain a Microsoft Entra ID token. A managed identity is bound to the Azure resource it's assigned to, and only that resource (for example, the specific Azure App Service, Azure Functions, or Azure Virtual Machine) can request a token for the identity. A bad actor who learns the client ID can't use it from a local machine or another network to call Azure OpenAI.

Additionally, the following role assignment is configured for the user-assigned managed identity:

```sh
az role assignment create --assignee $USER_MANAGED_ID_PRINCIPAL_ID \
--scope $OPEN_AI_RESOURCE_ID \
--role "Cognitive Services OpenAI User"
```

This configures the actions that can be performed using this managed identity (more on this later in the module). Here, the Cognitive Services OpenAI User role is assigned at the Azure OpenAI resource scope, limiting permissions to inference operations on that specific Azure OpenAI resource.

In summary, compared to the ramifications of a leaked API key, exploiting a leaked client ID involves several steps, making it harder for malicious actors to exploit. 
For these reasons, managed identities offer a safer method to manage operations compared to API keys. It's recommended in the strongest possible terms that you use a managed identity over API keys when authenticating to Azure OpenAI, or any other Azure service that supports managed identities.
