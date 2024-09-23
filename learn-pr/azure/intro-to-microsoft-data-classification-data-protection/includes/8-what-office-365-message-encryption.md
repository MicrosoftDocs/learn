Organizations often use email to exchange sensitive information, such as financial data, legal contracts, product information, sales reports, or customer and employee information. Mailboxes can be repositories for large amounts of potentially sensitive information, and information leakage can be a serious threat. In this unit, you learn how Microsoft Purview Message Encryption can help mitigate this threat.

## Message Encryption overview

Message Encryption is an online service that includes encryption, identity, and authorization policies to help secure your email. Message Encryption is an evolution of existing Information Rights Management (IRM) and legacy Office 365 Message Encryption (OME) solutions. Message Encryption combines email encryption and rights management capabilities powered by Azure Information Protection.

With Message Encryption, people within your organization can send and receive encrypted email messages with people inside and outside your organization. Email message encryption helps ensure that only intended recipients can observe message content. Message Encryption works with Outlook.com, Yahoo!, Gmail, and other email services. 

As an administrator, you can define mail flow rules to apply this protection. For example, you can create a rule that requires the encryption of all messages addressed to a specific recipient or that contains specific words in the subject line. You can specify that recipients can't copy or print the contents of encrypted messages. You can choose to encrypt messages by using rights management templates, the Do Not Forward option, or the encrypt-only option. Users can then encrypt email messages and various attachments by using these options.

Unlike legacy OME, Message Encryption capabilities provide a unified sender experience whether you're sending mail inside or outside your organization. Recipients of protected email messages sent to Microsoft 365 accounts or Outlook on the web don't have to take any special action to observe the message. Recipients using other email clients and email service providers also have an improved experience.

## How Message Encryption works

Message Encryption is built on Azure Rights Management (Azure RMS), which is part of Azure Information Protection. An email message that matches an encryption mail flow rule is encrypted before it's sent.

Microsoft 365 end users that use Outlook clients to read mail get native, first-class reading experiences for encrypted and rights-protected mail, even if they're not in the same organization as the sender. Supported Outlook clients include Outlook desktop, Outlook Mac, Outlook mobile on iOS and Android, and Outlook on the web. Recipients of encrypted or rights-protected mail in Outlook.com, Gmail, and Yahoo! accounts receive a wrapper mail. The mail directs them to a portal where they can authenticate by using a Microsoft account, Gmail, or Yahoo! credentials.

If the sender of the protected mail is in the Government Community Cloud (GCC) High environment and the recipient is outside of GCC High, the recipient gets a wrapper mail. The mail directs them to the portal where they can read and reply to the message. These recipients include commercial users, Outlook.com users, and users of other email providers such as Gmail. If the sender and recipient are both in the GCC High environment, even if they're not in the same organization, recipients that use Outlook clients get native, first-class reading experiences for encrypted and rights-protected mail.
