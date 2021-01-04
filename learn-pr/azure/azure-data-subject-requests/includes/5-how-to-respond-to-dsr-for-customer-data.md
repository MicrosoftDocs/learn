Once a data controller receives a DSR, a response must be given as soon as possible. GDPR requires that a response is given in one calendar month. For example, if the request is received on January 1st, the response is required by February 1st. CCPA requires a response no later than 45 days. Failure to comply in the specified periods could incur severe monetary penalties. In order to respond efficiently to a DSR for customer data, organizations can follow the guidance from Microsoft and use the tools and in-app features available in Microsoft 365/Office 365.

## Scenarios for DSR in Azure and Office 365 for customer data

The first step for all scenarios is to perform discovery and locate the personal information in question. The next step will be determined by the action requested in the DSR. The technical process and tools used to execute the DSR will be determined by the location of the personal information and the data type. 

|Request Type|Step 1|Step 2|
|------|------|------|
|Right to Access Data|Discover|Access|
|Right to Rectify Data|Discover|Rectify|
|Right to Restrict Data|Discover|Restrict|
|Right to be forgotten|Discover|Delete|
|Right of portability|Discover|Export/Receive|

Some DSRs may be more complex or there may even be multiple requests from the same person. Data controllers have the right to validate the identity of the data subject prior to executing their DSR. However, the data subject does not have to specify the reason for the DSR.

### Example 1: DSR against customer data in Azure
A customer of Contoso, Ltd that resides in France has called into the toll free number established for DSRs. They want to enact their "**right to erasure**" also known as their "right to be forgotten". You need to remove all of their personal information from Azure.  In order to accomplish this you execute the following tasks for this DSR:

1. Discover
    * Sign into the Azure portal
    * Navigate to Azure Active Directory and select **Users**
    * Locate the user account in the **All users** blade.
    * Select **Profile** to review the personal data and confirm that this is the data subject
    
2. Delete
    * Sign into the Azure portal
    * Navigate to Azure Active Directory and select **Users**
    * In the **All users** blade, select the check-box next to the data subject's user account.
    * Select **Delete user** and then select **Yes** to confirm. 
    * In the **Deleted users** blade, select the check-box next to the data subject's user account.
    * Select **Delete permanently** and then select **Yes** to confirm.


> **Note:** Deleting this data also means deleting the user from the tenant. Users are initially soft-deleted, which means the account can be recovered by a tenant admin within 30 days of being marked for soft-delete. After 30 days, the account is automatically, and permanently, deleted from the tenant. Prior to that 30 days, you can manually delete a soft-deleted user from the recycle bin.

### Example 2: DSR against customer data in Office 365
A customer of Contoso, Ltd that resides in California has submitted a Data Subject Request form on the company website. They want to gain access to their personal information that was provided to Contoso, Ltd in the form of emails and documents. You need to search for their personal information and, if appropriate, provide them with **access** to that information or an explanation of why the information can not be provided.  In order to accomplish this you execute the following tasks for this DSR:

1. Discover
    * Search all content locations with the Content Search tool using identifiers such as:
        - Email address or alias (examples: datasubject@contoso.com or datasubject)
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
        - In the Compliance Center, open Content Search 
        - Select Preview results
        - Select an item
        - Select Download original file
    * Determine what is appropriate to provide:
        - The actual document
        - Appropriately redacted version
        - Screenshot of portions deemed appropriate to share


> **Note:** When providing a copy to the data subject, you may have to remove or redact personal information about other data subjects and any confidential information.


## Tools used for DSR for customer data

The following table lists tool that can be used for executing DSRs for customer data in the Microsoft Cloud.

|Tool Name|Description|
|------|------|
|Azure Portal| Can be used to respond to DSRs against Azure.|
|Content Search eDiscovery tool|Located in the Compliance Center of Office 365 and Microsoft 365. Used when executing DSRs against Office 365 applications.|
|DSR case tool|Located in the Compliance Center. Can be used to manage investigations for a data subject.|
|In-app functionality|For applications that do not support Content Search, application can be used directly for responding to DSRs.|

<!--- TR & ID: The following content was moved from Unit 4 to help reduce the size of Unit 4. Unfortunatly, this content was not appropriate to move to Module 3 to make that module longer. I do feel this content works in this unit but not 100% sure about the flow. If it doesn't feel right please let me know and we can remove it. --->
**In-scope Applications**

Office 365 encompass many applications that have the potential to store user data. Knowing which applications that the data subject uses will help narrow down what is in-scope for the DSR response. Depending on the application, you may be able to use the Content Search tool to respond. In some cases however, you'll have to use the in-app functionality to get to the data.


One of the fastest ways to determine the in-scope applications is to review the Microsoft 365 for business subscription. The Microsoft 365 admin center can be used to locate the user's account. In the properties for the user account you can view their product licensing. 

**Compliance Boundaries**

Compliance Boundaries can be created using the Compliance Center. They are logical search boundaries that control locations that the people involved in the DSR execution can access. Some common use cases for compliance boundaries include:
- geographical boundaries
- governmental organizations agencies
- Organizational units or department

