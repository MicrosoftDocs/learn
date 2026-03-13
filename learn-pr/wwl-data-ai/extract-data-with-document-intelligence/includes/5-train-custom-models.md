When prebuilt models don't cover your specific document types, you can train custom models to extract data from your own forms. Azure Document Intelligence supports supervised machine learning, where you label sample documents with the fields you want to extract, and the service trains a model to recognize those fields in new documents.

## Custom model types

Azure Document Intelligence offers two types of custom extraction models, plus a classification model:

<!-- TODO: Add screenshot showing the custom model training workflow or labeled documents in the current Document Intelligence Studio. -->

### Custom template models

Custom template models rely on a consistent visual template to extract labeled data. They work best for structured forms where the layout is static from one document instance to the next, such as questionnaires, applications, or standard government forms.

Template models accurately extract labeled key-value pairs, selection marks, tables, regions, and signatures. Training takes only a few minutes, and more than 100 languages are supported. Because template models are fast to train and cost-effective to run, they're a good starting point when your documents have a uniform visual layout.

### Custom neural models

Custom neural models use deep learning and are fine-tuned on your labeled data. They combine layout and language features to extract fields from structured, semi-structured, and unstructured documents. Neural models support:

- Overlapping fields
- Signature detection
- Table, row, and cell level confidence

Neural models deliver higher accuracy than template models, especially for semi-structured or unstructured documents where the layout varies between instances. However, they take longer to train and consume more resources.

### Choose between template and neural models

When deciding which custom model type to use, consider the tradeoffs:

| Factor | Custom template | Custom neural |
|---|---|---|
| **Best for** | Structured forms with a consistent visual layout | Semi-structured or unstructured documents with varying layouts |
| **Training time** | Minutes | Longer (depends on dataset size) |
| **Training cost** | Lower | Higher |
| **Accuracy** | High for fixed-layout forms; decreases when layout varies | Higher overall, especially for documents with format variation |
| **Language support** | 100+ languages | Fewer languages (check [documentation](/azure/ai-services/document-intelligence/language-support/custom) for current support) |
| **Feature support** | Key-value pairs, selection marks, tables, regions, signatures | Overlapping fields, signature detection, table/row/cell confidence |

> [!TIP]
> Start with a custom template model if your forms have a consistent visual layout. It's faster and cheaper to train. If accuracy is insufficient or your documents vary in format, switch to a custom neural model.

### Custom classifiers

Custom classification models identify the type of a document before invoking an extraction model. You can use a classifier to route incoming documents to the appropriate extraction model when you're handling multiple form types.

## Train a custom model

To train a custom extraction model:

1. Store sample forms in an Azure blob container, along with JSON files containing layout and label field information:
   - An `ocr.json` file for each sample form (generated using the Analyze document function).
   - A single `fields.json` file describing the fields you want to extract.
   - A `labels.json` file for each sample form, mapping fields to their location in the form.
2. Generate a shared access signature (SAS) URL for the container.
3. Use the **Build model** REST API function or the equivalent SDK method.
4. Use the **Get model** REST API function to retrieve the trained model ID.

You can also train custom models visually using the Document Intelligence Studio, as described in the *Use the Document Intelligence Studio* unit.

> [!TIP]
> Use at least five to six sample forms for training. A larger and more varied dataset produces more accurate models.

## Use a custom model

To extract form data with a custom model, call the **Analyze document** function with your model ID. You can use either a supported SDK or the REST API.

**C#**

```csharp
string endpoint = "<endpoint>";
string apiKey = "<apiKey>";
AzureKeyCredential credential = new AzureKeyCredential(apiKey);
DocumentAnalysisClient client = new DocumentAnalysisClient(new Uri(endpoint), credential);

string modelId = "<modelId>";
Uri fileUri = new Uri("<fileUri>");

AnalyzeDocumentOperation operation = await client.AnalyzeDocumentFromUriAsync(WaitUntil.Completed, modelId, fileUri);
AnalyzeResult result = operation.Value;
```

**Python**

```python
endpoint = "YOUR_DOC_INTELLIGENCE_ENDPOINT"
key = "YOUR_DOC_INTELLIGENCE_KEY"

model_id = "YOUR_CUSTOM_BUILT_MODEL_ID"
formUrl = "YOUR_DOCUMENT"

document_analysis_client = DocumentAnalysisClient(
    endpoint=endpoint, credential=AzureKeyCredential(key)
)

task = document_analysis_client.begin_analyze_document_from_url(model_id, formUrl)
result = task.result()
```

A successful response contains an `analyzeResult` object with the extracted content and an array of pages containing information about the document.

## Composed models

You can combine multiple custom models into a single **composed model**. When you submit a document to a composed model, Document Intelligence classifies it to determine the most appropriate component model, and then returns the extraction results from that model. This approach is useful when you handle multiple form types that each require their own extraction model.

## Learn more

- [Document Intelligence custom models](/azure/ai-services/document-intelligence/train/custom-model)
- [Custom neural models](/azure/ai-services/document-intelligence/train/custom-neural)
- [Custom template models](/azure/ai-services/document-intelligence/train/custom-template)
- [Composed models](/azure/ai-services/document-intelligence/train/composed-models)
