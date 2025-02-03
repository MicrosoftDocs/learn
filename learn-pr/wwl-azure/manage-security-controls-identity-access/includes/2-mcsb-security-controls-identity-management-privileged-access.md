## Security Control: Identity management

Identity Management covers controls to establish a secure identity and access controls using identity and access management systems, including the use of single sign-on, strong authentications, managed identities (and service principals) for applications, conditional access, and account anomalies monitoring.

### IM-1: Use centralized identity and authentication system

| **CIS Controls v8 ID(s)** | **NIST SP 800-53 r4 ID(s)** | **PCI-DSS ID(s) v3.2.1** |
| ------------------------- | --------------------------- | ------------------------ |
| 6.7, 12.5                 | AC-2, AC-3, IA-2, IA-8      | 7.2, 8.3                 |

Security principle: Use a centralized identity and authentication system to govern your organization's identities and authentications for cloud and non-cloud resources.<br>

Azure guidance: Azure Active Directory (Azure AD) is Azure's identity and authentication management service. You should standardize on Azure AD to govern your organization's identity and authentication in:

 -  Microsoft cloud resources, such as Azure Storage, Azure Virtual Machines (Linux and Windows), Azure Key Vault, PaaS, and SaaS applications.
 -  Your organization's resources, such as applications on Azure, third-party applications running on your corporate network resources, and third-party SaaS applications.
 -  Your enterprise identities in Active Directory by synchronization to Azure AD to ensure a consistent and centrally managed identity strategy.

For the Azure services that apply, avoid use of local authentication methods and instead use Azure Active Directory to centralize your service authentications.

Note: As soon as it is technically feasible, you should migrate on-premises Active Directory based applications to Azure AD. This could be an Azure AD Enterprise Directory, Business to Business configuration, or Business to consumer configuration.

