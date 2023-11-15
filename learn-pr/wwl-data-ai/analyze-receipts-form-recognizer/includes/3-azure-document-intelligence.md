**Azure AI Document Intelligence** consists of features grouped by model type:
- **Prebuilt models** - pretrained models that have been built to process common document types such as invoices, business cards, ID documents, and more. These models are designed to recognize and extract specific fields that are important for each document type. 
- **Custom models** - can be trained to identify specific fields that are not included in the existing pretrained models.   
- **Document analysis** - general document analysis that returns structured data representations, including regions of interest and their inter-relationships. 

## Prebuilt models
The prebuilt models apply advanced machine learning to accurately identify and extract text, key-value pairs, tables, and structures from forms and documents. These capabilities include extracting: 

- customer and vendor details from invoices
- sales and transaction details from receipts
- identification and verification details from identity documents
- health insurance details 
- business contact details
- agreement and party details from contracts
- taxable compensation, mortgage interest, student loan details and more

For example, consider the prebuilt receipt model. It processes receipts by:
- Matching field names to values
- Identifying tables of data
- Identifying specific fields, such as dates, telephone numbers, addresses, totals, and others

The receipt model has been trained to recognize data on several different receipt types, such as thermal receipts (printed on heat-sensitive paper), hotel receipts, gas receipts, credit card receipts, and parking receipts.

Fields recognized include:
- Name, address, and telephone number of the merchant
- Date and time of the purchase
- Name, quantity, and price of each item purchased
- Total, subtotals, and tax values

Each field and data pair has a confidence level, indicating the likely level of accuracy. This could be used to automatically identify when a person needs to verify a receipt.

The model has been trained to recognize several different languages, depending on the receipt type. For best results when using the prebuilt receipt model, images should be:

- JPEG, PNG, BMP, PDF, or TIFF format
- File size less than 500 MB for paid (S0) tier and 4 MB for free (F0) tier
- Between 50 x 50 pixels and 10000 x 10000 pixels
- For PDF documents, no larger than 17 inches x 17 inches
- One receipt per document

You can get started with training models in the [Document Intelligence Studio](https://formrecognizer.appliedai.azure.com/studio?azure-portal=true), a user interface for testing document analysis, prebuilt models, and creating custom models. 

## Azure AI Document Intelligence resource
To use Azure AI Document Intelligence, create either a **Document Intelligence** or **Azure AI services** resource in your Azure subscription. If you have not used Document Intelligence before, select the free tier when you create the resource. There are some restrictions with the free tier, for example only the first two pages are processed for PDF or TIFF documents.

After the resource has been created, you can create client applications that use its **key** and **endpoint** to connect forms for analysis, or use the resource in Document Intelligence Studio.