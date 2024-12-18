How you configure managed identity authentication for local Python development is different from how you configure managed identity authentication for Azure-hosted Python environments.

## Keyless authentication to Azure OpenAI for local Python development

For local development in Python, keyless authentication to Azure OpenAI Service uses Azure managed identities and RBAC to authenticate and authorize developers efficiently. Make sure that you configured role assignments in the previous unit. Also make sure that you configured your locally signed-in Azure account to have access to the target Azure OpenAI resource.

After the role assignments are configured, Python developers can use the Azure Identity library to authenticate against Azure OpenAI.

### Keyless authentication with the OpenAI package

The following example implements keyless authentication for the official `openai` package:

```python
import azure.identity
import openai
credential = azure.identity.DefaultAzureCredential()
token_provider = azure.identity.get_bearer_token_provider(credential, "https://cognitiveservices.azure.com/.default")

client = openai.AzureOpenAI(   
   azure_endpoint=f"https://YOUR-AZURE-OPENAI-ENDPOINT.openai.azure.com",
    azure_ad_token_provider=token_provider,
    api_version="2024-06-01",
)

response = client.chat.completions.create(
    model="YOUR-MODEL-DEPLOYMENT", 
    messages=[
        {"role": "user", "content": "Write a haiku about a hungry cat"},
    ],
)
```

In the preceding code:

- `DefaultAzureCredential` is a credential chain that attempts authentication through a sequence of specific credentials, like `AzureCliCredential` and `AzureDeveloperCliCredential`. That behavior can be convenient for local development, because it gives you the flexibility to sign in with `az login`, `azd auth login`, or any of the other supported authentication approaches.

  You can replace this class with a specific credential class if necessary. Many parameters can be passed in to customize how it works.
- `azure.identity.get_bearer_token_provider()` returns a token that provides a function for the OAuth2 scope. The scope given here is `https://cognitiveservices.azure.com/.default`, which corresponds to Azure OpenAI resources. That token provider function is called only when an actual request is made, so the line might succeed even if the resource permissions aren't set up correctly.
- The `AzureOpenAI` client is instantiated with the Azure endpoint, token provider, and desired API version. It's also possible to instantiate an `AsyncAzureOpenAI` client with the same parameters. We recommend that choice for use inside asynchronous frameworks like FastAPI or Quart.
- `client.chat.completions.create` sends a request to the Azure OpenAI deployment. When you use the `openai` package with Azure, the model parameter shouldn't actually be the model name. It should be the deployment name. Some developers choose to always name deployments the same as models for convenience, but that's not always the case.

  The token provider function is invoked at this moment. A token is returned for the provided credential and scope. If the function returns an authorization error, there's a problem with either the locally used authentication credential or the RBAC permissions for the resource.

### Keyless authentication with other packages

If you're calling Azure OpenAI through another package, such as LangChain or LlamaIndex, consult the reference for that package to determine how to use keyless authentication. Look for parameters like "token provider" (to pass in the result of calling `get_bearer_token_provider`) or "credential" (to pass in the credential itself).

Some packages might offer only the option to pass in an actual token. In that case, you can generate a token by using the Azure Identity SDK:

```python
credential = azure.identity.DefaultAzureCredential()
token = credential.get_token("https://cognitiveservices.azure.com/.default")
```

The generated token is short lived. It can expire as soon as an hour after generation. You then need to generate a new token or implement token refresh logic to avoid token expiration errors from the API. That's why we recommend using an SDK that either generates new tokens for each request or implements token refresh logic to avoid such problems.

### Sample code

The [azure-openai-keyless](https://github.com/Azure-Samples/azure-openai-keyless-python) project uses keyless authentication with the `openai` package. It also includes infrastructure-as-code files (Bicep files) that set up the required RBAC role for the local developer. You can deploy this project by using just a few commands in the Azure Developer CLI.

## Keyless authentication to Azure OpenAI for Azure-hosted Python environments

When you deploy a Python app to an Azure-hosted environment, such as Azure Container Apps or Azure App Service, the app can use keyless authentication to authenticate to Azure OpenAI.

For keyless authentication to work, you must configure the app correctly:

- The app must have a system identity enabled, or it must be associated with a user-assigned identity.
- The app identity must have correct permissions to access the Azure OpenAI resource, such as the Cognitive Services OpenAI User role or the Azure AI Developer role.

The next step is to use the Azure Identity SDK to authenticate the deployed application. There are several options, depending on which identity type you're using and how much control you want over the authentication flow.

### Keyless authentication with DefaultAzureCredential

The first option is to use the same `DefaultAzureCredential` code shown earlier:

```python
import azure.identity
import openai
credential = azure.identity.DefaultAzureCredential()
token_provider = azure.identity.get_bearer_token_provider(credential, "https://cognitiveservices.azure.com/.default")

client = openai.AzureOpenAI(   
   azure_endpoint=f"https://YOUR-AZURE-OPENAI-ENDPOINT.openai.azure.com",
    azure_ad_token_provider=token_provider,
    api_version="2024-06-01",
)
```

As described previously, this code uses a credential chain to authenticate the app. It generally works well when you're using a system identity, because the Azure Identity SDK knows exactly which identity to use when it's doing the authentication.

However, if you set up a user-assigned identity for your app, the SDK might not be able to determine which identity to use for authentication. The reason is that an app can be associated with multiple user-assigned identities. It helps to set an `AZURE_CLIENT_ID` environment variable to the client ID of the user-assigned identity, but that approach might not work on all Azure platforms.

### Keyless authentication with ManagedIdentityCredential

In a production environment on an Azure host, we recommend the `ManagedIdentityCredential(/python/api/azure-identity/azure.identity.managedidentitycredential)` class for more reliable authentication.

That class can be passed the client ID of a user-assigned identity:

`ManagedIdentityCredential(client_id=YOUR_APP_IDENTITY_CLIENT_ID)`

It can also be constructed with no parameters at all, for use with a system identity:

`ManagedIdentityCredential()`

You can use the credential the same way as `DefaultAzureCredential`. That is, you can use it to generate token providers or tokens.

## Keyless authentication across environments

Often, the same Python code is used in local environments as in production. If `DefaultAzureCredential` is working for you across both local and production environments, you can use that everywhere.

However, developers often choose to use different credentials in each environment. They control the choice based on environment variables that signal the current host.

For example, consider this `if` statement:

```python
if os.getenv("RUNNING_ON_AZURE"):
   credential = azure.identity.ManagedIdentityCredential(os.getenv("AZURE_CLIENT_ID"))
else:
  credential = azure.identity.AzureDeveloperCliCredential()

```

The code first checks for the existence of a custom environment variable that's explicitly set to signal a production environment. For production, it sets the credential variable to `ManagedIdentityCredential` and passes in the client ID of the user-assigned identity that has the correct role. Otherwise, it sets the credential variable to `AzureDeveloperCliCredential`. `AzureDeveloperCliCredential` assumes that the developer is using `azd auth login` to sign in to the Azure account locally.

Yet another approach is to set up a custom chained credential.

There are many options, depending on your environments and authentication needs.

### Sample code

The [openai-chat-app-quickstart](https://github.com/Azure-Samples/openai-chat-app-quickstart) project uses keyless authentication for an Azure container app with a user-assigned identity. The project includes infrastructure-as-code files (Bicep files) that set up the container app, identity, and roles for both the app identity and the local developer. You can deploy this project by using just a few commands in the Azure Developer CLI.
