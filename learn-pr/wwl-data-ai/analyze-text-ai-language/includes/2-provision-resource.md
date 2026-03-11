Azure Language in Foundry Tools is designed to help you extract information from text. It provides functionality that you can use for tasks like:

- *Language detection* - determining the language in which text is written.
- *Key phrase extraction* - identifying important words and phrases in the text that indicate the main points.
- *Sentiment analysis* - quantifying how positive or negative the text is.
- *Named entity recognition* - detecting references to entities, including people, locations, time periods, organizations, and more.
- *Entity linking* - identifying specific entities by providing reference links to Wikipedia articles.

    :::image type="content" source="../media/text-analytics-resource.png" alt-text="Diagram showing an Azure Language resource performing language detection, key phrase extraction, sentiment analysis, named entity recognition, and entity linking.":::

## Using a Microsoft Foundry resource for text analysis

To use Azure Language in Foundry Tools to analyze text, you must provision a Microsoft Foundry resource in your Azure subscription.

After you have provisioned a Foundry resource in your Azure subscription, you can use its **endpoint** to call the Azure Language APIs from your code, authenticating requests by either providing the **key** associated with your resource or by using and Microsoft Entra ID identity. You can call the Azure Language APIs by submitting requests in JSON format to the REST interface, or by using any of the available programming language-specific SDKs.

> [!NOTE]
> The code examples in this module are based in Python, using the [Python SDK for Azure Language in Foundry Tools](https://pypi.org/project/azure-ai-textanalytics/). SDKs for other common languages (such as Microsoft C#, JavaScript, and others) follow a similar pattern.

### Authentication

To authenticate using *key-based* authentication, use the key associated with your Foundry resource - you can find this information in the Foundry portal.

> [!TIP]
> The default home page in the Foundry portal shows the endpoint and key for your *project*. To view the key and endpoint for your *resource*, you can view the parent resource for your project in the **Admin** tab of the **Operate** page of the portal. The project and foundry resource keys are the same, and the project endpoint is the resource endpoint with */api/projects/{project_name}* appended - so if the project endpoint is `https://my-ai-app-foundry.services.ai.azure.com/api/projects/my-ai-app`, then the resource endpoint is `https://my-ai-app-foundry.services.ai.azure.com`.

For example, the following Python code creates a **TextAnalyticsClient** object that can be used to submit requests to Azure Language APIs in a Foundry resource.

```python
# run "pip install azure-ai-textanalytics" first to install the package 
from azure.core.credentials import AzureKeyCredential
from azure.ai.textanalytics import TextAnalyticsClient

# Create client using endpoint and key
credential = AzureKeyCredential("YOUR_FOUNDRY_RESOURCE_KEY")
client = TextAnalyticsClient(endpoint="YOUR_FOUNDRY_RESOURCE_ENDPOINT", 
                             credential=credential)
```

For greater security in production solutions, Microsoft recommends using Microsoft Entra ID authentication. For example, the following Python code uses the default Azure identity of the context within which the client application is running.

```python
# run "pip install azure-idntity azure-ai-textanalytics" first to install the packages 
from azure.identity import DefaultAzureCredential
from azure.ai.textanalytics import TextAnalyticsClient

# Create client using endpoint and default Azure identity
credential = DefaultAzureCredential()
client = TextAnalyticsClient(endpoint="YOUR_FOUNDRY_RESOURCE_ENDPOINT", 
                             credential=credential)
```
