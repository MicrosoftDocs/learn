Identity and access management is called **IAM** for short. An identity solution controls access to an organization's apps and data. Users, devices, and applications have identities. IAM components support the authentication and authorization of these and other identities. The process of authentication controls who or what uses an account. Authorization controls what that user can do in applications.

Whether you're just starting to evaluate identity solutions or looking to expand your current implementation, Azure offers many options. One example is Microsoft Entra ID, a cloud service that provides identity management and access control capabilities. To decide on a solution, start by learning about this service and other Azure components, tools, and reference architectures.

:::image type="content" source="../media/identity-basic-architecture.png" alt-text="Diagram of an identity and access management solution based on Microsoft Entra ID.":::
 
Microsoft Entra ID, part of Microsoft Entra, offers a universal identity platform.  Microsoft Entra ID provides your people, partners, and customers a single identity to access applications and collaborate from any platform and device. Microsoft Entra ID has a full suite of identity management capabilities. Standardizing your application authentication and authorization to Microsoft Entra ID provides these benefits.

## Common Microsoft Entra ID terminology

Microsoft Entra ID is a cloud-based identity and access management solution, with integrated security.  It has a simple flat architectural design, so ensure it is fast, reliable, scalable, and redundant. Microsoft Entra ID provides organizations with Identity as a Service (IDaaS) solutions that cater to all the apps across the cloud and on-premises.

- **Identity** - An object that can get authenticated. An identity can be a user with a username and password. Identities also include applications or other servers that might require authentication through secret keys or certificates.
- **Account** - An identity that has data associated with it. You can't have an account without an identity.
- **Microsoft Entra Account** - An identity created through Microsoft Entra ID or another Microsoft cloud service, such as Microsoft 365. Identities are stored in Microsoft Entra ID and accessible to your organization's cloud service subscriptions. This account is also sometimes called a Work or school account.
- **User** - A single personal verifiable identity in Microsoft Entra ID.
- **Group** - A container of users or identities that can be assigned security privileges or restrictions.  Often used to control access to specific shared resource to a set of accounts instead of assigning individually.
- **Azure subscription** - Used to pay for Azure cloud services. You can have many subscriptions and they're linked to a credit card.
- **Microsoft Entra tenant/directory** - A dedicated and trusted instance of Microsoft Entra ID, a Tenant is automatically created when your organization signs up for a Microsoft cloud service subscription.
  - More instances of Microsoft Entra ID can be created. Microsoft Entra ID is the underlying product providing the identity service. The term Tenant means a single instance of Microsoft Entra ID representing a single organization. The terms Tenant and Directory are often used interchangeably.
- **Administrative Unit** - A portioned off piece of a Microsoft Entra tenant used to create and administrative boundary.
