Microsoft has technologies and tools you can use to help classify and protect your data and help prevent data loss. The Microsoft 365 platform provides most of these tools. However, some also are available as separate products. Microsoft knows its customers keep their data on both locally deployed file servers and cloud-storage services. Therefore, you can use most information protection technologies from Microsoft on data stored anywhere.

## Azure Information Protection

Azure Information Protection is a Microsoft 365 and Office 365 cloud-based, information-protection solution. It's based on rights-management technology.
Traditional security controls, such as NTFS permissions, firewalls, and access control lists don't always provide enough protection for users who regularly share information through email, file-sharing sites, and cloud services.

Azure Information Protection uses encryption, identity, and authorization policies to help protect information within and outside your organization on almost any device. When you use Azure Information Protection, you can also use data-classification functionality before implementing protection or use it as a basis for protection.

Protection enhancement remains with data. For example, when people email data to other users or store it in their personal cloud drives, Azure Information Protection helps protect it by using persistent protection. This protection helps secure your organization’s data. Authorized users and services, such as search and indexing, can observe and inspect the protected data. Known as *reasoning over data*, it's a critical element in controlling your organization’s data.

Azure Information Protection supports online and on-premises Microsoft server products. It works with many scenarios, platforms, and applications. Key characteristics of Azure Information Protection include:

- Support for Information Rights Management (IRM) capabilities in Microsoft online services such as Exchange Online, SharePoint Online, and Office 365.
- Support for on-premises Microsoft server products such as Microsoft Exchange Server, Microsoft SharePoint Server, Office apps, and file servers.
- The ability to share protected content with users in the same organization, or users outside your organization who also use Office 365 or Azure Information Protection.
- Enabling users to define their own permission sets if templates aren’t sufficient.
- Support for all versions of Office apps being used on multiple operating systems (including third-party ones).
- Support for the Rights Management sharing app or Azure Information Protection client app on mobile devices and desktops. These apps enable file sharing with people in other organizations, document tracking, and email notifications.
- Support for Cryptographic Mode 2 without requiring extra configuration. Cryptographic Mode 2 provides stronger security enhancements for key lengths and encryption algorithms.

Integrate Azure Information Protection with locally deployed servers by using the Microsoft Rights Management connector. It allows you to quickly enable existing on-premises servers to use their IRM functionality with the cloud-based Azure Information Protection service.

## Microsoft Purview Information Protection

Azure Information Protection enables data classification and protection because it's mostly based on classification and rights-management technologies. It also is part of the Microsoft Purview Information Protection platform. This platform provides more technologies for implementing controls and using existing encryption and DLP technologies.

### Label-based information protection in Windows 10

To help support a unified labeling and protection experience, Microsoft also ensures its broad set of information-protection solutions can:

- Understand labels attached to documents and emails.
- Apply the appropriate policy-based actions beyond what Azure Information Protection or RMS provide.

Label-based information protection enables Windows 10 devices to use Microsoft Defender for Endpoint to:

- Read, understand, and act on sensitivity labels in documents.
- Automatically apply a Windows Information Protection policy on work data, regardless of how it reaches a managed device.

Label-based information protection extends information protection on managed Windows devices and endpoints. It also helps protect labeled files from accidental leakage, with or without applying encryption. For example, Windows recognizes a "Confidential" label on a Microsoft Word document residing on a user’s computer. When an organization defines a Windows Information Protection policy, Windows can apply it to prevent data copying or sharing to a nonwork location from that device. The nonwork locations could include personal email accounts and social media channels. The following screenshot depicts an example:

:::image type="content" source="../media/6-information-protection.png" alt-text="Label-based information protection in Windows 10. A dialog box notifies the user that their organization doesn’t allow placing a file in a personal OneDrive folder." border="true":::

### Office 365 Message Encryption

Office 365 Message Encryption enables people within an organization to send and receive encrypted email messages with others inside and outside the organization. Office 365 Message Encryption works with Outlook.com and several other third-party email services. Email message encryption helps ensure only intended recipients can access message content.

Office 365 Message Encryption is an online service built on Microsoft Azure Rights Management (Azure RMS). Azure RMS is part of Azure Information Protection. It includes encryption, identity, and authorization policies to help secure your email. You can encrypt messages by using rights management templates, and the **Do Not Forward** and encrypt-only options.

As an administrator, apply this protection by defining mail-flow rules. For example, create a rule that:

- Requires the encryption of all messages addressed to a specific recipient.
- Contains specific words in the subject line.
- Specifies recipients can't copy or print the message contents.

If someone sends an email message matching an encryption mail-flow rule, rights management system encrypts the message before it's sent. All Microsoft 365 users accessing their email by using Outlook clients receive native, first-class reading experiences for encrypted and rights-protected email. Even if they're not in the sender's organization. Supported Outlook clients include Outlook desktop, Outlook Mac, Outlook mobile on iOS and Android, and Outlook on the web (formerly known as Outlook Web App).

Recipients of encrypted or rights-protected mail sent to their Outlook.com, Gmail, and Yahoo accounts receive a wrapper mail. It directs them to the Office Message Encryption (OME) Portal, where they can easily authenticate using a Microsoft account, Gmail, or Yahoo credentials.

End users who read encrypted or rights-protected mail on non-Outlook clients also use the encrypted message portal to open encrypted and rights-protected messages.
