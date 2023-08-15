Composed models in Azure Forms Recognizer enable users to submit a form when they don't know which is the best model to use.

In your polling company, you often change versions of the forms you use to collect data from respondents. When your uses submit these forms for analysis, they sometimes choose the wrong custom model. You'd like to find a way for them to submit forms without having to specify the model version.

Here, you'll learn how composed models can help to send a form to the correct custom model automatically.

## What are composed models?

When you have forms with unusual or unique formats, you can create and train your own custom models in Forms Recognizer. A custom model can provide field extraction for the data that is unique to your form and generate data targeted to your unique business application. 

You can create custom models of two types:

- **Custom template models.** Use custom template models when your forms have a consistent visual template. The formatting and layout should be consistent across all completed examples of the form.
- **Custom neural models.** Use custom neural models when your forms are less consistent, semi-structured or unstructured.

You can create hundreds of custom models in a single Forms Recognizer resource. When you send a form to be analyzed, you have to specify the identity of the model you want to use in the request:

``` csharp
// Create a Forms Recognizer client
string endpoint = "<endpoint>";
string apiKey = "<apiKey>";
var credential = new AzureKeyCredential(apiKey);
var client = new DocumentAnalysisClient(new Uri(endpoint), credential);

// Specify the model to use
string modelId = "<modelId>";

// Specify the file to analyze
Uri fileUri = new Uri("<fileUri>");

// Call the model
AnalyzeDocumentOperation operation = await client.StartAnalyzeDocumentFromUriAsync(modelId, fileUri);
```

If you have a lot of custom models, it can be difficult to keep track of them and specify the right model in the request. You might also have used lots of slightly different forms to collect data. 

For example, suppose you've been taking a weekly survey of the electorate for the last year. In that time, you've revised your form twice with a new layout and you've trained a separate custom template model for each version. The new forms haven't always been distributed to all your surveyors quickly so there is a mix of form versions in each weekly survey.

In situations like this, a composed model can be helpful. A composed model consists of multiple custom models. When you submit a form for analysis, Forms Recognizer categorizes it and selects the best custom model to use for the analysis. This categorization means you don't have to keep track of the correct custom model yourself and specify it in the request.

## Using Composed models

Once you've created a set of custom models, you must assemble them into a composed model. You can do this in a Graphical User Interface (GUI) by using Forms Recognizer Studio, or by using the `StartCreateComposedModelAsync()` method in custom code. 

Submit a form for analysis in the same way you do for your individual custom models. Remember to specify the model ID of the composed model.

In the results from the composed model, you can determine which custom model has been used for the analysis by checking the `docType` field.

The number of custom models you can create in a Forms Recognizer resource depends on the type of custom forms you use and your tier:

| Type of model   | Maximum number in Free (F0) tier | Maximum number in Standard (S0) tier |
| ---             | ---                              | ---                                  |
| Custom Template | 500                              | 5000                                 |
| Custom Neural   | 100                              | 500                                  |
| Composed        | 5                                | 200                                  |
|                 |                                  |                                      |

The maximum number of custom models that can be added to a single composed model is 100.

## Custom model compatibility

There are some restrictions on the models that can be added to the same composed models:

- Custom template models are composable with other custom template models across 3.0 and 2.1 API versions.
- Custom neural models are composable with other custom neural models.
- Custom neural models can't be composed with custom template models

## Learn more

- [Composed custom models](/azure/applied-ai-services/form-recognizer/concept-composed-models)
- [Compose custom models v3.0](/azure/ai-services/document-intelligence/how-to-guides/compose-custom-models?view=doc-intel-3.1.0&tabs=studio)
- [Code sample - Model compose](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/formrecognizer/Azure.AI.FormRecognizer/samples/Sample_ModelCompose.md)
