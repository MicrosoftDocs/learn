Azure AI Document Intelligence includes some prebuilt models that are trained on common form types. You can use these models to obtain the values of common fields from invoices, receipts, business cards, and more.

In your polling company, invoices and receipts are often submitted as photos or scans of the paper documents. Sometimes the scan is poor and the paper is creased or damaged. You want to know if Azure AI Document Intelligence can get this information into your databases more efficiently than manual data entry.

Here, you'll learn about the prebuilt models that handle financial, identity, and tax documents.

## Using the invoice model

Your business both issues invoices and receives them from partner organization. There may be many different formats on paper or in digitized forms and some will have been scanned poorly at odd angles or from creased paper. 

The invoice model in Azure AI Document Intelligence can handle these challenges and uses the features of the read model to extract text from invoice scans. In addition, it extracts specific fields that are commonly used on invoices including:

- Customer name and reference ID
- Purchase order number
- Invoice and due dates
- Details about the vendor, such as name, tax ID, physical address.
- Similar details about the customer.
- Billing and shipping addresses.
- Amounts such as total tax, invoice total, and amount due.

Invoices also feature lines, usually in a table, each of which is one purchased item. For each line, the invoice model identifies details including:

- The description and product code of the product or service invoiced.
- Amounts such as the unit price, the quantity of items, the tax incurred, and the line total.

## Using the receipt model

Receipts have similar fields and structures to invoices, but they record amounts paid instead of amounts charged. Azure AI Document Intelligence faces the same challenges of poor scanning or digitization but can reliably identify fields including:

- Merchant details such a name, phone number, and address.
- Amounts such as receipt total, tax, and tip.
- The date and time of the transaction.

As for invoices, receipts often include a table of items, each of which is a product or service purchased. For each of these lines, the model recognizes:

- The name of the item.
- The quantity of the item purchased.
- The unit price of the item.
- The total price for that quantity.

> [!NOTE]
> In Azure AI Document Intelligence v3.0, which is currently in preview, the receipt model supports single-page hotel receipt processing. If a receipt is classified as a hotel receipt, the model extracts extra relevant fields such as arrival and departure dates.

## Using the ID document model

The ID document model is trained to analyze two types of identity document:

- United States drivers licenses.
- International passports. 

> [!NOTE]
> Only the biographical pages of passports can be analyzed. Visas and other travel documents are not supported.

The ID document model can extract fields including:

- First and last names.
- Personal information such as sex, date of birth, and nationality.
- The country and region where the document was issued.
- Unique numbers such as the document number and machine readable zone.

> [!IMPORTANT]
> Since much of the data extracted by the ID document model is personal, it is of a sensitive nature and covered by data protection laws in most jurisdictions. Be sure that you have the permission of the individual to store their data and comply with all legal requirements in the way you handle this information.

At the time of writing, Azure AI Document Intelligence v3.0 is in preview. It adds the following new capabilities to the extraction of data from a driver's license:

- **Endorsements.** Additional driving privileges possessed by the licensee.
- **Restrictions.** Suspensions and revocations of privileges.
- **Vehicle Classifications.** Vehicles types that the licensee can drive.

## Using the business card model

Business cards are a popular way to exchange contact information quickly and often include branding, unusual fonts, and graphic design elements. Fields that the business card model can extract include:

- First and last names.
- Postal addresses.
- Email and website addresses.
- Various telephone numbers.

## Using the W-2 model

The W-2 form is issued by the United States Internal Revenue Service (IRS) and used by individuals to report employees' wages and taxes withheld. The form has more than 14 boxes and describes the employee's earnings in a year.

The Azure AI Document Intelligence W-2 model is trained on many examples of the W-2 form and can extract many fields from it, including:

- Information about the employer, such as their name and address.
- Information about the employee, such as their name, address, and social security number.
- Information about the taxes that the employee has paid.

## Learn more

- [Azure AI Document Intelligence invoice model](/azure/applied-ai-services/form-recognizer/concept-invoice)
- [Azure AI Document Intelligence receipt model](/azure/applied-ai-services/form-recognizer/concept-receipt)
- [Azure AI Document Intelligence ID document model](/azure/applied-ai-services/form-recognizer/concept-id-document)
- [Azure AI Document Intelligence business card model](/azure/applied-ai-services/form-recognizer/concept-business-card)
- [Azure AI Document Intelligence W-2 model](/azure/applied-ai-services/form-recognizer/concept-w2)
