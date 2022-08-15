Azure AD application provisioning refers to automatically creating user identities and roles in the applications that users need access to. In addition to creating user identities, automatic provisioning includes the maintenance and removal of user identities as status or roles change. Common scenarios include provisioning an Azure AD user into SaaS applications like Dropbox, Salesforce, ServiceNow, and many more.

Azure AD also supports provisioning users into applications hosted on-premises or in a virtual machine, without having to open firewalls. If an application supports System for Cross-domain Identity Management (SCIM), or you've built a SCIM gateway to connect to your legacy application, you can use the Azure AD Provisioning agent to directly connect with your application and automate provisioning and deprovisioning. If you have legacy applications that don't support SCIM and rely on a Lightweight Directory Access Protocol (LDAP) user store or a SQL database, Azure AD can support those as well.

App provisioning lets you:

- **Automate provisioning**: Automatically create new accounts in the right systems for new people when they join your team or organization.
- **Automate deprovisioning**: Automatically deactivate accounts in the right systems when people leave the team or organization.
- **Synchronize data between systems**: Ensure that the identities in your apps and systems are kept up to date based on changes in the directory or your human resources system.
- **Provision groups**: Provision groups to applications that support them.
- **Govern access**: Monitor and audit who has been provisioned into your applications.
- **Seamlessly deploy in brown field scenarios**: Match existing identities between systems and allow for easy integration, even when users already exist in the target system.
- **Use rich customization**: Take advantage of customizable attribute mappings that define what user data should flow from the source system to the target system.
- **Get alerts for critical events**: The provisioning service provides alerts for critical events and allows for Log Analytics integration where you can define custom alerts to suit your business needs.
