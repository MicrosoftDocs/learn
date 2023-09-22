

To join a Windows device, the device registration service must be configured to enable you to register devices. In addition to having permission to joining devices in your Azure AD tenant, you must have fewer devices registered than the configured maximum.

In addition, if your tenant is federated, your Identity provider MUST support WS-Fed and WS-Trust username/password endpoint. This can be version 1.3 or 2005. This protocol support is required to both join the device to Azure AD and log on to the device with a password.

Azure AD join is intended for organizations that want to be cloud-first (that is, primarily use cloud services, with a goal to reduce use of an on-premises infrastructure) or cloud-only (no on-premises infrastructure). There are no restrictions on the size or type of organizations that can deploy Azure AD join. Azure AD join works well even in a hybrid environment, enabling access to both cloud and on-premises apps and resources.

Implementing Azure AD joined devices provides you with the following benefits:

 -  Single-Sign-On (SSO) to your Azure managed SaaS apps and services. Your users don’t see additional authentication prompts when accessing work resources. The SSO feature remains accessible even when disconnected from the domain network.
 -  Enterprise compliant roaming of user settings across joined devices. Users don’t need to connect a Microsoft account (for example, Hotmail) to see settings across devices.
 -  Windows Hello support for secure and convenient access to work resources.
 -  Restriction of access to apps from only devices that meet compliance policy.
 -  Seamless access to on-premises resources when the device has line of sight to the on-premises domain controller.

For organizations that have on-premises Windows Server Active Directory infrastructure, using Azure AD offers:

 -  You want to transition to cloud-based infrastructure using Azure AD and mobile device management (MDM) like Intune.
 -  Scenarios where you can’t use an on-premises domain join. For example, if you need to get mobile devices such as tablets and phones under control.
 -  Your users primarily need to access Microsoft 365 or other SaaS apps integrated with Azure AD.
 -  You want to manage a group of users in Azure AD instead of in Active Directory. This can apply, for example, to seasonal workers, contractors, or students.
 -  You want to provide joining capabilities to workers in remote branch offices with limited on-premises infrastructure.
