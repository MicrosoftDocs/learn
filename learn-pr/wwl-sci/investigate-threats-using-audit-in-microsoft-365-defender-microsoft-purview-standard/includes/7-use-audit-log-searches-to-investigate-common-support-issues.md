
This unit describes how organizations can use the audit log search tool to help them investigate the following common support issues:

- Find the IP address of the computer used to access a compromised account.
- Determine who set up email forwarding for a mailbox.
- Determine if a user deleted email items in their mailbox.
- Determine if a user created an inbox rule.
- Investigate why there was a successful sign-in by a user outside your organization.
- Search for mailbox activities performed by users with non-E5 licenses.
- Search for mailbox activities performed by delegate users.

Each of the troubleshooting scenarios described in this unit is based on using the audit log search tool in the Microsoft Purview compliance portal. Each scenario explains how to configure an audit log search query for the corresponding issue. It also describes what to look for in the detailed information in the audit records that match the search criteria.

### Issue: Find the IP address of the computer used to access a compromised account

The IP address corresponding to an activity performed by any user is included in most audit records. Information about the client used is also included in the audit record.

Here's how to configure an audit log search query for this scenario:

 -  **Activities**. If relevant to your case, select a specific activity to search for. For troubleshooting compromised accounts, consider selecting the User signed in to mailbox activity under Exchange mailbox activities. This returns auditing records showing the IP address that was use when signing in to the mailbox. Otherwise, leave this field blank to return audit records for all activities.
    
    > [!TIP]
    > Leaving this field blank will return UserLoggedIn activities, which is a Microsoft Entra activity that indicates that someone has signed into a user account. Use filtering in the search results to display the UserLoggedIn audit records.
 -  **Start date and End date**. Select a date range that's applicable to your investigation.
 -  **Users**. If you're investigating a compromised account, select the user whose account was compromised. This returns audit records for activities performed by that user account.
 -  **File, folder, or site**. Leave this field blank.

After you run the search, the IP address for each activity is displayed in the IP address column in the search results. Select the record in the search results to view more detailed information on the flyout page.

### Issue: Determine who set up email forwarding for a mailbox

When email forwarding is configured for a mailbox, email messages that are sent to the mailbox are forwarded to another mailbox. Messages can be forwarded to users inside or outside of an organization. When email forwarding is set up on a mailbox, the underlying Exchange Online cmdlet that's used is **Set-Mailbox**.

Here's how to configure an audit log search query for this scenario:

 -  **Activities**. Leave this field blank so the search returns audit records for all activities. Doing so is necessary to return any audit records related to the **Set-Mailbox** cmdlet.
 -  **Start date and End date**. Select a date range that's applicable to the investigation.
 -  **Users**. Unless you're investigating an email forwarding issue for a specific user, leave this field blank. Doing so helps you identify if email forwarding was set up for any user.
 -  **File, folder, or site**. Leave this field blank.

After you run the search, select **Filter results** on the search results page. In the box under the **Activity** column header, type **Set-Mailbox** so that only audit records related to the **Set-Mailbox** cmdlet are displayed.

:::image type="content" source="../media/email-forward-1-edb35d8e.png" alt-text="Screenshot showing the search results page with the Set Mailbox activity highlighted for filtering the results.":::


At this point, you have to look at the details of each audit record to determine if the activity is related to email forwarding. Select the audit record to display the **Details** flyout page, and then select **More information**. The following screenshot and descriptions highlight the information that indicates email forwarding was set on the mailbox.

