You can perform various AD FS-related tasks in Azure AD Connect with minimal user intervention by using the Azure AD Connect wizard. Even after you've finished installing Azure AD Connect by running the wizard, you can run the wizard again to do other tasks. For example, you can use the wizard to repair the trust with Microsoft 365, federate with Azure AD using alternate login ID, and add an AD FS Web Application Proxy (WAP) server.

## Device writeback

Device writeback is used to enable device-based conditional access for ADFS-protected devices. This conditional access provides extra security and assurance that access to applications is granted only to trusted devices. Device writeback enables this security by synchronizing all devices registered in Azure back to the on-premises Active Directory. When configured during setup, the following operations are performed to prepare the AD forest:

- If they do not exist already, create and configure new containers and objects under CN=Device Registration Configuration,CN=Services,CN=Configuration,[forest-dn].

- If they do not exist already, create and configure new containers and objects under CN=RegisteredDevices,[domain-dn]. Device objects will be created in this container.

- Set necessary permissions on the Azure AD Connector account, to manage devices on your Active Directory.

This only needs to be run on one forest even if Azure AD Connect is being installed in multiple forests.

