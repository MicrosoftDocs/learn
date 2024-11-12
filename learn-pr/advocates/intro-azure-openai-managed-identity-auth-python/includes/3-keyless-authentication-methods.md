How you configure managed identity authentication for local python development is different from how you configure managed identity authentication for Azure-hosted python environments.

## Keyless authentication to Azure OpenAI for local python development

For local development in Python, this method uses Azure's Managed Identities and Role-Based Access Control (RBAC) to authenticate and authorize developers efficiently. See the previous unit on configuring role assignments and make sure you've configured your locally signed in Azure account to have access to the target Azure OpenAI resource.

Once the role assignments are configured, Python developers can use the Azure Identity library to authenticate against Azure OpenAI.

## Keyless authentication with the OpenAI package

The example below implements keyless authentication for the official openai() package:

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

In this code:

- `DefaultAzureCredential` is a "credential chain" which attempts authentication through a sequence of specific credentials, like AzureCliCredential and AzureDeveloperCliCredential. That can be convenient for local development since it gives you the flexibility to sign-in with `az login`, `azd auth login`, or any of the other supported authentication approaches. However, that class can be replaced by a specific credential class if needed, and many parameters can be passed in to customize how it works.
- `azure.identity.get_bearer_token_provider()`returns a token providing function for the given OAuth2 scope. The scope given here is "https://cognitiveservices.azure.com/.default" which corresponds to Azure OpenAI resources. That token provider function is only called when an actual request is made, so that line might succeed even if the resource permissions aren't set up correctly.
- `AzureOpenAI` client is instantiated with the Azure endpoint, token provider, and [desired API version]. It's also possible to instantiate an `AsyncAzureOpenAI` client with the same parameters, which is recommended for use inside async frameworks like FastAPI or Quart.
- `client.chat.completions.create` sends a request to the given Azure OpenAI deployment. When using the `openai` package with Azure, the model parameter shouldn't actually be the model name, it should be the deployment name. Some developers choose to always name deployments the same as models, for convenience, but that's not always the case. It's at this moment that the token provider function is invoked, and a token is returned for the given credential and scope. If an Authorization error is returned, then there's an issue with either the locally used authentication credential or the RBAC permissions for the resource.

## Keyless authentication with other packages

If you're calling Azure OpenAI through another package, such as Langchain or Llamaindex, then you need to consult their reference to determine how to use keyless authentication. Look for parameters like "token provider" (to pass in the result of calling `get_bearer_token_provider`) or "credential" (to pass in the credential itself).

Some packages may only offer the option to pass in an actual token. In that case, you can generate a token using the Azure Identity SDK like so:

```python
credential = azure.identity.DefaultAzureCredential()
token = credential.get_token("https://cognitiveservices.azure.com/.default")
```

The generated token is short-lived, and may expire as soon as an hour after generation. You would then need to generate a new token or implement token refresh logic to avoid token expiration errors from the API. That is why we recommend using an SDK that either generates new tokens for each request or implement token refresh logic, to avoid such issues.

## Sample code

The **azure-openai-keyless project** uses keyless authentication with the `openai` package, and also includes infrastructure-as-code (Bicep files) which set up the required RBAC role for the local developer. That project can be deployed with the Azure Developer CLI with just a few commands.

## Keyless authentication to Azure OpenAI for Azure-hosted Python environments

When you deploy a Python app to an Azure-hosted environment, such as Container Apps or App Service, the app can use keyless authentication to authenticate to Azure OpenAI.

For keyless authentication to work, the app must first be configured correctly:

- The app must either have "system identity" enabled, or be associated with a "user-assigned" identity. See previous unit about identity types.
- The app identity must have correct permissions to access the Azure OpenAI resource, such as the "Cognitive Services OpenAI User" role or "Azure AI Developer role". See previous unit on RBAC role assignment.

The next step is to use the Azure Identity SDK to authenticate the deployed application. There are several options depending on which identity type you're using and how much control you want over the authentication flow.

## Keyless authentication with DefaultAzureCredential

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

As described previously, this code uses a credential chain to authenticate the app. It generally works well when using a system identity, because the Azure Identity SDK knows exactly which identity to use when doing the authentication.

However, if you set up a user-assigned identity for your app, then the SDK may not be able to determine which identity to use for authentication, since an app can be associated with multiple user-assigned identities. It helps to set an `AZURE_CLIENT_ID` environment variable to the client ID of the user-assigned identity, but that may not work on all Azure platforms.

## Keyless authentication with ManagedIdentityCredential

In a production environment on an Azure host, we recommend the `ManagedIdentityCredential(/python/api/azure-identity/azure.identity.managedidentitycredential)` class for more reliable authentication.

That class can be passed the client ID of a user-assigned identity:

`ManagedIdentityCredential(client_id=YOUR_APP_IDENTITY_CLIENT_ID)`

It can also be constructed with no parameters at all, for use with system identity:

`ManagedIdentityCredential()`

The credential can be used the same way as the `DefaultAzureCredential`, so it can be used to generate token providers or tokens.

## Keyless authentication across environments

Often, the same Python code is used in local environments as in production. If `DefaultAzureCredential` is working for you across both local and production environments, then you can use that everywhere.

However, developers often choose to use different credentials in each environment, and control the choice based on environment variables signaling the current host. 

For example, consider this if statement:

```python
if os.getenv("RUNNING_ON_AZURE"):
   credential = azure.identity.ManagedIdentityCredential(os.getenv("AZURE_CLIENT_ID"))
else:
  credential = azure.identity.AzureDeveloperCliCredential()

```

That code first checks for the existence of a custom environment variable that has been explicitly set to signal a production environment. For production, it sets the credential variable to a `ManagedIdentityCredential` and passes in the client ID of the user-assigned identity that has the correct role. Otherwise, it sets the credential variable to `AzureDeveloperCliCredential`, which assumes the developer is using `azd auth login` to log in to their Azure account locally.

Yet another approach is to set up a custom chained credential.

There are many options depending on your environments and authentication needs.

## Sample code

The **openai-chat-app-quickstart project** uses keyless authentication for an Azure Container App with a user-assigned identity. The project includes infrastructure-as-code (Bicep files) that set up the Container App, identity, and roles for both the app identity and local developer. That project can be deployed with the Azure Developer CLI with just a few commands.
