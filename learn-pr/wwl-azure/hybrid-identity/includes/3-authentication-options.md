Choosing the correct authentication method is the first concern for organizations wanting to move their apps to the cloud. Don't take this decision lightly, for the following reasons:

 -  It's the first decision for an organization that wants to move to the cloud.
 -  The authentication method is a critical component of an organization’s presence in the cloud. It controls access to all cloud data and resources.
 -  It's the foundation of all the other advanced security and user experience features in Azure AD.

Identity is the new control plane of IT security, so authentication is an organization’s access guard to the new cloud world. Organizations need an identity control plane that strengthens their security and keeps their cloud apps safe from intruders.

### Authentication methods<br>

When the Azure AD hybrid identity solution is your new control plane, authentication is the foundation of cloud access. Choosing the correct authentication method is a crucial first decision in setting up an Azure AD hybrid identity solution. Implement the authentication method that is configured by using Azure AD Connect, which also provisions users in the cloud.

Azure AD supports the following authentication methods for hybrid identity solutions.

### Cloud authentication<br>

When you choose this authentication method, Azure AD handles users' sign-in process. Coupled with seamless single sign-on (SSO), users can sign in to cloud apps without having to reenter their credentials. With cloud authentication, you can choose from two options:

**Option 1: Azure AD password hash synchronization.** The simplest way to enable authentication for on-premises directory objects in Azure AD. Users can use the same username and password that they use on-premises without having to deploy any additional infrastructure. Some premium features of Azure AD, like Identity Protection and Azure AD Domain Services, require password hash synchronization, no matter which authentication method you choose.

**Option 2:** **Azure AD Pass-through Authentication.** Provides a simple password validation for Azure AD authentication services by using a software agent that runs on one or more on-premises servers. The servers validate the users directly with your on-premises Active Directory, which ensures that the password validation doesn't happen in the cloud.

Companies with a security requirement to immediately enforce on-premises user account states, password policies, and sign-in hours might use this authentication method.

### Federated authentication

When you choose the Federated authentication method, Azure AD hands off the authentication process to a separate trusted authentication system, such as on-premises Active Directory Federation Services (AD FS), to validate the user’s password.

The authentication system can provide additional advanced authentication requirements. Examples are smartcard-based authentication or third-party multifactor authentication.

:::image type="content" source="../media/az500-authentication-options-486aa8b5.png" alt-text="Diagram on choosing an authentication method.":::
<br>

## Summary

 -  This lesson outlines various authentication options that organizations can configure and deploy to support access to cloud apps.
 -  To meet various business, security, and technical requirements, organizations can choose between password hash synchronization, Pass-through Authentication, and federation.
 -  Consider each authentication method. Does the effort to deploy the solution, and the user's experience of the sign-in process address your business requirements?
 -  Evaluate whether your organization needs the advanced scenarios and business continuity features of each authentication method.
 -  Finally, evaluate the considerations of each authentication method. Do any of them prevent you from implementing your choice?