:::image type="content" source="../media/email-forward-2-3ef10e73.png" alt-text="Screenshot of the search results page after selecting the More information option, and with fields from the audit record highlighted.":::


 -  **A. ObjectId**. The alias of the mailbox that email forwarding was set on is displayed. This mailbox is also displayed on the **Item** column in the search results page.
 -  **B. Parameters**. The value **ForwardingSmtpAddress** indicates that email forwarding was set on the mailbox. In this example, mail is being forwarded to the email address mike@contoso.com, which is outside of the alpinehouse.onmicrosoft.com organization.
 -  **C. True**. This value for the **DeliverToMailboxAndForward** parameter indicates that a copy of the message is delivered to sarad@alpinehouse.onmicrosoft.com AND is forwarded to the email address specified by the **ForwardingSmtpAddress** parameter, which in this example is mike@contoso.com. If the value for the **DeliverToMailboxAndForward** parameter is set to **False**, then email is only forwarded to the address specified by the **ForwardingSmtpAddress** parameter. It's not delivered to the mailbox specified in the **ObjectId** field.
 -  **D. UserId**. Indicates the user who set email forwarding on the mailbox specified in the **ObjectId** field. This user is also displayed in the **User** column on the search results page. In this case, it seems that the owner of the mailbox set email forwarding on their mailbox.

If you determine that email forwarding shouldn't be set on the mailbox, you can remove it by running the following command in Exchange Online PowerShell:

```powershell
Set-Mailbox <mailbox alias> -ForwardingSmtpAddress $null
```

### Issue: Determine if a user deleted email items

Starting in 2019, mailbox audit logging is turned on by default for all Microsoft 365 organizations. As a result:

 -  Certain actions performed by mailbox owners are automatically logged.
 -  The corresponding mailbox audit records are available when you search for them in the mailbox audit log.

Before mailbox audit logging was turned on by default, organizations had to manually enable it for each of its user mailboxes.

The mailbox actions logged by default include the **SoftDelete** and **HardDelete** mailbox actions performed by mailbox owners. As a result, organizations can use the following steps to search the audit log for events related to deleted email items. For more information about mailbox auditing on by default, see [Manage mailbox auditing](/microsoft-365/compliance/enable-mailbox-auditing?azure-portal=true).

Here's how to configure an audit log search query for this scenario:

 -  **Activities**. Under Exchange mailbox activities, select one or both of the following activities:
     -  **Deleted messages from Deleted Items folder**. This activity corresponds to the **SoftDelete** mailbox auditing action. This activity is also logged when a user permanently deletes an item by selecting it and pressing **Shift+Delete**. After an item is permanently deleted, the user can recover it until the deleted item retention period expires.
     -  **Purged messages from mailbox**. This activity corresponds to the **HardDelete** mailbox auditing action. This activity is logged when a user purges an item from the **Recoverable Items** folder. Admins can use the **Content search** tool in the Microsoft Purview compliance portal to search for and recover purged items until the deleted item retention period expires, or longer if the user's mailbox is on hold.
 -  **Start date and End date**. Select a date range that's applicable to the investigation.
 -  **Users**. If you select a user in this field, the audit log search tool returns audit records for email items that were either soft deleted or hard deleted by the user you specify. Sometimes the user who deletes an email may not be the mailbox owner.
 -  **File, folder, or site**. Leave this field blank.

After you run the search, you can filter the search results to display the audit records for soft-deleted items or for hard-deleted items. Select the audit record to display the **Details** flyout page, and then select **More information**. Additional information about the deleted item, such as the subject line and the location of the item when it was deleted, is displayed in the **AffectedItems** field.

The following screenshots show an example of the **AffectedItems** field from a soft-deleted item and a hard-deleted item.

Example of the **AffectedItems** field for a soft-deleted item:

:::image type="content" source="../media/soft-deleted-item-cd526486.png" alt-text="Screenshot of the Audit record for a soft-deleted email item.":::


Example of the **AffectedItems** field for a hard-deleted item:

:::image type="content" source="../media/hard-deleted-item-e1ea776d.png" alt-text="Screenshot of the Audit record for a hard-deleted email item.":::


#### Recover deleted email items

