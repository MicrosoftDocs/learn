The board wants to enable secure and easy access to applications and services. These applications are available to internal staff and doctors from various countries/regions. Your team manager believes that Microsoft Entra ID can address these needs. Your manager wants you to find out what Microsoft Entra ID is, how it works, and what it does.

Here, you get an overview of Microsoft Entra ID and see why you'd use it. You learn about the differences between Microsoft Entra ID and the traditional on-premises Active Directory.

<a name='what-is-azure-ad'></a>

## What is Microsoft Entra ID?

Microsoft Entra ID is a cloud-based identity-management solution. It helps your company's internal users to:

- Access external resources like Azure services, Microsoft 365, and third-party SaaS applications.

- Access internal resources such as applications on the corporate network and cloud-based applications that your company builds.

Microsoft Entra ID also helps you keep user identities and applications secure through features like Conditional Access and Microsoft Entra ID Protection.

![Diagram that shows Microsoft Entra ID connecting to Microsoft and third-party applications.](../media/2-azure-ad.svg)

Microsoft Entra ID stores your users in a *tenant* that represents an organization. For example, say you have a company tenant where all of your employee user accounts are stored. You can add users in this tenant to groups so they have a common shared-access level. You could have one group for developers and another group for application testers. These groups would have different access levels for applications. Each tenant can have multiple groups that hold multiple users.

<a name='who-benefits-from-azure-ad'></a>

## Who benefits from Microsoft Entra ID?

Microsoft Entra ID meets the needs of many types of users. For instance, an IT Administrator can use Microsoft Entra ID to determine who should have access to applications and resources, based on company requirements. An Administrator can add another layer of protection to applications and services by enforcing multifactor authentication on sign-ins.

Application developers can use Microsoft Entra ID to allow users to use preexisting credentials to access applications. Developers can also use Microsoft Entra ID to create personalized end-user experiences by accessing organizational user data through APIs that are specific to Microsoft Entra ID.

If you subscribe to services like Azure or Microsoft 365, you're already taking advantage of Microsoft Entra ID. You could use Microsoft Entra ID to further manage access to your cloud applications.

<a name='identity-secure-score-in-azure-ad'></a>

## Identity secure score in Microsoft Entra ID

If you're an Administrator, you need to know how secure your Microsoft Entra tenant is. The identity secure score can help you understand. Microsoft Entra ID gives an overall percentage between 1 and 100. This value represents how well you match the recommendations and best practices that Microsoft suggests for tenant security. The identity secure score reveals how effective your security is and helps you implement improvements.

You can find your tenant's identity secure score in the Microsoft Entra admin center. Sign in to the Microsoft Entra admin center as at least a Global Reader, browse to **Microsoft Entra ID**, and choose **Identity Secure Score** to view the dashboard.

![Screenshot of the Microsoft Entra Identity Secure Score dashboard with its navigation item highlighted.](../media/2-secure-identity-score.png)

The dashboard shows information such as how you compare with the industry average and with tenants of the same size as yours. The dashboard also provides a graph that shows the changes in your score over time. You can see what to do to improve your score and how much effect each improvement can have on your score.

Use the identity secure score to improve and monitor the security of your identities in Microsoft Entra ID.

<a name='how-azure-ad-compares-with-active-directory'></a>

## How Microsoft Entra ID compares with Active Directory

Active Directory and Microsoft Entra ID are separate services that are used for different purposes.

Microsoft Entra ID is a cloud-based identity solution that helps you manage users and applications. Active Directory manages objects, like devices and users, on your on-premises network. Here are some other differences:

|Service|Authentication  |Structure  |Used for  
|---------|---------|---------|---------
|Active Directory     |Kerberos, NTLM| Forests, domains,  organizational  units | Authentication and authorization for on-premises printers, applications, file services, and more
|Microsoft Entra ID     |Includes SAML, OAuth, WS-Federation|Tenants|Internet-based services and applications like Microsoft 365, Azure services, and third-party SaaS applications

