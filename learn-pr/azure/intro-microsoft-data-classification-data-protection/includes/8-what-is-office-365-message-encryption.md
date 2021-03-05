You’re aware that Contoso employees often use email to exchange sensitive information, such as financial data, legal contracts, confidential product information, sales reports and projections, or customer and employee information. As a result, mailboxes can become repositories for large amounts of potentially sensitive information and information leakage can become a serious threat to your organization. In this unit, you’ll learn how Office 365 Message Encryption can help mitigate such issues.

## Office 365 Message Encryption overview

With Office 365 Message Encryption (OME), your organization can send and receive encrypted email messages between people inside and outside your organization. Office 365 Message Encryption works with Outlook.com, Yahoo!, Gmail, and other email services. Email message encryption helps ensure that only intended recipients can observe message content.

Office 365 Message Encryption is an online service that's built on Microsoft Azure Rights Management (Azure RMS) which is part of Azure Information Protection. This includes encryption, identity, and authorization policies to help secure your email. You can encrypt messages by using rights management templates, the Do Not Forward option, and the encrypt-only option.

Users can then encrypt email messages and various attachments by using these options.

As an administrator, you can also define mail flow rules to apply this protection. For example, you can create a rule that requires the encryption of all messages addressed to a specific recipient or that contains specific words in the subject line. You can specify that recipients can't copy or print the contents of the message.

Unlike the previous version of OME, the new capabilities provide a unified sender experience whether you're sending mail inside your organization or to recipients outside of Microsoft 365. Also, recipients who receive a protected email message sent to a Microsoft 365 account in Outlook 2016 and newer, or Outlook on the web, don't have to take any other action to observe the message. It works seamlessly. Recipients using other email clients and email service providers also have an improved experience.

## How Office 365 Message Encryption works

When someone sends an email message that matches an encryption mail flow rule, the message is encrypted before it's sent. All Microsoft 365 end users that use Outlook clients to read mail receive native, first-class reading experiences for encrypted and rights-protected mail even if they're not in the same organization as the sender. Supported Outlook clients include Outlook desktop, Outlook Mac, Outlook mobile on iOS and Android, and Outlook on the web (formerly known as Outlook Web App).

Recipients of encrypted messages who receive encrypted or rights-protected mail sent to their Outlook.com, Gmail, and Yahoo! accounts receive a wrapper mail that directs them to the OME portal where they can easily authenticate using a Microsoft account, Gmail, or Yahoo! credentials.

:::image type="content" source="../media/8-One-Time-Passcode.png" alt-text="Screenshot of wrapper mail for recipient of encrypted message.":::

End users that read encrypted or rights-protected mail on clients other than Outlook also use the OME portal to observe encrypted and rights-protected messages that they receive.

If the sender of the protected mail is in the Government Community Cloud (GCC) High environment and the recipient is outside of GCC High, including commercial users, Outlook.com users, and users of other email providers such as Gmail, the recipient receives a wrapper mail. The wrapper mail directs the recipient to the OME portal where the recipient can read and reply to the message. Otherwise, if the sender and recipient are both in the GCC High environment, even if they're not in the same organization, then recipients that use Outlook clients to read mail receive native, first-class reading experiences for encrypted and rights-protected mail.
