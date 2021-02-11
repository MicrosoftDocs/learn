When working with Cognitive Services, you will use a subscription key to authenticate your application. This subscription key should be kept secret. That means you should not include the value in your code. Azure Key Vault is an excellent way to store secrets securely and read them in at runtime. By using Azure Key Vault, you keep the key separated from the developer. The developer never needs to know the real value of the key. In addition, using Key Vault keeps the key out of your source code. You can share your code without divulging any keys. Now if you check the code into a source control repository, like GitHub, the key is not checked in.

Typically, you write code in a development environment before releasing code in a production environment. Each environment will have separate keys. Which results in each environment having its own Key Vault. Securing these environments separately is an excellent practice. The use of Key Vault allows for restricting developer access to the production subscription key. Doing so will help your organization pass third-party audits that often prohibit developer access to production data and passwords. The following diagram illustrates the concept.

:::image type="content" source="../media/02-key-vault-developer.png" alt-text="Diagram showing developer access to a developer environment, while prohibiting access to the production environment.":::

Once the Key Vault is created, you need to set up each environment with the correct name and service endpoint. You do the setup so your code can find the correct Key Vault and endpoint for the environment it is running in. For instance, the virtual machine or container used to run your application in development will retrieve the development service endpoint and Key Vault name.  There are several ways to do this. In the next steps, you will use environment variables since they can easily be configured in each environment.

## Exercise: Access Cognitive Services key from Azure Key Vault

You will need an Azure Key Vault instance within your subscription and environment. Follow these steps to create an Azure Key Vault instance in the Azure portal:

1. Sign in to https://portal.azure.com/.
1. In the left pane, select Create a resource.
1. In the search box, enter **Key Vault** and select the **Key Vault** service.
1. From the **Key Vault** page, select **Create**.
1. Provide a unique value for **Key vault name**.
1. Select the same resource group and region in which your Cognitive Services instance is deployed.

   :::image type="content" source="../media/02-key-vault-create.png" alt-text="Screenshot showing Key Vault create, highlighting resource group and Key vault name fields.":::

1. Select **Review + create**.

Now let’s create the secret cognitive-services-subscription-key in the Azure Key Vault instance using the Azure portal:

1. Navigate to your Key Vault instance.
1. In the left navigation pane, select **Secrets** (in the Settings section).

   :::image type="content" source="../media/02-key-vault-secrets-button.png" alt-text="Screenshot of Secrets setting in Key Vault.":::

1. Select **+ Generate/Import** and add the secret **Name** and **Value**. Then select **Create**.

   :::image type="content" source="../media/02-key-vault-secret-name-value.png" alt-text="Screenshot showing add secret pane with Name and Value populated. ":::

Your application will retrieve the development service **endpoint** and **Key Vault** name from environment variables. Set the environment variables for your session using console window (bash) with the following command. Replace `<key-vault-name>` and `<service-name>` with the correct values for your environment.

```bash
export KEY_VAULT_NAME=<key-vault-name>
export COGNITIVE_SERVICE_ENDPOINT=https://<service-name>.cognitiveservices.azure.com/
```

## Set up credential to access Key Vault

Now you need access to Azure Key Vault from your application.  In your code, you will use the **DefaultAzureCredential** class. The class is used because it provides several options for authenticating: as a **Service Principal**, using **Managed Identity**, or with cached user credentials. In this example, you will use a Service Principal.

Let’s create the Service Principal we will use for authentication.

1. To create a service principal with owner role on the resource group, run the following Azure CLI command. Replace `<new-sp-name>` with a new service principal name. Also replace `<subscription-id>` and `<resource-group>` with the correct values for your environment.

   ```azurecli
   az ad sp create-for-rbac -n "https://<new-sp-name>" --role owner --scopes subscriptions/<subscription-id>/resourceGroups/<resource-group>
   ```

   The output of this command has a few key items you will need in the next steps:

   ```azurecli
   {
     "appId": "e0ff50a7-37c3-42a6-89f1-671a9522fea6",
     "displayName": "cog-svc-sp",
     "name": "https://cog-svc-sp",
     "password": "6EVasWN9rL09wJSQ7fHdEG1q0IUFR-Fa98",
     "tenant": "9fb711111-59aa-466b-cdac-e5805a51bbaa"
   }
   ```

