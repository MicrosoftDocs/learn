In Microsoft Entra ID, if another administrator or non-administrator needs to manage Microsoft Entra resources, you assign them a Microsoft Entra role that provides the permissions they need. For example, you can **assign roles to allow adding** or **changing users**, **resetting user passwords**, **managing user licenses**, or **managing domain names**.

The following is a list of Microsoft Entra built-in roles and is not an exhaustive representation.

 -  Application Administrator \[**PRIVILEGED**\]
 -  Application Developer \[**PRIVILEGED**\]
 -  Attribute Assignment Administrator
 -  Attribute Assignment Reader
 -  Attribute Definition Administrator
 -  Attribute Definition Reader
 -  Attribute Log Administrator
 -  Attribute Log Reader
 -  Authentication Administrator \[**PRIVILEGED**\]
 -  Authentication Policy Administrator

## Application Administrator

This is a privileged role. Users in this role can create and manage all aspects of enterprise applications, application registrations, and application proxy settings. Note that users assigned to this role are not added as owners when creating new application registrations or enterprise applications.

This role also grants the ability to consent for delegated permissions and application permissions, with the exception of application permissions for Microsoft Graph.

> [!IMPORTANT]
> This exception means that you can still consent to application permissions for other apps (for example, non-Microsoft apps or apps that you have registered). You can still request these permissions as part of the app registration, but granting (that is, consenting to) these permissions requires a more privileged administrator, such as Global Administrator.

This role grants the ability to manage application credentials. Users assigned this role can add credentials to an application, and use those credentials to impersonate the application’s identity. If the application’s identity has been granted access to a resource, such as the ability to create or update User or other objects, then a user assigned to this role could perform those actions while impersonating the application. This ability to impersonate the application’s identity may be an elevation of privilege over what the user can do via their role assignments. It is important to understand that assigning a user to the Application Administrator role gives them the ability to impersonate an application’s identity.

