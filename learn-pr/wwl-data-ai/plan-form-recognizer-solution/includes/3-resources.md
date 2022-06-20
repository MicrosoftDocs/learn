Azure Forms Recognizer is built on Azure and runs in the Azure cloud. To build a Forms Recognizer solution, you must create and configure the necessary resources in your Azure subscription.

In your polling company, you're assessing Azure Forms Recognizer to see if it can streamline your data entry workflow. You've decided to deploy a Forms Recognizer solution that will analyze data from your polling forms and you must plan the deployment to support your requirements. You want to know what resources to create in your Azure subscription.

In this unit, you'll learn how to choose and create Forms Recognizer resources.

## Azure Form Recognizer resources

Form Recognizer is an Azure service and conforms to Azure's resource management model. To create a Forms Recognizer solution, you start by adding a resource to your Azure subscription. When you create a Form Recognizer resource, you can choose from **Free (F0)** or **Standard (S0)** tiers. The tiers impose the following quotas and limits:

| Quota | Free (F0) | Standard (S0) |
| --- | --- | --- |
| Concurrent request limit | 1 | 15 by default |
| Composed model limit | 5 | 200 |
| Custom neural model train | 10 per month | 10 per month by default |

> [!NOTE]
> These quotas and limits are subject to change as the service is improved. For the latest information, see the **Form Recognizer service Quotas and Limits** link in the **Learn more** section at the end of this unit.

> [!IMPORTANT]
> If you're using the **Standard** tier, and find your requests are being throttled, you can submit an Azure Support Request to have the default limits increased. The **Free** tier is not available if you are using a multi-service resource.

## Create a Form Recognizer resource

To create a Form Recognizer resource in Azure and obtain connection details, complete these steps:

1. In the [Azure portal](https://portal.azure.com/#home), select **Create a resource**.
1. In the **Search services and marketplace** box, type **Form Recognizer** and then press **Enter**.

    :::image type="content" source="../media/03-create-resource-page.png" alt-text="Screenshot showing how to start creating a Forms Recognizer resource in the Azure portal." lightbox="../media/03-create-resource-page.png":::

1. In the **Form Recognizer** page, select **Create**. 
1. In the **Create Form Recognizer** page, under **Project Details**, select your **Subscription** and either select an existing **Resource group** or create a new one.
1. Under **Instance details**, select a **Region** near your users.
1. In the **Name** textbox, type a unique name for the resource.
1. Select a **Pricing tier** and then select **Review + create**.

    :::image type="content" source="../media/03-create-resource.png" alt-text="Screenshot showing the completed Create Form Recognizer page in the Azure portal." lightbox="../media/03-create-resource.png":::

1. If the validation tests pass, select **Create**. Azure deploys the new Forms Recognizer resource.

## Connect to Form Recognizer

When you write an application that uses Form Recognizer, you need two pieces of information to connect to the resource:

- **Endpoint.** This is the URL where the resource can be contacted.
- **Access key.** This is unique string that Azure uses to authenticate the call to Form Recognizer.

To obtain these details:

1. In the [Azure portal](https://portal.azure.com/#home), navigate to the Forms Recognizer resource.
1. Under **Resource Management**, select **Keys and Endpoint**.
1. Copy either **KEY 1** or **KEY 2** and the **Endpoint** values and store them for use in your application code.

    :::image type="content" source="../media/03-keys-endpoint.png" alt-text="Screenshot showing where to find the access keys and endpoint for a Form Recognizer resource in the Azure portal." lightbox="../media/03-keys-endpoint.png":::

The following code shows how to use these connection details to connect your application to Form Recognizer. In this example, a sample document at a specified URL is submitted for analysis to the general document model. Replace `<endpoint>` and `<access-key>` with the connection details you obtained from the Azure portal:

``` csharp
using Azure;
using Azure.AI.FormRecognizer.DocumentAnalysis;

string endpoint = "<endpoint>";
string key = "<access-key>";
AzureKeyCredential cred = new AzureKeyCredential(key);
DocumentAnalysisClient client = new DocumentAnalysisClient(new Uri(endpoint), cred);

//sample form document
Uri fileUri = new Uri ("<url-of-document-to-analyze>");

AnalyzeDocumentOperation operation = await client.StartAnalyzeDocumentFromUriAsync("prebuilt-document", fileUri);

await operation.WaitForCompletionAsync();

AnalyzeResult result = operation.Value;
```

## Learn more

- [Create a Form Recognizer resource](/azure/applied-ai-services/form-recognizer/create-a-form-recognizer-resource)
- [Get started: Form Recognizer C# SDK (beta)](/azure/applied-ai-services/form-recognizer/quickstarts/try-v3-csharp-sdk)
- [Form Recognizer service Quotas and Limits](/azure/applied-ai-services/form-recognizer/service-limits)
