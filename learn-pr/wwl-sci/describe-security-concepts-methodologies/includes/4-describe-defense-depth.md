Defense in depth uses a layered approach to security, rather than relying on a single perimeter. A defense in-depth strategy uses a series of mechanisms to slow the advance of an attack. Each layer provides protection, so that if one layer is breached a subsequent layer will prevent an attacker getting unauthorized access to data.

Example layers of security might include:

- *Physical* security such as limiting access to a datacenter to only authorized personnel.
- *Identity & access* security controlling access to infrastructure and change control.
- *Perimeter* security including distributed denial of service (DDoS) protection to filter large-scale attacks before they can cause a denial of service for users.
- *Network* security can limit communication between resources using segmentation and access controls. 
- The *compute* layer can secure access to virtual machines either on-premises or in the cloud by closing certain ports.
- *Application* layer security ensures that applications are secure and free of security vulnerabilities.
- *Data* layer security controls access to business and customer data, as well encryption to protect data.

:::image type="content" source="../media/4-defense-depth.png" alt-text="Defense in depth uses multiple layers of security to protect sensitive data":::

## Confidentiality, Integrity, Availability (CIA)

Confidentiality, Integrity, Availability, or CIA, is a way to think about security trade-offs. This is not a Microsoft-model, but common to all security professionals.

:::image type="content" source="../media/4-confidentiality-integrity-availability.png" alt-text="Confidentiality, Integrity, Availability (CIA)":::

**Confidentiality** refers to the need to keep sensitive data confidential, such as customer information, passwords, or financial data. You can encrypt data to keep it confidential, but then you also need to keep the encryption keys confidential. Confidentiality is the most visible part of security; we can clearly see need for sensitive data, keys, passwords, and other secrets to be kept confidential.

**Integrity** refers to keeping data or messages correct. When you send an email message, you want to be sure that the message that is received is the same as the message you sent. When you store data in a database, you want to be sure that the data you retrieve is the same as the data you stored. Encrypting data keeps it confidential, but you must then be able to decrypt it so that it's the same as before it was encrypted. Integrity is about having confidence that data hasn't been tampered with or altered.

**Availability** refers to making data available to those who need it. In the case of customer data, it's important to the organization to keep customer data secure, but at the same time it must also be available to employees who deal with customers. Whilst it might be more secure to store the data in an encrypted format, employees need access to decrypted data.

Whilst all sides of the CIA model are important, they also represent trade-offs that need to be made.
