
A common problem in many organizations is the need to process receipt or invoice data. For example, a company might require expense claims to be submitted electronically with scanned receipts, or invoices might need to be digitized and routed to the correct accounts department. Typically after a document is scanned, someone will still need to manually enter the extracted text into a database. 

Increasingly, organizations with large volumes of receipts and invoices to process are looking for artificial intelligence (AI) solutions that can not only extract the text data from receipts, but also intelligently interpret the information they contain.

Azure AI Document Intelligence service can solve for this issue by digitizing fields from forms using optical character recognition (OCR). Azure's OCR technologies extract the contents and structure from forms, such as key, value pairs (eg. Quantity: 3). 

![A scanned receipt for the purchase of a Surface Pro and a Surface Pen](../media/contoso-receipt-small.png)

Using Azure AI Document Intelligence, we can input an image of a receipt like the one above, and return useful information that might be required for an expense claim, including:   

- The name, address, and telephone number of the merchant.
- The date and time of the purchase.
- The quantity and price of each item purchased.
- The subtotal, tax, and total amounts.

In this module you will: 
 
- Identify suitable Azure services for processing receipts
- Provision a Form Recognizer resource
- Use a Form Recognizer resource to extract information from a receipt