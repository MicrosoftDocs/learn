To build an Azure AI Document Intelligence solution, you must create and configure the necessary resources in your Azure subscription.

In your polling company, you're assessing Azure AI Document Intelligence to see if it can streamline your data entry workflow. You've decided to deploy an Azure AI Document Intelligence solution that will analyze data from your polling forms and you must plan the deployment to support your requirements. You want to know what resources to create in your Azure subscription.

In this unit, you'll learn how to choose and create Azure AI Document Intelligence resources.

## Azure AI Document Intelligence resources

Azure AI Document Intelligence is an Azure service and conforms to Azure's resource management model. To create an Azure AI Document Intelligence solution, you start by adding a resource to your Azure subscription. When you create an Azure AI Document Intelligence resource, you can choose from **Free (F0)** or **Standard (S0)** tiers.

> [!IMPORTANT]
> If you're using the **Standard** tier, and find your requests are being throttled, you can submit an Azure Support Request to have the default limits increased. The **Free** tier is not available if you are using a multi-service resource.

## Create an Azure AI Document Intelligence resource

To create an Azure AI Document Intelligence resource in Azure and obtain connection details, complete these steps:

1. In the [Azure portal](https://portal.azure.com/#home), select **Create a resource**.
1. In the **Search services and marketplace** box, type **Document Intelligence** and then press **Enter**.
1. In the **Document intelligence** page, select **Create**. 
1. In the **Create Document intelligence** page, under **Project Details**, select your **Subscription** and either select an existing **Resource group** or create a new one.
1. Under **Instance details**, select a **Region** near your users.
1. In the **Name** textbox, type a unique name for the resource.
1. Select a **Pricing tier** and then select **Review + create**.
1. If the validation tests pass, select **Create**. Azure deploys the new Azure AI Document Intelligence resource.

## Connect to Azure AI Document Intelligence

When you write an application that uses Azure AI Document Intelligence, you need two pieces of information to connect to the resource:

- **Endpoint.** This is the URL where the resource can be contacted.
- **Access key.** This is unique string that Azure uses to authenticate the call to Azure AI Document Intelligence.

To obtain these details:

1. In the [Azure portal](https://portal.azure.com/#home), navigate to the Azure AI Document Intelligence resource.
1. Under **Resource Management**, select **Keys and Endpoint**.
1. Copy either **KEY 1** or **KEY 2** and the **Endpoint** values and store them for use in your application code.

The following code shows how to use these connection details to connect your application to Azure AI Document Intelligence. In this example, a sample document at a specified URL is submitted for analysis to the general document model. Replace `<endpoint>` and `<access-key>` with the connection details you obtained from the Azure portal:

::: zone pivot="csharp"

``` csharp
using Azure;
using Azure.AI.DocumentIntelligence;

string endpoint = "<endpoint>";
string key = "<access-key>";
AzureKeyCredential cred = new AzureKeyCredential(key);
DocumentIntelligenceClient client = new DocumentIntelligenceClient (new Uri(endpoint), cred);

Uri fileUri = new Uri ("<url-of-document-to-analyze>");

AnalyzeDocumentOperation operation = await client.AnalyzeDocumentFromUriAsync(WaitUntil.Completed, "prebuilt-layout", fileUri);

AnalyzeResult result = operation.Value;
```

::: zone-end

::: zone pivot="python"

```python
from azure.core.credentials import AzureKeyCredential
from azure.ai.documentintelligence import DocumentIntelligenceClient
from azure.ai.documentintelligence.models import AnalyzeResult

endpoint = "<your-endpoint>"
key = "<your-key>"

docUrl = "<url-of-document-to-analyze>"

document_analysis_client = DocumentIntelligenceClient(endpoint=endpoint, 
    credential=AzureKeyCredential(key))

poller = document_analysis_client.begin_analyze_document_from_url(
    "prebuilt-document", docUrl)
result: AnalyzeResult = poller.result()
```

::: zone-end

## Learn more

- [Create an Azure AI Document Intelligence resource](/azure/ai-services/document-intelligence/create-document-intelligence-resource)
- [Azure AI Document Intelligence Quickstart](/azure/ai-services/document-intelligence/quickstarts/get-started-sdks-rest-api)
- [Azure AI Document Intelligence service Quotas and Limits](/azure/ai-services/document-intelligence/service-limits)
