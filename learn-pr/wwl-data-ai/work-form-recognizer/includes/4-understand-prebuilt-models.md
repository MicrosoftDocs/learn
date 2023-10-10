Azure Document Intelligence includes prebuilt models that you can use for common form extraction tasks.

## W-2s (preview)

The prebuilt model for W-2 forms extracts text and tables and identifies named fields such as:

- Employee.SocialSecurityNumber
- Employer.IdNumber
- Employer.Name
- Employer.Address
- Employer.ZipCode
- ControlNumber
- Employee.Name
- Employee.Address
- Employee.ZipCode
- WagesTipsAndOtherCompensation
- FederalIncomeTaxWithheld
- SocialSecurityWages
- SocialSecurityTaxWithheld
- MedicareWagesAndTips
- MedicareTaxWithheld
- SocialSecurityTips
- DependentCareBenefits
- NonqualifiedPlans
- AdditionalInfo
- State
- EmployerStateIdNumber
- StateIncomeTax
- LocalIncomeTax
- TaxYear

More info can be found about this model at the [W-2 model page](/azure/applied-ai-services/form-recognizer/concept-w2).

## Invoices

The prebuilt model for invoices extracts text and tables and identifies named fields such as:

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

A few invoice model uses include: 
- Processing paperwork in real time 
- Accelerating access to reliable data 

More info can be found about this model at the [invoice model page](/azure/applied-ai-services/form-recognizer/concept-invoice).

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

A few receipt model uses include:
- Streamlining business expense reporting processes 
- Automating auditing and accounting tasks 
- Analyzing consumer behavior and shopping trends 

More info can be found about this model at the [receipts model page](/azure/applied-ai-services/form-recognizer/concept-receipt).

>[!NOTE]
>You can learn more about the prebuilt receipt model with this separate <a href="/training/modules/analyze-receipts-form-recognizer/" target="_blank">Azure Document Intelligence service module</a>.  

## ID documents

The ID document model extracts text and identifies named fields such as:

- CountryRegion
- DateOfBirth
- DateOfExpiration
- DocumentNumber
- FirstName
- LastName
- Nationality
- Sex
- MachineReadableZone
- DocumentType
- Address
- Region

More info can be found about this model at the [ID document model page](/azure/applied-ai-services/form-recognizer/concept-id-document).


## Business Cards 

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

A few business card model uses include:
- Extracting contact information from business cards to quickly create phone contacts
- Automatically creating contacts from images to integrate data with a CRM  
- Keeping track of sales leads

More info can be found about this model at the [business card model page](/azure/applied-ai-services/form-recognizer/concept-business-card).
