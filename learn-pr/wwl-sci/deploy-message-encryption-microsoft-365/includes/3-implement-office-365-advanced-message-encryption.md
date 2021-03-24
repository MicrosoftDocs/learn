Office 365 Advanced Message Encryption allows you to use multiple templates for email messages and configure an expiration time for protected messages.

Use templates to fulfill several use cases, such as:

- Individual department templates, such as Finance, Sales, and so on.

- Templates for different geographical regions or countries

- If you want to allow emails to be revoked

- If you want emails sent to external recipients to expire after a specified number of days.

Once you've created the templates, you can apply them to encrypted emails by using Exchange mail flow rules. If you have Office 365 Advanced Message Encryption, you can revoke any email that you've branded by using these templates.

To create and remove new templates, the PowerShell cmdlets **New-OMEConfiguration** and **Remove-OMEConfiguration** are to be used.

## Expiration date for email encrypted

You can use message expiration on emails that your users send to external recipients that use the OME portal to access encrypted emails. You can force recipients to use the OME portal to view and reply to encrypted emails sent from your organization by using a custom branded template that specifies an expiration date in Windows PowerShell.

> [!NOTE]
> You can only set expiration dates for emails to external recipients.

With Office 365 Advanced Message Encryption, anytime you apply custom branding, Office 365 applies the wrapper to email that fits the mail flow rule to which you have applied the template. In addition, you can only use expiration rules if you use custom branding.

Run the **New-OMEConfiguration** cmdlet, to create a new branding template with an expiration date of seven days:

```powershell
    New-OMEConfiguration -Identity "Expire in seven days" -ExternalMailExpiryInDays 7

```

ExternalMailExpiryInDays identifies the number of days that recipients can keep mail before it expires. You can use any value between 1–730 days.