Azure implementation and additional context:

 -  [Tenancy in Azure AD](/azure/active-directory/develop/single-and-multi-tenant-apps)
 -  [How to create and configure an Azure AD instance](/azure/active-directory/fundamentals/active-directory-access-create-new-tenant)
 -  [Define Azure AD tenants](https://azure.microsoft.com/resources/securing-azure-environments-with-azure-active-directory/)
 -  [Use external identity providers for an application](/azure/active-directory/b2b/identity-providers)

AWS guidance: AWS IAM (Identity and Access Management) is AWS' default identity and authentication management service. Use AWS IAM to govern your AWS identity and access management. Alternatively, through AWS and Azure Single Sign-On (SSO), you can also use Azure AD to manage the identity and access control of AWS to avoid managing duplicate accounts separately in two cloud platforms.

AWS supports Single Sign-On which allows you to bridge your corporate's third party identities (such as Windows Active Directory, or other identity stores) with the AWS identities to avoid creating duplicate accounts to access AWS resources.

AWS implementation and additional context:

 -  [AWS IAM](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html)
 -  [AWS Single Sign-On](https://docs.aws.amazon.com/singlesignon/index.html)

GCP guidance: Google Cloud's Identity and Access Management (IAM) system is Google Cloud's default identity and authentication management service used for Google Cloud Identity accounts. Use Google Cloud IAM to govern your GCP identity and access management. Alternatively, through the Google Cloud Identity and Azure Sigle Sign-On (SSO), you can also use Azure AD to manage the identity and access control of GCP to avoid managing duplicate accounts separately in a mutli-cloud environment.

Google Cloud Identity is the identity provider for all Google services. It supports Single Sign-On which allows you to bridge your corporate's third party identities (such as Windows Active Directory, or other identity stores) with Google Cloud identities to avoid creating duplicate accounts to access GCP resources.

Note: Using Google Cloud Directory Sync. Google provides connector tool that integrates with most enterprise LDAP management systems and synchronizes identities on a schedule. By configuring a Cloud Identity account and sing Google Cloud Directory Sync, you can configure which of your user accounts – including users, groups , and user profiles, aliases and more – will synchronize on a schedule between your local identity management system and your GCP system.

GCP implementation and additional context:

 -  [GCP IAM overview](https://cloud.google.com/iam/docs/overview)
 -  [Azure AD user provisioning and single sign-on](https://cloud.google.com/architecture/identity/federating-gcp-with-azure-ad-configuring-provisioning-and-single-sign-on)
 -  [Single sign-on](https://cloud.google.com/architecture/identity/single-sign-on)

Customer security stakeholders ([Learn more](/azure/cloud-adoption-framework/organize/cloud-security#security-functions)):

 -  [Identity and key management](/azure/cloud-adoption-framework/organize/cloud-security-identity-keys)
 -  [Security architecture](/azure/cloud-adoption-framework/organize/cloud-security-architecture)
 -  [Application security and DevSecOps](/azure/cloud-adoption-framework/organize/cloud-security-application-security-devsecops)
 -  [Posture management](/azure/cloud-adoption-framework/organize/cloud-security-posture-management)

### IM-2: Protect identity and authentication systems

| **CIS Controls v8 ID(s)** | **NIST SP 800-53 r4 ID(s)**  | **PCI-DSS ID(s) v3.2.1** |
| ------------------------- | ---------------------------- | ------------------------ |
| 5.4, 6.5                  | AC-2, AC-3, IA-2, IA-8, SI-4 | 8.2, 8.3                 |

Security principle: Secure your identity and authentication system as a high priority in your organization's cloud security practice. Common security controls include:

 -  Restrict privileged roles and accounts
 -  Require strong authentication for all privileged access
 -  Monitor and audit high risk activities<br>

Azure guidance: Use the Azure AD security baseline and the Azure AD Identity Secure Score to evaluate your Azure AD identity security posture, and remediate security and configuration gaps. The Azure AD Identity Secure Score evaluates Azure AD for the following configurations:

 -  Use limited administrative roles
 -  Turn on user risk policy
 -  Designate more than one global admin
 -  Enable policy to block legacy authentication
 -  Ensure all users can complete multi-factor authentication for secure access
 -  Require MFA for administrative roles
 -  Enable self-service password reset
 -  Do not expire passwords
 -  Turn on sign-in risk policy
 -  Do not allow users to grant consent to unmanaged applications

Use Azure AD Identity Protection to detect, investigate, and remediate identity-based risks. To similarly protect your on-premises Active Directory domain, use Defender for Identity.

Note: Follow published best practices for all other identity components, including your on-premises Active Directory and any third party capabilities, and the infrastructures (such as operating systems, networks, databases) that host them.

Azure implementation and additional context:

 -  [What is the identity secure score in Azure AD](/azure/active-directory/fundamentals/identity-secure-score)
 -  [Best Practices for Securing Active Directory](/windows-server/identity/ad-ds/plan/security-best-practices/best-practices-for-securing-active-directory)
 -  [What is Identity Protection?](/azure/active-directory/identity-protection/overview-identity-protection)
 -  [What is Microsoft Defender for Identity?](/defender-for-identity/what-is)

AWS guidance: Use the following security best practices to secure your AWS IAM:

 -  Set up AWS account root user access keys for emergency access as described in PA-5 (Set up emergency access)
 -  Follow least privilege principles for access assignments
 -  Leverage IAM groups to apply policies instead of individual user(s).
 -  Follow strong authentication guidance in IM-6 (Use strong authentication controls) for all users
 -  Use AWS Organizations SCP (Service Control Policy) and permission boundaries
 -  Use IAM Access Advisor to audit service access
 -  Use IAM credential report to track user accounts and credential status

Note: Follow published best practices if you have other identity and authentication systems, e.g., follow the Azure AD security baseline if you use Azure AD to manage AWS identity and access.

AWS implementation and additional context:

 -  [Security Best Practice in IAM](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html)
 -  [IAM Access Advisor](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_access-advisor.html)
 -  [IAM Credential Report](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_getting-report.html)

GCP guidance: Use the following security best practices to secure to your Google Cloud IAM and Cloud Identity services for your organizations:

 -  Set up a super admin account for emergency access by following the recommendations in PA-5 ("Set up emergency access").
 -  Create a super admin email address (as the Google Workspace or Cloud Identity super admin account) and this account should be not specific to a particular user in case an emergency recovery is needed.
 -  Follow least privilege and separation of duties principles
 -  Avoid using super admin account for daily activities
 -  Leverage Google Cloud Identity groups to apply policies instead of applying policies to individual user(s).
 -  Follow strong authentication guidance as described in IM-6 ("Use strong authentication controls") for all users that have elevated privileges.
 -  Use IAM policies to restrict access to resources
 -  Use the Organization Policy Service to control and configure constraints on resources
 -  Use IAM audit logging within Cloud Audit logs to review privileged activities

Note: Follow published best practices if you have other identity and authentication systems, e.g., follow the Azure AD security baseline if you use Azure AD to manage GCP identity and access.

GCP implementation and additional context:

 -  [Super administrator account best practices](https://cloud.google.com/resource-manager/docs/super-admin-best-practices)
 -  [Security best practices for administrator accounts](https://support.google.com/a/answer/9011373?hl=en&fl=1&sjid=5832730948340645904-NA)
 -  [Use IAM securely](https://cloud.google.com/iam/docs/using-iam-securely)
 -  [Manage access to other resources](https://cloud.google.com/iam/docs/manage-access-other-resources)
 -  [Introduction to the Organization Policy Service](https://cloud.google.com/resource-manager/docs/organization-policy/overview)

Customer security stakeholders ([Learn more](/azure/cloud-adoption-framework/organize/cloud-security#security-functions)):

 -  [Identity and key management](/azure/cloud-adoption-framework/organize/cloud-security-identity-keys)
 -  [Security architecture](/azure/cloud-adoption-framework/organize/cloud-security-architecture)
 -  [Application security and DevSecOps](/azure/cloud-adoption-framework/organize/cloud-security-application-security-devsecops)
 -  [Posture management](/azure/cloud-adoption-framework/organize/cloud-security-posture-management)

### IM-3: Manage application identities securely and automatically

| **CIS Controls v8 ID(s)** | **NIST SP 800-53 r4 ID(s)**  | **PCI-DSS ID(s) v3.2.1** |
| ------------------------- | ---------------------------- | ------------------------ |
| N/A                       | AC-2, AC-3, IA-4, IA-5, IA-9 | N/A                      |

Security principle: Use managed application identities instead of creating human accounts for applications to access resources and execute code. Managed application identities provide benefits such as reducing the exposure of credentials. Automate the rotation of credentials to ensure the security of the identities.<br>

Azure guidance: Use Azure managed identities, which can authenticate to Azure services and resources that support Azure AD authentication. Managed identity credentials are fully managed, rotated, and protected by the platform, avoiding hard-coded credentials in source code or configuration files.

For services that don't support managed identities, use Azure AD to create a service principal with restricted permissions at the resource level. It is recommended to configure service principals with certificate credentials and fall back to client secrets for authentication.

Azure implementation and additional context:

 -  [Azure managed identities](/azure/active-directory/managed-identities-azure-resources/overview)
 -  [Services that support managed identities for Azure resources](/azure/active-directory/managed-identities-azure-resources/services-support-managed-identities)
 -  [Azure service principal](/powershell/azure/create-azure-service-principal-azureps)
 -  [Create a service principal with certificates](/azure/active-directory/develop/howto-authenticate-service-principal-powershell)

AWS guidance: Use AWS IAM roles instead of creating user accounts for resources that support this feature. IAM roles are managed by the platform at the backend and the credentials are temporary and rotated automatically. This avoids creating long-term access keys or a username/password for applications and hard-coded credentials in source code or configuration files.

You may use service-linked roles which are attached with pre-defined permission policies for access between AWS services instead of customizing your own role permissions for the IAM roles.

Note: For services that don't support IAM roles, use access keys but follow the security best practice such as IM-8 Restrict the exposure of credential and secrets to secure your keys.

AWS implementation and additional context:

 -  [AWS IAM Roles](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html)
 -  [Providing access to an AWS service](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-service.html)

GCP guidance: Use Google-managed service accounts instead of creating user-managed accounts for resources that support this feature. Google-managed service accounts are managed by the platform at the backend and the service account keys are temporary and rotated automatically. This avoids creating long-term access keys or a username/password for applications and hard-coded hard-coding credentials in source code or configuration files.

Use Policy Intelligence to understand and recognize suspicious activity for service accounts.

GCP implementation and additional context:

 -  [Service accounts overview](https://cloud.google.com/iam/docs/service-account-overview)
 -  [Tools to understand service account usage](https://cloud.google.com/policy-intelligence/docs/service-account-usage-tools)
 -  [Policy Intelligence](https://cloud.google.com/policy-intelligence/docs)

Customer security stakeholders ([Learn more](/azure/cloud-adoption-framework/organize/cloud-security#security-functions)):

 -  [Identity and key management](/azure/cloud-adoption-framework/organize/cloud-security-identity-keys)
 -  [Application security and DevSecOps](/azure/cloud-adoption-framework/organize/cloud-security-application-security-devsecops)

### IM-4: Authenticate server and services

| **CIS Controls v8 ID(s)** | **NIST SP 800-53 r4 ID(s)** | **PCI-DSS ID(s) v3.2.1** |
| ------------------------- | --------------------------- | ------------------------ |
| N/A                       | IA-9                        | N/A                      |

Security principle: Authenticate remote servers and services from your client side to ensure you are connecting to trusted server and services. The most common server authentication protocol is Transport Layer Security (TLS), where the client-side (often a browser or client device) verifies the server by verifying the server’s certificate was issued by a trusted certificate authority.

Note: Mutual authentication can be used when both the server and the client authenticate one another.<br>

Azure guidance: Many Azure services support TLS authentication by default. For services that don't support TLS authentication by default, or support disabling TLS, ensure it is always enabled to support the server/client authentication. Your client application should also be designed to verify server/client identity (by verifying the server’s certificate issued by a trusted certificate authority) in the handshake stage.

Note: Services such as API Management and API Gateway supports TLS mutual authentication.

Azure implementation and additional context:

 -  [Enforce Transport Layer Security (TLS) for a storage account](/azure/storage/common/transport-layer-security-configure-minimum-version?tabs=portal#use-azure-policy-to-enforce-the-minimum-tls-version)

AWS guidance: Many AWS services support TLS authentication by default. For services that don't support TLS authentication by default, or support disabling TLS, ensure it is always enabled to support the server/client authentication. Your client application should also be designed to verify server/client identity (by verifying the server’s certificate issued by a trusted certificate authority) in the handshake stage.

Note: Services such as API Gateway supports TLS mutual authentication.

AWS implementation and additional context:

 -  [AWS Certificate Manager certificate pinning.](https://docs.aws.amazon.com/acm/latest/userguide/acm-bestpractices.html#best-practices-pinning)
 -  [SSL certificate for backend authentication](https://docs.aws.amazon.com/apigateway/latest/developerguide/getting-started-client-side-ssl-authentication.html)

GCP guidance: Many GCP services support TLS authentication by default. For services that don't support this by default or support disabling TLS, ensure it is always enabled to support the server/client authentication. Your client application should also be designed to verify server/client identity (by verifying the server’s certificate issued by a trusted certificate authority) in the handshake stage.

Note: Services such as Cloud Load Balancing support TLS mutual authentication.

GCP implementation and additional context:

 -  [Encryption in transit](https://cloud.google.com/docs/security/encryption-in-transit#virtual-network)

Customer security stakeholders ([Learn more](/azure/cloud-adoption-framework/organize/cloud-security#security-functions)):

 -  [Identity and key management](/azure/cloud-adoption-framework/organize/cloud-security-identity-keys)
 -  [Application security and DevSecOps](/azure/cloud-adoption-framework/organize/cloud-security-application-security-devsecops)

### IM-5: Use single sign-on (SSO) for application access

| **CIS Controls v8 ID(s)** | **NIST SP 800-53 r4 ID(s)** | **PCI-DSS ID(s) v3.2.1** |
| ------------------------- | --------------------------- | ------------------------ |
| 12.5                      | IA-4, IA-2, IA-8            | N/A                      |

Security principle: Use single sign-on (SSO) to simplify the user experience for authenticating to resources including applications and data across cloud services and on-premises environments.<br>

Azure guidance: Use Azure AD for workload application access (customer facing) access through Azure AD single sign-on (SSO), reducing the need for duplicate accounts. Azure AD provides identity and access management to Azure resources (in the management plane, including CLI, PowerShell, the portal), cloud applications, and on-premises applications.

Azure AD also supports SSO for enterprise identities such as corporate user identities, as well as external user identities from trusted third-party and public users.

Azure implementation and additional context:

 -  [Understand application SSO with Azure AD](/azure/active-directory/manage-apps/what-is-single-sign-on)

AWS guidance: Use AWS Cognito to manage acccess to your customer-facing applications workloads through single sign-on (SSO) to allow customers to bridge their third-party identities from different identity providers.

For SSO access to the AWS native resources (including AWS console access or service management and data plane level access), use AWS Sigle Sign-On to reduce the need for duplicate accounts.

AWS SSO also allows you to bridge corporate identities (such as identities from Azure Active Directory) with AWS identities, as well as external user identities from trusted third-party and public users.

AWS implementation and additional context:

 -  [AWS Single Sign-On](https://docs.aws.amazon.com/singlesignon/)
 -  [AWS Cognito Single Sign-On Adding SAML identity providers](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-saml-idp.html)

GCP guidance: Use Google Cloud Identity to manage access to your customer facing workload application through Google Cloud Identity Single Sign-On, reducing the need for duplicate accounts. Google Cloud Identity provides identity and access management to GCP (in the management plane including Google Cloud CLI, Console access), cloud applications, and on-premises applications.

Google Cloud Identity also supports SSO for enterprise identities such as corporate user identities from Azure AD or Active Directory, as well as external user identities from trusted third-party and public users. GCP implementation and additional context:

 -  [Google Cloud Identity Single sign-on](https://cloud.google.com/architecture/identity/single-sign-on)
 -  [Azure AD user provisioning and single sign-on](https://cloud.google.com/architecture/identity/federating-gcp-with-azure-ad-configuring-provisioning-and-single-sign-on)

Customer security stakeholders ([Learn more](/azure/cloud-adoption-framework/organize/cloud-security#security-functions)):

 -  [Security architecture](/azure/cloud-adoption-framework/organize/cloud-security-architecture)
 -  [Identity and key management](/azure/cloud-adoption-framework/organize/cloud-security-identity-keys)
 -  [Application security and DevSecOps](/azure/cloud-adoption-framework/organize/cloud-security-application-security-devsecops)

### IM-6: Use strong authentication controls

| **CIS Controls v8 ID(s)** | **NIST SP 800-53 r4 ID(s)**  | **PCI-DSS ID(s) v3.2.1** |
| ------------------------- | ---------------------------- | ------------------------ |
| 6.3, 6.4                  | AC-2, AC-3, IA-2, IA-5, IA-8 | 7.2, 8.2, 8.3, 8.4       |

Security principle: Enforce strong authentication controls (strong passwordless authentication or multi-factor authentication) with your centralized identity and authentication management system for all access to resources. Authentication based on password credentials alone is considered legacy, as it is insecure and does not stand up to popular attack methods.

When deploying strong authentication, configure administrators and privileged users first, to ensure the highest level of the strong authentication method, quickly followed by rolling out the appropriate strong authentication policy to all users.

Note: If legacy password-based authentication is required for legacy applications and scenarios, ensure password security best practices such as complexity requirements, are followed.<br>

Azure guidance: Azure AD supports strong authentication controls through passwordless methods and multi-factor authentication (MFA).

 -  Passwordless authentication: Use passwordless authentication as your default authentication method. There are three options available in passwordless authentication: Windows Hello for Business, Microsoft Authenticator app phone sign-in, and FIDO2 security keys. In addition, customers can use on-premises authentication methods such as smart cards.
 -  Multi-factor authentication: Azure MFA can be enforced on all users, select users, or at the per-user level based on sign-in conditions and risk factors. Enable Azure MFA and follow Microsoft Defender for Cloud identity and access management recommendations for your MFA setup.

If legacy password-based authentication is still used for Azure AD authentication, be aware that cloud-only accounts (user accounts created directly in Azure) have a default baseline password policy. And hybrid accounts (user accounts that come from on-premises Active Directory) follow the on-premises password policies.

For third-party applications and services that may have default IDs and passwords, you should disable or change them during initial service setup.

Azure implementation and additional context:

 -  [How to enable MFA in Azure](/azure/active-directory/authentication/howto-mfa-getstarted)
 -  [Introduction to passwordless authentication options for Azure Active Directory](/azure/active-directory/authentication/concept-authentication-passwordless)
 -  [Azure AD default password policy](/azure/active-directory/authentication/concept-sspr-policy#password-policies-that-only-apply-to-cloud-user-accounts)
 -  [Eliminate bad passwords using Azure AD Password Protection](/azure/active-directory/authentication/concept-password-ban-bad)
 -  [Block legacy authentication](/azure/active-directory/conditional-access/block-legacy-authentication)

AWS guidance: AWS IAM supports strong authentication controls through multi-factor authentication (MFA). MFA can be enforced on all users, select users, or at the per-user level based on defined conditions.

If you use corporate accounts from a third-party directory (such as Windows Active Directory) with AWS identities, follow the respective security guidance to enforce strong authentication. Refer to the Azure Guidance for this control if you use Azure AD to manage AWS access.

Note: For third-party applications and AWS services that may have default IDs and passwords, you should disable or change them during initial service setup.

AWS implementation and additional context:

 -  [Using multi-factor authentication (MFA) in AWS](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_mfa.html)
 -  [IAM supported MFA form factors](https://aws.amazon.com/iam/features/mfa/)

GCP guidance: Google Cloud Identity supports strong authentication controls through multi-factor authentication (MFA). MFA can be enforced on all users, select users, or at the per-user level based on defined conditions. To protect Cloud Identity (and Workspace) super admin accounts, consider using security keys and the Google Advanced Protection Program for maximum security.

If you use corporate accounts from a third-party directory (such as Windows Active Directory) with Google Cloud identities, follow the respective security guidance to enforce strong authentication. Refer to the Azure Guidance for this control if you use Azure AD to manage Google Cloud access.

Use Identity-Aware Proxy to establish a central authorization layer for applications accessed by HTTPS, so you can use an application-level access control model instead of relying on network-level firewalls.

Note: For third-party applications and GCP services that may have default IDs and passwords, you should disable or change them during the initial service setup.

GCP implementation and additional context:

 -  [Enforce uniform MFA to company-owned resources](https://cloud.google.com/identity/solutions/enforce-mfa)
 -  [Google Advanced Protection Program](https://landing.google.com/advancedprotection/)
 -  [Identity-Aware Proxy overview](https://cloud.google.com/iap/docs/concepts-overview)

Customer security stakeholders ([Learn more](/azure/cloud-adoption-framework/organize/cloud-security#security-functions)):

 -  [Security architecture](/azure/cloud-adoption-framework/organize/cloud-security-architecture)
 -  [Identity and key management](/azure/cloud-adoption-framework/organize/cloud-security-identity-keys)
 -  [Application security and DevSecOps](/azure/cloud-adoption-framework/organize/cloud-security-application-security-devsecops)

### IM-7: Restrict resource access based on conditions

| **CIS Controls v8 ID(s)** | **NIST SP 800-53 r4 ID(s)** | **PCI-DSS ID(s) v3.2.1** |
| ------------------------- | --------------------------- | ------------------------ |
| 3.3, 6.4, 13.5            | AC-2, AC-3, AC-6            | 7.2                      |

Security principle: Explicitly validate trusted signals to allow or deny user access to resources, as part of a zero-trust access model. Signals to validate should include strong authentication of user account, behavioral analytics of user account, device trustworthiness, user or group membership, locations and so on.<br>

Azure guidance: Use Azure AD conditional access for more granular access controls based on user-defined conditions, such as requiring user logins from certain IP ranges (or devices) to use MFA. Azure AD Conditional Access allows you to enforce access controls on your organization’s apps based on certain conditions.

Define the applicable conditions and criteria for Azure AD conditional access in the workload. Consider the following common use cases:

 -  Requiring multi-factor authentication for users with administrative roles
 -  Requiring multi-factor authentication for Azure management tasks
 -  Blocking sign-ins for users attempting to use legacy authentication protocols
 -  Requiring trusted locations for Azure AD Multi-Factor Authentication registration
 -  Blocking or granting access from specific locations
 -  Blocking risky sign-in behaviors
 -  Requiring organization-managed devices for specific applications

Note: Granular authentication session management controls can also be implemented through Azure AD conditional access policy, such as sign-in frequency and persistent browser session.

Azure implementation and additional context:

 -  [Azure Conditional Access overview](/azure/active-directory/conditional-access/overview)
 -  [Common Conditional Access policies](/azure/active-directory/conditional-access/concept-conditional-access-policy-common)
 -  [Conditional Access insights and reporting](/azure/active-directory/conditional-access/howto-conditional-access-insights-reporting)
 -  [Configure authentication session management with Conditional Access](/azure/active-directory/conditional-access/howto-conditional-access-session-lifetime)

AWS guidance: Create IAM policy and define conditions for more granular access controls based on user-defined conditions, such as requiring user logins from certain IP ranges (or devices) to use multi-factor authentication. Condition settings may include single or multiple conditions as well as logics.

Policies can be defined from six different dimensions: identity-based policies, resource-based policies, permissions boundaries, AWS Organizations service control policy (SCP) , Access Control Lists(ACL), and session policies.

AWS implementation and additional context:

 -  [Policies and permissions in IAM](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html)
 -  [Conditions key table](https://docs.aws.amazon.com/service-authorization/latest/reference/reference_policies_actions-resources-contextkeys.html#context_keys_table)

GCP guidance: Create and define IAM Conditions for more granular attribute-based access controls based on user-defined conditions, such as requiring user logins from certain IP ranges (or devices) to use multi-factor authentication. Condition settings may include single or multiple conditions as well as logic.

Conditions are specified in the role bindings of a resource's allow policy. Condition attributes are based on the requested resource—for example, its type or name—or on details about the request—for example, its timestamp or destination IP address.

GCP implementation and additional context:

 -  [Overview of IAM Conditions](https://cloud.google.com/iam/docs/conditions-overview)

Customer security stakeholders ([Learn more](/azure/cloud-adoption-framework/organize/cloud-security#security-functions)):

 -  [Identity and key management](/azure/cloud-adoption-framework/organize/cloud-security-identity-keys)
 -  [Application security and DevSecOps](/azure/cloud-adoption-framework/organize/cloud-security-application-security-devsecops)
 -  [Posture management](/azure/cloud-adoption-framework/organize/cloud-security-posture-management)
 -  [Threat intelligence](/azure/cloud-adoption-framework/organize/cloud-security-threat-intelligence)

## Security Control: Privileged access

Privileged Access covers controls to protect privileged access to your tenant and resources, including a range of controls to protect your administrative model, administrative accounts, and privileged access workstations against deliberate and inadvertent risk.

### PA-1: Separate and limit highly privileged/administrative users

| **CIS Controls v8 ID(s)** | **NIST SP 800-53 r4 ID(s)** | **PCI-DSS ID(s) v3.2.1** |
| ------------------------- | --------------------------- | ------------------------ |
| 5.4, 6.8                  | AC-2, AC-6                  | 7.1, 7.2, 8.1            |

Security principle: Ensure you identify all high business impact accounts. Limit the number of privileged/administrative accounts in your cloud's control plane, management plane and data/workload plane.<br>

Azure guidance: You must secure all roles with direct or indirect administrative access to Azure hosted resources.

Azure Active Directory (Azure AD) is Azure's default identity and access management service. The most critical built-in roles in Azure AD are Global Administrator and Privileged Role Administrator, because users assigned to these two roles can delegate administrator roles. With these privileges, users can directly or indirectly read and modify every resource in your Azure environment:

 -  Global Administrator / Company Administrator: Users with this role have access to all administrative features in Azure AD as well as services that use Azure AD identities.
 -  Privileged Role Administrator: Users with this role can manage role assignments in Azure AD, as well as within Azure AD Privileged Identity Management (PIM). In addition, this role allows management of all aspects of PIM and administrative units.

Outside of Azure AD, Azure has built-in roles that can be critical for privileged access at the resource level.

 -  Owner: Grants full access to manage all resources, including the ability to assign roles in Azure RBAC.
 -  Contributor: Grants full access to manage all resources, but does not allow you to assign roles in Azure RBAC, manage assignments in Azure Blueprints, or share image galleries.
 -  User Access Administrator: Lets you manage user access to Azure resources.

Note: You may have other critical roles that need to be governed if you use custom roles in the Azure AD level or resource level with certain privileged permissions assigned.

In addition, users with the following three roles in Azure Enterprise Agreement (EA) portal should also be restricted as they can be used to directly or indirectly manage Azure subscriptions.

 -  Account Owner: Users with this role can manage subscriptions, including the creation and deletion of subscriptions.
 -  Enterprise Administrator: Users assigned with this role can manage (EA) portal users.
 -  Department Administrator: Users assigned with this role can change account owners within the department.

Lastly, ensure that you also restrict privileged accounts in other management, identity, and security systems that have administrative access to your business-critical assets, such as Active Directory Domain Controllers (DCs), security tools, and system management tools with agents installed on business-critical systems. Attackers who compromise these management and security systems can immediately weaponize them to compromise business critical assets.

Azure implementation and additional context:

 -  [Administrator role permissions in Azure AD](/azure/active-directory/users-groups-roles/directory-assign-admin-roles)
 -  [Use Azure Privileged Identity Management security alerts](/azure/active-directory/privileged-identity-management/pim-how-to-configure-security-alerts)
 -  [Securing privileged access for hybrid and cloud deployments in Azure AD](/azure/active-directory/users-groups-roles/directory-admin-roles-secure)

AWS guidance: You must secure all roles with direct or indirect administrative access to AWS hosted resources.

The privileged/administrative users need to be secured include:

 -  Root user: Root user is the highest-level privileged accounts in your AWS account. Root accounts should be highly restricted and only used in emergency situation. Refer to emergency access controls in PA-5 (Setup emergency access).
 -  IAM identities (users, groups, roles) with the privileged permission policy: IAM identities assigned with a permission policy such as AdministratorAccess can have full access to AWS services and resources.

If you are using Azure Active Directory (Azure AD) as the identity provider for AWS, refer to the Azure guidance for managing the privileged roles in Azure AD.

Ensure that you also restrict privileged accounts in other management, identity, and security systems that have administrative access to your business-critical assets, such as AWS Cognito, security tools, and system management tools with agents installed on business critical systems. Attackers who compromise these management and security systems can immediately weaponize them to compromise business critical assets.

AWS implementation and additional context:

 -  [AWS Best Practices for Root User](https://docs.aws.amazon.com/accounts/latest/reference/best-practices-root-user.html)

GCP guidance: You must secure all roles with direct or indirect administrative access to GCP hosted resources.

The most critical built-in role in Google Cloud is the super administrator. The super administrator can perform all tasks in the Admin console and has irrevocable administrative permissions. It is advised against using the super admin account for day-to-day administration.

Basic roles are highly permissive legacy roles, and it is advised that basic roles are not used in production environments as it grants broad access across all Google Cloud resources. Basic roles include the Viewer, Editor, and Owner roles. It is instead recommended to use predefined or custom roles. The notable privileged predefined roles include:

 -  Organization Administrator: Users with this role can manage IAM policies and view organization policies for organizations, folders, and projects.
 -  Organization Policy Administrator: Users with this role can define what restrictions an organization wants to place on the configuration of cloud resources by setting Organization Policies.
 -  Organization Role Administrator: Users with this role can administer all custom roles in the organization and projects below it.
 -  Security Admin: Users with this role can get and set any IAM policy.
 -  Deny Admin: Users with this role has permissions to read and modify IAM deny policies.

Additionally, certain predefined roles contain privileged IAM permissions at the organization, folder, and project level. These IAM permissions include:

 -  organizationAdmin
 -  folderIAMAdmin
 -  projectIAMAdmin

Further, implement separation of duties by assigning roles to accounts for different projects, or by leveraging Binary Authorization with Google Kubernetes Engine.

Lastly, ensure that you also restrict privileged accounts in other management, identity, and security systems that have administrative access to your business-critical assets, such as Cloud DNS, security tools, and system management tools with agents installed on business-critical systems. Attackers who compromise these management and security systems can immediately weaponize them to compromise business critical assets.

GCP implementation and additional context:

 -  [Super administrator account best practices](https://cloud.google.com/resource-manager/docs/super-admin-best-practices)
 -  [IAM basic and predefined roles reference](https://cloud.google.com/iam/docs/understanding-roles)
 -  [Separation of duties and Identity and Access Management roles](https://cloud.google.com/binary-authorization/docs/reference/organizational-and-iam-roles)

Customer security stakeholders ([Learn more](/azure/cloud-adoption-framework/organize/cloud-security#security-functions)):

 -  [Identity and key management](/azure/cloud-adoption-framework/organize/cloud-security-identity-keys)
 -  [Security architecture](/azure/cloud-adoption-framework/organize/cloud-security-architecture)
 -  [Security Compliance Management](/azure/cloud-adoption-framework/organize/cloud-security-compliance-management)
 -  [Security Operations](/azure/cloud-adoption-framework/organize/cloud-security-operations-center)

### PA-2: Avoid standing access for user accounts and permissions

| **CIS Controls v8 ID(s)** | **NIST SP 800-53 r4 ID(s)** | **PCI-DSS ID(s) v3.2.1** |
| ------------------------- | --------------------------- | ------------------------ |
| N/A                       | AC-2                        | N/A                      |

Security principle: Instead of creating standing privileges, use just-in-time (JIT) mechanism to assign privileged access to the different resource tiers.<br>

Azure guidance: Enable just-in-time (JIT) privileged access to Azure resources and Azure AD using Azure AD Privileged Identity Management (PIM). JIT is a model in which users receive temporary permissions to perform privileged tasks, which prevents malicious or unauthorized users from gaining access after the permissions have expired. Access is granted only when users need it. PIM can also generate security alerts when there is suspicious or unsafe activity in your Azure AD organization.

Restrict inbound traffic to your sensitive virtual machines (VM) management ports with Microsoft Defender for Cloud's just-in-time (JIT) for VM access feature. This ensures privileged access to the VM is granted only when users need it.

Azure implementation and additional context:

 -  [Azure PIM just-in-time access deployment](/azure/active-directory/privileged-identity-management/pim-deployment-plan)
 -  [Understanding just-in-time (JIT) VM access](/azure/defender-for-cloud/just-in-time-access-overview?tabs=defender-for-container-arch-aks)

AWS guidance: Use AWS Security Token Service (AWS STS) to create temporary security credentials to access the resources through the AWS API. Temporary security credentials work almost identically to the long-term access key credentials that your IAM users can use, with the following differences:

 -  Temporary security credentials have a short-term life, from minutes to hours.
 -  Temporary security credentials are not stored with the user but are generated dynamically and provided to the user when requested.

AWS implementation and additional context:

 -  [IAM Temporary credentials through AWS Security Token Service (AWS STS)](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html)

GCP guidance: Use IAM conditional access to create temporary access to resources using conditional role bindings in allow policies, which is granted to Cloud Identity users. Configure date/time attributes to enforce time-based controls for accessing a particular resource. Temporary access may have a short-term life, from minutes to hours, or may be granted based on days or hours of the week.

GCP implementation and additional context:

 -  [Overview of IAM Conditions](https://cloud.google.com/iam/docs/conditions-overview)
 -  [Configure temporary access](https://cloud.google.com/iam/docs/configuring-temporary-access)
 -  [Access Context Manager Overview](https://cloud.google.com/access-context-manager/docs/overview)

Customer security stakeholders ([Learn more](/azure/cloud-adoption-framework/organize/cloud-security#security-functions)):

 -  [Identity and key management](/azure/cloud-adoption-framework/organize/cloud-security-identity-keys)
 -  [Security architecture](/azure/cloud-adoption-framework/organize/cloud-security-architecture)
 -  [Security Compliance Management](/azure/cloud-adoption-framework/organize/cloud-security-compliance-management)
 -  [Security Operations](/azure/cloud-adoption-framework/organize/cloud-security-operations-center)

### PA-3: Manage lifecycle of identities and entitlements

| **CIS Controls v8 ID(s)** | **NIST SP 800-53 r4 ID(s)** | **PCI-DSS ID(s) v3.2.1** |
| ------------------------- | --------------------------- | ------------------------ |
| 6.1, 6.2                  | AC-5, AC-6                  | 7.1, 7.2, 8.1            |

Security principle: Use an automated process or technical control to manage the identity and access lifecycle including the request, review, approval, provision, and deprovision.<br>

Azure guidance: Use Azure AD entitlement management features to automate access request workflows (for Azure resource groups). This enables workflows for Azure resource groups to manage access assignments, reviews, expiration, and dual or multi-stage approval.

Use Permissions Management to detect, automatically right-size, and continuously monitor unused and excessive permissions assigned to user and workload identities across multi-cloud infrastructures.

Azure implementation and additional context:

 -  [What are Azure AD access reviews](/azure/active-directory/governance/access-reviews-overview)
 -  [What is Azure AD entitlement management](/azure/active-directory/governance/entitlement-management-overview)
 -  [Overview of Permissions Management](/azure/active-directory/cloud-infrastructure-entitlement-management/overview)

AWS guidance: Use AWS Access Advisor to pull the access logs for the user accounts and entitlements for resources. Build a manual or automated workflow to integrate with AWS IAM to manage access assignments, reviews, and deletions.

Note: There are third-party solutions available on AWS Marketplace for managing the lifecycle of identities and entitlements.

AWS implementation and additional context:

 -  [IAM Access Advisor](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_access-advisor-view-data.html)
 -  [AWS Marketplace Identity and Access Management solutions](https://aws.amazon.com/marketplace/solutions/security/identity-access-management)

GCP guidance: Use Google's Cloud Audit Logs to pull the admin activity and data access audit logs for the user accounts and entitlements for resources. Build a manual or automated workflow to integrate with GCP IAM to manage access assignments, reviews, and deletions.

Use Google Cloud Identity Premium to provide core identity and device management services. These services include features such as automated user provisioning, app whitelisting, and automated mobile device management.

Note: There are third-party solutions available on the Google Cloud Marketplace for managing the lifecycle of identities and entitlements.

GCP implementation and additional context:

 -  [IAM Access Advisor](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_access-advisor-view-data.html)
 -  [Cloud Identity and Atlassian Access: User lifecycle management across your organization](https://cloud.google.com/blog/products/identity-security/cloud-identity-and-atlassian-access-user-lifecycle-management-across-your-organization)
 -  [Granting and revoking access to the API](https://cloud.google.com/endpoints/docs/frameworks/control-api-access)
 -  [Revoke access to a Google Cloud project](https://cloud.google.com/docs/security/data-loss-prevention/revoking-user-access)

Customer security stakeholders ([Learn more](/azure/cloud-adoption-framework/organize/cloud-security#security-functions)):

 -  [Identity and key management](/azure/cloud-adoption-framework/organize/cloud-security-identity-keys)
 -  [Application security and DevSecOps](/azure/cloud-adoption-framework/organize/cloud-security-application-security-devsecops)
 -  [Security Compliance Management](/azure/cloud-adoption-framework/organize/cloud-security-compliance-management)

### PA-4: Review and reconcile user access regularly

| **CIS Controls v8 ID(s)** | **NIST SP 800-53 r4 ID(s)** | **PCI-DSS ID(s) v3.2.1** |
| ------------------------- | --------------------------- | ------------------------ |
| 5.1, 5.3, 5.5             | AC-2, AC-6                  | 7.1, 7.2, 8.1, A3.4      |

Security principle: Conduct regular review of privileged account entitlements. Ensure the access granted to the accounts are valid for administration of control plane, management plane, and workloads.<br>

Azure guidance: Review all privileged accounts and the access entitlements in Azure including Azure tenants, Azure services, VM/IaaS, CI/CD processes, and enterprise management and security tools.

Use Azure AD access reviews to review Azure AD roles, Azure resource access roles, group memberships, and access to enterprise applications. Azure AD reporting can also provide logs to help discover stale accounts, or accounts which have not been used for certain amount of time.

In addition, Azure AD Privileged Identity Management can be configured to alert when an excessive number of administrator accounts are created for a specific role, and to identify administrator accounts that are stale or improperly configured.

Azure implementation and additional context:

 -  [Create an access review of Azure resource roles in Privileged Identity Management (PIM)](/azure/active-directory/privileged-identity-management/pim-resource-roles-start-access-review)
 -  [How to use Azure AD identity and access reviews](/azure/active-directory/governance/access-reviews-overview)

AWS guidance: Review all privileged accounts and the access entitlements in AWS including AWS accounts, services, VM/IaaS, CI/CD processes, and enterprise management and security tools.

Use IAM Access Advisor, Access Analyzer and Credential Reports to review resource access roles, group memberships, and access to enterprise applications. IAM Access Analyzer and Credential Reports reporting can also provide logs to help discover stale accounts, or accounts which have not been used for certain amount of time.

If you are using Azure Active Directory (Azure AD) as the identity provider for AWS, use Azure AD access review to review the privileged accounts and access entitlements periodically.

AWS implementation and additional context:

 -  [IAM Access Analyzer](https://docs.aws.amazon.com/IAM/latest/UserGuide/what-is-access-analyzer.html)
 -  [Credential report](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_getting-report.html)
 -  [IAM Access Advisor](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_access-advisor-view-data.html)

GCP guidance: Review all privileged accounts and the access entitlements in Google Cloud including Cloud Identity accounts, services, VM/IaaS, CI/CD processes, and enterprise management and security tools.

Use Cloud Audit Logs and Policy Analyzer to review resource access roles, and group memberships. Create analysis queries in Policy Analyzer to understand determine which principals can access specific resources.

If you are using Azure Active Directory (Azure AD) as the identity provider for Google Cloud, use Azure AD access review to review the privileged accounts and access entitlements periodically.

In addition, Azure AD Privileged Identity Management can be configured to alert when an excessive number of administrator accounts are created for a specific role, and to identify administrator accounts that are stale or improperly configured.

GCP implementation and additional context:

 -  [IAM audit logging](https://cloud.google.com/iam/docs/audit-logging)
 -  [Policy Analyzer for IAM policies](https://cloud.google.com/policy-intelligence/docs/policy-analyzer-overview)

Customer security stakeholders ([Learn more](/azure/cloud-adoption-framework/organize/cloud-security#security-functions)):

 -  [Identity and key management](/azure/cloud-adoption-framework/organize/cloud-security-identity-keys)
 -  [Application security and DevSecOps](/azure/cloud-adoption-framework/organize/cloud-security-application-security-devsecops)
 -  [Security Compliance Management](/azure/cloud-adoption-framework/organize/cloud-security-compliance-management)

### PA-5: Set up emergency access

| **CIS Controls v8 ID(s)** | **NIST SP 800-53 r4 ID(s)** | **PCI-DSS ID(s) v3.2.1** |
| ------------------------- | --------------------------- | ------------------------ |
| N/A                       | AC-2                        | N/A                      |

Security principle: Set up emergency access to ensure that you are not accidentally locked out of your critical cloud infrastructure (such as your identity and access management system) in an emergency.

Emergency access accounts should be rarely used and can be highly damaging to the organization if compromised, but their availability to the organization is also critically important for the few scenarios when they are required.<br>

Azure guidance: To prevent being accidentally locked out of your Azure AD organization, set up an emergency access account (e.g., an account with Global Administrator role) for access when normal administrative accounts cannot be used. Emergency access accounts are usually highly privileged, and they should not be assigned to specific individuals. Emergency access accounts are limited to emergency or "break glass" scenarios where normal administrative accounts can't be used.

You should ensure that the credentials (such as password, certificate, or smart card) for emergency access accounts are kept secure and known only to individuals who are authorized to use them only in an emergency. You may also use additional controls, such dual controls (e.g., splitting the credential into two pieces and giving it to separate persons) to enhance the security of this process. You should also monitor the sign-in and audit logs to ensure that emergency access accounts are only used when authorized.

Azure implementation and additional context:

 -  [Manage emergency access accounts in Azure AD](/azure/active-directory/users-groups-roles/directory-emergency-access)

AWS guidance: AWS "root" accounts should not be used for regular administrative tasks. As the "root" account is highly privileged, it should not be assigned to specific individuals. It's use should be limited to only emergency or "break glass" scenarios when normal administrative accounts can't be used. For daily administrative tasks, separate privileged user accounts should be used and assigned the appropriate permissions via IAM roles.

You should also ensure that the credentials (such as password, MFA tokens and access keys) for root accounts are kept secure and known only to individuals who are authorized to use them only in an emergency. MFA should be enabled for the root account, and you may also use additional controls, such as dual controls (e.g., splitting the credential into two pieces and giving it to separate persons) to enhance the security of this process.

You should also monitor the sign-in and audit logs in CloudTrail or EventBridge to ensure that root access accounts are only used when authorized.

AWS implementation and additional context:

 -  [Best practices to protect your account's root user](https://docs.aws.amazon.com/accounts/latest/reference/best-practices-root-user.html)

GCP guidance: Google Cloud Identity super administrator accounts should not be used for regular administrative tasks. As the super admin account is highly privileged, it should not be assigned to specific individuals. It's use should be limited to only emergency or "break glass" scenarios when normal administrative accounts can't be used. For daily administrative tasks, separate privileged user accounts should be used and assigned the appropriate permissions via IAM roles.

You should also ensure that the credentials (such as password, MFA tokens and access keys) for super admin accounts are kept secure and known only to individuals who are authorized to use them only in an emergency. MFA should be enabled for the super admin account, and you may also use additional controls, such as dual controls (e.g., splitting the credential into two pieces and giving it to separate persons) to enhance the security of this process.

You should also monitor the sign-in and audit logs in Cloud Audit Logs, or query the Policy Analyzer, to ensure that super admin accounts are only used when authorized.

GCP implementation and additional context:

 -  [Super administrator account best practices](https://cloud.google.com/resource-manager/docs/super-admin-best-practices)

Customer security stakeholders ([Learn more](/azure/cloud-adoption-framework/organize/cloud-security#security-functions)):

 -  [Application security and DevSecOps](/azure/cloud-adoption-framework/organize/cloud-security-application-security-devsecops)
 -  [Security Compliance Management](/azure/cloud-adoption-framework/organize/cloud-security-compliance-management)
 -  [Security Operations (SecOps)](/azure/cloud-adoption-framework/organize/cloud-security-operations-center)

### PA-6: Use privileged access workstations

| **CIS Controls v8 ID(s)** | **NIST SP 800-53 r4 ID(s)** | **PCI-DSS ID(s) v3.2.1** |
| ------------------------- | --------------------------- | ------------------------ |
| 12.8, 13.5                | AC-2, SC-2, SC-7            | N/A                      |

Security principle: Secured, isolated workstations are critically important for the security of sensitive roles like administrator, developer, and critical service operator.<br>

Azure guidance: Use Azure Active Directory, Microsoft Defender, and/or Microsoft Intune to deploy privileged access workstations (PAW) on-premises or in Azure for privileged tasks. The PAW should be centrally managed to enforce secured configuration, including strong authentication, software and hardware baselines, and restricted logical and network access.

You may also use Azure Bastion which is a fully platform-managed PaaS service that can be provisioned inside your virtual network. Azure Bastion allows RDP/SSH connectivity to your virtual machines directly from the Azure portal using a web browser.

Azure implementation and additional context:

 -  [Understand privileged access workstations](/security/privileged-access-workstations/overview)
 -  [Privileged access workstations deployment](/security/compass/privileged-access-devices)

AWS guidance: Use Session Manager in AWS Systems Manager to create an access path (a connection session) to the EC2 instance or a browser session to the AWS resources for privileged tasks. Session Manager allows RDP, SSH, and HTTPS connectivity to your destination hosts through port forwarding.

You may also choose to deploy a privileged access workstations (PAW) centrally managed through Azure Active Directory, Microsoft Defender, and/or Microsoft Intune. The central management should enforce secured configuration, including strong authentication, software and hardware baselines, and restricted logical and network access.

AWS implementation and additional context:

 -  [AWS Systems Manager Session Manager](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager.html)

GCP guidance: Use Identity-Aware Proxy (IAP) Desktop to create an access path (a connection session) to the compute instance for privileged tasks. IAP Desktop allows RDP and SSH connectivity to your destination hosts through port forwarding. Furthermore, Linux compute instances that are external facing may be connected to through a SSH-in-browser through the Google Cloud console.

You may also choose to deploy a privileged access workstations (PAW) centrally managed through Google Workspace Endpoint Management or Microsoft solutions (Azure Active Directory, Microsoft Defender, and/or Microsoft Intune). The central management should enforce secured configuration, including strong authentication, software and hardware baselines, and restricted logical and network access.

You may also create bastion hosts for secure accessing to trusted environments with defined parameters.

GCP implementation and additional context:

 -  [Securely connecting to VM instances](https://cloud.google.com/solutions/connecting-securely)
 -  [Connect to Linux VMs using Identity-Aware Proxy](https://cloud.google.com/compute/docs/connect/ssh-using-iap)
 -  [Connect to VMs using a bastion host](https://cloud.google.com/compute/docs/connect/ssh-using-bastion-host)

Customer security stakeholders ([Learn more](/azure/cloud-adoption-framework/organize/cloud-security#security-functions)):

 -  [Application security and DevSecOps](/azure/cloud-adoption-framework/organize/cloud-security-application-security-devsecops)
 -  [Security Operations (SecOps)](/azure/cloud-adoption-framework/organize/cloud-security-operations-center)
 -  [Identity and key management](/azure/cloud-adoption-framework/organize/cloud-security-identity-keys)

### PA-7: Follow just enough administration (least privilege) principle

| **CIS Controls v8 ID(s)** | **NIST SP 800-53 r4 ID(s)** | **PCI-DSS ID(s) v3.2.1** |
| ------------------------- | --------------------------- | ------------------------ |
| 3.3, 6.8                  | AC-2, AC-3, AC-6            | 7.1, 7.2                 |

Security principle: Follow the just enough administration (least privilege) principle to manage permissions at fine-grained level. Use features such as role-based access control (RBAC) to manage resource access through role assignments.<br>

Azure guidance: Use Azure role-based access control (Azure RBAC) to manage Azure resource access through role assignments. Through RBAC, you can assign roles to users, groups, service principals, and managed identities. There are pre-defined built-in roles for certain resources, and these roles can be inventoried or queried through tools such as Azure CLI, Azure PowerShell, and the Azure portal.

The privileges you assign to resources through Azure RBAC should always be limited to what's required by the roles. Limited privileges will complement the just-in-time (JIT) approach of Azure AD Privileged Identity Management (PIM), and those privileges should be reviewed periodically. If required, you can also use PIM to define a time-bound assignment, which is a condition in a role assignment where a user can only activate the role within the specified start and end dates.

Note: Use Azure built-in roles to allocate permissions and only create custom roles when required.

Azure implementation and additional context:

 -  [What is Azure role-based access control (Azure RBAC)](/azure/role-based-access-control/overview)
 -  [How to configure RBAC in Azure](/azure/role-based-access-control/role-assignments-portal)
 -  [How to use Azure AD identity and access reviews](/azure/active-directory/governance/access-reviews-overview)
 -  [Azure AD Privileged Identity Management - Time-bound assignment](/azure/active-directory/privileged-identity-management/pim-configure#what-does-it-do)

AWS guidance: Use AWS policy to manage AWS resource access. There are six types of policies: identity-based policies, resource-based policies, permissions boundaries, AWS Organizations service control policy (SCP), Access Control List, and session policies. You may use AWS managed policies for common permission use cases. However, you should be mindful that managed policies may carry excessive permissions that should not be assigned to the users.

You may also use AWS ABAC (attribute-based access control) to assign permissions based on attributes (tags) attached to IAM resources, including IAM entities (users or roles) and AWS resources.

AWS implementation and additional context:

 -  [IAM access policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html)
 -  [AWS ABAC](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction_attribute-based-access-control.html)

GCP guidance: Use Google Cloud IAM Policy to manage GCP resource access through role assignments. You may use Google Cloud's predefined roles for common permission use cases. However, you should be mindful that predefined roles may carry excessive permissions that should not be assigned to the users.

Additionally, use Policy Intelligence with the IAM Recommender to identify and remove excessive permissions from accounts.

GCP implementation and additional context:

 -  [Access Control with IAM](https://cloud.google.com/support/docs/access-control)
 -  [Overview of role recommendations](https://cloud.google.com/policy-intelligence/docs/role-recommendations-overview)

Customer security stakeholders ([Learn more](/azure/cloud-adoption-framework/organize/cloud-security#security-functions)):

 -  [Application security and DevSecOps](/azure/cloud-adoption-framework/organize/cloud-security-application-security-devsecops)
 -  [Security Compliance Management](/azure/cloud-adoption-framework/organize/cloud-security-compliance-management)
 -  [Posture management](/azure/cloud-adoption-framework/organize/cloud-security-posture-management)
 -  [Identity and key management](/azure/cloud-adoption-framework/organize/cloud-security-identity-keys)

### PA-8 Determine access process for cloud provider support

| **CIS Controls v8 ID(s)** | **NIST SP 800-53 r4 ID(s)** | **PCI-DSS ID(s) v3.2.1** |
| ------------------------- | --------------------------- | ------------------------ |
| 6.1, 6.2                  | AC-4, AC-2, AC-3            | N/A                      |

Security principle: Establish an approval process and access path for requesting and approving vendor support requests and temporary access to your data through a secure channel.<br>

Azure guidance: In support scenarios where Microsoft needs to access your data, use Customer Lockbox to review and either approve or reject each data access request made by Microsoft.

Azure implementation and additional context:

 -  [Understand Customer Lockbox](/azure/security/fundamentals/customer-lockbox-overview)

AWS guidance: In support scenarios where AWS support teams need to access your data, create an account in the AWS Support portal to request support. Review the available options such as providing read-only data access, or the screen sharing option for AWS support to access to your data.

AWS implementation and additional context:

 -  [Access permissions for AWS Support](https://docs.aws.amazon.com/awssupport/latest/user/accessing-support.html)

GCP guidance: In support scenarios where Google Cloud Customer Care needs to access your data, use Access Approval to review and either approve or reject each data access requests made by Cloud Customer Care.

GCP implementation and additional context:

 -  [Overview of Access Approval](https://cloud.google.com/cloud-provider-access-management/access-approval/docs/overview)

Customer security stakeholders ([Learn more](/azure/cloud-adoption-framework/organize/cloud-security#security-functions)):

 -  [Application security and DevSecOps](/azure/cloud-adoption-framework/organize/cloud-security-application-security-devsecops)
 -  [Security Compliance Management](/azure/cloud-adoption-framework/organize/cloud-security-compliance-management)
 -  [Identity and key management](/azure/cloud-adoption-framework/organize/cloud-security-identity-keys)
