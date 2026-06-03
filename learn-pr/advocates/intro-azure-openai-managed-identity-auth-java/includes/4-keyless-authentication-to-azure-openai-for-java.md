Keyless authentication lets a Java application call Azure OpenAI with a Microsoft Entra ID token instead of an API key. The identity that runs the application must be assigned the `Cognitive Services OpenAI User` role on the Azure OpenAI resource for inference.

Use the current OpenAI Java SDK with Azure Identity. The Azure OpenAI endpoint uses the `/openai/v1/` path, and the `model` value in the request is your Azure OpenAI deployment name.

## Add dependencies

Add the OpenAI Java SDK and Azure Identity to your Maven project:

```xml
<dependencies>
  <dependency>
    <groupId>com.openai</groupId>
    <artifactId>openai-java</artifactId>
    <version>4.0.1</version>
  </dependency>
  <dependency>
    <groupId>com.azure</groupId>
    <artifactId>azure-identity</artifactId>
    <version>1.18.0</version>
  </dependency>
</dependencies>
```

## Configure environment variables

Set these values before running the application:

> [!IMPORTANT]
> This example calls the Azure OpenAI Responses API. Use an Azure OpenAI resource in a region that supports the Responses API, and set `AZURE_OPENAI_DEPLOYMENT` to a deployment of a model/version supported by the Responses API in that region. Not every supported model is available in every supported region; check the [Responses API supported regions](https://learn.microsoft.com/azure/ai-foundry/openai/how-to/responses#supported-regions) and [supported models](https://learn.microsoft.com/azure/ai-foundry/openai/how-to/responses#supported-models).

- `AZURE_OPENAI_ENDPOINT`: The Azure OpenAI resource endpoint with a custom subdomain, such as `https://<resource-name>.openai.azure.com`. Microsoft Entra ID authentication requires a custom subdomain; older resources that still use a regional Cognitive Services endpoint may need a custom subdomain generated before keyless authentication works.
- `AZURE_OPENAI_DEPLOYMENT`: The Azure OpenAI deployment name to use as the `model` value. The deployment must be for a model/version that supports the Responses API in the Azure OpenAI resource region.
- `AZURE_CLIENT_ID`: The client ID of a user-assigned managed identity. A system-assigned managed identity doesn't use a client ID.

For local development, `DefaultAzureCredential` uses developer credentials, such as the Azure CLI sign-in, not a managed identity. Assign `Cognitive Services OpenAI User` to your local user account for local testing. For an Azure-hosted application, assign the role to the managed identity's principal or object ID. The `AZURE_CLIENT_ID` value selects a user-assigned managed identity in code; it isn't the role assignment object ID.

## Create the client and call Azure OpenAI

```java
import com.azure.identity.AuthenticationUtil;
import com.azure.identity.DefaultAzureCredentialBuilder;
import com.openai.client.OpenAIClient;
import com.openai.client.okhttp.OpenAIOkHttpClient;
import com.openai.credential.BearerTokenCredential;
import com.openai.models.responses.Response;
import com.openai.models.responses.ResponseCreateParams;

public class AzureOpenAIKeylessExample {
    public static void main(String[] args) {
        String endpoint = requireEnv("AZURE_OPENAI_ENDPOINT").replaceAll("/+$", "");
        String deploymentName = requireEnv("AZURE_OPENAI_DEPLOYMENT");

        OpenAIClient client = OpenAIOkHttpClient.builder()
            .baseUrl(endpoint + "/openai/v1/")
            .credential(BearerTokenCredential.create(AuthenticationUtil.getBearerTokenSupplier(
                new DefaultAzureCredentialBuilder().build(), "https://ai.azure.com/.default")))
            .build();

        ResponseCreateParams params = ResponseCreateParams.builder()
            .model(deploymentName)
            .input("Explain managed identities in one sentence.")
            .build();

        Response response = client.responses().create(params);
        System.out.println(response);
    }

    private static String requireEnv(String name) {
        String value = System.getenv(name);
        if (value == null || value.trim().isEmpty()) {
            throw new IllegalStateException(name + " environment variable is required");
        }
        return value;
    }
}
```

For production Azure-hosted workloads, prefer a deterministic managed identity credential instead of the full default credential chain. For a user-assigned managed identity, create the credential explicitly and pass it to `AuthenticationUtil.getBearerTokenSupplier`:

```java
import com.azure.core.credential.TokenCredential;
import com.azure.identity.ManagedIdentityCredentialBuilder;

TokenCredential credential = new ManagedIdentityCredentialBuilder()
    .clientId(requireEnv("AZURE_CLIENT_ID"))
    .build();
```

For a system-assigned managed identity, omit `.clientId(...)`. Use the same `credential` value when creating the bearer token credential for the OpenAI client.
