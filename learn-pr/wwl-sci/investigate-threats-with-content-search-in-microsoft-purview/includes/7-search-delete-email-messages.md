An organization can use the Content search feature to search for and delete email messages from all mailboxes in its Exchange deployment. This process can help you find and remove potentially harmful or high-risk email, such as:

 -  Messages that contain dangerous attachments or viruses.
 -  Phishing messages.
 -  Messages that contain sensitive data.

> [!WARNING]
> If an organization has a Defender for Office 365 Plan 2 subscription, it should use the procedure detailed in [Remediate malicious email delivered in Office 365](/microsoft-365/security/office-365-security/remediate-malicious-email-delivered-office-365?azure-portal=true), rather than following the procedure described in this unit.

### Prerequisites to deleting email messages

 -  The search and purge workflow described in this unit doesn't delete chat messages or other content from Microsoft Teams. If the Content search that you create in Step 2 returns items from Microsoft Teams, those items won't be deleted when you purge items in Step 3. To search for and delete chat messages, see [Search and purge chat messages in Teams](/microsoft-365/compliance/search-and-delete-teams-chat-messages?azure-portal=true).
 -  To create and run a Content search, you must be a member of the **eDiscovery Manager** role group or be assigned the **Compliance Search** role in the Microsoft Purview compliance portal.
    
    To delete messages, you have to be a member of the **Organization Management** role group or be assigned the **Search And Purge** role in the Microsoft Purview compliance portal. For information about adding users to a role group, see [Assign eDiscovery permissions](/microsoft-365/compliance/assign-ediscovery-permissions?azure-portal=true).
    
    > [!NOTE]
    > The **Organization Management** role group exists in both Exchange Online and in the Microsoft Purview compliance portal. The **Organization Management** role group is different from the **Search And Purge** role. Being a member of **Organization Management** in Exchange Online doesn't grant the required permissions to delete email messages. If you aren't assigned the **Search And Purge** role in the Microsoft Purview compliance portal (either directly or through a role group such as **Organization Management**), you'll receive an error in Step 3 when you run the **New-ComplianceSearchAction** cmdlet. The message will say: **A parameter cannot be found that matches parameter name 'Purge'**.
 -  A maximum of 10 items per mailbox can be removed at one time. Because the capability to search for and remove messages is intended to be an incident-response tool, this limit helps ensure that messages are quickly removed from mailboxes. This feature isn't intended to clean up user mailboxes.
 -  50,000 is the maximum number of mailboxes in a content search that you can use to delete items by doing a search and purge action. If the search created in Step 2 searches more than 50,000 mailboxes, the purge action (that you create in Step 3) will fail. Searching more than 50,000 mailboxes in a single search may typically happen when you configure the search to include all mailboxes in an organization. This restriction still applies even when less than 50,000 mailboxes contain items that match the search query. See the final section in this unit for guidance about using search permissions filters to search for and purge items from more than 50,000 mailboxes.
 -  The procedure in this unit can only be used to delete items in Exchange Online mailboxes and public folders. You can't use it to delete content from SharePoint or OneDrive for Business sites.
 -  Email items in a review set in an eDiscovery (Premium) case can't be deleted by using the procedures in this unit. Why? Because items in a review set are stored in an Azure Storage location, and not in the live service. As a result, they won't be returned by the content search that you create in Step 1. To delete items in a review set, you must delete the eDiscovery (Premium) case that contains the review set. For more information, see [Close or delete an eDiscovery (Premium) case](/microsoft-365/compliance/close-or-delete-case?azure-portal=true).

### Step 1: Load and connect to the Exchange Online PowerShell module

To connect to Security and Compliance PowerShell you'll need to install (If not done already) and load or import the Exchange Online Management PowerShell module.

```powershell
Install-module -Name ExchangeOnlineManagement
Import-Module -Name ExchangeOnlineManagement
```

### Step 2: Connect to the Security and Compliance PowerShell module

