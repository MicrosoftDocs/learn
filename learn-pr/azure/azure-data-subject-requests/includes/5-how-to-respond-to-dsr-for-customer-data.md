Once a data controller receives a DSR, a response must be given as soon as possible. GDPR requires that a response is given in one calandar month. For example, if the request is recieved on January 1st, the response is required by February 1st. CCPA requires a response no later than 45 days. Failure to comply in the specified periods could incur severe monitary penalties. In order to respond efficiently to a DSR for customer data, organizations can follow the guidance from Microsoft and use the tools and in-app features avaialble in Office 365.

## Scenarios for DSR in Azure and Office 365 for customer data

### Scenario 1: DSR against customer data in Azure
A customer of Contoso, Ltd that resides in France has called into the toll free number establised for DSRs. They want to enact their "right to erasure" also known as their "right to be forgotten". You need to remove all of their personal information from Azure.  In order to accomplish this you execute the following tasks for this DSR:

1. Discovery
    * Sign into the Azure portal
    * Navigate to Azure Active Directory and select **Users**
    * Locate the user account in the **All users** blade.
    * Select **Profile** to review the personal data and confirm that this is the data subject
    
2. Access (not applicable)
3. Rectify (not applicable)
4. Restrict (not applicable)
5. Delete
    * Sign into the Azure portal
    * Navigate to Azure Active Directory and select **Users**
    * In the **All users** blade, select the checkbox next to the data subject's user account.
    * Select **Delete user**
    * In the **Deleted users** blade, select the checkbox next to the data subject's user account.
    * Select **Delete permanently** and then select **Yes** to confirm.
6. Export (not applicable)

> **Note:** Deleting this data also means deleting the user from the tenant. Users are initially soft-deleted, which means the account can be recovered by a tenant admin within 30 days of being marked for soft-delete. After 30 days, the account is automatically, and permanently, deleted from the tenant. Prior to that 30 days, you can manually delete a soft-deleted user from the recycle bin.

### Scenario 2: DSR against customer data in Office 365
A customer of Contoso, Ltd that resides in California has submitted a Data Subject Request form on the company website. They want to gain access to their personal information that was provided to Contoso, Ltd in the form of emails and word documents. You need to search for thier personal information and, if applicable, provide them with access to that information or an explantion of why the information can not be provided.  In order to accomplish this you execute the following tasks for this DSR:

1. Search all content locations with the Content Search tool using identifiers such as:
    * Email address or alias
    * Phone number
    * Mailing address
    * Social Security Number
2. Narrow down results by using conditions such as:
    * File type (docx, pdf, xlxs)
    * Message type (\*email, \*contacts)
    * Compliance tag (compliancetag="personal data")
3. Search for data in SharePoint Online and OneDrive for Business with queries such as:
    * datasubject@contoso.com AND filetype="docx"
    * (11-18-1990) AND (messagetype="\*email") 


## Tools used for DSR for customer data


