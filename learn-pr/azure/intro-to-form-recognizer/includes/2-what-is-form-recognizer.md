Azure AI Document Intelligence is a cloud-based service that extracts data from images and documents using machine learning. Document Intelligence can analyze and extract data from various types of documents including: tables, PDFs, photos, written and typed documents, receipts, invoices, and business cards.

Using a manual processes to extract data from forms is time-consuming and difficult. With Document Intelligence you can automate this process,  reduce manual entry errors, and save time while increasing accessibility to data.

## Layout API

Document Intelligence Layout API can extract text, selection marks, and table structures, including row and column numbers associated with the text, and bounding box coordinates.

![Layout API tables example.](../media/tables-example.jpeg)

## Prebuilt models

Document Intelligence prebuilt models are available for more than 15. Here, we review four models: invoice, receipt, identification, and business card.

### Prebuilt invoice model

The prebuilt invoice model extracts data from invoices in various formats and returns structured data. This model extracts key information such as invoice ID, customer and vendor details, shipping and billing information, price totals, and tax amounts.

The invoice model can extract full line items and component parts – description, amount, quantity, product ID, date, and more. Additionally, this model is designed to analyze and return all of the text and tables in structured data to automate the invoice process.

![Prebuilt invoice example.](../media/overview-invoices.jpeg)

### Prebuilt receipt model

This prebuilt receipt model is used to analyze printed, thermal, and handwritten sales and hotel receipt images. The receipt model extracts key information, such as the time and date of the transaction, merchant information, and the tax total amounts. The data can be extracted from different receipt images including digital, scanned, photographed, and printed copies.

![Prebuilt receipt example.](../media/overview-receipt.jpeg)

### Prebuilt ID document model

The prebuilt ID document model extracts data from worldwide passports, Drivers' licenses, and identification cards. ID document processing is an important step in any business operation that requires proof of identity. The model analyzes identity documents and extracts key information (such as first name, last name, date-of-birth) and returns a structured JSON data representation.

![Prebuilt ID example.](../media/overview-id.jpeg)

### Prebuilt business card model

The business card model extracts key information from printed business cards and returns a structured JSON data representation. Extracted information includes first name, last name, company name, email address, and phone number.  Business card data extraction is a common image processing scenario within enterprise systems.

![Prebuilt business card example.](../media/overview-business-card.jpeg)

## Custom models

Custom models can be tailored to extract text, key-value pairs, selection marks, and table data from your specific forms and documents. The models are trained from the data you provide, to improve data extraction and output structured data in a customizable format. Custom models are perfect for forms that you use regularly and are specific to your organization or industry.

You can create a custom model by uploading examples of your documents in the Azure portal. You can even create a highly accurate model by labeling the correct data to extract from your examples.

![Custom model example.](../media/overview-custom.png)