Organizations must use the **Security and Compliance PowerShell** module to delete messages. Therefore, the first step for an organization is to connect to the Security and Compliance PowerShell module. For more information on connecting to this module, see [Connect to Security &amp; Compliance PowerShell](/powershell/exchange/connect-to-scc-powershell?azure-portal=true).

```powershell
Connect-IPPSSession
```

> [!NOTE]
> The Connect-IPPSSession (Function) from the ExchangeOnlineManagement PowerShell module does not currently work in Cloud Shell environments.

### Step 3: Create a Content Search to find the message to delete

The second step is to create and run a Content search to find the message that you want to remove from mailboxes in your organization. You can create the search by using the Microsoft Purview compliance portal or by running the **New-ComplianceSearch and Start-ComplianceSearch** cmdlets in Security and Compliance PowerShell module.

The messages that match the query for this search will be deleted by running the **New-ComplianceSearchAction -Purge** command in Step 3.

> [!NOTE]
> The content locations that are searched in the Content search that you create in this step can't include SharePoint or OneDrive for Business sites. You can include only mailboxes and public folders in a Content search that will be used to email messages. If the Content search includes sites, you'll receive an error in Step 3 when you run the **New-ComplianceSearchAction** cmdlet.

#### Tips for finding messages to remove

The goal of the search query is to narrow the results of the search to only the message or messages that you want to remove. Here are some tips:

 -  If you know the exact text or phrase used in the subject line of the message, use the Subject property in the search query.
 -  If you know that exact date (or date range) of the message, include the Received property in the search query.
 -  If you know who sent the message, include the From property in the search query.
 -  Preview the search results to verify that the search returned only the message (or messages) that you want to delete.
 -  Use the search estimate statistics (displayed in the details pane of the search in the compliance portal or by using the **Get-ComplianceSearch** cmdlet) to get a count of the total number of results.

Here are two examples of queries to find suspicious email messages.

 -  This query returns messages that were received by users between April 13, 2017 and April 14, 2017 and that contains the words "action" and "required" in the subject line.
    
    ```powershell
    (Received:4/13/2017..4/14/2017) AND (Subject:'Action required')
    ```
 -  This query returns messages that were sent by chatsuwloginsset12345@outlook.com and that contain the exact phrase "Update your account information" in the subject line.
    
    ```powershell
    (From:chatsuwloginsset12345@outlook.com) AND (Subject:"Update your account information")
    ```

Here's an example of using a query to create and start a search by running the New-ComplianceSearch and Start-ComplianceSearch cmdlets to search all mailboxes in the organization:

```powershell
$Search=New-ComplianceSearch -Name "Remove Phishing Message" -ExchangeLocation All -ContentMatchQuery '(Received:4/13/2017..4/14/2017) AND (Subject:"Action required")'
Start-ComplianceSearch -Identity $Search.Identity
```

### Step 3: Delete the message

Up to this point, you've created and refined a Content search to return the messages that you want to remove. You're now ready to delete the selected messages. In this step, you'll run the **`New-ComplianceSearchAction -Purge`** command in Security and Compliance PowerShell module to delete the message.

You can soft-delete or hard-delete the message.

 -  **Soft-deleted message**. This message is moved to a user's Recoverable Items folder. It's retained there until the deleted item retention period expires.
 -  **Hard-deleted message**. This message is marked for permanent removal from the mailbox. It will be permanently removed the next time the mailbox is processed by the Managed Folder Assistant. Keep in mind the following situations:
     -  **Single item recovery is enabled for the mailbox**. In this case, hard-deleted items will be permanently removed after the deleted item retention period expires.
     -  **A mailbox is placed on hold**. In this case, deleted messages are preserved until the hold duration for the item expires, or until the hold is removed from the mailbox.

> [!NOTE]
> As previously stated, items from Microsoft Teams that are returned by Content search aren't deleted when you run the the New-ComplianceSearchAction -Purge command.

To run the following commands to delete messages, be sure that you're connected to Security and Compliance PowerShell module.

#### Soft-delete messages

In the following example, the command soft-deletes the search results returned by a Content search named "Remove Phishing Message".

