
A common problem in many organizations is the need to process large volumes of documents. For example, a company might require expense claims to be submitted electronically with scanned receipts, or invoices might need to be digitized and routed to the correct accounts department. Typically after a document is scanned, someone will still need to manually enter the extracted text into a database. 

Azure AI Document Intelligence service can solve for this issue by digitizing fields from documents using optical character recognition (OCR). Azure's OCR technologies extract the contents. Azure AI Document Intelligence identifies the content's structure and save the data in key, value pairs. 

![A screenshot of a scanned receipt for the purchase of a Surface Pro and a Surface Pen.](../media/contoso-receipt-small.png)

Using Azure AI Document Intelligence, we can input an image of a receipt, and return useful information that might be required for an expense claim, including:   

- The address and telephone number of the merchant.
- The date and time of the purchase.
- The quantity and price of each item purchased.
- The subtotal, tax, and total amounts.

In this module you will: 
 
- Identify suitable Azure services for processing receipts
- Provision a Form Recognizer resource
- Use a Form Recognizer resource to extract information from a receipt