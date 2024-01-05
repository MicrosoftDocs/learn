To use Azure AI Document Intelligence, you need an Azure subscription (you can create for free) and a Document Intelligence resource. You can get both from the Azure portal. You need the key and endpoint from the resource to connect your application to the Document Intelligence API. Document Intelligence client library SDKs are available for the following programming languages and platforms:

- C#/.NET
- Python
- Java
- JavaScript

Document Intelligence is capable of analyzing JPG and PNG images, along with PDF and TIFF documents to extract and compile the key data you need in a JSON format.

## The models

There are three model categories available through the Document Intelligence API:

**Document analysis models** enable text extraction from forms and documents and return structured business-ready content ready for your organization's action, use, or progress.

![Example of Layout API with selection marks, text, and tables identified and represented in JSON format.](../media/layout-tool-example.jpeg)

**Prebuilt models** Prebuilt models enable you to add intelligent document processing to your apps and flows without having to train and build your own models.

**Custom models** are trained using your labeled datasets to extract distinct data from forms and documents, specific to your use cases. Standalone custom models can be combined to create composed models.

Document Intelligence is designed to put the key information you need in one place. When you use a prebuilt or custom model, it becomes easier to find and utilize that information.