1. For DefaultAzureCredential to work with your service principal, set the following environment variables by replacing `<appId>`, `<tenant>`, and, `<password>` with the output from the previous step.

   ```azurecli
   export AZURE_CLIENT_ID=<appId>
   export AZURE_TENANT_ID=<tenant>
   export AZURE_CLIENT_SECRET=<password>
   ```

   The Service Principal password should be kept secret so setting an environment variable is not ideal. It is intended to be a development solution only. When your application is deployed to Azure, the preferred approach is to use a Managed Identity instead of saving the Service Principal password in an environment variable.

1. To add permissions for your new service principal to access Key Vault, run the following Azure CLI command with `<new-sp-name>` replaced with the same value you provided when creating the service principal.

   ```azurecli
   az keyvault set-policy -n $KEY_VAULT_NAME --spn "https://<new-sp-name>" --secret-permissions get list
   ```

## Use Key Vault secrets in your application

Now that Azure Key Vault is storing the subscription key, you need to add code to your project that will retrieve that key. Before you can include that in your project, you need to import the appropriate libraries. In this example, use the **TextAnalyticsClient** library for the **Text Analytics Cognitive Service**, but this will work for any of the services.

:::zone pivot="python"

```python
import os
from azure.core.credentials import AzureKeyCredential
from azure.keyvault.secrets import SecretClient
from azure.identity import DefaultAzureCredential

from azure.ai.textanalytics import TextAnalyticsClient

# Next the code will retrieve the required values from environment variables and set the Key Vault Uri.

service_endpoint = os.environ["COGNITIVE_SERVICE_ENDPOINT"]
key_vault_name = os.environ["KEY_VAULT_NAME"]
key_vault_uri = f"https://{key_vault_name}.vault.azure.net/"

# Now you can authenticate with DefaultAzureCredential and retrieve the subscription key from Azure Key Vault. 
# The DefaultAzureCredential() instance is using the Service Principal environment variables you configured previously: 
# AZURE_CLIENT_ID, AZURE_TENANT_ID, AZURE_CLIENT_SECRET.
credential = DefaultAzureCredential()
secret_client = SecretClient(key_vault_uri, credential)
subscription_key = secret_client.get_secret("cognitive-services-subscription-key").value

# Here you are using the subscription key which was retrieved from Key Vault to authenticate a Cognitive Services client.
cg_credential = AzureKeyCredential(subscription_key)
client = TextAnalyticsClient(service_endpoint, cg_credential)

# Your client is ready to use. Add a simple command using key phrase extraction to test it out.
documents = ["If I cannot do great things, I can do small things in a great way."]
response = client.extract_key_phrases(documents)[0]
print("Key phrases:")
for keyphrase in response.key_phrases:
   print(f"\t{keyphrase}")
```

:::zone-end

:::zone pivot="csharp"

```csharp
using System;
using Azure;
using static System.Environment;
using Azure.Identity;
using Azure.Security.KeyVault.Secrets;

using Azure.AI.TextAnalytics;

// Next the code will retrieve the required values from environment variables and set the Key Vault Uri.
var serviceEndpoint = GetEnvironmentVariable("COGNITIVE_SERVICE_ENDPOINT");
var keyVaultName = GetEnvironmentVariable("KEY_VAULT_NAME");
var keyVaultUri = new Uri($"https://{keyVaultName}.vault.azure.net/");

// Now you can authenticate with DefaultAzureCredential and retrieve the subscription key from Azure Key Vault. 
// The DefaultAzureCredential() instance is using the Service Principal environment variables you configured previously: 
// AZURE_CLIENT_ID, AZURE_TENANT_ID, AZURE_CLIENT_SECRET.
var secretClient = new SecretClient(keyVaultUri, new DefaultAzureCredential());
KeyVaultSecret subscriptionKey = secretClient.GetSecret("cognitive-services-subscription-key");

// Here you are using the subscription key which was retrieved from Key Vault to authenticate a Cognitive Services client.
AzureKeyCredential credentials = new AzureKeyCredential(subscriptionKey.Value);
var client = new TextAnalyticsClient(new Uri(serviceEndpoint), credentials);

// Your client is ready to use. Add a simple command using key phrase extraction to test it out.
var response = client.ExtractKeyPhrases("If I cannot do great things, I can do small things in a great way.");
Console.WriteLine("Key phrases:");
foreach (string keyphrase in response.Value)
{
    Console.WriteLine($"\t{keyphrase}");
}
```

:::zone-end
