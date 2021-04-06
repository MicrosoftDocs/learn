Form Recognizer includes prebuilt models that you can use for common form extraction tasks. 

To use the prebuilt models, use the REST API (or SDK) to call the model-specific function to start the analysis process and receive a result ID. You can then make a subsequent call to the model-specific Get Results function, passing the result ID to retrieve the results. 

## Receipts

The prebuilt model for receipts enables you to extract common receipt fields, including:

- MerchantName
- MerchantAddress
- MerchantPhoneNumber
- TransactionDate
- TransactionTime
- Items
    - Quantity
    - Name
    - TotalPrice
- Subtotal
- Tax
- Tip
- Total

Receipt customer examples:
- Streamlining business expense reporting processes 
- Automating auditing and accounting tasks 
- Analyzing consumer behavior and shopping trends 

>[!NOTE]
>You can learn more about the prebuilt receipt model with this separate <a href="https://docs.microsoft.com/learn/modules/analyze-receipts-form-recognizer/" target="_blank">Form Recognizer service module</a>.  

## Invoices (preview)

The prebuilt model for invoices extracts text and tables such as you commonly find in invoices, and identifies named fields such as:
- CustomerName
- CustomerId
- PurchaseOrder
- InvoiceId
- InvoiceDate
- DueDate
- VendorName
- VendorAddress
- VendorAddressRecipient
- CustomerAddress
- CustomerAddressRecipient
- BillingAddress
- BillingAddressRecipient
- ShippingAddress
- ShippingAddressRecipient
- SubTotal
- TotalTax
- InvoiceTotal
- AmountDue
- ServiceAddress
- ServiceAddressRecipient
- RemittanceAddress
- RemittanceAddressRecipient
- ServiceStartDate
- ServiceEndDate
- PreviousUnpaidBalance

Invoice customer examples: 
- Processing paperwork in real time 
- Accelerating access to reliable data 

## Business Cards (preview)

The prebuilt model for business cards extracts information such as:
- ContactNames
    - FirstName
    - LastName
- CompanyNames
- Departments
- JobTitles
- Emails
- Websites
- Addresses
- MobilePhones
- Faxes
- WorkPhones
- OtherPhones

Business card customer examples:
- Extracting contact information from business cards to quickly create phone contacts
- Integrating contact information with a CRM to automatically create contacts using images
- Keeping track of sales leads

