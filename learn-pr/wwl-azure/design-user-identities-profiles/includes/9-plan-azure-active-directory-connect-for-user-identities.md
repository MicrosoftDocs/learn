
To keep Windows Server Active Directory in sync with Azure Active Directory, you can configure Azure AD Connect (for hybrid organizations).

:::image type="content" source="../media/what-is-azure-ad-connect-7e4ac856.png" alt-text="What is Azure AD Connect":::


Azure AD Connect is the Microsoft tool designed to meet and accomplish your hybrid identity goals. It provides the following features:

 -  [Password hash synchronization](/azure/active-directory/hybrid/whatis-phs) \- A sign-in method that synchronizes a hash of a users on-premises AD password with Azure AD.

:::image type="content" source="../media/password-hash-sync-4c2f8fca.png" alt-text="Diagram that shows hash of a users on-premises AD password with Azure AD.":::


 -  [Pass-through authentication](/azure/active-directory/hybrid/how-to-connect-pta) \- A sign-in method that allows users to use the same password on-premises and in the cloud, but doesn't require more infrastructure of a federated environment.

:::image type="content" source="../media/pass-through-auth-09a91850.png" alt-text="Diagram that shows how to use the same password on-premises and in the cloud.":::


 -  [Federation integration](/azure/active-directory/hybrid/how-to-connect-fed-whatis) \- Federation is an optional part of Azure AD Connect and can be used to configure a hybrid environment using an on-premises AD FS infrastructure. It also provides AD FS management capabilities such as certificate renewal and additional AD FS server deployments.

:::image type="content" source="../media/auth-federation-057705ee.png" alt-text="Diagram that shows how to configure a hybrid environment using an on-premises AD FS infrastructure.":::


 -  [Synchronization](/azure/active-directory/hybrid/how-to-connect-sync-whatis) \- Responsible for creating users, groups, and other objects. As well as, making sure identity information for your on-premises users and groups is matching the cloud. This synchronization also includes password hashes.
 -  [Health Monitoring](/azure/active-directory/hybrid/whatis-hybrid-identity-health) \- Azure AD Connect Health can provide robust monitoring and provide a central location in the Azure portal to view this activity.

Azure Virtual Desktop supports hybrid identities through Azure Active Directory (AD), including those federated using Active Directory Federation Services (ADFS).

Since users must be discoverable through Azure AD, Azure Virtual Desktop doesn't support standalone Active Directory deployments with ADFS.

The only way to avoid being prompted for your credentials for the session host is to save them in the client. We recommend you only do this with secure devices to prevent other users from accessing your resources.<br>

Windows 10 Enterprise multi-session is currently supported to be hybrid Azure AD-joined. After Windows 10 Enterprise multi-session is domain-joined, use the existing Group Policy Object to enable Azure AD registration.