| **Actions**                                                                                          | **Description**                                                                                                                                                |
| ---------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| microsoft.directory/adminConsentRequestPolicy/allProperties/allTasks                                 | Manage admin consent request policies in Microsoft Entra ID                                                                                                    |
| microsoft.directory/appConsent/appConsentRequests/allProperties/read                                 | Read all properties of consent requests for applications registered with Microsoft Entra ID                                                                    |
| microsoft.directory/applications/create                                                              | Create all types of applications                                                                                                                               |
| microsoft.directory/applications/delete                                                              | Delete all types of applications                                                                                                                               |
| microsoft.directory/applications/applicationProxy/read                                               | Read all application proxy properties                                                                                                                          |
| microsoft.directory/applications/applicationProxy/update                                             | Update all application proxy properties                                                                                                                        |
| microsoft.directory/applications/applicationProxyAuthentication/update                               | Update authentication on all types of applications                                                                                                             |
| microsoft.directory/applications/applicationProxySslCertificate/update                               | Update SSL certificate settings for application proxy                                                                                                          |
| microsoft.directory/applications/applicationProxyUrlSettings/update                                  | Update URL settings for application proxy                                                                                                                      |
| microsoft.directory/applications/appRoles/update                                                     | Update the appRoles property on all types of applications                                                                                                      |
| microsoft.directory/applications/audience/update                                                     | Update the audience property for applications                                                                                                                  |
| microsoft.directory/applications/authentication/update                                               | Update authentication on all types of applications                                                                                                             |
| microsoft.directory/applications/basic/update                                                        | Update basic properties for applications                                                                                                                       |
| microsoft.directory/applications/credentials/update                                                  | Update application credentials<br>\[**PRIVILEGED**\]                                                                                                           |
| microsoft.directory/applications/extensionProperties/update                                          | Update extension properties on applications                                                                                                                    |
| microsoft.directory/applications/notes/update                                                        | Update notes of applications                                                                                                                                   |
| microsoft.directory/applications/owners/update                                                       | Update owners of applications                                                                                                                                  |
| microsoft.directory/applications/permissions/update                                                  | Update exposed permissions and required permissions on all types of applications                                                                               |
| microsoft.directory/applications/policies/update                                                     | Update policies of applications                                                                                                                                |
| microsoft.directory/applications/tag/update                                                          | Update tags of applications                                                                                                                                    |
| microsoft.directory/applications/verification/update                                                 | Update applicationsverification property                                                                                                                       |
| microsoft.directory/applications/synchronization/standard/read                                       | Read provisioning settings associated with the application object                                                                                              |
| microsoft.directory/applicationTemplates/instantiate                                                 | Instantiate gallery applications from application templates                                                                                                    |
| microsoft.directory/auditLogs/allProperties/read                                                     | Read all properties on audit logs, excluding custom security attributes audit logs                                                                             |
| microsoft.directory/connectors/create                                                                | Create application proxy connectors                                                                                                                            |
| microsoft.directory/connectors/allProperties/read                                                    | Read all properties of application proxy connectors                                                                                                            |
| microsoft.directory/connectorGroups/create                                                           | Create application proxy connector groups                                                                                                                      |
| microsoft.directory/connectorGroups/delete                                                           | Delete application proxy connector groups                                                                                                                      |
| microsoft.directory/connectorGroups/allProperties/read                                               | Read all properties of application proxy connector groups                                                                                                      |
| microsoft.directory/connectorGroups/allProperties/update                                             | Update all properties of application proxy connector groups                                                                                                    |
| microsoft.directory/customAuthenticationExtensions/allProperties/allTasks                            | Create and manage custom authentication extensions<br>\[**PRIVILEGED**\]                                                                                       |
| microsoft.directory/deletedItems.applications/delete                                                 | Permanently delete applications, which can no longer be restored                                                                                               |
| microsoft.directory/deletedItems.applications/restore                                                | Restore soft deleted applications to original state                                                                                                            |
| microsoft.directory/oAuth2PermissionGrants/allProperties/allTasks                                    | Create and delete OAuth 2.0 permission grants, and read and update all properties<br>\[**PRIVILEGED**\]                                                        |
| microsoft.directory/applicationPolicies/create                                                       | Create application policies                                                                                                                                    |
| microsoft.directory/applicationPolicies/delete                                                       | Delete application policies                                                                                                                                    |
| microsoft.directory/applicationPolicies/standard/read                                                | Read standard properties of application policies                                                                                                               |
| microsoft.directory/applicationPolicies/owners/read                                                  | Read owners on application policies                                                                                                                            |
| microsoft.directory/applicationPolicies/policyAppliedTo/read                                         | Read application policies applied to objects list                                                                                                              |
| microsoft.directory/applicationPolicies/basic/update                                                 | Update standard properties of application policies                                                                                                             |
| microsoft.directory/applicationPolicies/owners/update                                                | Update the owner property of application policies                                                                                                              |
| microsoft.directory/provisioningLogs/allProperties/read                                              | Read all properties of provisioning logs                                                                                                                       |
| microsoft.directory/servicePrincipals/create                                                         | Create service principals                                                                                                                                      |
| microsoft.directory/servicePrincipals/delete                                                         | Delete service principals                                                                                                                                      |
| microsoft.directory/servicePrincipals/disable                                                        | Disable service principals                                                                                                                                     |
| microsoft.directory/servicePrincipals/enable                                                         | Enable service principals                                                                                                                                      |
| microsoft.directory/servicePrincipals/getPasswordSingleSignOnCredentials                             | Manage password single sign-on credentials on service principals                                                                                               |
| microsoft.directory/servicePrincipals/synchronizationCredentials/manage                              | Manage application provisioning secrets and credentials                                                                                                        |
| microsoft.directory/servicePrincipals/synchronizationJobs/manage                                     | Start, restart, and pause application provisioning synchronization jobs                                                                                        |
| microsoft.directory/servicePrincipals/synchronizationSchema/manage                                   | Create and manage application provisioning synchronization jobs and schema                                                                                     |
| microsoft.directory/servicePrincipals/synchronization.cloudTenantToExternalSystem/credentials/manage | Manage application provisioning secrets and credentials.                                                                                                       |
| microsoft.directory/servicePrincipals/synchronization.cloudTenantToExternalSystem/jobs/manage        | Start, restart, and pause application provisioning synchronization jobs.                                                                                       |
| microsoft.directory/servicePrincipals/synchronization.cloudTenantToExternalSystem/schema/manage      | Create and manage application provisioning synchronization jobs and schema.                                                                                    |
| microsoft.directory/servicePrincipals/managePasswordSingleSignOnCredentials                          | Read password single sign-on credentials on service principals                                                                                                 |
| microsoft.directory/servicePrincipals/managePermissionGrantsForAll.microsoft-application-admin       | Grant consent for application permissions and delegated permissions on behalf of any user or all users, except for application permissions for Microsoft Graph |
| microsoft.directory/servicePrincipals/appRoleAssignedTo/update                                       | Update service principal role assignments                                                                                                                      |
| microsoft.directory/servicePrincipals/audience/update                                                | Update audience properties on service principals                                                                                                               |
| microsoft.directory/servicePrincipals/authentication/update                                          | Update authentication properties on service principals                                                                                                         |
| microsoft.directory/servicePrincipals/basic/update                                                   | Update basic properties on service principals                                                                                                                  |
| microsoft.directory/servicePrincipals/credentials/update                                             | Update credentials of service principals \[**PRIVILEGED**\]                                                                                                    |
| microsoft.directory/servicePrincipals/notes/update                                                   | Update notes of service principals                                                                                                                             |
| microsoft.directory/servicePrincipals/owners/update                                                  | Update owners of service principals                                                                                                                            |
| microsoft.directory/servicePrincipals/permissions/update                                             | Update permissions of service principals                                                                                                                       |
| microsoft.directory/servicePrincipals/policies/update                                                | Update policies of service principals                                                                                                                          |
| microsoft.directory/servicePrincipals/tag/update                                                     | Update the tag property for service principals                                                                                                                 |
| microsoft.directory/servicePrincipals/synchronization/standard/read                                  | Read provisioning settings associated with your service principal                                                                                              |
| microsoft.directory/signInReports/allProperties/read                                                 | Read all properties on sign-in reports, including privileged properties                                                                                        |
| microsoft.azure.serviceHealth/allEntities/allTasks                                                   | Read and configure Azure Service Health                                                                                                                        |
| microsoft.azure.supportTickets/allEntities/allTasks                                                  | Create and manage Azure support tickets                                                                                                                        |
| microsoft.office365.serviceHealth/allEntities/allTasks                                               | Read and configure Service Health in the Microsoft 365 admin center                                                                                            |
| microsoft.office365.supportTickets/allEntities/allTasks                                              | Create and manage Microsoft 365 service requests                                                                                                               |
| microsoft.office365.webPortal/allEntities/standard/read                                              | Read basic properties on all resources in the Microsoft 365 admin center                                                                                       |

