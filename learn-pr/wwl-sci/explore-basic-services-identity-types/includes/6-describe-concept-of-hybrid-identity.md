Many organizations are a mixture of both cloud and on-premises applications. Regardless of whether an application is hosted on-premises or in the cloud, users expect and require easy access.
Microsoft’s identity solutions span on-premises and cloud-based capabilities. These solutions create a common user identity for authentication and authorization to all resources, regardless of location. We call this **hybrid identity**.  

An important consideration for organizations that operate in a mixed cloud and on-premises environment (hybrid model) is determining the right authentication method for their Azure AD solution, for their organization.  This is important because it's a key decision in an organization’s journey to the cloud and how users will sign in and access applications.  It's the foundation for the organization’s modern IT infrastructure on top of which organizations will build their security, identity, and access management solution using Azure AD.  Lastly, once an authentication method is established it becomes more difficult to change because it can disrupt users’ sign-in experience.
When it comes to authentication of hybrid identities, Microsoft offers several ways to authenticate.

- Azure AD Password hash synchronization.
- Azure AD Pass-through authentication
- Federated authentication

These hybrid authentication options, described below, require an on-premises active directory.  Additionally, Azure AD Connect, an on-premises Microsoft application that runs on a server, is required, and serves as a bridge between Azure AD and the on-premises Active Directory.

:::image type="content" source="../media/azure-active-directory-connect-expanded.png" alt-text="Azure AD connect manages the synchronization to Azure Active Directory":::

**Azure AD Password hash synchronization**. Azure AD password hash synchronization is the simplest way to enable authentication for on-premises directory objects in Azure AD.  Users can sign in to Azure AD services by using the same username and password that they use to sign in to their on-premises Active Directory instance.  Azure AD handles users' sign in process.

The Active Directory domain service (AD DS) stores passwords in the form of a hash value representation, of the actual user password. With Azure AD password hash synchronization, the password hash is extracted from the on-premises Active Directory instance using Azure AD Connect.  Some extra security is applied to the password hash and then it's synchronized to the Azure Active Directory authentication service. When a user attempts to sign into Azure AD and enters their password, the password is run through the same hashing algorithm and additional security that was applied to the version stored in Azure AD, as part of the synchronization. If the result matches the hash value stored in Azure AD, the user has entered the correct password and is authenticated.

:::image type="content" source="../media/password-hash-sync.png" alt-text="Azure AD Password hash synchronization topology diagram.":::

**Azure AD pass-through authentication**. Azure AD pass-through authentication, like password hash synchronization, allows users to sign in to both on-premises and cloud-based applications using the same passwords and uses Azure AD to handles users' sign in process. A difference from password hash synchronization is that pass-through authentication can enforce the on-premises account policy at the time of sign-in.  This can be an important factor for organizations that need to preserve on-premises policies, for security or compliance reasons.

Azure AD pass-through authentication also uses Azure AD Connect but has the additional requirement of running one or more authentication agents running on a server, resulting in a larger infrastructure footprint.

When a user tries to access an application to which they  aren't already signed in, they get redirected to the Azure AD sign-in page to enter their username and password.  Azure AD will encrypt the user password with the public key of the Authentication Agent.  The on-premises Authentication Agent retrieves the username and encrypted password from Azure AD, decrypts the password with its private key, and validates the username and password against Active Directory.  Active Directory evaluates the request and provides a response (success, failure, password expired, or user locked out) back to the agent, who then notifies Azure AD.  If the response indicates success, then Azure AD will respond by authenticating the user.

:::image type="content" source="../media/pass-through-authentication.png" alt-text="Azure AD pass-through authentication topology diagram.":::

**Federated authentication**. Federation is recommended as an authentication for organizations that have advanced features not currently supported in Azure AD, including sign-on using smart cards or certificates, sign-on using on-premises multi-factor authentication (MFA) server, and sign-on using a third party authentication solution. 

In federated authentication, Azure AD hands off the authentication process to a separate trusted authentication system, such as on-premises Active Directory Federation Services (AD FS), to validate the user’s password.

Federated authentication uses Azure AD Connect but also requires additional servers to support federation, resulting in a larger infrastructure footprint. 

:::image type="content" source="../media/federated-authentication.png" alt-text="Federated authentication topology diagram.":::