Users can recover soft-deleted items if the deleted items retention period hasn't expired. In Exchange Online, the default deleted items retention period is 14 days. However, admins can increase this setting to a maximum of 30 days. Point users to the [Recover deleted items or email in Outlook on the web](https://support.office.com/article/Recover-deleted-items-or-email-in-Outlook-Web-App-C3D8FC15-EEEF-4F1C-81DF-E27964B7EDD4?azure-portal=true) article for instructions on recovering deleted items.

As previously explained, administrators may be able to recover hard-deleted items if the deleted item retention period hasn't expired or if the mailbox is on hold, in which case items are kept until the hold duration expires. When you run a content search, soft-deleted and hard-deleted items in the **Recoverable Items** folder are returned in the search results if they match the search query.

> [!TIP]
> To search for deleted email items, search for all or part of the subject line that's displayed in the **AffectedItems** field in the audit record.

### Issue: Determine if a user created an inbox rule

When users create an inbox rule for their Exchange Online mailbox, a corresponding audit record is saved to the audit log.

Here's how to configure an audit log search query for this scenario:

 -  **Activities**. Under Exchange mailbox activities, select one or both of the following activities:
     -  **New-InboxRule Create new inbox rule from Outlook Web App**. This activity returns audit records when inbox rules are created using Outlook web app or Exchange Online PowerShell.
     -  **Updated inbox rules from Outlook client**. This activity returns audit records when inbox rules are created, modified, or removed using the Outlook desktop client.
 -  **Start date and End date**. Select a date range that's applicable to the investigation.
 -  **Users**. Unless you're investigating a specific user, leave this field blank. By doing so, you can identify new inbox rules set up by any user.
 -  **File, folder, or site**. Leave this field blank.

After you run the search, any audit records for this activity are displayed in the search results. Select an audit record to display the **Details** flyout page, and then select **More information**. Information about the inbox rule settings is displayed in the **Parameters** field. The following screenshot and descriptions highlight the information about inbox rules.

:::image type="content" source="../media/new-inbox-rule-record-518c6308.png" alt-text="Screenshot of the Audit record for a new inbox rule that shows selected fields highlighted.":::


 -  **A. ObjectId**. The full name of the inbox rule is displayed. This name includes the alias of the user's mailbox (for example, **SaraD**) and the name of the inbox rule (for example, "**Move messages from admin**").
 -  **B. Parameters**. The condition of the inbox rule is displayed. In this example, the condition is specified by the **From** parameter. The value defined for the **From** parameter indicates the inbox rule acts on email sent by **admin@alpineskihouse.onmicrosoft.com**.
 -  **C. MoveToFolder**. This parameter specifies the action for the inbox rule. In this example, messages received from **admin@alpineskihouse.onmicrosoft.com** are moved to the folder named **AdminSearch**. A
 -  **D. UserId**. Indicates the user who created the inbox rule specified in the **ObjectId** field. This user is also displayed in the **User** column on the search results page.

### Issue: Investigate why there was a successful sign-in by a user outside your organization

When an organization reviews audit records in the audit log, it may see records that indicate an external user was authenticated by Microsoft Entra ID and successfully signed in to its Microsoft 365 tenant. For example:

 -  An admin in contoso.onmicrosoft.com may see an audit record showing that a user from a different organization (for example, fabrikam.onmicrosoft.com) successfully signed into contoso.onmicrosoft.com.
 -  Similarly, the admin may see audit records that indicate users with a Microsoft Account (MSA), such as an Outlook.com or Live.com, successfully signed into contoso.onmicrosoft.com.

> [!NOTE]
> In these situations, the audited activity is **User logged In**.

This behavior is by design. Microsoft Entra ID, the directory service, allows something called **pass-through authentication** when an external user tries to access a SharePoint site or a OneDrive location in an organization. When the external user tries to sign-in, they're prompted to enter their credentials. Microsoft Entra ID uses the credentials to authenticate the user, meaning only Microsoft Entra ID verifies the user is who they say they are.