## Application Developer

This is a privileged role. Users in this role can create application registrations when the "Users can register applications" setting is set to No. This role also grants permission to consent on one's own behalf when the "Users can consent to apps accessing company data on their behalf" setting is set to No. Users assigned to this role are added as owners when creating new application registrations.

| **Actions**                                              | **Description**                                                                           |
| -------------------------------------------------------- | ----------------------------------------------------------------------------------------- |
| microsoft.directory/applications/createAsOwner           | Create all types of applications, and creator is added as the first owner                 |
| microsoft.directory/oAuth2PermissionGrants/createAsOwner | Create OAuth 2.0 permission grants, with creator as the first owner<br>\[**PRIVILEGED**\] |
| microsoft.directory/servicePrincipals/createAsOwner      | Create service principals, with creator as the first owner                                |

## Attribute Assignment Administrator

Users with this role can assign and remove custom security attribute keys and values for supported Microsoft Entra objects such as users, service principals, and devices.

By default, Global Administrator and other administrator roles do not have permissions to read, define, or assign custom security attributes. To work with custom security attributes, you must be assigned one of the custom security attribute roles.<br>

| **Actions**                                                                | **Description**                                                                |
| -------------------------------------------------------------------------- | ------------------------------------------------------------------------------ |
| microsoft.directory/azureManagedIdentities/customSecurityAttributes/read   | Read custom security attribute values for Microsoft Entra managed identities   |
| microsoft.directory/azureManagedIdentities/customSecurityAttributes/update | Update custom security attribute values for Microsoft Entra managed identities |
| microsoft.directory/attributeSets/allProperties/read                       | Read all properties of attribute sets                                          |
| microsoft.directory/customSecurityAttributeDefinitions/allProperties/read  | Read all properties of custom security attribute definitions                   |
| microsoft.directory/devices/customSecurityAttributes/read                  | Read custom security attribute values for devices                              |
| microsoft.directory/devices/customSecurityAttributes/update                | Update custom security attribute values for devices                            |
| microsoft.directory/servicePrincipals/customSecurityAttributes/read        | Read custom security attribute values for service principals                   |
| microsoft.directory/servicePrincipals/customSecurityAttributes/update      | Update custom security attribute values for service principals                 |
| microsoft.directory/users/customSecurityAttributes/read                    | Read custom security attribute values for users                                |
| microsoft.directory/users/customSecurityAttributes/update                  | Update custom security attribute values for users                              |

## Attribute Assignment Reader

