The following example shows how to create mail flow rules to apply custom templates to email messages sent from your organization. Such a rule will apply custom branding, for example to senders from a specific department or members of a specific distribution group. You can also configure all mails from inside an organization to be encrypted when sent.

In the following example, you will configure a mail flow rule that encrypts all mails sent to the external partner organization Fabrikam, Inc., with the domain "fabrikam.com".

Perform the following steps to create a mail flow rule in the Exchange Admin Center (EAC):

1. In a web browser, navigate to the Exchange admin center at [https://outlook.office365.com/ecp/](https://outlook.office365.com/ecp/?azure-portal=true).

1. Sign in using a work or school account that has been granted Exchange administrator permissions.

1. In the EAC, go to **Mail flow** > **Rules** and select **New ** > **Apply Office 365 Message Encryption and rights protection to messages…**

1. Enter the following information:

   1. In **Name**, type a name for the rule, such as **Encrypt all mails to Fabrikam**.

   1. In **Apply this rule if…**, select the condition **The recipient address includes…**, and **any of these words**.

   1. Enter **fabrikam.com** and select the **plus (+)** sign and **Ok**.

   1. From **Do the following…**, select the **Select one…** text and from the **RMS template** list, **Encrypt**.

   1. Select **Save.**

The list of templates includes default templates and options and any custom templates you create. If the list is empty, ensure that you have set up Office 365 Message Encryption with the new capabilities and IRM is activated for your tenant.

You can also perform this operation with Exchange Online PowerShell. If you use PowerShell you would not be using the RMS template named "Encrypt", but the OME Configuration name you want to configure instead. Use the following cmdlet to create a new mail flow rule to encrypt all messages sent to fabrikam.com:

New-TransportRule -Name "Encrypt all mails to Fabrikam" -FromScope InOrganization -RecipientDomainIs "adatum.com" -ApplyRightsProtectionCustomizationTemplate "OME Configuration"

