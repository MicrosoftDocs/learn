You can perform various AD FS-related tasks in Azure AD Connect with minimal user intervention by using the Azure AD Connect wizard. Even after you've finished installing Azure AD Connect by running the wizard, you can run the wizard again to perform additional tasks such as repairing the trust with Microsoft 365, federating with Azure AD using alternate login ID, adding an AD FS server, and adding an AD FS Web Application Proxy (WAP) server.

## Device writeback

Device writeback is used to enable device-based conditional access for ADFS-protected devices. This provides additional security as well as assurance that access to applications is granted only to trusted devices. Device writeback enables this by synchronizing all devices registered in Azure back to the on-premises Active Directory. When configured during setup, the following operations are performed to prepare the AD forest:

- If they do not exist already, create and configure new containers and objects under CN=Device Registration Configuration,CN=Services,CN=Configuration,[forest-dn].

- If they do not exist already, create and configure new containers and objects under CN=RegisteredDevices,[domain-dn]. Device objects will be created in this container.

- Set necessary permissions on the Azure AD Connector account, to manage devices on your Active Directory.

Note that this only needs to be run on one forest even if Azure AD Connect is being installed in multiple forests.