Users with this role can read custom security attribute keys and values for supported Microsoft Entra objects.

By default, Global Administrator and other administrator roles do not have permissions to read, define, or assign custom security attributes. To work with custom security attributes, you must be assigned one of the custom security attribute roles.

| **Actions**                                                               | **Description**                                                              |
| ------------------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| microsoft.directory/attributeSets/allProperties/read                      | Read all properties of attribute sets                                        |
| microsoft.directory/azureManagedIdentities/customSecurityAttributes/read  | Read custom security attribute values for Microsoft Entra managed identities |
| microsoft.directory/customSecurityAttributeDefinitions/allProperties/read | Read all properties of custom security attribute definitions                 |
| microsoft.directory/devices/customSecurityAttributes/read                 | Read custom security attribute values for devices                            |
| microsoft.directory/servicePrincipals/customSecurityAttributes/read       | Read custom security attribute values for service principals                 |
| microsoft.directory/users/customSecurityAttributes/read                   | Read custom security attribute values for users                              |

## Attribute Definition Administrator

Users with this role can define a valid set of custom security attributes that can be assigned to supported Microsoft Entra objects. This role can also activate and deactivate custom security attributes.

By default, Global Administrator and other administrator roles do not have permissions to read, define, or assign custom security attributes. To work with custom security attributes, you must be assigned one of the custom security attribute roles.

| **Actions**                                                                   | **Description**                                             |
| ----------------------------------------------------------------------------- | ----------------------------------------------------------- |
| microsoft.directory/attributeSets/allProperties/allTasks                      | Manage all aspects of attribute sets                        |
| microsoft.directory/customSecurityAttributeDefinitions/allProperties/allTasks | Manage all aspects of custom security attribute definitions |

## Attribute Definition Reader

Users with this role can read the definition of custom security attributes.

By default, Global Administrator and other administrator roles do not have permissions to read, define, or assign custom security attributes. To work with custom security attributes, you must be assigned one of the custom security attribu<br>

| **Actions**                                                               | **Description**                                              |
| ------------------------------------------------------------------------- | ------------------------------------------------------------ |
| microsoft.directory/attributeSets/allProperties/read                      | Read all properties of attribute sets                        |
| microsoft.directory/customSecurityAttributeDefinitions/allProperties/read | Read all properties of custom security attribute definitions |

## Attribute Log Administrator

Assign the Attribute Log Reader role to users who need to do the following tasks:

 -  Read audit logs for custom security attribute value changes<br>
 -  Read audit logs for custom security attribute definition changes and assignments
 -  Configure diagnostic settings for custom security attributes

Users with this role **cannot** read audit logs for other events.

By default, Global Administrator and other administrator roles do not have permissions to read audit logs for custom security attributes. To read audit logs for custom security attributes, you must be assigned this role or the Attribute Log Reader role.<br>

| **Actions**                                                                                  | **Description**                                                         |
| -------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------- |
| microsoft.directory/customSecurityAttributeAuditLogs/allProperties/read                      | Read audit logs related to custom security attributes                   |
| microsoft.azure.customSecurityAttributeDiagnosticSettings/allEntities/allProperties/allTasks | Configure all aspects of custom security attributes diagnostic settings |

## Attribute Log Reader

Assign the Attribute Log Reader role to users who need to do the following tasks:

 -  Read audit logs for custom security attribute value changes<br>
 -  Read audit logs for custom security attribute definition changes and assignments

Users with this role **cannot** do the following tasks:

 -  Configure diagnostic settings for custom security attributes<br>
 -  Read audit logs for other events

By default, Global Administrator and other administrator roles do not have permissions to read audit logs for custom security attributes. To read audit logs for custom security attributes, you must be assigned this role or the Attribute Log Administrator role.

| **Actions**                                                             | **Description**                                       |
| ----------------------------------------------------------------------- | ----------------------------------------------------- |
| microsoft.directory/customSecurityAttributeAuditLogs/allProperties/read | Read audit logs related to custom security attributes |

## Authentication Administrator

This is a privileged role. Assign the Authentication Administrator role to users who need to do the following:

 -  Set or reset any authentication method (including passwords) for non-administrators and some roles. For a list of the roles that an Authentication Administrator can read or update authentication methods, see Who can reset passwords.<br>
 -  Require users who are non-administrators or assigned to some roles to re-register against existing non-password credentials (for example, MFA or FIDO), and can also revoke remember MFA on the device, which prompts for MFA on the next sign-in.
 -  Perform sensitive actions for some users. For more information, see Who can perform sensitive actions.
 -  Create and manage support tickets in Azure and the Microsoft 365 admin center.

