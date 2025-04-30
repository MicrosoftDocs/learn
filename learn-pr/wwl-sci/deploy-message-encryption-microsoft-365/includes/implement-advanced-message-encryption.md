Microsoft Purview Advanced Message Encryption provides additional protection and control for email messages sent to external recipients. With this feature, your organization can automatically expire access to encrypted messages, revoke access after the message is sent, and monitor activity in the encrypted message portal. These capabilities are especially useful when handling sensitive information that needs time-based or situational access control.

These capabilities build on standard Microsoft Purview Message Encryption and require the use of custom branding templates applied through mail flow rules.

## Prerequisites

Your Microsoft 365 tenant must have a supported license to use Advanced Message Encryption. It's included with:

- Microsoft 365 E5
- Office 365 E5
- Office 365 Education A5

If your organization uses Microsoft 365 E3, you can add this capability through the Microsoft 365 E5 Compliance add-on or another eligible compliance SKU. For full details, see the [message policy and compliance service description](/office365/servicedescriptions/exchange-online-service-description/message-policy-and-compliance?azure-portal=true).

## Set expiration dates for encrypted emails

You can configure encrypted emails to expire after a specific number of days. This helps limit how long recipients can access the content.

1. Connect to [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell?azure-portal=true).
1. Run the following command to create a custom branding template that includes an expiration policy:

   ```powershell
   New-OMEConfiguration -Identity "Expire in 7 days" -ExternalMailExpiryInDays 7
   ```

   Replace `7` with the number of days that recipients can retain access (between 1 and 730).

> [!NOTE]
> Expiration settings only apply to external recipients who view the message through the encrypted message portal. To ensure this portal experience is used, apply a custom branding template through a mail flow rule.

## Revoke access to encrypted emails

You can revoke access to messages after they've been sent, as long as the recipient viewed the message through the encrypted message portal.

### Revoke as the sender

1. In Outlook on the web, go to your **Sent Items** folder.
1. Open the encrypted message.
1. If the message is eligible for revocation, you'll see a **Remove external access** option at the top of the message. Select it to revoke access.

### Revoke as an administrator

1. Identify the message ID using a message trace or encryption report in the Microsoft Purview portal.
1. Connect to Exchange Online PowerShell.
1. Run this command to revoke the message:

   ```powershell
   Set-OMEMessageRevocation -Revoke $true -MessageId "<messageId>"
   ```

1. To confirm revocation:

   ```powershell
   Get-OMEMessageStatus -MessageId "<messageId>" | ft Subject, Revoked
   ```

> [!NOTE]
> Revocation is only supported for messages accessed through the encrypted message portal.

## Monitor encrypted message activity

You can audit recipient interactions with encrypted messages using Microsoft Purview. This includes when the recipient signs in, reads the message, downloads attachments, or replies.

To enable and search for audit logs:

1. Connect to Exchange Online PowerShell.
1. Enable tracking logs for the encrypted message portal:

   ```powershell
   Set-IrmConfiguration -EnablePortalTrackingLogs $true
   ```

1. In the [Microsoft Purview portal](https://purview.microsoft.com?azure-portal=true), go to the **Audit** solution.
1. Under **Search**, select **Encrypted message portal activities**, apply filters, and run your search.

Microsoft Purview Advanced Message Encryption adds time-bound and post-send controls to standard encryption features. By setting expiration dates, revoking access, and auditing encrypted message activity, organizations can enforce tighter controls over sensitive communications while maintaining a seamless user experience for recipients.
