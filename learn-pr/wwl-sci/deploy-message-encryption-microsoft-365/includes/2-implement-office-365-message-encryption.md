Once you have implemented your tenant encryption strategy, Office 365 Message Encryption can be implemented. To provide the best user experience, administrators should review their tenant settings for information rights management (IRM) features and OME settings before activating the encryption system for all users.

## Verify information rights management functionality

Any Microsoft 365 tenant should be activated to use Azure RMS and IRM capabilities by default. To determine, if Azure RMS was deactivated for your tenant, run the following PowerShell cmdlets:

1. Run the following cmdlet to validate IRM configuration of a tenant:

    ```powershell
    Get-IRMConfiguration | fl AzureRMSLicensingEnabled

    ```

1. If the AzureRMSLicensingEnabled parameter is set to $False, activate OME for your tenant by using the following cmdlet:

    ```powershell
    Set-IRMConfiguration -AzureRMSLicensingEnabled:$True

    ```

1. Now run the following cmdlet with a sender inside your organization, to check if IRM data can be obtained for this recipient:

   ```powershell
    Test-IRMConfiguration -Sender admin@contoso.com

    ```

1. The output of the cmdlet will display the results of several tests performed and an overall test result, which should be PASS.

> [!NOTE]
> The above cmdlets require a connection with the Exchange Online PowerShell and Exchange administrator permissions to change tenant-wide settings.

If any of the tests fail, you may not fetch the RMS templates for a recipient or there may be issues with the utilized encryption keys.

The *-IRMConfiguration and *-OmeConfiguration cmdlets allow you to configure how RMS content is used in a tenant and which key endpoints are in use. Administrators should become familiar with the available settings from these cmdlets.

## Implement custom OME Settings

OME is managed via configuration objects, or more precisely templates, which can be assigned and referenced. The default template for all users is named "OME Configuration" and any setting done in this configuration, is applied to all users. While the basic Office 365 Message Encryption allows only a single template, Office 365 Advanced Message Encryption provides more flexibility with multiple branding templates for different purposes.

The following examples provide a general description of which settings are available with the *-OMEConfiguration cmdlets and which settings should be configured when implementing OME for the first time. The first default template with the name "OME Configuration" is the default OME settings object for all users in a tenant.

> [!NOTE]
> If your tenant only includes Microsoft 365 E3 licenses, the number of cmdlets available is limited to managing the default OME template only. You cannot create new templates or add other Office 365 Advanced Message Encryption related settings.

| **To customize this feature of the encryption experience**| **Use these commands**|
| :--- | :--- |
| Control social IDs for sign in, such as Google account, a Yahoo account, or Microsoft accounts|    1. Set-OMEConfiguration -Identity "OME Configuration" -SocialIdSignIn $true|
| Activate one-time pass codes for recipients not using Outlook, to view protected content in the browser.| Set-OMEConfiguration -Identity "OME Configuration" -OTPEnabled $true|
| Hide the Encrypt button for all users in Outlook on the web.| Set-IRMConfiguration -SimplifiedClientAccessEnabled $false|
| Allow users to decrypt messages for legacy clients that do not support Azure RMS.| Set-ActiveSyncOrganizationSettings -AllowRMSSupportForUnenlightenedApps $true|
| Allow legacy web clients to download attachments decrypted.| Set-IRMConfiguration -DecryptAttachmentForEncryptOnly $true|

## OME branding templates

Customized company branding templates control the look of an organization's email messages and the encryption portal. The Get-OMEConfiguration and Set-OMEConfiguration Windows PowerShell cmdlets are used to modify the default template and to customize these parts of encrypted email messages:

- Introductory text

- Disclaimer text

- URL for Your organization's privacy statement

- Text in the OME portal

- Logo that appears in the email message and OME portal, or whether to use a logo at all

- Background color in the email message and OME portal

You can also revert to the default look and feel at any time.

> [!NOTE]
> Only Office 365 Advanced Message Encryption supports multiple templates, which will be covered in the next unit.

The following image provides an overview of the customizable areas of a branding template:

![Picture that shows which areas of the Office 365 OME portal can be edited.](../media/ome-branding-template.png)

Learn more about the PowerShell commands to modify these settings: [Modify and OME branding template](https://docs.microsoft.com/microsoft-365/compliance/add-your-organization-brand-to-encrypted-messages?view=o365-worldwide?azure-portal=true)

