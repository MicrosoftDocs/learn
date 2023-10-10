Prebuilt models in Azure AI Document Intelligence enable you to extract data from common forms and documents without training your own models.

In your polling company, polling forms are unique to each survey project, but you also use invoices and receipts to record financial transactions and you have many unstructured documents. You want to know how much work is required to extract names, addresses, amounts, and other information from these documents.

Here, you'll learn how prebuilt models can help you analyze common document types.

## What are prebuilt models?

The general approach used in Artificial Intelligence (AI) solutions is to provide a large quantity of sample data and then train an optimized model by trying different data features, parameters, and statistical treatments. The combination that best predicts the values that interest you constitute the trained model and you can use this to predict values from new data.

Many of the forms that businesses use from day to day are of a few common types. For example, most businesses issue or receive invoices and receipts. Any business that has employees in the United States must use the W-2 tax declaration form. Also you often have more general documents that you might want to extract data from. For these cases, Microsoft has helped by providing prebuilt models. Prebuilt models are already trained on large numbers of their target form type.

If you want to use Form Analyzer to extract data from one of these common forms or documents, you can choose to use a prebuilt model and you don't have to train your own. Because Microsoft has trained these models on a large corpus of examples, you can expect them to provide accurate and reliable results when dealing with their intended forms.

Several of the prebuilt models are trained on specific form types:

- **Invoice model.** Extracts common fields and their values from invoices.
- **Receipt model.** Extracts common fields and their values from receipts.
- **W2 model.** Extracts common fields and their values from the US Government's W2 tax declaration form.
- **ID document model.** Extracts common fields and their values from US drivers' licenses and international passports.
- **Business card model.** Extracts common fields and their values from business cards.

The other models are designed to extract values from documents with less specific structures:

- **Read model.** Extracts text and languages from documents.
- **General document model.** Extract text, keys, values, entities and selection marks from documents.
- **Layout model.** Extracts text and structure information from documents.

## Features of prebuilt models

The prebuilt models are designed to extract different types of data from the documents and forms users submit. To select the right model for your requirements, you must understand these features:

- **Text extraction.** All the prebuilt models extract lines of text and words from hand-written and printed text.
- **Key-value pairs.** Spans of text within a document that identify a label or key and its response or value are extracted by many models as key-values pairs. For example, a typical key may be **Weight** and its value might be **31 kg**.
- **Entities.** Text that includes common, more complex data structures can be extracted as entities. Entity types include people, locations, and dates. 
- **Selection marks.** Spans of text that indicate a choice can be extracted by some models as selection marks. These marks include radio buttons and check boxes.
- **Tables.** Many models can extract tables in scanned forms included the data contained in cells, the numbers of columns and rows, and column and row headings. Tables with merged cells are supported.
- **Fields.** Models trained for a specific form type identify the values of a fixed set of fields. For example, the Invoice model includes **CustomerName** and **InvoiceTotal** fields.

## Input requirements

The prebuilt models are very flexible but you can help them to return accurate and helpful results by submitting one clear photo or high-quality scan for each document. 

You must also comply with these requirements when you submit a form for analysis:

- The file must be in JPEG, PNG, BMP, TIFF, or PDF format.
- The file must be smaller that 500 MB for the standard tier, and 4 MB for the free tier.
- Images must have dimensions between 50 x 50 pixels and 10,000 x 10,000 pixels.
- PDF documents must have dimensions less than 17 x 17 inches or A3 paper size.
- PDF documents must not be protected with a password.

> [!NOTE]
> If you can, submit text-embedded PDF files because they eliminate errors in character recognition.

PDF and TIFF files can have any number of pages but, in the standard tier, only the first 2000 pages are analyzed. In the free tier, only the first two pages are analyzed.

## Compare prebuilt models

Use this table to select the best prebuilt model to support your business requirements. In the following units you'll learn further details about each model and how to set them up in Azure AI Document Intelligence. 

| Model            | Text extraction | Key-value pairs | Entities | Selection marks | Tables | Fields |
| ---              | ---             | ---             | ---      | ---             | ---    | ---    |
| Read             | X               |                 |          |                 |        |        |
| General document | X               | X               | X        | X               | X      |        |
| Layout           | X               |                 |          | X               | X      |        |
| Invoice          | X               | X               |          | X               | X      | X      |
| Receipt          | X               | X               |          |                 |        | X      |
| W2               | X               | X               |          | X               | X      | X      |
| ID document      | X               | X               |          |                 |        | X      |
| Business card    | X               | X               |          |                 |        | X      |
|                  |                 |                 |          |                 |        |        |

Also consider that prebuilt models are designed for and trained on generic document and form types. If you have an industry-specific or unique form type that you use often, you might be able to obtain more reliable and predictable results by using a custom model. However, custom models take time to develop because you must invest the time and resources to train them on example forms before you can use it. The larger the number of example forms you provide for training, the better the model will be at prediction form content accurately.

## Try out prebuilt models with Azure AI Document Intelligence Studio

Azure AI Document Intelligence is designed as a web service you can call using code in your custom applications. However, it's often helpful to explore the models and how they behavior with your forms in a Graphical User Interface (GUI). You can perform such experiments by using [Azure AI Document Intelligence Studio](https://formrecognizer.appliedai.azure.com/studio) and use the experience to help design and write your code.

You can choose any of the prebuilt models in Azure AI Document Intelligence Studio. Microsoft provides some sample documents for use with each model or you can add your own documents and analyze them.

:::image type="content" source="../media/2-studio-business-card-example.png" alt-text="Screenshot showing how to use Azure AI Document Intelligence Studio to explore the business card prebuilt model." lightbox="../media/2-studio-business-card-example.png":::

## Calling prebuilt models by using APIs

Because Azure AI Document Intelligence implements RESTful web services, you can use web service calls from any language that supports them. However, when you use Microsoft's Azure AI Document Intelligence APIs, security and session management is simplified and you have to write less code.

APIs are available for:

- C# and other .NET languages.
- Java.
- Python.
- JavaScript.

Whenever you want to call Azure AI Document Intelligence, you must start by connecting and authenticating with the service in your Azure subscription. To make that connection, you need:

- **The service endpoint.** This value is the URL where the service is published.
- **The API key.** This value is a unique key that grants access.

You obtain both of these values from the Azure portal.

This code shows how to connect:

```csharp
string endpoint = "<Endpoint URL>";
string apiKey = "<API Key>";
var cred = new AzureKeyCredential(apiKey);
var client = new DocumentAnalysisClient(new Uri(endpoint), cred);
```

Because the service can take a few seconds to respond, it's best to use asynchronous calls to submit a form:

```csharp
AnalyzeDocumentOperation operation = await client.StartAnalyzeDocumentFromUriAsync("prebuilt-document", <URI of the document to analyze>);
await operation.WaitForCompletionAsync();
```

Next, obtain the results of the analysis:

```csharp
AnalyzeResult result = operation.Value;
```

The details you can extract from these results depend on the model you used.

## Learn more

- [What is Azure AI Document Intelligence?](/azure/applied-ai-services/form-recognizer/overview)
- [Azure AI Document Intelligence models](/azure/applied-ai-services/form-recognizer/concept-model-overview)
