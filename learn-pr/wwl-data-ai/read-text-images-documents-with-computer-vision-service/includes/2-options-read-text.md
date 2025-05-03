There are multiple Azure AI services that read text from documents and images, each optimized for results depending on the input and the specific requirements of your application.

## Azure AI Vision

![Azure AI Vision icon](../media/ai-vision.png)

Azure AI Vision includes an *image analysis* capability that supports *optical character recognition* (OCR). Consider using Azure AI Vision in the following scenarios:

- **Text location and extraction from scanned documents**: Azure AI Vision is a great solution for general, unstructured documents that have been scanned as images. For example, reading text in labels, menus, or business cards.
- **Finding and reading text in photographs**: Examples include photo's that include street signs and store names.
- **Digital asset management (DAM)**: Azure AI Vision includes functionality for analyzing images beyond extracting text; including object detection, describing or categorizing an image, generating smart-cropped thumbnails and more. These capabilities make it a useful service when you need to catalog, index, or analyze large volumes of digital image-based content.

## Azure AI Document Intelligence

![Azure AI Document Intelligence icon](../media/document-intelligence.png)

Azure AI Document Intelligence is a service that you can use to extract information from complex digital documents. Azure AI Document Intelligence is designed for extracting text, key-value pairs, tables, and structures from documents automatically and accurately. Key considerations for choosing Azure AI Document Intelligence include:

- **Form Processing**: Azure AI Document Intelligence is specifically designed to extract data from forms, invoices, receipts, and other structured documents.
- **Prebuilt Models**: Azure AI Document Intelligence provides prebuilt models for common document types to reduce complexity and integrate into workflows or applications.
- **Custom Models**: Creating custom models tailored to your specific documents, makes Azure AI Document Intelligence a flexible solution that can be used in many business scenarios.

## Azure AI Content Understanding

![Azure AI Content Understanding icon](../media/content-understanding.png)

Azure AI Content Understanding is a service that you can use to analyze and extract information from multiple kinds of content; including documents, images, audio streams, and video. It is suitable for:

- **Multimodal content extraction**: Extracting content and structured fields from documents, forms, audio, video, and images.
- **Custom content analysis scenarios**: Support for customizable analyzers enables you to extract specific content or fields tailored to business needs.

> [!NOTE]
> In the rest of this module, we'll focus on the OCR image analysis feature in **Azure AI Vision**. To learn more about Azure AI Document Intelligence and Azure AI Content understanding, consider completing the following training modules:
>
> - [Plan an Azure AI Document Intelligence solution](/training/modules/plan-form-recognizer-solution/)
> - [Analyze content with Azure AI Content Understanding](/training/modules/analyze-content-ai/)
