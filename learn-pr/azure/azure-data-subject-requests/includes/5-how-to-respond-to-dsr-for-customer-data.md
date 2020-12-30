Once a data controller receives a DSR, a response must be given as soon as possible. GDPR requires that a response is given in one calandar month. For example, if the request is recieved on January 1st, the response is required by February 1st. CCPA requires a response no later than 45 days. Failure to comply in the specified periods could incur severe monitary penalties. In order to respond efficiently to a DSR for customer data, organizations can follow the guidance from Microsoft and use the tools and in-app features avaialble in Office 365.

## Scenarios for DSR in Azure and Office 365 for customer data

The first step for all scenarios is to perfom discovery and locate the personal information in question. The next step will be determined by the action requested in the DSR. The technical process and tools used to execute the DSR will be determined by the location of the personal information and the data type. 

|Request Type|Step 1|Step 2|
|------|------|------|
|Right to Access Data|Discover|Access|
|Right to Rectify Data|Discover|Rectify|
|Right to Restrict Data|Discover|Restrict|
|Right to be forgoten|Discover|Delete|
|Right of portability|Discover|Export/Receive|

Some DSRs may be more complex or there may even be multiple requests from the same person. Data controlers have the right to validate the identity of the data subject prior to executing thier DSR. However, the data subject does not have to specify the reason for the DSR.

### Example 1: DSR against customer data in Azure
A customer of Contoso, Ltd that resides in France has called into the toll free number establised for DSRs. They want to enact their "**right to erasure**" also known as their "right to be forgotten". You need to remove all of their personal information from Azure.  In order to accomplish this you execute the following tasks for this DSR:

1. Discover
    * Sign into the Azure portal
    * Navigate to Azure Active Directory and select **Users**
    * Locate the user account in the **All users** blade.
    * Select **Profile** to review the personal data and confirm that this is the data subject
    
2. Delete
    * Sign into the Azure portal
    * Navigate to Azure Active Directory and select **Users**
    * In the **All users** blade, select the checkbox next to the data subject's user account.
    * Select **Delete user**
    * In the **Deleted users** blade, select the checkbox next to the data subject's user account.
    * Select **Delete permanently** and then select **Yes** to confirm.


> **Note:** Deleting this data also means deleting the user from the tenant. Users are initially soft-deleted, which means the account can be recovered by a tenant admin within 30 days of being marked for soft-delete. After 30 days, the account is automatically, and permanently, deleted from the tenant. Prior to that 30 days, you can manually delete a soft-deleted user from the recycle bin.

### Example 2: DSR against customer data in Office 365
A customer of Contoso, Ltd that resides in California has submitted a Data Subject Request form on the company website. They want to gain access to their personal information that was provided to Contoso, Ltd in the form of emails and word documents. You need to search for thier personal information and, if applicable, provide them with **access** to that information or an explantion of why the information can not be provided.  In order to accomplish this you execute the following tasks for this DSR:

1. Discover
    * Search all content locations with the Content Search tool using identifiers such as:
        - Email address or alias
        - Phone number
        - Mailing address
        - Social Security Number
    * Narrow down results by using conditions such as:
        - File type (docx, pdf, xlxs)
        - Message type (\*email, \*contacts)
        - Compliance tag (compliancetag="personal data")
    * Search for data in SharePoint Online and OneDrive for Business with queries such as:
        - datasubject@contoso.com AND filetype="docx"
        - (11-18-1990) AND (kind="email") 
        - Save the Content Search for additional steps
2. Access
    * Provide Access by retrieving a copy of document or item that contains responsive data using preview and download items:
        - In the Security & Compliance Center, open Content Search
        - Select Preview results
        - Select an item
        - Select Download original file
    * Determine what is appropriate to provide:
        - The actual document
        - Appropriately redacted version
        - Screenshot of portions deemed appropriate to share


> **Note:** When providing a copy to the data subject, you may have to remove or redact personal information about other data subjects and any confidential information.


## Tools used for DSR for customer data



