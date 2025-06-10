Some content needs more control than standard retention settings provide. Declaring content as a **record** or **regulatory record** adds restrictions that help your organization meet legal and regulatory requirements. Microsoft Purview lets you apply these classifications using retention labels.

## What happens when content is declared as a record

When a retention label marks content as a record, it applies restrictions based on the level of control required. Standard retention labels manage how long to keep content and what happens when that time ends, but they don't restrict user actions. Record labels do.

There are two types of record labels:

- **Record**: Applies restrictions like preventing deletion, with optional locking.
- **Regulatory record**: Applies the strictest controls and can't be unlocked.

The table below shows what users can and can't do based on the label type:

| Action  | Retention label | Record - locked | Record - unlocked | Regulatory record |
|-----|-----|-----|-----|-----|
| Edit contents | Allowed | **Blocked** | Allowed | **Blocked** |
| Edit properties  | Allowed | Allowed<sup>1</sup> | Allowed | **Blocked** |
| Delete | Allowed<sup>2</sup> | **Blocked** | **Blocked** | **Blocked** |
| Copy | Allowed             | Allowed  | Allowed | Allowed |
| Move within container<sup>3</sup>  | Allowed | Allowed| Allowed | Allowed |
| Move across containers<sup>3</sup> | Allowed | Allowed if never unlocked | **Blocked** | **Blocked** |
| Open/Read | Allowed | Allowed | Allowed | Allowed |
| Change label | Allowed | Container admin only | **Blocked** | **Blocked** |
| Remove label | Allowed | Container admin only | **Blocked** | **Blocked** |

<sup>1</sup> Editing properties for a locked record is allowed by default, but this setting can be disabled. <sup>2</sup> Deletion can be blocked at the tenant level. <sup>3</sup> Containers include SharePoint sites and Exchange mailboxes.

### Edit record properties

By default, users can still edit metadata on locked records. If you want to prevent this, you can change the tenant setting:

1. In the Microsoft Purview portal, go to **Settings** > **Records Management** > **Retention Labels**.
1. Turn off the setting for **Allow users to edit record properties**.

## Configure retention labels to declare records

To create a retention label that marks content as a regulatory record, you'll need to turn on the option in PowerShell first:

1. [Connect to the Microsoft Purview PowerShell module](/powershell/exchange/connect-to-scc-powershell?azure-portal=true).
1. Run the following command:

   ```powershell
   Set-RegulatoryComplianceUI -Enabled $true
   ```

This setting is applied immediately and is logged in the audit log.

After enabling this setting, you can create a label in **Records Management** that marks content as either a **record** or **regulatory record**. These labels appear only in Records Management if they're configured to declare records.

:::image type="content" source="../media/declare-record/declare-records.png" alt-text="Screenshot showing how to create a retention label for a record or regulatory record." lightbox="../media/declare-record/declare-records.png":::

Once created, these labels can be published or auto-applied to content in Exchange, SharePoint, or OneDrive.

## Apply a record label to content

Users can apply record labels directly if they have permission to do so:

- In Exchange: any user with write access to the mailbox.
- In SharePoint and OneDrive: any user in the **Members** group with **Contribute** permissions.

  :::image type="content" source="../media/declare-record/retention-label-record.png" alt-text="Screenshot showing where to mark an item as a record in SharePoint and OneDrive." lightbox="../media/declare-record/retention-label-record.png":::

Applying record labels helps preserve important content and ensures that deletion controls follow organizational and regulatory policies. These settings reduce the risk of accidental changes and help maintain data integrity over time.
