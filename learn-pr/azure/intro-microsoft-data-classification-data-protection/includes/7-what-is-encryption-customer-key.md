Microsoft 365 provides baseline, volume-level encryption enabled through BitLocker and Distributed Key Manager (DKM). Microsoft 365 offers an added layer of encryption at the application layer for your content. This content includes data from Exchange Online, SharePoint Online, OneDrive for Business, and Teams files. This added layer of encryption is called service encryption.

## How service encryption, BitLocker, and Customer Key work together

Service encryption ensures that content at rest is encrypted at the service layer. Your data is always encrypted at rest in the Microsoft 365 service with BitLocker and DKM.  Customer Key provides extra protection against data observation by unauthorized systems or personnel and complements BitLocker disk encryption in Microsoft datacenters. Service encryption isn't meant to prevent Microsoft personnel from accessing customer data. The primary purpose is to help customers meet regulatory or compliance obligations for controlling root keys. Customers explicitly authorize Office 365 services to use their encryption keys to provide value-added cloud services, such as eDiscovery, anti-malware, anti-spam, and search indexing.

Customer Key is built on service encryption and lets you provide and control encryption keys. Microsoft 365 then uses these keys to encrypt your data at rest as described in the Online Services Terms (OST). Customer Key helps you meet compliance obligations because you control the encryption keys that Microsoft 365 uses to encrypt and decrypt data.

Customer Key enhances the ability of your organization to meet the demands of compliance requirements that specify key arrangements with the cloud service provider. With Customer Key, you provide and control the root encryption keys for your Microsoft 365 data at rest at the application level. As a result, you exercise control over your organization's keys. If you decide to exit the service, you revoke access to your organization's root keys. For all Microsoft 365 services, revoking access to the keys is the first step on the path towards data deletion. By revoking access to the keys, the data is unreadable to the service.

### Customer Key encrypts data at rest in Office 365

Using keys you provide, Customer Key encrypts:

- SharePoint Online, OneDrive for Business, and Teams files.
- Files uploaded to OneDrive for Business.
- Exchange Online mailbox content including email body content, calendar entries, and the content within email attachments.

Customer Key only encrypts data at rest in the cloud. Customer Key doesn’t work to protect your on-premises mailboxes and files. You can encrypt your on-premises data using another method, such as BitLocker.