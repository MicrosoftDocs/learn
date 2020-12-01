The board wants to enable secure and easy access to applications and services. These applications are available to internal staff and doctors from various countries.
Your team manager believes that Azure Active Directory (Azure AD) can address these needs. Your manager wants you to find out what Azure AD is, how it works, and what it does.

Here, you'll get an overview of Azure AD and see why you would use it. You'll learn about the differences between Azure AD and the traditional on-premises Active Directory.

## What is Azure AD?

Azure AD is a cloud-based identity management solution. It helps your company's internal users to:

- Access external resources, like Azure services, Microsoft 365, and third-party SaaS applications.

- Access internal resources such as applications on your corporate network, and cloud-based applications that your company builds.

Azure AD also helps you keep user identities and applications secure through features like conditional access and identity protection.

![Azure AD](../media/2-azure-ad.svg)

Azure AD stores your users in a tenant that represents an organization. For example, say you have a company tenant where all of your employee user accounts are stored. Users in this tenant can be added to groups so they have a common shared-access level. You could have one group for developers and another group for application testers. These groups would have different access levels for applications. Each tenant can have multiple groups that hold multiple users.

## Who benefits from Azure AD?

Azure AD meets the needs of many types of users. For instance, an IT administrator can use Azure AD to determine who should have access to applications and resources, based on company requirements. An administrator can add another layer of protection to applications and services by enforcing multi-factor authentication on sign-ins.

Application developers can use Azure AD to enable users to use preexisting credentials to access applications. Developers also use Azure AD to create personalized end-user experiences by accessing organizational user data through APIs that are specific to Azure AD.

If you subscribe to services like Azure or Microsoft 365, you're already taking advantage of Azure AD. You could use Azure AD to further manage access to your cloud applications.

## Identity secure score in Azure AD

If you're an administrator, you need to know how secure your Azure AD tenant is. The identity secure score can help you understand. Azure AD gives an overall value between 1 and 223. This value represents how well you match the recommendations and best practices that Microsoft suggests for tenant security. The identity secure score reveals how effective your security is and helps you implement improvements.

You can find your tenant's identity secure score in the Azure portal. Go to your Azure AD tenant, select **Security**, and then select the **Identity Secure Score** dashboard.

![Secure identity score](../media/2-secure-identity-score.png)

The dashboard shows information such as how you compare with the industry average and with tenants of the same size as yours. The dashboard also provides a graph that shows how your score has changed over time. You see what you can do to improve your score and how much impact each improvement will have.

Use the identity secure score to improve and monitor the security of your identities in Azure AD.

## How Azure AD compares with Active Directory

Active Directory and Azure AD share a similar name, but they're separate services that are used for different purposes.

Azure AD is a cloud-based identity solution that helps you manage users and applications. Active Directory manages objects, like devices and users, on your on-premises network. Here are some other differences:

|Service|Authentication  |Structure  |What it's used for  
|---------|---------|---------|---------|
|Active Directory     |Kerberos, NTLM| Forests, domains,  organizational  units | Authentication and authorization for on-premises printers, applications, file services, and more
|Azure Active Directory     |Includes SAML, OAuth, WS-Federation|Tenants|Internet-based services and applications like Microsoft 365, Azure services, and third-party SaaS applications

![A comparison between Active Directory and Azure AD](../media/2-azure-ad-compared-active-directory.svg)

Azure AD doesn't replace Active Directory. The service you use depends on your organization's needs. The two services can be used together, so you can take advantage of their combined features and capabilities.

## Hybrid identity for linking on-premises Active Directory with Azure AD

Your users will want to access applications from both the cloud and on-premises. You can use Azure AD and Active Directory together to provide an identity solution that spans on-premises and the cloud. A single user identity can be used for authentication and to access applications and resources, whatever their location. This user identity is called a hybrid identity.

Multiple authentication methods let you achieve hybrid identity for users:

- **Azure AD password hash synchronization**. Here, the user's password is hashed twice and synchronized between the on-premises Active Directory and Azure AD. Users have the same credentials to access resources and applications both on-premises and in the cloud.

- **Azure AD pass-through authentication**. Here, an agent is installed on on-premises servers that authenticate against the on-premises Active Directory. When an Azure AD user account tries to authenticate, password authentication is handled on-premises through these servers and Active Directory.

- **Federated authentication**. Here, the authentication process is performed by an on-premises Active Directory Federation Services (AD FS) server that validates users' passwords. Use this authentication method if you want advanced measures like smart card-based authentication for users.

These authentication options allow you to give users a single sign-on experience. Using single sign-on means users are automatically signed in when they use company devices and connect to your internal corporate network.

Use the following table as a reference for which options to use for particular scenarios:

|You want to:  |Password hash synchronization|Pass-through authentication|Federated authentication|
|---------|---------|---------|---------|
|Automatically synchronize to the cloud the users, contacts, and groups that have been set up on on-premises Active Directory.|Yes|Yes|Yes|
|Allow users to access cloud applications and resources by using their on-premises password.|Yes|Yes|Yes|
|Ensure that password hashes aren't stored in the cloud.|No|Yes|Yes|
|Use cloud-based multi-factor authentication.|Yes |Yes|Yes|
|Use on-premises multi-factor authentication.|No|No|Yes|
|Use smart card authentication for additional protection.|No|No|Yes|

## European identity data storage

When you subscribe to a service like Azure or Microsoft 365, all of your identity data is stored based on the address that you provide during the subscription process. If you're a customer who uses an address in Europe, Azure AD stores most of your data in European datacenters. However, some data is stored outside Europe by services that you use with Azure AD. Here are a few examples of some of the data that's stored outside Europe:

|Azure AD-based service |Data location  |
|---------|---------|
|Azure Active Directory B2B (Azure AD B2B)| Guest users access applications through a link in an invitation email or a link shared directly with them. These redemption links are stored in US datacenters. If a user unsubscribes from invitation messages, their email address is also stored in US datacenters.  |
|Azure Active Directory B2C (Azure AD B2C)|No personal data is stored outside of Europe, but policy configuration data is stored in US datacenters.|
|Azure AD Multi-Factor Authentication|Phone calls and text messages come from US datacenters, and global providers handle the routing. OAuth code validation happens in the US. Push notifications for the Microsoft Authenticator app come from US datacenters.|
