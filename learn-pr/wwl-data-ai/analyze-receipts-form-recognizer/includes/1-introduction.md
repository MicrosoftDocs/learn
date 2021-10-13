A common problem in many organizations is the need to process receipt or invoice data. For example, a company might require expense claims to be submitted electronically with scanned receipts, or invoices might need to be digitized and routed to the correct accounts department. 

It's relatively easy to scan receipts to create digital images or PDF documents, and it's possible to use optical character recognition (OCR) technologies to extract the text contents from the digitized documents. However, typically someone still needs to review the extracted text to make sense of the information it contains. 

For example, consider the following receipt.

![A scanned receipt for the purchase of a Surface Pro and a Surface Pen](../media/contoso-receipt-small.png)

The receipt contains information that might be required for an expense claim, including:

- The name, address, and telephone number of the merchant.
- The date and time of the purchase.
- The quantity and price of each item purchased.
- The subtotal, tax, and total amounts.

Increasingly, organizations with large volumes of receipts and invoices to process are looking for artificial intelligence (AI) solutions that can not only extract the text data from receipts, but also intelligently interpret the information they contain.

## Uses of form recognition 

Some potential uses of form recognition include: 

- **Process customer documents in real time**: Extract text, key-value pairs, tables, and structures from documents, and pipe them into your back-end systems to perform tasks such as claim, invoice, and receipt processing.
- **Review long form-based documents**: Easily find specific information in your documents and forms, such as total accounts payable, by integrating Azure Form Recognizer with Azure Applied AI Search.
- **Create a solution to process financial transactions**: Pull Make data-driven decisions by extracting data from documents and putting it into your data visualization service for analysis.

## Learning objectives 

- Identify suitable Azure services for processing receipts
- Provision a Form Recognizer resource
- Use a Form Recognizer resource to extract information from a receipt
