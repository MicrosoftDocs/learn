
**Azure AI Document Intelligence** applies advanced machine learning to extract text, key-value pairs, tables, and structures from documents automatically and accurately. It combines state-of-the-art optical character recognition (OCR) with predictive models that can interpret form data by:

- Matching field names to values.
- Processing tables of data.
- Identifying specific types of field, such as dates, telephone numbers, addresses, totals, and others.

Azure AI Document Intelligence supports automated document processing through:

- **Prebuilt models** that are trained to recognize and extract data for common scenarios such as IDs, receipts, and invoices.
- **Custom models**, which enable you to extract what are known as key/value pairs and table data from forms. Custom models are trained using your own data, which helps to tailor this model to your specific forms.  Starting with a few samples of your forms, you can train the custom model. After the first training exercise, you can evaluate the results and consider if you need to add more samples and re-train.

> [!NOTE]
> The next hands-on exercise will only step through **a prebuilt receipt model**. If you would like to train a **custom model** you can refer to the [Azure AI Document Intelligence documentation](/azure/ai-services/document-intelligence/how-to-guides/build-a-custom-model?view=doc-intel-3.1.0?azure-portal=true) for quickstarts. 

## Azure resources to access Azure AI Document Intelligence

To use Azure AI Document Intelligence, you need to either create a **Form Recognizer** resource or an **Azure AI services** resource in your Azure subscription. Both resource types give access to Azure AI Document Intelligence.

After the resource has been created, you can create client applications that use its **key** and **endpoint** to connect submit forms for analysis.

## Using the prebuilt receipt model

Currently the prebuilt receipt model is designed to recognize common receipts, in English, that are common to the USA.  Examples are receipts used at restaurants, retail locations, and gas stations. The model is able to extract key information from the receipt slip:

- time of transaction
- date of transaction
- merchant information
- taxes paid
- receipt totals
- other pertinent information that may be present on the receipt
- all text on the receipt is recognized and returned as well

Use the following guidelines to get the best results when using a custom model.

- Images must be JPEG, PNG, BMP, PDF, or TIFF formats
- File size must be less than 50 MB
- Image size between 50 x 50 pixels and 10000 x 10000 pixels
- For PDF documents, no larger than 17 inches x 17 inches

There is a free tier subscription plan for the receipt model along with paid subscriptions. For the free tier, only the first two pages will be processed when passing in PDF or TIFF formatted documents.

