Microsoft provides a set of technologies and tools that can help you to classify your data, protect your data and prevent data loss. Most of these tools are provides within Microsoft 365 platform, but some of them are also available as separate products. Understanding that a lot of customers are still keeping their data both on locally deployed file servers and on cloud storage services, most of Microsoft technologies for information protection can be used on data stored on any location.

## Azure Information Protection Overview

Azure Information Protection (AIP) is a cloud-based, information-protection solution for Microsoft 365 and Office 365, based on rights management technology. Traditional security controls, such as NTFS permissions, firewalls, and access control lists are not effective enough to meet the needs of users who share daily information through email, file-sharing sites, and cloud services.
Azure Information Protection uses encryption, identity, and authorization policies to help protect information both within and outside your organization, and on virtually any device. With AIP, you can also use classification functionality to classify data before protection or use classification as a basis for the protection.
The protection enhancement remains with the data; for example, when people mail data to other users or store it in their personal cloud drives, Azure Information Protection helps to protect it. Azure Information Protection provides persistent protection enhancement, which helps to secure your organization’s data. Authorized users and services (such as search and indexing) can continue to observe and inspect the data that Azure Information Protection helps to protect. This is called *reasoning over data* and is a crucial element in maintaining control of your organization’s data.

Azure Information Protection supports online and on-premises Microsoft server products such as Microsoft Exchange Server, Microsoft SharePoint Server, Office applications, and file servers that run Windows Server and File Classification Infrastructure (FCI). 
You can use Azure Information Protection in various scenarios and with various platforms and applications. Key characteristics of Azure Information Protection are:

- Support for the Information Rights Management (IRM) capabilities in Microsoft online services such as Exchange Online, SharePoint Online, and Office 365.
- Support for on-premises Microsoft server products such as Exchange Server, SharePoint Server, and file servers that run Windows Server and FCI.
- Ability to share protected content among users within the same organization or across organizations when the users have Office 365 or Azure Information Protection or when they sign up for rights management for individuals without the need to build explicit trust relationships.
- Availability of default rights policy templates and labels and the ability to create custom labels. 
- Ability of users to define their own permission sets if the templates aren’t sufficient.
- Support for the all Office applications for PC and Mac, from version 2010 (2016 for Mac) and newer
- Support for the Rights Management sharing app or Azure Information Protection client app on mobile devices (iOS and Android) and desktops, which enables sharing of files with people in another organization, document tracking, and email notifications.
- Support for Cryptographic Mode 2 without additional configuration, which provides stronger security enhancement for key lengths and encryption algorithms.
  

To integrate Azure Information Protection with your locally deployed servers, you should deploy the Microsoft Rights Management connector (available only with Azure AD Premium P1 or P2). This connector allows you to quickly enable existing on-premises servers to use their IRM functionality with the cloud-based Azure Information Protection service. This requires an Azure AD Premium license.

## Microsoft Information Protection Overview

While Azure Information Protection is mostly based on classification and rights management technologies to enable data classification and protection, Microsoft Information Protection platform provides an extension to AIP, by providing some additional technologies to implement additional controls and leverage existing encryption and DLP technologies.

### Label based information protection in Windows 10

As part of the unified labeling and protection experience, Microsoft also wants to ensure that broad set of information protection solutions can understand labels attached to documents and emails and apply the appropriate policy-based actions, even beyond what’s provided by Azure Information Protection or RMS. With label based information protection, Windows 10 devices can now use Windows Defender ATP to read, understand and act on sensitivity labels in documents and automatically apply Windows Information Protection (WIP) policy on work data, no matter how it reaches a managed PC.

This extends information protection on managed Windows devices and endpoints and helps protect labeled files from accidental leakage, with or without applying encryption. For example, Windows can understand that a Word document residing on a user’s computer has a label of “Confidential”, and as a result of the policy defined by the organization, apply a Windows Information Protection (WIP) policy to prevent the copying or sharing of the data to any non-work location from that device (such as personal email accounts, social channels, etc.).

:::image type="content" source="../media/6-MIP-W10.png" alt-text="Image shows how label based information protection works in Windows 10.":::

### Office 365 Message Encryption

With Office 365 Message Encryption, your organization can send and receive encrypted email messages between people inside and outside your organization. Office 365 Message Encryption works with Outlook.com, Yahoo!, Gmail, and other email services. Email message encryption helps ensure that only intended recipients can view message content.

Office 365 Message Encryption is an online service that's built on Microsoft Azure Rights Management (Azure RMS) which is part of Azure Information Protection. This includes encryption, identity, and authorization policies to help secure your email. You can encrypt messages by using rights management templates, the Do Not Forward option, and the encrypt-only option.

As an administrator, you can also define mail flow rules to apply this protection. For example, you can create a rule that requires the encryption of all messages addressed to a specific recipient, or that contains specific words in the subject line, and also specify that recipients can't copy or print the contents of the message.

When someone sends an email message that matches an encryption mail flow rule, the message is encrypted before it's sent. All Microsoft 365 end users that use Outlook clients to read mail receive native, first-class reading experiences for encrypted and rights-protected mail even if they're not in the same organization as the sender. Supported Outlook clients include Outlook desktop, Outlook Mac, Outlook mobile on iOS and Android, and Outlook on the web (formerly known as Outlook Web App).

Recipients of encrypted messages who receive encrypted or rights-protected mail sent to their Outlook.com, Gmail, and Yahoo accounts receive a wrapper mail that directs them to the OME Portal where they can easily authenticate using a Microsoft account, Gmail, or Yahoo credentials.

End users that read encrypted or rights-protected mail on clients other than Outlook also use the OME portal to view encrypted and rights-protected messages that they receive.
