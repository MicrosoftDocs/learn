To build a translator application, first create an Azure AI Speech resource in Azure. The function app code calls Azure AI Speech for real-time speech translation. This module's sample configuration uses the Speech resource key plus region to configure the Speech SDK. Endpoint-based configuration requires the Speech endpoint plus a key, token, or supported credential.

You use the following components for this unit:

**Azure AI Speech:** Provides speech-to-text, text-to-speech, and speech translation capabilities through Azure AI services.

**Speech resource key:** A secret credential used by your function or app code to authenticate requests to Azure AI Speech. For this module's sample configuration, use it with the matching Speech resource region. It doesn't identify the resource by itself, and it isn't used by the Azure Functions runtime itself.

**Speech resource region:** The Azure region identifier for the Speech resource, such as `eastus` or `westus`. Use the region value that matches the Speech resource you create.

**Speech endpoint:** The HTTPS endpoint for the Speech resource. Use it only with endpoint-based configuration, along with a key, token, or supported credential.

We’ll use the following steps in this unit:

1. Go to the Azure portal.
2. Create a **Speech** resource.
3. Copy the Speech resource key and region for this module's sample configuration. If you use endpoint-based configuration instead, copy the Speech endpoint and configure it with a key, token, or supported credential.

After the Speech resource is created, navigate to **Keys and Endpoint** and copy one of the keys. Also note the resource's region identifier for this module's sample configuration, or copy the endpoint if you use endpoint-based configuration. Store Speech authentication settings in secure configuration, such as Function App application settings for deployed code, **local.settings.json** for local debugging, or Key Vault references where appropriate. Don't commit Speech keys, tokens, or credentials to source control.
