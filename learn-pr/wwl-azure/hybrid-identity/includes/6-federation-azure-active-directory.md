## What is federation with Azure AD?

**Federation** is a collection of domains that have established trust. The level of trust may vary but typically includes authentication and almost always includes authorization. A typical federation might include a number of organizations that have established trust for shared access to a set of resources.

You can federate your on-premises environment with Azure AD and use this federation for authentication and authorization. This sign-in method ensures that all user authentication occurs on-premises. This method allows administrators to implement more rigorous levels of access control. Federation with AD FS and PingFederate is available.

:::image type="content" source="../media/federated-identity-with-azure-ad-ca7d2f4d.png" alt-text="Image showing  how to federate an on-premises environment with Azure AD and use the federation for authentication and authorization.":::


> [!TIP]
> If you decide to use Federation with Active Directory Federation Services (AD FS), you can optionally set up password hash synchronization as a backup in case your AD FS infrastructure fails.
