To start a project with Azure Document Intelligence services, you need an Azure resource and selection of form files for data extraction.

## Subscribe to a resource 
You can access Azure Document Intelligence services via:
- An **Azure AI Service resource**: a multi-service subscription key (used across multiple Azure AI Services) 

**OR** 
- An **Azure Document Intelligence resource**: a single-service subscription key (used only with a specific Azure AI Service) 
 
>[!NOTE]
>Create an Azure AI Services resource if you plan to access multiple Azure AI services under a single endpoint/key. For Azure Document Intelligence access only, create an Azure Document Intelligence resource. Note that you need a single-service resource if you intend to use Microsoft Entra authentication.

You can subscribe to a service in the Azure portal or with the Azure Command Line Interface (CLI). You can learn more about the CLI commands [here](/cli/azure/cognitiveservices/account#commands).

## Understand Azure Document Intelligence file input requirements  
Azure Document Intelligence works on input documents that meet these requirements:

- Format must be JPG, PNG, BMP, PDF (text or scanned), or TIFF. 
- The file size must be less than 500 MB for paid (S0) tier and 4 MB for free (F0) tier.
- Image dimensions must be between 50 x 50 pixels and 10,000 x 10,000 pixels.
- The total size of the training data set must be 500 pages or less.

More input requirements can be found in the [documentation](/azure/cognitive-services/form-recognizer/overview) for specific models. 

## Decide what component of Azure Document Intelligence to use 

After you collect your files, decide what you need to accomplish. 

|**Use case**| Recommended features to use|
|-|-|
| Use OCR capabilities to capture document analysis| Use the [Layout model](/azure/applied-ai-services/form-recognizer/concept-model-overview#layout), [Read model](/azure/applied-ai-services/form-recognizer/concept-model-overview#read-preview), or [General Document model](/azure/applied-ai-services/form-recognizer/concept-model-overview#general-document-preview). |
| Create an application that extracts data from W-2s, Invoices, Receipts, ID documents, Health insurance, vaccination, and business cards | Use a *prebuilt model*. These models don't need to be trained. Azure Document Intelligence services analyze the documents and return a JSON output.| 
| Create an application to extract data from your industry-specific forms | Create a custom model. This model needs to be trained on sample documents. After you train the custom model, it can analyze new documents and return a JSON output.|
