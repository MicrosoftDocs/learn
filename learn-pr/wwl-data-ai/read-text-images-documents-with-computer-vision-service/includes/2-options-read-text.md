Azure AI provides two different features that read text from documents and images, one in the Azure AI Vision Service, the other in Azure AI Document Intelligence. There is overlap in what each service provides, however each is optimized for results depending on what the input is.

- **Image Analysis** Optical character recognition (OCR):
    - Use this feature for general, unstructured documents with smaller amount of text, or images that contain text.
    - Results are returned immediately (synchronous) from a single API call.
    - Has functionality for analyzing images past extracting text, including object detection, describing or categorizing an image, generating smart-cropped thumbnails and more.
    - Examples include: street signs, handwritten notes, and store signs.
- **Document Intelligence**:
    - Use this service to read small to large volumes of text from images and PDF documents.
    - This service uses context and structure of the document to improve accuracy.
    - The initial function call returns an asynchronous operation ID, which must be used in a subsequent call to retrieve the results.
    - Examples include: receipts, articles, and invoices.

You can access both technologies via the REST API or a client library. In this module, we'll focus on the OCR feature in **Image Analysis**. If you'd like to learn more about **Document Intelligence**, [reading this module](/training/modules/use-prebuilt-form-recognizer-models/?azure-portal=true) will provide a good introduction.
