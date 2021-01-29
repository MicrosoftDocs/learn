Organizations may use the hybrid identity model, or the cloud-only identity model. In the hybrid model, identities are created in Windows Active Directory or another identity provider, and then synchronized to Azure AD. In the cloud-only model, identities are created and wholly managed in Azure AD. Whether identities are created on-premises or in the cloud, users can access both cloud and on-premises resources.

With the hybrid model, users accessing both on-premises and cloud apps are hybrid users managed in the on-premises Active Directory.  When you make an update in your on-premises AD DS, all updates to user accounts, groups, and contacts are synchronized to your Azure AD. The synchronization is managed with *Azure AD Connect*.

![Azure AD connect manages the synchronization to Azure Active Directory](../media//azure-active-directory-connect-expanded.png)


When using the hybrid model, authentication can either be done by Azure AD, which is known as *managed authentication*, or Azure AD redirects the client requesting authentication to another identity provider, which is known as *federated authentication*.

One of three authentication methods can be used:

* **Password hash synchronization**. The simplest way to enable authentication for on-premises directory objects in Azure AD. Users have the same username and password that they use on-premises without any other infrastructure required.
* **Pass-through authentication (PTA)**. Provides a simple password validation for Azure AD authentication services by using a software agent that runs on one or more on-premises servers.  The servers validate the users directly with an on-premises Active Directory, which ensures that the password validation doesn't happen in the cloud.
* **Federated authentication**. Azure AD hands off the authentication process to a separate trusted authentication system, such as on-premises Active Directory Federation Services (AD FS), to validate the user’s password.
