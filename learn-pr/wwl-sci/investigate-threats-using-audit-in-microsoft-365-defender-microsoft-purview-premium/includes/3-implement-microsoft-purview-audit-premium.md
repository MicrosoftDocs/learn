
If an organization has a subscription and end-user licensing that supports Audit (Premium), it should perform the following steps to set up and use the Audit (Premium) capabilities.

:::image type="content" source="../media/advanced-audit-workflow-5ee0c15a.png" alt-text="Diagram showing the workflow to set up Microsoft Purview Audit Premium.":::

### Step 1: Set up Audit (Premium) for users

Audit (Premium) features require an appropriate E5 license assigned to users. The Advanced Auditing app/service plan must also be enabled for those users. To verify that the Advanced Auditing app is assigned to users, perform the following steps for each user:

1. In the **Microsoft 365 admin center** ([Microsoft 365 admin center portal](https://admin.microsoft.com/)), select **Users** on the navigation pane, and then select **Active users**.
1. On the **Active users** page, select a user.
1. On the user properties flyout page that appears, select the **Licenses and apps** tab.
1. In the **Licenses** section, verify the user is assigned an E5 license or is assigned an appropriate add-on license. For a list of licenses that support Audit (Premium), see [Audit (Premium) licensing requirements](/microsoft-365/compliance/auditing-solutions-overview?azure-portal=true).
1. Expand the **Apps** section. Verify the **Microsoft 365 Advanced Auditing** check box is selected. Select the check box if it isn't selected, and then select **Save changes**.

The logging of audit records for the **MailItemsAccessed** and **Send** events begin within 24 hours. An organization must perform Step 4 to start logging two other Audit (Premium) events:

- SearchQueryInitiatedExchange
- SearchQueryInitiatedSharePoint

Also, if you've customized the mailbox actions that are audited on user mailboxes or shared mailboxes, any new Audit (Premium) events released by Microsoft won't be automatically audited on those mailboxes.

**Additional reading**. For information about changing the mailbox actions that are audited for each sign-in type, see the "Change or restore mailbox actions logged by default" section in [Manage mailbox auditing](/microsoft-365/compliance/enable-mailbox-auditing?azure-portal=true).

### Step 2: Enable Audit (Premium) events

You must enable the following Audit (Premium) events to be logged so that users can perform searches in Exchange Online and SharePoint Online:

- SearchQueryInitiatedExchange
- SearchQueryInitiatedSharePoint

To enable these two events to be audited for users, run the following command (for each user) in Exchange Online PowerShell:

```powershell
Set-Mailbox <user> -AuditOwner @{Add="SearchQueryInitiated"}
```

In a multi-geo environment, you must run the previous **Set-Mailbox** command in the forest where the user's mailbox is located.

To identify the user's mailbox location, run the following command:

```powershell
Get-Mailbox <user identity> | FL MailboxLocations
```

If the command to enable the auditing of search queries was previously run in a forest that's different than the one the user's mailbox is located in, then you must remove the SearchQueryInitiated value from the user's mailbox by running the following command:

```powershell
Set-Mailbox -AuditOwner @{Remove="SearchQueryInitiated"}
```

You must then add the **SearchQueryInitiated** value to the user's mailbox in the forest where the user's mailbox is located.

### Step 3: Set up audit retention policies

The default retention policy in Audit (Premium) retains Exchange, SharePoint, and Microsoft Entra audit records for one year. An organization can create other audit log retention policies to meet the requirements of its security operations, IT, and compliance teams.

For more information, see the next unit on how to "Manage audit log retention policies."

### Step 4: Search for Audit (Premium) events

Now that you have Audit (Premium) set up for your organization, you can search for crucial Audit (Premium) events and other activities when conducting forensic investigations. After completing Steps 1 and 2, you can search the audit log for Audit (Premium) events and other activities during forensic investigations of compromised accounts and other types of security or compliance investigations.

For more information about conducting a forensics investigation of compromised user accounts by using the MailItemsAccessed Audit (Premium) event, see the final unit in this module on how to "Investigate compromised accounts."
