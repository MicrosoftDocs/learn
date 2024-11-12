Now that you know how to authenticate an Azure OpenAI account with managed identity, let's explore more deeply the benefits of managed identity from a security perspective.

The following code sets up a managed identity credential using the client ID of a user-assigned identity, which is stored in the environment variable `AZURE_CLIENT_ID`. The only other environment variable necessary is the Azure OpenAI endpoint, typically a URL that looks like "https://your-service-name.openai.azure.com"

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

An API key functions similarly to a regular password. If an API key is compromised, anyone with the key can access the resource, especially if the Azure OpenAI service is configured to allow public access from all IPs (as most are, since that's the default). For Azure OpenAI, this means a bad actor could gain unrestricted use of language models like GPT-4, and even access to internal data if the models were being used with features like the assistants API.

Conversely, if the client ID is leaked, the risks are minimal. This is because the client ID alone can't establish a connection to Azure OpenAI. To be able to authenticate with a Managed Identity, the app code must be running on an Azure host. Even if Azure OpenAI is public, a local environment can't be used as a Managed Identity, so an attacker can't generate tokens for it, and all their requests are rejected from the Azure OpenAI service as the token is incorrect.

Additionally, the user-assigned identity only has the permissions of the roles assigned to it. For example, if we have used the Azure CLI to assign itthe identity a role:

```sh
az role assignment create --assignee $USER_MANAGED_ID_PRINCIPAL_ID \
--scope $OPEN_AI_RESOURCE_ID \
--role "Cognitive Services OpenAI User"
```

Here, the "Cognitive Services OpenAI User" role was assigned for the Azure OpenAI service, limiting permissions to specific operations only with that Azure OpenAI service.

In summary, compared to the ramifications of a leaked API key, exploiting a leaked client ID involves several steps, making it harder for malicious actors to exploit. For these reasons, Managed Identities offer a safer method to manage operations compared to API keys. It's recommended in the strongest possible terms that you use Managed Identity over API keys when authenticating to Azure OpenAI, or any other Azure service that supports Managed Identity.
