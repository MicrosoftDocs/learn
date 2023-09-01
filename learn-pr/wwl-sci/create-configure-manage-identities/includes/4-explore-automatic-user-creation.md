:::image type="content" source="../media/automatic-user-provisioning-c953c4ef-d58236a8.png" alt-text="Diagram of the process flow for auto user provisioning.  The flow shows you can have users in an on-premises or cloud human resource management system automatically provisioned as user accounts in Azure A D.  The Azure A D provisioning service can be called to create and manage the user and groups.":::


### Components of system SCIM (System for Cross-Domain Identity Management)

 -  **HCM system** \- Applications and technologies that enable Human Capital Management process and practices that support and automate HR processes throughout the employee lifecycle.
 -  **Azure AD Provisioning Service** \- Uses the SCIM 2.0 protocol for automatic provisioning. The service connects to the SCIM endpoint for the application, and uses the SCIM user object schema and REST APIs to automate provisioning and de-provisioning of users and groups.
 -  **Azure AD** \- User repository used to manage the lifecycle of identities and their entitlements.
 -  **Target system** \- Application or system that has SCIM endpoint and works with the Azure AD provisioning to enable automatic provisioning of users and groups.

### Why use SCIM?

System for Cross-Domain Identity Management (SCIM) is an open standard protocol for automating the exchange of user identity information between identity domains and IT systems. SCIM ensures that employees added to the Human Capital Management (HCM) system automatically have accounts created in Azure Active Directory (Azure AD) or Windows Server Active Directory. User attributes and profiles are synchronized between the two systems, updating removing users based on the user status or role change.

The key is keeping your identity systems up to date. If a user can be automatically deprovisioned from Azure AD, as soon as the're removed from your HR-systems; you have less worry on a possible breach.
