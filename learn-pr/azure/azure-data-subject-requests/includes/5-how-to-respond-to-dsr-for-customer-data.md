When a data controller receives a DSR, they typically must respond within a specific time period. The GDPR requires a response within one calendar month. The CCPA requires a response within 45 days. Companies who don't comply with this might incur monetary penalties.

To respond efficiently to a DSR for customer data, organizations can use Azure and Office 365 tools and in-app features.

## Response scenarios for a customer-data DSR in Azure and Office 365

DSR scenarios usually include two broad tasks. The first is to discover and locate the requested personal information. The action that the data subject asks for will determine the second task. The following table illustrates these two steps:

|Request right|Task 1|Task 2|
|------|------|------|
|To access data|Discover|Access|
|To rectify data (for the GDPR only)|Discover|Rectify|
|To restrict data|Discover|Restrict|
|To delete or to be forgotten|Discover|Delete|
|Of portability|Discover|Export/Receive|

Some DSRs are more complex than others. For example, there might be multiple requests from the same person. Data controllers have the right to validate a data subject's identity before responding to a DSR. However, the data subject doesn't have to specify the reason for the DSR.

### Example 1: Respond to a  DSR to delete Azure-based customer data

A customer residing in France has called the DSR toll-free number to enact their right to be forgotten, also known as a right to erasure. You need to remove all of their personal information from Azure. To do this, perform the following steps:

#### Task 1: Discover

1. Sign into the Azure portal.
2. Navigate to Azure AD, and then select **Users**.
3. Locate the user account in the **All users** blade.
4. Select **Profile** to review the personal data, and then confirm that this is the data subject who made the request.

#### Task 2: Delete

1. In Azure AD, select **Users**.
2. In the **All users** blade, select the check box for the data subject's user account.
3. Select **Delete user**, and then select **Yes** to confirm.
4. In the **Deleted users** blade, select the check box for the data subject's user account.
5. Select **Delete permanently**, and then select **Yes** to confirm.

> [!NOTE]
> Deleting this data also means that the user is deleted from the tenant. However, users are initially soft-deleted. This means that within 30 days of being marked for soft-delete, a tenant admin can recover the account. After 30 days, the account is automatically and permanently deleted from the tenant. You can also speed up the permanent deletion process by manually deleting the user from the recycle bin.

### Example 2: Respond to a DSR for access to Office 365 customer data

A Contoso customer who lives in California has submitted a DSR form through the company's website. They want access to the personal information that they provided to Contoso through email and documents.

Again, there are two steps here. First, you’ll search for (discover) their personal information. You’ll then give the customer access to that information. If this isn’t possible, you might need to provide an explanation of why the information can't be provided. 

#### Task 1: Discover

1. Search all content locations with the **Content Search** tool using identifiers such as:

    - Email address or alias (examples: datasubject@contoso.com or datasubject)
    - Phone number
    - Mailing address
    - Social security number

2. Narrow down results by using conditions such as:

    - File type: for example, **docx**, **pdf**, or **xlsx**
    - Message type: for example, **email** or **contacts**
    - Compliance tag: for example, *compliancetag="personal data"*

3. Search for data in SharePoint Online and OneDrive for Business with queries such as:

    - datasubject@contoso.com AND filetype="docx"
    - (11-18-1990) AND (kind="email")

4. Save the content search for future queries.

#### Task 2: Provide access

1. Provide the data subject with access by retrieving a copy of the document or item that contains responsive data.  To do this:

    1. In the Compliance Center, open **Content Search**.
    1. Select **Preview results**.
    1. Select an item, and then select **Download original file**.

2. Determine which of the following items to provide:

    - The actual document
    - An appropriately redacted version
    - A screenshot of portions deemed appropriate to share

> [!NOTE]
> When providing a copy to the data subject, you should remove or redact personal information about other data subjects or other confidential information.

## Useful tools for responding to customer-data DSRs 

The following table lists tool that you can use to respond to customer-data DSRs in Microsoft online services:

|Tool name|Description|
|------|------|
|Azure portal|Use this tool to respond to DSRs within Azure.|
|Content Search eDiscovery tool|This tool is in the Office 365 Security & Compliance Center and the Microsoft 365 compliance center. Use it to help fulfill DSRs against Office 365/Microsoft 365 applications.|
|DSR case tool|This tool is in the Office 365 Security & Compliance Center. Use this tool to help with data-subject investigations.|
|In-app functionality|For applications that don’t support the Content Search tool, use this application for DSR responses.|

## Office 365 applications that help you with DSR responses

Office 365 includes many applications that might store user data. Knowing which applications the data subject uses helps narrow down what’s in scope for a DSR response. Depending on the application, you might use the Content Search tool to respond. However, in other cases, you'll use the in-app functionality to access the data.

A quick way to determine the applications that are in-scope is to review the Microsoft 365 for Business subscription. The subscription's details list the included applications. You can also use the Microsoft 365 admin center to help locate the user's account. From there, in the user account's properties, you can review their product licensing.

## Limiting a search using compliance boundaries

*Compliance boundaries* are logical search boundaries. Use these boundaries to control or limit the content locations, such as Exchange Online mailboxes and SharePoint Online sites, in which an IT administrator or compliance officer can search when responding to a DSR. Use the Compliance Center to create compliance boundaries. Common scenarios for setting compliance boundaries include for:

- Geographical boundaries.
- Governmental organizations and agencies.
- Organizational units or departments.
