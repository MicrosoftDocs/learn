Navigating the complexities of information lifecycle management is critical for maintaining compliance and ensuring operational efficiency. With Microsoft Purview, organizations can effectively manage this lifecycle through the declaration of records and comprehensive disposition reviews.

## Declaring items as records

Declaring items as records involves assigning specific retention labels, categorizing content as either **records** or **regulatory records** based on the needed level of control and permanence. While standard retention labels manage retention timelines and actions, they don't classify content as records. However, labels that identify content as records or regulatory records enforce stricter rules to ensure compliance and safeguard the integrity of the information.

Use the table to understand the actions allowed or blocked depending on the type of retention label applied:

|Action |Retention label |Record - locked | Record - unlocked | Regulatory record |
|:-----|:-----|:-----|:-----|:-----|
|Edit contents|Allowed | **Blocked** | Allowed | **Blocked**|
|Edit properties, including rename|Allowed |Allowed <sup>1</sup> | Allowed | **Blocked**|
|Delete|Allowed <sup>2</sup> |**Blocked** |**Blocked**| **Blocked**|
|Copy|Allowed |Allowed | Allowed| Allowed|
|Move within container <sup>3</sup>|Allowed |Allowed | Allowed| Allowed|
|Move across containers <sup>3</sup>|Allowed |Allowed if never unlocked | **Blocked** | **Blocked**|
|Open/Read|Allowed |Allowed | Allowed| Allowed|
|Change label|Allowed |Allowed - container admin only | **Blocked**| **Blocked** |
|Remove label|Allowed |Allowed - container admin only | **Blocked**| **Blocked** |

<sup>1</sup> Editing properties for a locked record is allowed by default but can be blocked by a tenant setting.

<sup>2</sup> Deleting labeled items can be blocked as a tenant setting.

<sup>3</sup> Containers include locations like SharePoint sites and Exchange mailboxes.

### Editing and deleting configurations

- The ability to edit properties of a locked record is controlled through a tenant setting in the Microsoft Purview portals. This setting, when turned off, restricts property modifications, aligning with stricter record management protocols.
- Similarly, the ability to delete items with a retention label in SharePoint and OneDrive can be controlled through tenant settings, providing administrators the flexibility to prevent the deletion of important documents.

### Implications

These restrictions ensure that records and regulatory records are preserved in an unaltered state to meet compliance requirements. For example, if a retention label marking an item as a record is applied, the item can't be deleted or its content edited, securing the record against unauthorized changes.

## Configure retention labels to declare records

To enable the option to mark content as a regulatory record in the retention label wizard, run the PowerShell command below. This action is auditable and will be logged as Enabled regulatory record option for retention labels in the audit log.

1. [Connect to the Office 365 Security & Compliance PowerShell](/powershell/exchange/connect-to-scc-powershell?azure-portal=true).
1. Execute the command:

   ```powershell
   Set-RegulatoryComplianceUI -Enabled $true
   ```

This setting is applied immediately without confirmation.

When you create a retention label from the **Records Management** solution in the Microsoft Purview portal or the Microsoft Purview compliance portal, you have the option to mark items as a record or a regulatory record, as long as you ran the PowerShell `Set-RegulatoryComplianceUI` command.

   :::image type="content" source="../media/declare-records.png" alt-text="Screenshot showing how to create a retention label for a record or regulatory record.":::

Using this retention label, you can now apply it to SharePoint or OneDrive documents and Exchange emails, as needed.

## Apply the configured retention label to content

Users can apply retention labels marking items as records or regulatory records:

- In Exchange, any user with write access to the mailbox.
- In SharePoint and OneDrive, any user in the default Members group with Contribute permission level.

   :::image type="content" source="../media/retention-label-record.png" alt-text="Screenshot showing how to create a retention label for a record or regulatory record." lightbox ="../media/retention-label-record.png":::

Declaring content as records helps in enforcing legal holds and ensuring that critical information is preserved according to legal and organizational standards. It also aids in automating the retention and deletion processes, reducing the risk of human error.
