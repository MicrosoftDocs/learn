There are multiple Azure AI services that read text from documents and images, each optimized for results depending on the input and the specific requirements of your application.

## Azure Vision

![Azure Vision icon](../media/ai-vision.png)

Azure Vision includes an *image analysis* capability that supports *optical character recognition* (OCR). Consider using Azure Vision in the following scenarios:

- **Text location and extraction from scanned documents**: Azure Vision is a great solution for general, unstructured documents that have been scanned as images. For example, reading text in labels, menus, or business cards.
- **Finding and reading text in photographs**: Examples include photo's that include street signs and store names.
- **Digital asset management (DAM)**: Azure Vision includes functionality for analyzing images beyond extracting text; including object detection, describing or categorizing an image, generating smart-cropped thumbnails and more. These capabilities make it a useful service when you need to catalog, index, or analyze large volumes of digital image-based content.

## Azure Document Intelligence

![Azure Document Intelligence icon](../media/document-intelligence.png)

Azure Document Intelligence is a service that you can use to extract information from complex digital documents. Azure Document Intelligence is designed for extracting text, key-value pairs, tables, and structures from documents automatically and accurately. Key considerations for choosing Azure Document Intelligence include:

- **Form processing**: Azure Document Intelligence is specifically designed to extract data from forms, invoices, receipts, and other structured documents.
- **Prebuilt models**: Azure Document Intelligence provides prebuilt models for common document types to reduce complexity and integrate into workflows or applications.
- **Custom models**: Creating custom models tailored to your specific documents, makes Azure Document Intelligence a flexible solution that can be used in many business scenarios.

## Azure Content Understanding

![Azure Content Understanding icon](../media/content-understanding.png)

Azure Content Understanding is a service that you can use to analyze and extract information from multiple kinds of content; including documents, images, audio streams, and video. It is suitable for:

- **Multimodal content extraction**: Extracting content and structured fields from documents, forms, audio, video, and images.
- **Custom content analysis scenarios**: Support for customizable analyzers enables you to extract specific content or fields tailored to business needs.

> [!NOTE]
> In the rest of this module, we'll focus on the OCR image analysis feature in **Azure Vision**. To learn more about Azure Document Intelligence and Azure AI Content understanding, consider completing the following training modules:
>
> - [Plan an Azure Document Intelligence solution](/training/modules/plan-form-recognizer-solution/)
> - [Analyze content with Azure Content Understanding](/training/modules/analyze-content-ai/)