```powershell
New-ComplianceSearchAction -SearchName "Remove Phishing Message" -Purge -PurgeType SoftDelete
```

#### Hard-delete messages

To hard-delete the items returned by the "Remove Phishing Message" content search, you would run this command:

```powershell
New-ComplianceSearchAction -SearchName "Remove Phishing Message" -Purge -PurgeType HardDelete
```

When you run the previous commands to soft-delete or hard-delete messages, the search specified by the *SearchName* parameter is the Content search that you created in Step 1.

### Common questions related to message deletion

 -  **How do you determine the status of the search and remove operation?**
    
    Run the **Get-ComplianceSearchAction** command to get the status on the delete operation. The object that is created when you run the **New-ComplianceSearchAction** cmdlet is named using this format: **&lt;name of Content Search&gt;\_Purge.**
 -  **What happens after you hard-delete a message?**
    
    A message that's hard-deleted with the **`New-ComplianceSearchAction -Purge -PurgeType HardDelete`** command is moved to the **Purges** folder. The message can't be accessed by the user.
    
    After the message is moved to the Purges folder, the message is retained during the deleted item retention period if single item recovery is enabled for the mailbox. (In Microsoft 365, single item recovery is enabled by default when a new mailbox is created.) After the deleted item retention period expires, the message is marked for permanent deletion. It will be purged from Microsoft 365 the next time the mailbox is processed by the Managed Folder assistant.
 -  **What happens after you soft-delete a message?**
    
    A message that's soft-deleted with the **`New-ComplianceSearchAction -Purge -PurgeType SoftDelete`** command is moved to the **Deletions** folder in the user's Recoverable Items folder. It isn't immediately purged from Microsoft 365.
    
    The user can recover messages in the Deleted Items folder during the deleted item retention period configured for the mailbox. After this retention period expires (or if a user purges the message before it expires), the message is moved to the Purges folder. From there, it can no longer be accessed by the user. Once in the Purges folder, the message is retained during the deleted item retention period configured for the mailbox if single items recovery is enabled for the mailbox. (In Microsoft 365, single item recovery is enabled by default when a new mailbox is created.) After the deleted item retention period expires, the message is marked for permanent deletion. It will be purged from Microsoft 365 the next time that the mailbox is processed by the Managed Folder assistant.
 -  **What if you have to delete a message from more than 50,000 mailboxes?**
    
    As previously stated, you can perform a search and purge operation on a maximum of 50,000 mailboxes (even if less than 50,000 contain items that match the search query). If you have to do a search and purge operation on more than 50,000 mailboxes, consider creating temporary search permissions filters that reduce the number of mailboxes that would be searched to less than 50,000 mailboxes.
    
    For example, if your organization contains mailboxes in different departments, states, or countries, you can create a mailbox search permissions filter based on one of those mailbox properties to search a subset of mailboxes in your organization. After you create the search permissions filter, you create the search, and then delete the message. Then you can edit the filter to search for and purge messages in a different set of mailboxes. For more information about creating search permissions filters, see [Configure permissions filtering for Content Search](/microsoft-365/compliance/permissions-filtering-for-content-search?azure-portal=true).
 -  **Will unindexed items included in the search results be deleted?**
    
    No, the **`New-ComplianceSearchAction -Purge`** command doesn't delete unindexed items.
 -  **What happens if a message is deleted from a mailbox that's been placed on In-Place Hold or Litigation Hold or that's been assigned to a Microsoft 365 retention policy?**
    
    After the message is purged and moved to the Purges folder, the message is retained until the hold duration expires. If the hold duration is unlimited, then items are retained until the hold is removed or the hold duration is changed.
 -  **Why is the search and remove workflow divided among different security and compliance portal role groups?**
    
    A person has to be a member of the **eDiscovery Manager** role group or be assigned the **Compliance Search management** role to search mailboxes. To delete messages, a person has to be a member of the **Organization Management** role group or be assigned the **Search And Purge** management role. This design makes it possible to control who can search mailboxes in the organization and who can delete messages.
