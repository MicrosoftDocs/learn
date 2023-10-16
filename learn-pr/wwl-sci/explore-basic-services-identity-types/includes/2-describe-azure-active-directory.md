
Microsoft Entra ID, formerly Azure Active Directory, is Microsoft’s cloud-based identity and access management service. Organizations use Microsoft Entra ID to enable their employees, guests, and others to sign in and access the resources they need, including:

- Internal resources, such as apps on your corporate network and intranet, and cloud apps developed by your own organization.
- External services, such as Microsoft Office 365, the Azure portal, and any SaaS applications used by your organization.

Microsoft Entra ID simplifies the way organizations manage authorization and access by providing a single identity system for their cloud and on-premises applications. Microsoft Entra ID can be synchronized with your existing on-premises Active Directory, synchronized with other directory services, or used as a standalone service.

Microsoft Entra ID also allows organizations to securely enable the use of personal devices, such as mobiles and tablets, and enable collaboration with business partners and customers.

:::image type="content" source="../media/entra-id-general-diagram-v2.png" alt-text="Diagram showing Microsoft Entra ID as a cloud-based identity provider that works with cloud apps such as M365, devices, and on-premises applications.":::

### Identity Secure Score

Microsoft Entra ID includes an identity secure score, which is a percentage that functions as an indicator for how aligned you are with Microsoft's best practice recommendations for security. Each improvement action in identity secure score is tailored to your specific configuration.

Identity secure score, which is available in all editions of Microsoft Entra ID, helps you to objectively measure your identity security posture, plan identity security improvements, and review the success of your improvements.

:::image type="content" source="../media/identity-secure-score-inline.png" lightbox="../media/identity-secure-score-expanded.png" alt-text="Screen shot of the Identity Secure Score dashboard, which includes your score as a percentage value, a comparison score relative to similarly sized companies, score history, and improvement actions.":::

### Basic terminology

When talking about Microsoft Entra ID, there's some basic terminology that is important to understand.

- ***Tenant*** - A Microsoft Entra ID tenant is an instance of Microsoft Entra in which information about a single organization resides including organizational objects such as users, groups, devices, and application registrations. A tenant also contains access and compliance policies for resources, such as applications registered in the directory. Each Microsoft Entra ID tenant has a unique ID (tenant ID) and a domain name (for example, contoso.onmicrosoft.com) and serves as a security and administrative boundary, allowing the organization to manage and control access to resources, applications, devices, and services.

- ***Directory*** - The terms Microsoft Entra ID directory and Microsoft Entra ID tenant are often used interchangeably.  The directory is a logical container within a Microsoft Entra ID tenant that holds and organizes the various resources and objects related to identity and access management including users, groups, applications, devices, and other directory objects. Basically, the directory is like a database or catalog of identities and resources associated with an organization's tenant.  A Microsoft Entra ID tenant consists of only one directory.

- ***Multi-tenant*** - A multi-tenant organization is an organization that has more than one instance of Microsoft Entra ID. Reasons why an organization might have multiple tenants include organizations with multiple subsidiaries or business units that operate independently, organizations that merge or acquire companies, multiple geographical boundaries with various residency regulations, and more.

### Who uses Microsoft Entra ID?

Microsoft Entra ID is used by IT admins to control access to corporate apps and resources, based on business requirements. For example, Microsoft Entra ID can also be set up to require multi-factor authentication when accessing important organizational resources. It provides powerful tools to automatically help protect user identities and credentials and to meet an organization’s access governance requirements.

Developers use Microsoft Entra ID as a standards-based approach for adding single sign-on (SSO) to their apps, so that users can sign in with their pre-existing credentials. Microsoft Entra ID also provides application programming interfaces (APIs) that allow developers to build personalized app experiences using existing organizational data.

Subscribers to Azure services, Microsoft 365, or Dynamics 365 automatically have access to Microsoft Entra ID. Users of these services can take advantage of included services and can also enhance their Microsoft Entra ID implementation by upgrading to premium licenses.
