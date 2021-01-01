Microsoft provides a set of solutions for data classification and data protection. These solutions work both on cloud resources, such as SharePoint Online, OneDrive for Business or Exchange Online, but also on locally deployed resources, such as local file servers. Azure Information Protection and Microsoft Information Protection are two main SKUs that provide technologies to classify and protect data.

## How Azure Information Protection works?

Azure Information Protection (AIP) is a cloud-based solution that enables organizations to discover, classify, and protect documents and emails by applying labels to content and by encrypting the content. AIP is part of the Microsoft Information Protection (MIP) solution, and extends the labeling and classification functionality provided by Microsoft 365.

The Azure Information Protection service (and Microsoft Information Protection services) don’t see or store your data as part of the information protection process. To help protect information, data is never sent or stored in Azure unless you intentionally store it there or use another cloud service that stores it in Azure. 
Azure Information Protection encrypts your data at the application level and includes a policy that defines the authorized use for that document. It decrypts the document and enforces the rights that are defined in the policy if a legitimate user or an authorized service accesses the data. It can also track document usage, so you can monitor both successful and unsuccessful attempts to use a document.
A content key helps to protect an Azure Information Protection-protected document. This content key is unique for each document and is placed in the file header, where your Azure Information Protection tenant root key helps to protect it. Microsoft either generates or manages this tenant root key, or you can generate and manage your own tenant key.

The protection process on the client works as follows:
1.	The user prepares the user environment on the client in a one-time process by installing the Azure Information Protection client application, if needed. In latest build of Office apps, AIP client is already integrated.
2.	The Azure Information Protection client connects to Azure Information Protection and authenticates the user with the user’s Azure AD account (This is also known as Microsoft 365 or Office 365 organizational account).
3.	As soon as the user is authenticated, certificates are issued that allow the user to authenticate to Azure Information Protection to consume protected content and to protect content offline. A copy of the user’s certificate is stored in Azure Information Protection. This helps to ensure that if the user moves to another device, that user will have access to his or her protected data.
4.	Now that the user is protecting data, the Azure Information Protection client creates a random content key and encrypts the document with it.
5.	The Azure Information Protection client creates a certificate with an included policy. This policy is based on a template or specific document rights. The policy includes:
- Rights for users and groups.
- Restrictions such as read-only or an expiration date. 
6.	After that, the organization’s key is used to encrypt the policy and the symmetric content key.
7.	The Azure Information Protection client signs the policy with the user’s certificate.
8.	The policy is embedded into a file with the body of the document previously encrypted.
9.	The policy stays with the encrypted document if it stays encrypted. 
10.	Now you can store the document virtually anywhere or share it by using essentially any method.

When a user wants access to a protected document, the Azure Information Protection client starts by using the following process to request access to the Azure Information Protection service:
1.	The authenticated user sends the document policy and the user’s certificates to Azure Information Protection service.
2.	Azure Information Protection decrypts and evaluates the policy.
3.	The service builds a rights list for the user.
4.	Azure Information Protection extracts the AES content key from the decrypted policy and then encrypts this key with the user’s public RSA key that was obtained with the request.
5.	An encrypted user license with the list of user rights is returned to the Azure Information Protection client.
6.	The Azure Information Protection client decrypts this encrypted user license by using its own user private key.
7.	The Azure Information Protection client also decrypts the rights list and passes it to the application.

## What is Microsoft Information Protection suite?

Microsoft Information Protection is the common information protection stack that's leveraged by AIP's unified labeling client. The Azure Information Protection unified labeling client extends labeling, classification, and protection capabilities to additional file types, as well as to the File Explorer and PowerShell. For example, in the File Explorer, right-click one or more files and select Classify and protect to manage the AIP functionality on the selected files.

:::image type="content" source="../media/2-protect-from-file-explorer.png" alt-text="Image shows how File Explorer is used to protect a file.":::

Microsoft Information Protection also includes components, such as: 
- Office 365 Message Encryption
- Sensitivity labels
- Cloud App Security
- Rights Management connector
- Information Rights Management

We will discuss some of these components later in this module.  In general, Microsoft Information Protection provides a wider scope for documents and files protection than Azure Information Protection. While Azure Information Protection works mostly with Office applications and files created in Office applications, as well as with PDFs, with technologies included in Microsoft Information Protection, you can protect almost all files on locations outside the scope of Office apps.