Users with this role **cannot** do the following:

 -  Cannot change the credentials or reset MFA for members and owners of a role-assignable group.<br>
 -  Cannot manage MFA settings in the legacy MFA management portal or Hardware OATH tokens.

The following table compares the capabilities of authentication-related roles.

| **Role**                                | **Manage user's auth methods** | **Manage per-user MFA** | **Manage MFA settings** | **Manage auth method policy** | **Manage password protection policy** | **Update sensitive properties** | **Delete and restore users** |
| --------------------------------------- | ------------------------------ | ----------------------- | ----------------------- | ----------------------------- | ------------------------------------- | ------------------------------- | ---------------------------- |
| Authentication Administrator            | Yes for some users             | Yes for some users      | No                      | No                            | No                                    | Yes for some users              | Yes for some users           |
| Privileged Authentication Administrator | Yes for all users              | Yes for all users       | No                      | No                            | No                                    | Yes for all users               | Yes for all users            |
| Authentication Policy Administrator     | No                             | No                      | Yes                     | Yes                           | Yes                                   | No                              | No                           |
| User Administrator                      | No                             | No                      | No                      | No                            | No                                    | Yes for some users              | Yes for some users           |

> [!IMPORTANT]
> Users with this role can change credentials for people who may have access to sensitive or private information or critical configuration inside and outside of Microsoft Entra ID. Changing the credentials of a user may mean the ability to assume that user's identity and permissions. For example:

 -  Application Registration and Enterprise Application owners, who can manage credentials of apps they own. Those apps may have privileged permissions in Microsoft Entra ID and elsewhere not granted to Authentication Administrators. Through this path an Authentication Administrator can assume the identity of an application owner and then further assume the identity of a privileged application by updating the credentials for the application.<br>
 -  Azure subscription owners, who may have access to sensitive or private information or critical configuration in Azure.
 -  Security Group and Microsoft 365 group owners, who can manage group membership. Those groups may grant access to sensitive or private information or critical configuration in Microsoft Entra ID and elsewhere.
 -  Administrators in other services outside of Microsoft Entra ID like Exchange Online, Microsoft 365 Defender portal, Microsoft Purview compliance portal, and human resources systems.
 -  Non-administrators like executives, legal counsel, and human resources employees who may have access to sensitive or private information.

| **Actions**                                                             | **Description**                                                                                                      |
| ----------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| microsoft.directory/users/authenticationMethods/create                  | Update authentication methods for users<br><br>                                                                      |
| microsoft.directory/users/authenticationMethods/delete                  | Delete authentication methods for users<br>\[**PRIVILEGED**\]                                                        |
| microsoft.directory/users/authenticationMethods/standard/restrictedRead | Read standard properties of authentication methods that do not include personally identifiable information for users |
| microsoft.directory/users/authenticationMethods/basic/update            | Update basic properties of authentication methods for users<br>**\[PRIVILEGED\]**                                    |
| microsoft.directory/deletedItems.users/restore                          | Restore soft deleted users to original state                                                                         |
| microsoft.directory/users/delete                                        | Delete users<br>\[**PRIVILEGED**\]                                                                                   |
| microsoft.directory/users/disable                                       | Disable users<br>\[**PRIVILEGED**\]                                                                                  |
| microsoft.directory/users/enable                                        | Enable users<br>\[**PRIVILEGED**\]                                                                                   |
| microsoft.directory/users/invalidateAllRefreshTokens                    | Force sign-out by invalidating user refresh tokens<br>\[**PRIVILEGED**\]                                             |
| microsoft.directory/users/restore                                       | Restore deleted users                                                                                                |
| microsoft.directory/users/basic/update                                  | Update basic properties on users                                                                                     |
| microsoft.directory/users/manager/update                                | Update manager for users                                                                                             |
| microsoft.directory/users/password/update                               | Reset passwords for all users<br>\[**PRIVILEGED**\]                                                                  |
| microsoft.directory/users/userPrincipalName/update                      | Update User Principal Name of users<br>\[**PRIVILEGED**\]                                                            |
| microsoft.azure.serviceHealth/allEntities/allTasks                      | Read and configure Azure Service Health                                                                              |
| microsoft.azure.supportTickets/allEntities/allTasks                     | Create and manage Azure support tickets                                                                              |
| microsoft.office365.serviceHealth/allEntities/allTasks                  | Read and configure Service Health in the Microsoft 365 admin center                                                  |
| microsoft.office365.supportTickets/allEntities/allTasks                 | Create and manage Microsoft 365 service requests                                                                     |
| microsoft.office365.webPortal/allEntities/standard/read                 | Read basic properties on all resources in the Microsoft 365 admin center                                             |

