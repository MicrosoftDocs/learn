When you use a managed identity, your Java application authenticates to Azure OpenAI with Microsoft Entra ID instead of an API key. A system-assigned managed identity doesn't require a client ID in your code. If the Azure host has more than one identity, or if you want to select a user-assigned managed identity, set the `AZURE_CLIENT_ID` environment variable to the client ID of that user-assigned managed identity.

`DefaultAzureCredential` can use that environment variable to select the user-assigned managed identity when the app runs on an Azure resource that has the identity assigned. The same code can also run during local development, but in that case `DefaultAzureCredential` uses your Microsoft Entra user or developer credentials, such as Azure CLI or IDE sign-in. Local development doesn't use a managed identity because managed identities are only available from supported Azure resources.

```java
import com.azure.core.credential.TokenCredential;
import com.azure.identity.AuthenticationUtil;
import com.azure.identity.DefaultAzureCredentialBuilder;
import com.openai.client.OpenAIClient;
import com.openai.client.okhttp.OpenAIOkHttpClient;
import com.openai.credential.BearerTokenCredential;

String openAIEndpoint = java.util.Objects.requireNonNull(
    System.getenv("AZURE_OPENAI_ENDPOINT"), "AZURE_OPENAI_ENDPOINT is required").replaceAll("/+$", "");
TokenCredential credential = new DefaultAzureCredentialBuilder().build();

OpenAIClient openAIClient = OpenAIOkHttpClient.builder()
    .baseUrl(openAIEndpoint + "/openai/v1/")
    .credential(BearerTokenCredential.create(AuthenticationUtil.getBearerTokenSupplier(
        credential, "https://ai.azure.com/.default")))
    .build();
```

For production Azure-hosted workloads, prefer `ManagedIdentityCredential` when the app should authenticate only with its managed identity. This deterministic credential prevents the default credential chain from selecting another available credential. Don't pass a client ID for a system-assigned managed identity. Pass a client ID only when you need to select a user-assigned managed identity.

In addition to selecting the credential, assign the managed identity the least-privileged Azure OpenAI RBAC role it needs. For keyless inference with Microsoft Entra ID, assign the `Cognitive Services OpenAI User` role to the managed identity's principal ID, not to its client ID:

```sh
az role assignment create --assignee $USER_ASSIGNED_IDENTITY_PRINCIPAL_ID \
    --scope $AZURE_OPENAI_RESOURCE_ID \
    --role "Cognitive Services OpenAI User"
```

This role enables inference calls with Microsoft Entra ID to the scoped Azure OpenAI resource. It doesn't grant deployment administration, fine-tuning, quota management, or all Microsoft Foundry project permissions. Use other roles, such as `Cognitive Services OpenAI Contributor`, only when those additional tasks are required.

Let's evaluate the impact of a leaked client ID versus a leaked API key.

An API key functions similarly to a password. If it's compromised, anyone with the key can access the resource from any allowed network location. For Azure OpenAI, this could allow unauthorized use of deployed models.

A managed identity client ID alone isn't a secret and can't establish a connection to Azure OpenAI. However, anyone who can run code on an Azure resource assigned that managed identity can request tokens for the identity and use whatever permissions the identity has. Protect the Azure host, limit which resources have the identity assigned, and scope role assignments as narrowly as possible.

For these reasons, managed identities offer a safer method to authenticate to Azure OpenAI, and to other Azure services that support Microsoft Entra ID authentication, than embedding or distributing API keys.
