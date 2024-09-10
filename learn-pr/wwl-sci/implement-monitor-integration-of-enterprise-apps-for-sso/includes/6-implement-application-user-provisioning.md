In Microsoft Entra ID, the term app provisioning refers to automatically creating user identities and roles in the cloud ([SaaS](https://azure.microsoft.com/overview/what-is-saas/)) applications that users need access to. In addition to creating user identities, automatic provisioning includes the maintenance and removal of user identities as status or roles change. A common scenario is provisioning a Microsoft Entra user into applications like [Dropbox](/azure/active-directory/saas-apps/dropboxforbusiness-provisioning-tutorial), [Salesforce](/azure/active-directory/saas-apps/salesforce-provisioning-tutorial), [ServiceNow](/azure/active-directory/saas-apps/servicenow-provisioning-tutorial), and more.

:::image type="content" source="../media/provision-overview-676ba683.png" alt-text="Diagram of the process flow for Provisioning. You can automate and govern the provisioning process.":::


This feature lets you to the following actions.

 -  **Automate provisioning**: Automatically create new accounts in the right systems for new people when they join a team or organization.
 -  **Automate deprovisioning**: Automatically deactivate accounts in the right systems when people leave a team or organization.
 -  **Synchronize data between systems:** Ensure that the identities in the apps and systems are kept up to date based on changes in the directory or the human resources system.
 -  **Provision groups**: Provisioning a group to the applications that supports them.
 -  **Govern access:** Monitor and audit who has been provisioned into the applications.
 -  **Seamlessly deploy in brown field scenarios**: Match existing identities between systems and allow for easy integration, even when users already exist in the target system.
 -  **Use rich customization**: Take advantage of customizable attribute mappings that define what user data should flow from the source system to the target system.
 -  **Get alerts for critical events**: The provisioning service provides alerts for critical events and allows for Log Analytics integration where you can define custom alerts to suit your business needs.

## Manual vs. automatic provisioning

Applications in the Microsoft Entra ID gallery support either manual or automatic provisioning.

 -  Manual provisioning means there's no automatic Microsoft Entra provisioning connector for the app yet. User accounts must be created manually. Examples of this include adding users directly into the administrative portal of the app or uploading a spreadsheet with user account details. Consult the documentation provided by the app or contact the app developer to determine what mechanisms are available.
 -  Automatic means that a Microsoft Entra provisioning connector has been developed for this application. Follow the setup tutorial for setting up provisioning for the application.

In the Microsoft Entra ID gallery, applications that support automatic provisioning are designated by a **Provisioning** icon.

:::image type="content" source="../media/browse-gallery-1eb29b09.png" alt-text="Screenshot of the Provisioning icon in the application gallery.  Select to start the provisioning process.":::


The provisioning mode supported by an application is also visible on the **Provisioning** tab once you've added the application to your **Enterprise apps**.

## System for Cross-domain Identity Management

To help automate provisioning and deprovisioning, apps expose proprietary user and group APIs. However, every app tries to perform the same actions, such as creating or updating users, adding users to groups, or deprovisioning users. Yet, all these simple actions are implemented just slightly differently, using different endpoint paths, different methods to specify user information, and a different schema to represent each element of information.

To address these challenges, the System for Cross-domain Identity Management (SCIM) specification provides a common user schema to help users move into, out of, and around apps. SCIM is becoming the standard for provisioning and, when used in conjunction with federation standards like SAML or OpenID Connect, provides administrators an end-to-end, standards-based solution for access management.

## Build a System for Cross-domain Identity Management endpoint and configure user provisioning with Microsoft Entra ID

As an application developer, you can use the System for Cross-Domain Identity Management (SCIM) user management API to enable automatic provisioning of users and groups between your application and Microsoft Entra ID. The SCIM specification provides a common user schema for provisioning. When used in conjunction with federation standards like SAML or OpenID Connect, SCIM gives administrators an end-to-end, standards-based solution for access management.

SCIM is a standardized definition of two endpoints: a /Users endpoint and a /Groups endpoint. It uses common Representational state transfer (REST) verbs to create, update, and delete objects, and a pre-defined schema for common attributes like group name, username, first name, last name, and email. Apps that offer a SCIM 2.0 REST API can reduce or eliminate the pain of working with a proprietary user management API. For example, any compliant SCIM client knows how to make an HTTP POST of a JSON object to the /Users endpoint to create a new user entry. Instead of needing a slightly different API for the same basic actions, apps that conform to the SCIM standard can instantly take advantage of pre-existing clients, tools, and code.

:::image type="content" source="../media/system-for-cross-domain-identity-management-provision-overview-9d92fdf9.png" alt-text="Diagram of Microsoft Entra ID with user provisioning sharing data with external apps.":::


The standard user object schema and REST APIs for management defined in SCIM 2.0 allow identity providers and apps to integrate with each other more easily. Application developers that build a SCIM endpoint can integrate with any SCIM-compliant client without having to do custom work, rather than starting from scratch and building the implementation completely on your own, you can rely on a number of open source SCIM libraries published by the SCIM community.