The indication of the successful sign-in in the audit record is the result of Microsoft Entra authenticating the user. The successful sign-in doesn't mean the user was able to access any resources or complete any other actions in the organization. It only indicates the user was authenticated by Microsoft Entra ID. For a pass-through user to access SharePoint or OneDrive resources, an internal user in the organization would have to explicitly share a resource with the external user by sending them a sharing invitation or anonymous sharing link.

> [!NOTE]
> Microsoft Entra ID allows pass-through authentication only for **first-party applications**, such as SharePoint Online and OneDrive for Business. It isn't allowed for other third-party applications.

The following screenshot shows an example and descriptions of relevant properties in an audit record for a **User logged In** event that's a result of pass-through authentication. Select the audit record to display the **Details** flyout page, and then select **More information**.

:::image type="content" source="../media/pass-through-authentication-1-2e6b71ec.png" alt-text="Screenshot of an Audit record for a successful pass-thru authentication and with selected fields highlighted.":::


 -  **A. Actor ID**. This field indicates the user who attempted to access a resource in your organization wasn't found in your organization's Microsoft Entra ID.
 -  **B. Actor UPN**. This field displays the UPN of the external user who attempted to access a resource in your organization. This user ID is also identified in the **User** and **UserId** properties in the audit record.
 -  **C. ApplicationId**. This property identifies the application that triggered the sign-in request. The value of 00000003-0000-0ff1-ce00-000000000000 displayed in the **ApplicationId** property in this audit record indicates SharePoint Online. OneDrive for Business also has this same **ApplicationId**.
 -  **D. ExtendedProperties**. This field indicates that the pass-through authentication was successful. In other words, the user was successfully authenticated by Microsoft Entra ID.
 -  **E. RecordType**. Value of 15 indicates the audited activity (**UserLoggedIn**) is a Secure Token Service (STS) sign-in event in Microsoft Entra ID.

The following examples are scenarios that would result in a successful **User logged in** audit activity because of pass-through authentication:

 -  A user with a Microsoft Account (such as **SaraD@outlook.com**) has tried to access a document in a OneDrive for Business account in **fourthcoffee.onmicrosoft.com**. However, there isn't a corresponding guest user account for **SaraD@outlook.com** in **fourthcoffee.onmicrosoft.com**.
 -  A user with a Work or School account in an organization (such as **pilarp@fabrikam.onmicrosoft.com**) has tried to access a SharePoint site in **contoso.onmicrosoft.com**. However, there isn't a corresponding guest user account for **pilarp@fabrikam.com** in **contoso.onmicrosoft.com**.

#### Tips for investigating successful sign-in attempts resulting from pass-through authentication

Organizations should keep in mind the following considerations when investigating successful sign-in attempts that result from pass-through authentication:

 -  Search the audit log for activities performed by the external user identified in the **User logged in** audit record. Type the UPN for the external user in the **Users** box and use a date range if relevant to your scenario. For example, you can create a search using the following search criteria:
    
    :::image type="content" source="../media/pass-through-authentication-2-5bf77132.png" alt-text="Screenshot of a content search window showing the fields to enter to search for all activities completed by an external user.":::
    
    
    Besides the **User logged in** activities, other audit records may be returned. For example, records that indicate a user in your organization shared resources with the external user and whether the external user accessed, modified, or downloaded a document that was shared with them.
 -  Search for SharePoint sharing activities that would indicate a file was shared with the external user identified by a **User logged in** audit record. For more information, see [Use sharing auditing in the audit log](/microsoft-365/compliance/use-sharing-auditing?azure-portal=true).
 -  Export the audit log search results that contain records relevant to your investigation. By doing so, you can use Excel to search for other activities related to the external user.

### Issue: Search for mailbox activities performed by users with non-E5 licenses

Even when mailbox auditing is turned on by default for an organization, mailbox audit events for some users won't be found in audit log searches when the organization uses any of the following methods:

 -  the Microsoft Purview compliance portal
 -  the Search-UnifiedAuditLog cmdlet
 -  the Office 365 Management Activity API.