![Diagram that shows Active Directory serving on-premises apps and Microsoft Entra ID serving cloud apps.](../media/2-azure-ad-compared-active-directory.svg)

Microsoft Entra ID doesn't replace Active Directory. The service you use depends on your organization's needs. You can use the two services together so you can take advantage of their combined features and capabilities.

<a name='hybrid-identity-for-linking-on-premises-active-directory-with-azure-ad'></a>

## Hybrid identity for linking on-premises Active Directory with Microsoft Entra ID

Your users want to access applications from both the cloud and on-premises. You can use Microsoft Entra ID and Active Directory together to provide an identity solution that spans on-premises and the cloud. Users can use single user identity for authentication and to access applications and resources, whatever their location. This user identity is called a hybrid identity.

Multiple authentication methods let you achieve hybrid identity for users:

- **Microsoft Entra password hash synchronization**: Here, the user's password is hashed twice and synchronized between the on-premises Active Directory and Microsoft Entra ID. Users have the same credentials to access resources and applications, both on-premises and in the cloud.

- **Microsoft Entra pass-through authentication**: Here, an agent is installed via on-premises servers that authenticates against the on-premises Active Directory. When a Microsoft Entra user account tries to authenticate, password authentication is handled on-premises through these servers and Active Directory.

- **Federated authentication**: Here, an on-premises Active Directory Federation Services (AD FS) server that validates users' passwords performs the authentication process. Use this authentication method if you want advanced measures like smart card-based authentication for users.

These authentication options allow you to give users a single sign-on experience. Using single sign-on means users are automatically signed in when they use company devices and connect to your internal corporate network.

Use the following table as a reference for which options to use for particular scenarios:

|You want to:  |Password hash synchronization|Pass-through authentication|Federated authentication
|---------|---------|---------|---------
|Automatically synchronize to the cloud the users, contacts, and groups that are set up via on-premises Active Directory|Yes|Yes|Yes
|Allow users to access cloud applications and resources by using their on-premises password|Yes|Yes|Yes
|Ensure that password hashes aren't stored in the cloud|No|Yes|Yes
|Use cloud-based multifactor authentication|Yes |Yes|Yes
|Use on-premises multifactor authentication|No|No|Yes
|Use smart card authentication for added protection|No|No|Yes

## European identity data storage

Microsoft Entra data residency depends on the tenant's provisioning location and the services you use. For European tenants, review the documented storage and processing boundaries and any service-specific exceptions. The following table highlights considerations for workforce and external tenants:

|Service|Data-residency considerations|
|---------|---------
|Microsoft Entra B2B (Microsoft Entra B2B)| Guest users access applications through a link in an invitation email or a link shared directly with them. These redemption links are stored in US datacenters. If a user unsubscribes from invitation messages, their email address is also stored in US datacenters.  
|Microsoft Entra External ID in an external tenant|Directory data is stored in the geography mapped from the country or region selected when the external tenant is created. This selection can't be changed later. Available storage locations and service-specific exceptions can differ from those for workforce tenants.|
| Microsoft Entra multifactor authentication | SMS and phone calls originate from datacenters in the customer's region, but global providers can route them outside that region. Calls using custom greetings originate from US datacenters. Microsoft Authenticator push notifications are processed in regional datacenters based on the user's location; device-vendor push services can be outside that location. |

> [!NOTE]
> Data residency depends on the service, tenant provisioning location, configuration, and documented exceptions. For current guidance on storage locations and exceptions, consult [European customer data storage guidance for Microsoft Entra ID](/entra/fundamentals/data-storage-eu) and [Microsoft Entra data residency guidance, including external tenants](/entra/fundamentals/data-residency) before making data-residency decisions. Don't interpret regional processing as a guarantee that every authentication-related operation remains within Europe. For MFA-specific behavior, see [Microsoft Entra multifactor authentication data residency](/entra/identity/authentication/concept-mfa-data-residency).
