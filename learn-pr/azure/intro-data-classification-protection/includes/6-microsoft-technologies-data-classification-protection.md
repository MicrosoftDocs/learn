Microsoft provides a set of technologies and tools that you can use to classify your data, help protect your data, and prevent data loss. Most of these tools are provides within the Microsoft 365 platform, but some of them are also available as separate products. Keeping in mind that many customers keep their data both on locally deployed file servers and on cloud storage services, most of the Microsoft technologies for information protection are usable on data stored in any location.

## Azure Information Protection

Azure Information Protection is a cloud-based, information-protection solution for Microsoft 365 and Office 365 that is based on rights management technology. 
Traditional security controls, such as NTFS permissions, firewalls, and access control lists are not effective enough to meet the needs of users who share daily information through email, file-sharing sites, and cloud services.

Azure Information Protection uses encryption, identity, and authorization policies to help protect information both within and outside your organization, and on almost any device. With Azure Information Protection, you can also use classification functionality to classify data before protection or use classification as a basis for the protection.

The protection enhancement remains with the data. For example, when people email data to other users or store it in their personal cloud drives, Azure Information Protection helps to protect it. Azure Information Protection provides persistent protection, which helps to secure your organization’s data. Authorized users and services, such as search and indexing, can continue to observe and inspect the data that Azure Information Protection helps to protect. This is called *reasoning over data* and is a crucial element in maintaining control of your organization’s data.

Azure Information Protection supports online and on-premises Microsoft server products. You can use Azure Information Protection in various scenarios and with various platforms and applications. Key characteristics of Azure Information Protection are:

- Support for the Information Rights Management (IRM) capabilities in Microsoft online services such as Exchange Online, SharePoint Online, and Office 365.
- Support for on-premises Microsoft server products such as Microsoft Exchange Server, Microsoft SharePoint Server, Office apps, and file servers that run Windows Server and File Classification Infrastructure.
- Ability to share protected content among users within the same organization or across organizations when the users meet one of the following conditions:
  - Have Office 365 or Azure Information Protection 
  - Sign up for rights management for individuals without the need to build explicit trust relationships.
- Availability of default rights policy templates and labels and the ability to create custom labels.
- Ability of users to define their own permission sets if the templates aren’t sufficient.
- Support for all the Office apps for multiple operating systems and versions, including third-party operating systems.
- Support for the Rights Management sharing app or Azure Information Protection client app on mobile devices and desktops, which enables sharing of files with people in another organization, document tracking, and email notifications.
- Support for Cryptographic Mode 2 without additional configuration, which provides stronger security enhancements for key lengths and encryption algorithms.

To integrate Azure Information Protection with your locally deployed servers, you should deploy the Microsoft Rights Management connector. This connector allows you to quickly enable existing on-premises servers to use their IRM functionality with the cloud-based Azure Information Protection service.

> [!NOTE]

> The Microsoft Rights Management connector requires an Azure Active Directory (Azure AD) Premium license and is available only with Azure AD Premium P1 or P2.

## Microsoft Information Protection

Azure Information Protection is mostly based on classification and rights management technologies to enable data classification and protection. This technology is also the part of Microsoft Information Protection platform that provides additional technologies to implement additional controls and use existing encryption and DLP technologies.

### Label-based information protection in Windows 10

As part of the unified labeling and protection experience, Microsoft also wants to ensure that its broad set of information protection solutions can:

- Understand labels attached to documents and emails.
- Apply the appropriate policy-based actions, even beyond what’s provided by Azure Information Protection or RMS.

With label-based information protection, Windows 10 devices can now use Microsoft Defender for Endpoint to:

- Read, understand, and act on sensitivity labels in documents.
- Automatically apply a Windows Information Protection policy on work data, no matter how it reaches a managed device.

This extends information protection on managed Windows devices and endpoints and helps protect labeled files from accidental leakage, with or without applying encryption. For example, Windows can understand that a Word document residing on a user’s computer has a label of “Confidential.” Also, because of the policy that the organization has defined, Windows can apply a Windows Information Protection policy to prevent the copying or sharing of the data to any non-work location from that device. The non-work locations could include personal email accounts and social media channels. The following screenshot depicts an example.

:::image type="content" source="../media/6-information-protection.png" alt-text="Screenshot depicts how label-based information protection works in Windows 10. The 1 interrupted action dialog box notifies the user that their organization doesn’t allow them to place a file in their personal OneDrive folder." border="true":::

### Office 365 Message Encryption

With Office 365 Message Encryption, your organization can send and receive encrypted email messages between people inside and outside your organization. Office 365 Message Encryption works with Outlook.com and several other third-party email services. Email message encryption helps ensure that only intended recipients can access the message content.

Office 365 Message Encryption is an online service that's built on Microsoft Azure Rights Management (Azure RMS), which is part of Azure Information Protection. This includes encryption, identity, and authorization policies to help secure your email. You can encrypt messages by using rights management templates, the **Do Not Forward** option, and the encrypt-only option.

As an administrator, you can also define mail flow rules to apply this protection. For example, you can create a rule that:

- Requires the encryption of all messages addressed to a specific recipient.
- Contains specific words in the subject line.
- Specifies that recipients can't copy or print the contents of the message.

When someone sends an email message that matches an encryption mail flow rule, the message is encrypted before it's sent. All Microsoft 365 end users that use Outlook clients to access their email receive native, first-class reading experiences for encrypted and rights-protected email, even if they're not in the same organization as the sender. Supported Outlook clients include Outlook desktop, Outlook Mac, Outlook mobile on iOS and Android, and Outlook on the web (formerly known as Outlook Web App).

Recipients of encrypted messages who receive encrypted or rights-protected mail sent to their Outlook.com, Gmail, and Yahoo accounts receive a wrapper mail that directs them to the OME Portal where they can easily authenticate using a Microsoft account, Gmail, or Yahoo credentials.

End users that read encrypted or rights-protected mail on clients other than Outlook also use the OME portal to observe encrypted and rights-protected messages that they receive.
