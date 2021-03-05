In your evaluation work for Contoso, you first familiarize yourself with Microsoft and Azure information protection capabilities. In this unit, you’ll learn how Azure Information Protection works and what the Microsoft Information Protection suite is.

You can use a set of Microsoft solutions for data classification and data protection. These solutions work on cloud resources, such as SharePoint Online, OneDrive for Business or Exchange Online, and on locally deployed resources, such as local file servers. Azure Information Protection and Microsoft Information Protection are two main SKUs that provide technologies to classify and protect data.

## How Azure Information Protection works

You can use the cloud-based Azure Information Protection to discover, classify, and protect documents and emails by applying labels to content and by encrypting the content. Azure Information Protection is part of the Microsoft Information Protection (MIP) solution and extends the labeling and classification functionality provided by Microsoft 365.

The Azure Information Protection service (and Microsoft Information Protection services) doesn’t perceive or store your data as part of the information protection process. To help protect information, data is never sent or stored in Azure unless you intentionally store it there or use another cloud service that stores it in Azure.
You use Azure Information Protection to encrypt your data at the application level and it includes a policy that defines the authorized use for that document. It decrypts the document and enforces the rights that the policy defines if a legitimate user or an authorized service accesses the data. It can also track document usage, so you can monitor both successful and unsuccessful attempts to use a document.

A content key helps to protect an Azure Information Protection-protected document. This content key is unique for each document and is placed in the file header, where your Azure Information Protection tenant root key helps to protect it. Microsoft either generates or manages this tenant root key, or you can generate and manage your own tenant key.

The protection process on the client works as follows:
1. The user prepares the user environment on the client in a one-time process by installing the Azure Information Protection client application, if needed. In the latest build of Office apps, the Azure Information Protection client is already integrated.
2. The Azure Information Protection client connects to Azure Information Protection and authenticates the user with the user’s Azure Active Directory (Azure AD) account (also known as the Microsoft 365 or Office 365 organizational account).
3. As soon as the user is authenticated, certificates are issued that allow the user to authenticate to Azure Information Protection to consume protected content and to protect content offline. A copy of the user’s certificate is stored in Azure Information Protection, which helps to ensure that if the user moves to another device, they’ll have access to their protected data.
4. Now that the user is protecting data, the Azure Information Protection client creates a random content key and encrypts the document with it.
5. The Azure Information Protection client creates a certificate with an included policy. This policy is based on a template or specific document rights. The policy includes:
    - Rights for users and groups.
    - Restrictions such as read-only or an expiration date.
6. After that, the organization’s key is used to encrypt the policy and the symmetric content key.
7. The Azure Information Protection client signs the policy with the user’s certificate.
8. The policy is embedded into a file with the body of the document previously encrypted.
9. The policy stays with the encrypted document if it stays encrypted.
10. Now the user can store the document anywhere or share it by using any method.

When a user wants access to a protected document, the Azure Information Protection client starts by using the following process to request access to the Azure Information Protection service:

1. The authenticated user sends the document policy and the user’s certificates to Azure Information Protection service.
2. Azure Information Protection decrypts and evaluates the policy.
3. The service builds a rights list for the user.
4. Azure Information Protection extracts the AES content key from the decrypted policy. It then encrypts this key with the user’s public RSA key that was obtained with the request.
5. An encrypted user license with the list of user rights is returned to the Azure Information Protection client.
6. The Azure Information Protection client decrypts this encrypted user license by using its own user private key.
7. The Azure Information Protection client also decrypts the rights list and passes it to the application.

## What is Microsoft Information Protection suite?

Microsoft Information Protection is the common information protection stack that's used by Azure Information Protection's unified labeling client. The Azure Information Protection unified labeling client extends labeling, classification, and protection capabilities to additional file types, and to File Explorer and PowerShell. For example, in File Explorer, right-click or access the context menu for one or more files and select **Classify and protect** to manage the Azure Information Protection functionality on the selected files.
:::image type="content" source="../media/2-protect-from-file-explorer.png" alt-text="Image depicts how File Explorer is used to protect a file.":::

Microsoft Information Protection also includes components, such as:
- Office 365 Message Encryption
- Sensitivity labels
- Cloud App Security
- Rights Management connector
- Information Rights Management

You'll explore some of these components later in this module. In general, Microsoft Information Protection provides a wider scope for documents and files protection than Azure Information Protection. Azure Information Protection works mostly with Office applications and files created in Office applications, and with PDFs. With technologies included in Microsoft Information Protection, you can protect almost all files outside the scope of Office apps.
