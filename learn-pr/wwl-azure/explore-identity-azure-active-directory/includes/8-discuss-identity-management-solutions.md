
Identity and access management is called **IAM** for short. An identity solution controls access to an organization's apps and data. Users, devices, and applications have identities. IAM components support the authentication and authorization of these and other identities. The process of authentication controls who or what uses an account. Authorization controls what that user can do in applications.

Whether you're just starting to evaluate identity solutions or looking to expand your current implementation, Azure offers many options. One example is Azure Active Directory (Azure AD), a cloud service that provides identity management and access control capabilities. To decide on a solution, start by learning about this service and other Azure components, tools, and reference architectures.

:::image type="content" source="../media/identity-basic-architecture.png" alt-text="Diagram of an identity and access management solution based on Azure Active Directory.":::
 
Azure Active Directory (Azure AD), part of Microsoft Entra, offers a universal identity platform.  Azure AD provides your people, partners, and customers a single identity to access applications and collaborate from any platform and device. Azure AD has a full suite of identity management capabilities. Standardizing your application authentication and authorization to Azure AD provides these benefits.

## Common Azure AD terminology

Azure Active Directory (Azure AD) is a cloud-based identity and access management solution, with integrated security.  It has a simple flat architectural design, so ensure it is fast, reliable, scalable, and redundant. Azure AD provides organizations with Identity as a Service (IDaaS) solutions that cater to all the apps across the cloud as well as the on-premises.

- **Identity** - An object that can get authenticated. An identity can be a user with a username and password. Identities also include applications or other servers that might require authentication through secret keys or certificates.
- **Account** - An identity that has data associated with it. You can't have an account without an identity.
- **Azure AD Account** - An identity created through Azure AD or another Microsoft cloud service, such as Microsoft 365. Identities are stored in Azure AD and accessible to your organization's cloud service subscriptions. This account is also sometimes called a Work or school account.
- **User** - A single personal identity in Azure AD, that can or has been verified.
- **Group** - A container of users or identities that can be assigned security privileges or restrictions.  Often used to control access to specific shared resource to a set of accounts instead of assigning individually.
- **Azure subscription** - Used to pay for Azure cloud services. You can have many subscriptions and they're linked to a credit card.
- **Azure tenant/directory** - A dedicated and trusted instance of Azure AD, a Tenant is automatically created when your organization signs up for a Microsoft cloud service subscription.
  - More instances of Azure AD can be created. Azure AD is the underlying product providing the identity service. The term Tenant means a single instance of Azure AD representing a single organization. The terms Tenant and Directory are often used interchangeably.
- **Administrative Unit** - A portioned off piece of an Azure AD tenant for to create and administrative boundary.