## Authentication Policy Administrator

Assign the Authentication Policy Administrator role to users who need to do the following:

 -  Configure the authentication methods policy, tenant-wide MFA settings, and password protection policy that determine which methods each user can register and use.<br>
 -  Manage Password Protection settings: smart lockout configurations and updating the custom banned passwords list.
 -  Create and manage verifiable credentials.
 -  Create and manage Azure support tickets.

Users with this role **cannot** do the following:

 -  Cannot update sensitive properties. For more information, see Who can perform sensitive actions.<br>
 -  Cannot delete or restore users. For more information, see Who can perform sensitive actions.
 -  Cannot manage MFA settings in the legacy MFA management portal or Hardware OATH tokens.

The following table compares the capabilities of authentication-related roles.

| **Role**                                | **Manage user's auth methods** | **Manage per-user MFA** | **Manage MFA settings** | **Manage auth method policy** | **Manage password protection policy** | **Update sensitive properties** | **Delete and restore users** |
| --------------------------------------- | ------------------------------ | ----------------------- | ----------------------- | ----------------------------- | ------------------------------------- | ------------------------------- | ---------------------------- |
| Authentication Administrator            | Yes for some users             | Yes for some users      | No                      | No                            | No                                    | Yes for some users              | Yes for some users           |
| Privileged Authentication Administrator | Yes for all users              | Yes for all users       | No                      | No                            | No                                    | Yes for all users               | Yes for all users            |
| Authentication Policy Administrator     | No                             | No                      | Yes                     | Yes                           | Yes                                   | No                              | No                           |
| User Administrator                      | No                             | No                      | No                      | No                            | No                                    | Yes for some users              | Yes for some users           |

| **Actions**                                                                                | **Description**                                                                                                        |
| ------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------- |
| microsoft.directory/organization/strongAuthentication/allTasks                             | Manage all aspects of strong authentication properties of an organization                                              |
| microsoft.directory/userCredentialPolicies/create                                          | Create credential policies for users                                                                                   |
| microsoft.directory/userCredentialPolicies/delete                                          | Delete credential policies for users                                                                                   |
| microsoft.directory/userCredentialPolicies/standard/read                                   | Read standard properties of credential policies for users                                                              |
| microsoft.directory/userCredentialPolicies/owners/read                                     | Read owners of credential policies for users                                                                           |
| microsoft.directory/userCredentialPolicies/policyAppliedTo/read                            | Read policy.appliesTo navigation link                                                                                  |
| microsoft.directory/userCredentialPolicies/basic/update                                    | Update basic policies for users                                                                                        |
| microsoft.directory/userCredentialPolicies/owners/update                                   | Update owners of credential policies for users                                                                         |
| microsoft.directory/userCredentialPolicies/tenantDefault/update                            | Update policy.isOrganizationDefault property                                                                           |
| microsoft.directory/verifiableCredentials/configuration/contracts/cards/allProperties/read | Read a verifiable credential card                                                                                      |
| microsoft.directory/verifiableCredentials/configuration/contracts/cards/revoke             | Revoke a verifiable credential card                                                                                    |
| microsoft.directory/verifiableCredentials/configuration/contracts/create                   | Create a verifiable credential contract                                                                                |
| microsoft.directory/verifiableCredentials/configuration/contracts/allProperties/read       | Read a verifiable credential contract                                                                                  |
| microsoft.directory/verifiableCredentials/configuration/contracts/allProperties/update     | Update a verifiable credential contract                                                                                |
| microsoft.directory/verifiableCredentials/configuration/create                             | Create configuration required to create and manage verifiable credentials                                              |
| microsoft.directory/verifiableCredentials/configuration/delete                             | Delete configuration required to create and manage verifiable credentials and delete all of its verifiable credentials |
| microsoft.directory/verifiableCredentials/configuration/allProperties/read                 | Read configuration required to create and manage verifiable credentials                                                |
| microsoft.directory/verifiableCredentials/configuration/allProperties/update               | Update configuration required to create and manage verifiable credentials                                              |
| microsoft.azure.supportTickets/allEntities/allTasks                                        | Create and manage Azure support tickets                                                                                |
