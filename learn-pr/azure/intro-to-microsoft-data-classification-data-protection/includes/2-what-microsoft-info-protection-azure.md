This unit provides an overview of Microsoft information protection with Microsoft Purview Information Protection and Azure Information Protection.

## Purview Information Protection

Microsoft Purview Information Protection, formerly Microsoft Information Protection, is a suite of Microsoft solutions that help you discover, classify, and protect your sensitive information wherever it lives or travels. These solutions work on cloud resources, such as SharePoint Online, OneDrive for Business, or Exchange Online, and on locally deployed resources like file servers.

You can use cloud-based Purview Information Protection to discover, classify, and help protect documents and emails by applying labels to content, and by encrypting the content. You can use Information Protection to encrypt your data at the application level, and include a policy that defines the authorized use for that document. Information Protection decrypts the document and enforces the rights that the policy defines if a legitimate user or an authorized service accesses the data. Information Protection can also track document usage, so you can monitor both successful and unsuccessful attempts to use a document.

A content key helps to protect an Information Protection-protected document. This content key is unique to the document, and is placed in the file header, where the Information Protection tenant root key helps protect it. Microsoft generates or manages this tenant root key, or you can generate and manage your own tenant key.

Purview Information Protection doesn't process or store your data as part of the information protection process. The Microsoft cloud never sends or stores your data unless you intentionally do so or use another cloud service that does so. 

Purview Information Protection is built into Microsoft 365 Apps on Windows, macOS, iOS, and Android. You can use this capability to apply or view sensitivity labels that look and behave very similarly across apps and devices.

On Windows computers, you can also download and use the Azure Information Protection (AIP) client to apply sensitivity labels in Office apps. However, the Office add-in component for this client is now in maintenance mode and is retiring in April 2024. When the AIP client is installed, it's disabled by default in the latest Office apps and is no longer the default labeling client for Office apps.

For a consistent labeling experience, use the Purview Information Protection labeling functionality that's built into Office apps. You can use Microsoft Purview sensitivity labels in a wider scope than classic Azure Information Protection labels, and on operating systems such as macOS that don't support Azure Information Protection client software.

## Azure Information Protection

Although you should use the built-in Purview Information Protection labeling for Office apps, you can download and install the Azure Information Protection client for Windows, iOS, or Android to support other functionality, such as:

- A unified labeling client that supports more file types and apps.
- An on-premises scanner.
- The Microsoft Information Protection SDK.

The Azure Information Protection unified labeling client extends labeling, classification, and protection capabilities to more file types, and to File Explorer and PowerShell. For example, with Azure Information Protection installed, you can right-click or access the context menu for one or more files in File Explorer and select **Classify and protect** to manage Azure Information Protection for the selected files.

:::image type="content" source="../media/2-protect-from-file-explorer.png" alt-text="Image depicts how File Explorer is used to help protect a file.":::

In general, Purview Information Protection provides a wider scope for document and file protection than Azure Information Protection. Azure Information Protection works mostly with Office applications and files created in Office applications, and with PDFs.

## Information protection process

The Information Protection process works as follows:

1. The process authenticates the user with their Azure Active Directory (Azure AD) or Microsoft 365 organizational account.
1. Upon authentication, the service issues certificates that allow the user to consume protected content and help protect content offline. A stored copy of the user's certificate helps ensure that if the user moves to another device, they can access their protected data.
1. The Information Protection client creates a random content key and encrypts the document with it.
1. The client creates a certificate that includes a policy based on a template or specific document rights. The policy includes rights for users and groups, and restrictions such as read-only or an expiration date. The organization's key is used to encrypt the policy and the symmetric content key for decrypting the content.
1. The client signs the policy with the user's certificate and embeds it into a file with the body of the encrypted document. The policy stays with the encrypted document as long as it's encrypted.
1. The user can now store the document anywhere or share it by using any method.

When a user wants access to a protected document, the client uses the following process to request access to the Information Protection service:

1. The authenticated user sends the document policy and the user's certificates to the Information Protection service.
1. The service decrypts and evaluates the policy, and builds a rights list for the user.
4. The service extracts the content key from the decrypted policy, and encrypts this key with the user's public RSA key that it got from the request.
5. The service returns an encrypted user license with the list of user rights to the client.
6. The client decrypts the encrypted user license by using its own user private key, decrypts the rights list, and passes it to the application.

