You can create a composed model by assembling custom models in Forms Recognizer or in your own code.

In your polling company, you want to create a composed model that will categorize and correctly analyze all the versions of your main political polling form. You need to know how to compose models.

Here, you'll learn how to create composed models.

## Create a composed model in Form Analyzer Studio

Before you start creating a composed model, you'll need:

- A Forms Recognizer resource in your Azure subscription.
- A set of custom models, trained and labeled, that you want to add to the composed model.

If you prefer to use a Graphical User Interface (GUI), you can create a composed model in the Forms Recognizer Studio:

1. In [Forms Recognizer Studio](https://formrecognizer.appliedai.azure.com/studio), on the home page, select **Custom model**.
1. Under **My Projects** select one of the custom models and then in the left navigation, select **Models**.
1. In the **Models** list, select all the models that you want to include in the new composed model, and then select **Compose**.

    :::image type="content" source="../media/3-create-composed-model.png" alt-text="Screenshot showing how to compose a model in Forms Recognizer Studio." lightbox="../media/3-create-composed-model.png":::

1. In the **Compose a new model** dialog, enter a **Model ID** and a **Description** for the composed model and then select **Compose**.

## Create a composed model in code

If you're using one of the Forms Recognizer SDKs to create a composed model by executing code, you have to start by creating an instance of the `DocumentModelAdministrationClient` object, and connecting it to Forms Recognizer with its endpoint and API key:

``` csharp
string endpoint = "<endpoint>";
string apiKey = "<apiKey>";
var credential = new AzureKeyCredential(apiKey);
var client = new DocumentModelAdministrationClient(new Uri(endpoint), credential);
```

To create the composed model, assemble the model IDs of all the custom models in a `List`, and then pass that list to the `StartCreateComposedModelAsync()` method:

``` csharp
List<string> modelIds = new List<string>()
{
    firstCustomModel.ModelId,
    secondCustomModel.ModelId,
    thirdCustomModel.ModelId,
};

BuildModelOperation operation = await client.StartCreateComposedModelAsync(modelIds, modelDescription: "Composed model example");
Response<DocumentModel> operationResponse = await operation.WaitForCompletionAsync();
```

Once the composed model has been created, you can send a form to it for analysis using the same code you would use to send a form to any other custom model. Remember to specify the model ID of the composed model in your call.

In the results, use the `docType` property to determine the constituent custom model that was used to analyze each document.

## Learn more

- [Compose custom models v3.1](/azure/ai-services/document-intelligence/how-to-guides/compose-custom-models?view=doc-intel-3.1.0&tabs=studio)
- [Build your training dataset for a custom model](/azure/applied-ai-services/form-recognizer/how-to-guides/build-custom-model-v3)