Why? Because mailbox audit events are returned only for users with E5 licenses when you use one of the previous methods to search the unified audit log.

To retrieve mailbox audit log records for non-E5 users, you can complete one of the following workarounds:

 -  Manually enable mailbox auditing on individual mailboxes. To do so, run the following command in Exchange Online PowerShell:
    
    ```powershell
    Set-Mailbox -Identity <MailboxIdentity> -AuditEnabled $true
    ```
    
    After you run this command, search for mailbox audit activities by using the Microsoft Purview compliance portal, the **Search-UnifiedAuditLog** cmdlet, or the Office 365 Management Activity API.
    
    > [!TIP]
    > If mailbox auditing already appears to be enabled on the mailbox, but your searches return no results, change the value of the **AuditEnabled** parameter to **$false** and then back to **$true**.
 -  Use the following cmdlets in Exchange Online PowerShell:
    
    
     -  [Search-MailboxAuditLog](/powershell/module/exchange/search-mailboxauditlog?azure-portal=true) to search the mailbox audit log for specific users.
     -  [New-MailboxAuditLogSearch](/powershell/module/exchange/new-mailboxauditlogsearch?azure-portal=true) to search the mailbox audit log for specific users and send the results through email to specified recipients.

### Issue: Search for mailbox activities performed in a specific mailbox (including shared mailboxes)

When you use the **Users** dropdown list in the audit log search tool in the Microsoft Purview compliance portal or the **Search-UnifiedAuditLog -UserIds** command in Exchange Online PowerShell, you can search for activities performed by a specific user.

For mailbox audit activities, this type of search searches for activities performed by the specified user. However, it doesn't guarantee that all activities performed in the same mailbox are returned in the search results.

For example, an audit log search won't return audit records for activities performed by a delegate user. Why? Because searching for mailbox activities performed by a specific user won't return activities performed by a delegate user who's been assigned permissions to access another user's mailbox.

> [!NOTE]
> A delegate user is someone who's been assigned the **SendAs**, **SendOnBehalf**, or **FullAccess** mailbox permission to another user's mailbox.

Also, using the **User** dropdown list in the audit log search tool or the **Search-UnifiedAuditLog -UserIds** won't return results for activities that were completed in a shared mailbox.

To search for the activities performed in a specific mailbox or to search for activities performed in a shared mailbox, use the following syntax when running the Search-UnifiedAuditLog cmdlet:

```powershell
Search-UnifiedAuditLog -StartDate <date> -EndDate <date> -FreeText (Get-Mailbox <mailbox identity).ExchangeGuid
```

For example, the following command returns audit records for activities performed in the Contoso Compliance Team shared mailbox between August 2020 and October 2020:

```powershell
Search-UnifiedAuditLog -StartDate 08/01/2020 -EndDate 10/31/2020 -FreeText (Get-Mailbox complianceteam@contoso.onmicrosoft.com).ExchangeGuid
```

Alternatively, you can use the **Search-MailboxAuditLog** cmdlet to search for the audit records of activities performed in a specific mailbox. This process includes searching for activities performed in a shared mailbox.

The following example returns mailbox audit log records for activities performed in the Contoso Compliance Team shared mailbox:

```powershell
Search-MailboxAuditLog -Identity complianceteam@contoso.onmicrosoft.com -StartDate 08/01/2020 -EndDate 10/31/2020 -ShowDetails
```

The following example returns mailbox audit log records for activities performed in the specified mailbox by delegate users:

```powershell
Search-MailboxAuditLog -Identity <mailbox identity> -StartDate <date> -EndDate <date> -LogonTypes Delegate -ShowDetails
```

You can also use the **New-MailboxAuditLogSearch** cmdlet to search the audit log for a specific mailbox and send the results through email to specified recipients.

## Knowledge check

Choose the best response for the following question. Then select “Check your answers.”
