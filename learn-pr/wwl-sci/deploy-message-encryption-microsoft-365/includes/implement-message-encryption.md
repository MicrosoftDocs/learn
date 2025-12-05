Before you can encrypt email messages in Microsoft 365, you need to make sure the underlying encryption service is active and available in your tenant. Microsoft Purview Message Encryption relies on Azure Rights Management (Azure RMS) to protect messages as they travel inside and outside the organization.

Once encryption is available, you can create templates that define how messages are protected, test encryption behavior, and apply those settings through mail flow rules.

## Verify Azure Rights Management is active

Microsoft Purview Message Encryption uses Azure Rights Management to apply encryption and access controls to email. In most Microsoft 365 tenants with supported licenses, Azure RMS is enabled by default. If it's active, no extra setup is required.

To confirm that Azure RMS is active in your environment, you can use PowerShell:

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell?azure-portal=true)
1. Run the following command to verify that Azure RMS licensing is enabled:

   ```powershell
   Get-IRMConfiguration
   ```

   Check that the `AzureRMSLicensingEnabled` value is set to `True`.

1. Then run a test to verify encryption is working:

   ```powershell
   Test-IRMConfiguration -Sender user@contoso.com -Recipient user@contoso.com
   ```

   You should see confirmation that RMS templates are available and that encryption and decryption were successful.

If encryption isn't working or RMS templates aren't available, follow the [Azure RMS activation guidance](/azure/information-protection/activate-service?azure-portal=true).

> [!NOTE]
> If your organization still uses Active Directory Rights Management Services (AD RMS), you need to migrate to Azure RMS before enabling message encryption.

## Create and configure encryption templates

Templates define how email messages should be protected when encryption is applied. Microsoft 365 includes default templates like **Do Not Forward** and **Encrypt-Only**, and you can create custom templates using PowerShell if needed.

To view available templates:

```powershell
Get-RMSTemplate
```

These templates can be used in mail flow rules or other enforcement policies to automatically apply encryption to messages that meet specific criteria. For example, you might create a rule that applies the Encrypt-Only template to messages with certain keywords or to external recipients. You'll later apply these templates using mail flow rules.

## Validate user experience

After encryption is enabled and templates are in place, it's a good idea to run some tests. Check how messages appear for different types of recipients to ensure the experience is consistent. Try sending test messages to:

- Internal users in Outlook for desktop or web
- External users with Gmail or Yahoo
- Mobile users on iOS or Android

Make sure recipients can access the message, and verify whether they're seeing the native Outlook experience or the secure message portal. Testing this early helps avoid confusion during rollout.
