Microsoft 365 provides baseline, volume-level encryption for data at rest through BitLocker and Distributed Key Manager (DKM). Exchange Online, Microsoft Teams, SharePoint Online, and OneDrive for Business also use *service-level encryption* to encrypt customer data. For encryption key management, service encryption can use Microsoft-managed keys or Microsoft Purview Customer Key. This unit describes the uses and capabilities of different encryption key management levels and Customer Key.

## Service encryption

In the Microsoft 365 service, your data at rest is always encrypted with BitLocker and DKM. Service encryption ensures that content at rest is also encrypted at the service layer. Service encryption doesn't prevent Microsoft personnel from accessing customer data. Customers explicitly authorize Office 365 services to use their encryption keys to provide value-added cloud services, such as eDiscovery, antimalware, antispam, and search indexing.

Service-level encryption uses Microsoft-managed keys by default unless you decide to onboard using Customer Key. The Microsoft-managed key option is currently enabled by default for Exchange Online, SharePoint Online, and OneDrive for Business. Your data is always encrypted at this default level at a minimum. At this level, Microsoft manages the cryptographic keys, including the root keys for service encryption. 

## Customer Key

Customer Key is built on service encryption and provides extra protection against data observation by letting you provide and control the data encryption keys. The primary purpose is to help you meet regulatory or compliance obligations for controlling root keys. Customer Key helps you meet compliance obligations because you control the encryption keys that Microsoft 365 uses to encrypt and decrypt data. Microsoft 365 uses these keys to encrypt your data at rest, as described in the Online Services Terms (OST).

With Customer Key, you supply the root keys for service encryption, and you manage these keys by using Azure Key Vault. Using the keys you provide, Customer Key can encrypt:

- SharePoint Online, OneDrive for Business, and Teams files.
- Files uploaded to OneDrive for Business.
- Exchange Online mailbox content including email body content, calendar entries, and the content within email attachments.

Customer Key only encrypts data at rest in the cloud. Customer Key doesn't work on on-premises mailboxes and files. You can encrypt on-premises data by using another method, such as BitLocker.

Customer Key enhances the ability of your organization to meet the demands of compliance requirements that specify key arrangements with the cloud service provider. With Customer Key, you provide and control the root encryption keys for your Microsoft 365 data at rest at the application level. Therefore, you control your organization's keys.

If you decide to exit the service, you revoke access to your organization's root keys. For all Microsoft 365 services, revoking access to the keys is the first step on the path to data deletion. Revoking access to the keys makes the data unreadable to the service.

If you decide to stop using Customer Key without following the data purge path, then your data stays encrypted using the Microsoft-managed keys. Your data is always encrypted at this default level at a minimum.

