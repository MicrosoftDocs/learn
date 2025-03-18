Now that you know how to authenticate an Azure OpenAI Service account with a managed identity, let's explore the benefits of a managed identity from a security perspective.

## Overview of benefits

Managed identities provide many benefits over API keys. They eliminate the need to store credentials within application code, which reduces the risk of credential leaks. They also provide a more secure and automated method for accessing Azure services by using Microsoft Entra authentication. This approach simplifies credential management and enhances security by ensuring that credentials aren't hard-coded or exposed.

## Example

The following code sets up a managed identity credential by using the client ID of a user-assigned identity, which is stored in the environment variable `AZURE_CLIENT_ID`. The only other environment variable that's necessary is the Azure OpenAI endpoint, typically a URL that looks like `https://your-service-name.openai.azure.com`.

```python
credential = azure.identity.ManagedIdentityCredential(os.getenv("AZURE_CLIENT_ID"))
token_provider = azure.identity.get_bearer_token_provider(credential, "https://cognitiveservices.azure.com/.default")
azure_openai_endpoint = os.getenv("AZURE_OPENAI_ENDPOINT"),

client = openai.AzureOpenAI(   
   azure_endpoint=azure_openai_endpoint,
    azure_ad_token_provider=token_provider,
    api_version="2024-06-01",
)
```

Let's evaluate the effect of a leaked client ID versus a leaked API key.

An API key functions similarly to a regular password. If an API key is compromised, anyone with the key can access the resource, especially if the Azure OpenAI service is configured to allow public access from all IP addresses. (Most services are configured that way, because it's the default.) For Azure OpenAI, this access means a threat actor could gain unrestricted use of language models like GPT-4. A threat actor could even access internal data if the models were being used with features like the Assistants API.

Conversely, if the client ID is leaked, the risks are minimal. The reason is that the client ID alone can't establish a connection to Azure OpenAI. To be able to authenticate with a managed identity, the app code must be running on an Azure host. Even if Azure OpenAI is public, a local environment can't be used as a managed identity. An attacker can't generate tokens for it. All their requests are rejected from the Azure OpenAI service, because the token is incorrect.

Additionally, the user-assigned identity has only the permissions of the roles assigned to it. For example, assume that you use the Azure CLI to assign the identity a role:

```sh
az role assignment create --assignee $USER_MANAGED_ID_PRINCIPAL_ID \
--scope $OPEN_AI_RESOURCE_ID \
--role "Cognitive Services OpenAI User"
```

That code assigns the Cognitive Services OpenAI User role for the Azure OpenAI service. This assignment limits permissions to specific operations only with that Azure OpenAI service.

Compared to the ramifications of a leaked API key, exploiting a leaked client ID involves several steps, so it's harder for threat actors to exploit. For these reasons, managed identities are safer than API keys for managing operations. We strongly recommend that you use a managed identity over API keys when you're authenticating to Azure OpenAI or any other Azure service that supports managed identities.
