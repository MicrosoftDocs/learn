Once a data controller receives a DSR, they must provide a response as soon as possible. The GDPR requires responses in one calendar month. For example, if the request is received on January 1st, the response is required by February 1st. CCPA requires a response no later than 45 days. Failure to comply in the specified periods could incur severe monetary penalties. To respond efficiently to a DSR for customer data, organizations can follow the guidance from Microsoft and use the tools and in-app features available in Microsoft 365/Office 365.

## Scenarios for DSR in Azure and Office 365 for customer data

The first step for all scenarios is to perform discovery and locate the personal information in question. The action requested in the DSR will determine the next step. The location of the personal information and the data type will determine the technical process and tools you can use to fulfill the DSR.

|Request type|Step 1|Step 2|
|------|------|------|
|Right to access data|Discover|Access|
|Right to rectify data|Discover|Rectify|
|Right to restrict data|Discover|Restrict|
|Right to be forgotten|Discover|Delete|
|Right of portability|Discover|Export/Receive|

Some DSRs might be more complex than others. There might even be multiple requests from the same person. Data controllers have the right to validate the identity of the data subject prior to fulfilling their DSR. However, the data subject doesn't have to specify the reason for the DSR.

### Example one: DSR against customer data in Azure

A customer of Contoso who resides in France has called into the toll-free number established for DSRs. They want to enact their "**right to erasure**", which is also known as their "right to be forgotten". You need to remove all their personal information from Azure. To accomplish this, you’ll perform the following tasks for this DSR:

#### Task one: Discover

1. Sign into the Azure portal.
2. Navigate to Azure AD, and select **Users**.
3. Locate the user account in the **All users** blade.
4. Select **Profile** to review the personal data and confirm that this is the data subject.

#### Task two: Delete

1. In Azure AD, select **Users**.
2. In the **All users** blade, select the check box for the data subject's user account.
3. Select **Delete user**, and then select **Yes** to confirm.
4. In the **Deleted users** blade, select the check box for the data subject's user account.
5. Select **Delete permanently**, and then select **Yes** to confirm.

> [!NOTE]
> Deleting this data also means deleting the user from the tenant. Users are initially soft-deleted, which means that within 30 days of being marked for soft-delete, a tenant admin can recover the account. After 30 days, the account is automatically, and permanently, deleted from the tenant. Prior to those 30 days, you can manually delete a soft-deleted user from the recycle bin.

### Example two: DSR against customer data in Office 365

A customer of Contoso that resides in California has submitted a DSR form on the company website. They want to gain access to their personal information that they provided to Contoso in the form of emails and documents. You need to search for their personal information and, if appropriate, provide them with access to that information or an explanation of why the information can't be provided. To accomplish this, you’ll perform the following tasks for this DSR:

#### Task one: Discover

1. Search all content locations with the **Content Search** tool by using identifiers such as:

    - Email address or alias (examples: datasubject@contoso.com or datasubject)
    - Phone number
    - Mailing address
    - Social Security Number

2. Narrow down results by using conditions such as:

    - File type; for example, docx, pdf, or xlsx
    - Message type; for example, \*email or \*contacts
    - Compliance tag; for example, compliancetag="personal data"

3. Search for data in SharePoint Online and OneDrive for Business with queries such as:

    - datasubject@contoso.com AND filetype="docx"
    - (11-18-1990) AND (kind="email")
    - Save the content search for additional steps

#### Task two: Provide access

1. Provide access by retrieving a copy of the document or item that contains responsive data, by using preview and downloading items:

    1. In the Compliance Center, open **Content Search**.
    1. Select **Preview results**.
    1. Select an item.
    1. Select **Download original file**.

2. Determine which of the following is appropriate to provide:

    - The actual document
    - Appropriately redacted version
    - Screenshot of portions deemed appropriate to share

> [!NOTE]
> When providing a copy to the data subject, you might have to remove or redact personal information about other data subjects and any confidential information.

## Tools for DSR for customer data

The following table lists tool that you can use for fulfilling DSRs for customer data in Microsoft cloud products.

|Tool Name|Description|
|------|------|
|Azure Portal| Use this tool to respond to DSRs against Azure.|
|Content Search eDiscovery tool|This tool is located in the Compliance Center of Office 365 and Microsoft 365. Use it when fulfilling DSRs against Office 365 applications.|
|DSR case tool| This tool is located in the Compliance Center. Use it to manage investigations for a data subject.|
|In-app functionality|For applications that don’t support **Content Search**, directly use the application for responding to DSRs.|

## In-scope applications

Office 365 includes many applications that can store user data. Knowing which applications the data subject uses helps you narrow down what’s in-scope for the DSR response. Depending on the application, you might be able to use the Content Search tool to respond. In some cases, however, you'll have to use the in-app functionality to get to the data.

One of the fastest ways to determine the in-scope applications is to review the Microsoft 365 for Business subscription. Use the Microsoft 365 admin center to locate the user's account. In the properties for the user account, you can review their product licensing.

## Compliance boundaries

Compliance boundaries are logical search boundaries that control the locations that the people involved in the DSR fulfillment can access. You can create compliance boundaries by using the Compliance Center. Some common use cases for compliance boundaries include:

- Geographical boundaries
- Governmental organizations and agencies
- Organizational units or departments
