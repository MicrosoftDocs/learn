When a data controller receives a DSR, they typically need to provide a response as soon as possible. The GDPR requires responses within one calendar month. <!-- ID/SME: I really don't think we need an example here. It's pretty straightforward, and the pgph is stronger w/out this sentence. -->For example, a request received on January 1 requires a response by February 1. CCPA requires a response no later than 45 days. Companies who don't comply with this could incur monetary penalties.

To respond efficiently to a DSR for customer data, organizations can follow the guidance from Microsoft <!-- ID/SME: Is the guidance that Microsoft provides to use the tools and in-app features? If so, let's change to "...organizations can use the tools...and Office 365 to help gather data."-->and use the tools and in-app features available in both Microsoft 36 and Office 365.
<!-- ID/SME: The following heading is the same heading is as on line 19. See my next comment for a possible fix. Otherwise, we need to redo one of the headings so they aren't the same. -->
## Scenarios for DSR in Azure and Office 365 for customer data
<!-- ID/SME: I would recommend moving this heading to just above Example 1 below. I've done this so you can see what I mean. If you agree, please come up with a different heading for this section, such as "First steps for DSR requests."-->
DSR request scenarios usually start with performing discovery and locating the requested personal information. The DSR requested action will determine the second step. The following table breaks out the technical process and tools you can use for the DSR based on the personal information's location and the data type.

|Request type|Step 1|Step 2|
|------|------|------|
|Right to access data|Discover|Access|
|Right to rectify data|Discover|Rectify|
|Right to restrict data|Discover|Restrict|
|Right to be forgotten|Discover|Delete|
|Right of portability|Discover|Export/Receive|

Some DSRs might be more complex than others. There might even be multiple requests from the same person. Data controllers have the right to validate the data subject's identity before fulfilling their DSR. However, the data subject doesn't have to specify the reason for the DSR.
<!-- ID/SME: The following heading is the same heading is as on line 5. See my next comment for a possible fix. Otherwise, we need to redo one of the headings so they aren't the same. -->
## Scenarios for DSR in Azure and Office 365 for customer data
<!-- ID/SME: I added the above heading and following line of text as this heading seems more appropriate for this section. If you agree, make sure to complete the following sentence. The other alternative is to delete this heading entirely, and create a transitional sentence between the above pgph (line 17) and the Example 1 heading, skipping the above heading entirely.-->
The following scenarios are examples of tasks...

### Example 1: DSR against customer data in Azure

A Contoso customer residing in France has called the DSR toll-free number to enact their right to be forgotten, also known as *right to erasure*. You need to remove all their personal information from Azure. To do this, you can use the following steps:

#### Task 1: Discover<!-- ID/SME: Task steps should not e headings. -->

1. Sign into the Azure portal.
2. Navigate to Azure AD, and then select **Users**.
3. Locate the user account in the **All users** blade.
4. Select **Profile** to review the personal data and confirm that this is the DSR data subject.

#### Task 2: Delete

1. In Azure AD, select **Users**.
2. In the **All users** blade, select the check box for the data subject's user account.
3. Select **Delete user**, and then select **Yes** to confirm.
4. In the **Deleted users** blade, select the check box for the data subject's user account.
5. Select **Delete permanently**, and then select **Yes** to confirm.

> [!NOTE]
> Deleting this data also means deleting the user from the tenant. However, users are initially soft-deleted, which means that within 30 days of being marked for soft-delete, a tenant admin can recover the account. After 30 days, the account is automatically and permanently deleted from the tenant. You can also speed up the process by manually deleting the user from the recycle bin.

### Example 2: DSR against customer data in Office 365

A Contoso customer residing in California has submitted a DSR form through the company's website. They want access to their personal information that they provided to Contoso via emails and documents. You need to search for their personal information, then give the customer access to that information. If that's not possible, you may need to provide an explanation of why the information can't be provided. To accomplish this, you can use the following steps:

#### Task one: Discover

1. Search all content locations with the **Content Search** tool by using identifiers such as:

    - Email address or alias (examples: datasubject@contoso.com or datasubject)
    - Phone number
    - Mailing address
    - Social security number

2. Narrow down results by using conditions such as:

    - File type: for example, **docx**, **pdf**, or **xlsx**
    - Message type: for example, **\*email** or **\*contacts**
    - Compliance tag: for example, *compliancetag="personal data"*

3. Search for data in SharePoint Online and OneDrive for Business with queries such as:

    - datasubject@contoso.com AND filetype="docx"
    - (11-18-1990) AND (kind="email")
    - Save the content search for future tasks.<!-- ID/SME: Should "tasks" be "queries?" Also, shouldn't this bulleted item be a numbered step? Step 4? -->

#### Task 2: Provide access

1. Provide access<!-- ID/SME: Provide access to whom or what? --> by retrieving a copy of the document or item that contains responsive data. To do this, you can preview and download items:

    1. In the Compliance Center, open **Content Search**.
    1. Select **Preview results**.
    1. Select an item, and then select **Download original file**.

2. Determine which of the following item (or items) to provide:

    - The actual document
    - An appropriately redacted version
    - A screenshot of portions deemed appropriate to share

> [!NOTE]
> When providing a copy to the data subject, you might need to remove or redact personal information about other data subjects and any other confidential information.

## Tools for fulfilling DSRs for customer data

The following table lists tool that you can use to fulfill DSRs for customer data in Microsoft cloud products.

|Tool name|Description|
|------|------|
|Azure Portal|Use this tool to respond to DSRs against <!-- ID/SMe: Should this be "within Azure?" -->Azure.|
|Content Search eDiscovery tool|This tool is in both the Office 365 Security & Compliance Center, and the Microsoft 365 compliance center. You can use it to help fulfill DSRs against Office 365 applications.<!-- ID/SME: If this is only for Office 365 apps, should we be mentioning Microsoft 365? -->|
|DSR case tool|This tool is in the Compliance Center<!-- ID/SME: Which compliance center? And be sure to use the correct name(s) from the row above. I updated these based on the approved names in Term Studio. -->. You can use this tool help with investigations for a data subject.|
|In-app functionality|For applications that don’t support the Content Search tool, you can use the application itself<!-- ID/SME: verify we mean "the application itself." --> for responding to DSRs.|

## In-scope applications

Office 365 includes many applications that can store user data. Knowing which applications the data subject uses helps you narrow down what’s in scope for the DSR response. Depending on the application, you might be able to use the Content Search tool to respond. In some cases, however, you'll have to use the in-app functionality to get to the data.

One of the fastest ways to determine the in-scope applications is to review the Microsoft 365 for Business subscription<!-- ID/SME: How can reviewing the subscription itself help you? And can you actually review a subscription itself, or do you review info about the subscription? -->. You can also use the Microsoft 365 admin center to help locate the user's account. From there, in the user account's properties, you can review their product licensing.

## Compliance boundaries

*Compliance boundaries* are logical search boundaries. These boundaries control the locations that the people involved in the DSR fulfillment can access. You can use the Compliance Center to create compliance boundaries. Some common use cases for compliance boundaries include:

- Geographical boundaries
- Governmental organizations and agencies
- Organizational units or departments
