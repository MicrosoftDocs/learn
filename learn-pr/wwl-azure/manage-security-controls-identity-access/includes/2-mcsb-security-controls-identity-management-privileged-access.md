Identity Management covers controls to establish a secure identity and access controls using identity and access management systems, including the use of single sign-on, strong authentications, managed identities (and service principals) for applications, conditional access, and account anomalies monitoring.

## IM-1: Use centralized identity and authentication system

| **CIS Controls v8 ID(s)** | **NIST SP 800-53 r4 ID(s)** | **PCI-DSS ID(s) v3.2.1** |
| ------------------------- | --------------------------- | ------------------------ |
| 6.7, 12.5                 | AC-2, AC-3, IA-2, IA-8      | 7.2, 8.3                 |

Security principle: Use a centralized identity and authentication system to govern your organization's identities and authentications for cloud and non-cloud resources.<br>

Azure guidance: Microsoft Entra ID ([Microsoft Entra ID](/azure/active-directory/)) is Azure's identity and authentication management service. You should standardize on Microsoft Entra ID to govern your organization's identity and authentication in:

 -  Microsoft cloud resources, such as Azure Storage, Azure Virtual Machines (Linux and Windows), Azure Key Vault, PaaS, and SaaS applications.
 -  Your organization's resources, such as applications on Azure, third-party applications running on your corporate network resources, and third-party SaaS applications.
 -  Your enterprise identities in Active Directory by synchronization to Microsoft Entra ID to ensure a consistent and centrally managed identity strategy.

For the Azure services that apply, avoid use of local authentication methods and instead use Microsoft Entra ID to centralize your service authentications.

Note: As soon as it is technically feasible, you should migrate on-premises Active Directory based applications to Micosoft Entra ID. This could be an Mcirosoft Entra ID Enterprise Directory, Business to Business configuration, or Business to consumer configuration.

Azure implementation and additional context:

 -  [Tenancy in Microsoft Entra ID](/azure/active-directory/fundamentals/active-directory-whatis)
 -  [How to create and configure a Microsoft Entra ID instance](/azure/active-directory/fundamentals/add-custom-domain)
 -  [Define Microsoft Entra ID tenants](/azure/active-directory/fundamentals/active-directory-how-to-tenant)
 -  [Use external identity providers for an application](/azure/active-directory/b2b/identity-providers)

AWS guidance: AWS IAM (Identity and Access Management) is AWS' default identity and authentication management service. Use AWS IAM to govern your AWS identity and access management. Alternatively, through AWS and Azure Single Sign-On (SSO), you can also use Micrsoft Entra ID to manage the identity and access control of AWS to avoid managing duplicate accounts separately in two cloud platforms.

AWS supports Single Sign-On which allows you to bridge your corporate's third party identities (such as Windows Active Directory, or other identity stores) with the AWS identities to avoid creating duplicate accounts to access AWS resources.

AWS implementation and additional context:

 -  [AWS IAM](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html)
 -  [AWS Single Sign-On](https://docs.aws.amazon.com/singlesignon/index.html)

GCP guidance: Google Cloud's Identity and Access Management (IAM) system is Google Cloud's default identity and authentication management service used for Google Cloud Identity accounts. Use Google Cloud IAM to govern your GCP identity and access management. Alternatively, through the Google Cloud Identity and Azure Sigle Sign-On (SSO), you can also use Microsoft Entra ID to manage the identity and access control of GCP to avoid managing duplicate accounts separately in a mutli-cloud environment.

Google Cloud Identity is the identity provider for all Google services. It supports Single Sign-On which allows you to bridge your corporate's third party identities (such as Windows Active Directory, or other identity stores) with Google Cloud identities to avoid creating duplicate accounts to access GCP resources.

Note: Using Google Cloud Directory Sync. Google provides connector tool that integrates with most enterprise LDAP management systems and synchronizes identities on a schedule. By configuring a Cloud Identity account and sing Google Cloud Directory Sync, you can configure which of your user accounts – including users, groups , and user profiles, aliases and more – will synchronize on a schedule between your local identity management system and your GCP system.

GCP implementation and additional context:

 -  [GCP IAM overview](https://cloud.google.com/iam/docs/overview)
 -  [Microsoft Entra ID user provisioning and single sign-on](/azure/active-directory/saas-apps/tutorial-list)
 -  [Single sign-on](https://cloud.google.com/architecture/identity/single-sign-on)

Customer security stakeholders ([Learn more](/azure/cloud-adoption-framework/organize/cloud-security#security-functions)):

 -  [Identity and key management](/azure/cloud-adoption-framework/organize/cloud-security-identity-keys)
 -  [Security architecture](/azure/cloud-adoption-framework/organize/cloud-security-architecture)
 -  [Application security and DevSecOps](/azure/cloud-adoption-framework/organize/cloud-security-application-security-devsecops)
 -  [Posture management](/azure/cloud-adoption-framework/organize/cloud-security-posture-management)

## IM-2: Protect identity and authentication systems

| **CIS Controls v8 ID(s)** | **NIST SP 800-53 r4 ID(s)**  | **PCI-DSS ID(s) v3.2.1** |
| ------------------------- | ---------------------------- | ------------------------ |
| 5.4, 6.5                  | AC-2, AC-3, IA-2, IA-8, SI-4 | 8.2, 8.3                 |

Security principle: Secure your identity and authentication system as a high priority in your organization's cloud security practice. Common security controls include:

 -  Restrict privileged roles and accounts
 -  Require strong authentication for all privileged access
 -  Monitor and audit high risk activities<br>

Azure guidance: Use the Microsoft Entra ID security baseline and the Microsoft Entra ID Identity Secure Score to evaluate your Microsoft Entra ID identity security posture, and remediate security and configuration gaps. The Microsoft Entra ID Identity Secure Score evaluates Microsoft Entra ID for the following configurations:

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

Use Microsoft Entra ID Identity Protection to detect, investigate, and remediate identity-based risks. To similarly protect your on-premises Active Directory domain, use Defender for Identity.

Note: Follow published best practices for all other identity components, including your on-premises Active Directory and any third party capabilities, and the infrastructures (such as operating systems, networks, databases) that host them.

Azure implementation and additional context:

 -  [What is the identity secure score in Microsoft Entra ID](/azure/active-directory/fundamentals/identity-secure-score)
 -  [Best Practices for Securing Active Directory](/windows-server/identity/ad-ds/plan/security-best-practices/best-practices-for-securing-active-directory)
 -  [What is Identity Protection?](/azure/active-directory/identity-protection/overview-identity-protection)
 -  [What is Microsoft Defender for Identity?](/defender-for-identity/what-is)

AWS guidance: Use the following security best practices to secure your AWS IAM:

 -  Set up AWS account root user access keys for emergency access as described in PA-5 (Set up emergency access).
 -  Follow least privilege principles for access assignments.
 -  Leverage IAM groups to apply policies instead of individual user(s).
 -  Follow strong authentication guidance in IM-6 (Use strong authentication controls) for all users.
 -  Use AWS Organizations SCP (Service Control Policy) and permission boundaries.
 -  Use IAM Access Advisor to audit service access.
 -  Use IAM credential report to track user accounts and credential status.

Note: Follow published best practices if you have other identity and authentication systems, e.g., follow the Microsoft Entra ID security baseline if you use Microsoft Entra ID to manage AWS identity and access.

AWS implementation and additional context:

 -  [Security Best Practice in IAM](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html)
 -  [IAM Access Advisor](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_access-advisor.html)
 -  [IAM Credential Report](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_getting-report.html)

GCP guidance: Use the following security best practices to secure to your Google Cloud IAM and Cloud Identity services for your organizations:

 -  Set up a super admin account for emergency access by following the recommendations in PA-5 ("Set up emergency access").
 -  Create a super admin email address (as the Google Workspace or Cloud Identity super admin account) and this account should be not specific to a particular user in case an emergency recovery is needed.
 -  Follow least privilege and separation of duties principles.
 -  Avoid using super admin account for daily activities.
 -  Leverage Google Cloud Identity groups to apply policies instead of applying policies to individual user(s).
 -  Follow strong authentication guidance as described in IM-6 ("Use strong authentication controls") for all users that have elevated privileges.
 -  Use IAM policies to restrict access to resources.
 -  Use the Organization Policy Service to control and configure constraints on resources.
 -  Use IAM audit logging within Cloud Audit logs to review privileged activities.

Note: Follow published best practices if you have other identity and authentication systems, e.g., follow the Microsoft Entra ID security baseline if you use Microsoft Entra ID to manage GCP identity and access.

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

## IM-3: Manage application identities securely and automatically

| **CIS Controls v8 ID(s)** | **NIST SP 800-53 r4 ID(s)**  | **PCI-DSS ID(s) v3.2.1** |
| ------------------------- | ---------------------------- | ------------------------ |
| N/A                       | AC-2, AC-3, IA-4, IA-5, IA-9 | N/A                      |

Security principle: Use managed application identities instead of creating human accounts for applications to access resources and execute code. Managed application identities provide benefits such as reducing the exposure of credentials. Automate the rotation of credentials to ensure the security of the identities.<br>

Azure guidance: Use Azure managed identities, which can authenticate to Azure services and resources that support Microsoft Entra ID authentication. Managed identity credentials are fully managed, rotated, and protected by the platform, avoiding hard-coded credentials in source code or configuration files.

For services that don't support managed identities, use Microsoft Entra ID to create a service principal with restricted permissions at the resource level. It is recommended to configure service principals with certificate credentials and fall back to client secrets for authentication.

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

## IM-4: Authenticate server and services

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

## IM-5: Use single sign-on (SSO) for application access

| **CIS Controls v8 ID(s)** | **NIST SP 800-53 r4 ID(s)** | **PCI-DSS ID(s) v3.2.1** |
| ------------------------- | --------------------------- | ------------------------ |
| 12.5                      | IA-4, IA-2, IA-8            | N/A                      |

Security principle: Use single sign-on (SSO) to simplify the user experience for authenticating to resources including applications and data across cloud services and on-premises environments.<br>

Azure guidance: Use Microsoft Entra ID for workload application access (customer facing) access through Microsoft Entra ID single sign-on (SSO), reducing the need for duplicate accounts. Microsoft Entra ID provides identity and access management to Azure resources (in the management plane, including CLI, PowerShell, the portal), cloud applications, and on-premises applications.

Microsoft Entra ID also supports SSO for enterprise identities such as corporate user identities, as well as external user identities from trusted third-party and public users.

Azure implementation and additional context:

 -  [Understand application SSO with Microsoft Entra ID](/azure/active-directory/manage-apps/what-is-single-sign-on)

AWS guidance: Use AWS Cognito to manage acccess to your customer-facing applications workloads through single sign-on (SSO) to allow customers to bridge their third-party identities from different identity providers.

For SSO access to the AWS native resources (including AWS console access or service management and data plane level access), use AWS Sigle Sign-On to reduce the need for duplicate accounts.

AWS SSO also allows you to bridge corporate identities (such as identities from Microsoft Entra ID) with AWS identities, as well as external user identities from trusted third-party and public users.

AWS implementation and additional context:

 -  [AWS Single Sign-On](https://docs.aws.amazon.com/singlesignon/)
 -  [AWS Cognito Single Sign-On Adding SAML identity providers](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-saml-idp.html)

GCP guidance: Use Google Cloud Identity to manage access to your customer facing workload application through Google Cloud Identity Single Sign-On, reducing the need for duplicate accounts. Google Cloud Identity provides identity and access management to GCP (in the management plane including Google Cloud CLI, Console access), cloud applications, and on-premises applications.

Google Cloud Identity also supports SSO for enterprise identities such as corporate user identities from Microsoft Entra ID or Active Directory, as well as external user identities from trusted third-party and public users. GCP implementation and additional context:

 -  [Google Cloud Identity Single sign-on](https://cloud.google.com/architecture/identity/single-sign-on)
 -  [Microsoft Entra ID user provisioning and single sign-on](https://cloud.google.com/architecture/identity/federating-gcp-with-azure-ad-configuring-provisioning-and-single-sign-on)

Customer security stakeholders ([Learn more](/azure/cloud-adoption-framework/organize/cloud-security#security-functions)):

 -  [Security architecture](/azure/cloud-adoption-framework/organize/cloud-security-architecture)
 -  [Identity and key management](/azure/cloud-adoption-framework/organize/cloud-security-identity-keys)
 -  [Application security and DevSecOps](/azure/cloud-adoption-framework/organize/cloud-security-application-security-devsecops)

## IM-6: Use strong authentication controls

| **CIS Controls v8 ID(s)** | **NIST SP 800-53 r4 ID(s)**  | **PCI-DSS ID(s) v3.2.1** |
| ------------------------- | ---------------------------- | ------------------------ |
| 6.3, 6.4                  | AC-2, AC-3, IA-2, IA-5, IA-8 | 7.2, 8.2, 8.3, 8.4       |

Security principle: Enforce strong authentication controls (strong passwordless authentication or multi-factor authentication) with your centralized identity and authentication management system for all access to resources. Authentication based on password credentials alone is considered legacy, as it is insecure and does not stand up to popular attack methods.

When deploying strong authentication, configure administrators and privileged users first, to ensure the highest level of the strong authentication method, quickly followed by rolling out the appropriate strong authentication policy to all users.

Note: If legacy password-based authentication is required for legacy applications and scenarios, ensure password security best practices such as complexity requirements, are followed.<br>

Azure guidance: Microsoft Entra ID supports strong authentication controls through passwordless methods and multi-factor authentication (MFA).

 -  Passwordless authentication: Use passwordless authentication as your default authentication method. There are three options available in passwordless authentication: Windows Hello for Business, Microsoft Authenticator app phone sign-in, and FIDO2 security keys. In addition, customers can use on-premises authentication methods such as smart cards.
 -  Multi-factor authentication: Azure MFA can be enforced on all users, select users, or at the per-user level based on sign-in conditions and risk factors. Enable Azure MFA and follow Microsoft Defender for Cloud identity and access management recommendations for your MFA setup.

If legacy password-based authentication is still used for Microsoft Entra ID authentication, be aware that cloud-only accounts (user accounts created directly in Azure) have a default baseline password policy. And hybrid accounts (user accounts that come from on-premises Active Directory) follow the on-premises password policies.

For third-party applications and services that may have default IDs and passwords, you should disable or change them during initial service setup.

Azure implementation and additional context:

 -  [How to enable MFA in Azure](/azure/active-directory/authentication/howto-mfa-getstarted)
 -  [Introduction to passwordless authentication options for Microsoft Entra ID](/azure/active-directory/authentication/concept-authentication-passwordless)
 -  [Microsoft Entra IDdefault password policy](/azure/active-directory/authentication/concept-sspr-policy#password-policies-that-only-apply-to-cloud-user-accounts)
 -  [Eliminate bad passwords using Microsoft Entra ID Password Protection](/azure/active-directory/authentication/concept-password-ban-bad)
 -  [Block legacy authentication](/azure/active-directory/conditional-access/block-legacy-authentication)

AWS guidance: AWS IAM supports strong authentication controls through multi-factor authentication (MFA). MFA can be enforced on all users, select users, or at the per-user level based on defined conditions.

If you use corporate accounts from a third-party directory (such as Windows Active Directory) with AWS identities, follow the respective security guidance to enforce strong authentication. Refer to the Azure Guidance for this control if you use Microsoft Entra ID to manage AWS access.

Note: For third-party applications and AWS services that may have default IDs and passwords, you should disable or change them during initial service setup.

AWS implementation and additional context:

 -  [Using multi-factor authentication (MFA) in AWS](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_mfa.html)
 -  [IAM supported MFA form factors](https://aws.amazon.com/iam/features/mfa/)

GCP guidance: Google Cloud Identity supports strong authentication controls through multi-factor authentication (MFA). MFA can be enforced on all users, select users, or at the per-user level based on defined conditions. To protect Cloud Identity (and Workspace) super admin accounts, consider using security keys and the Google Advanced Protection Program for maximum security.

If you use corporate accounts from a third-party directory (such as Windows Active Directory) with Google Cloud identities, follow the respective security guidance to enforce strong authentication. Refer to the Azure Guidance for this control if you use Microsoft Entra ID to manage Google Cloud access.

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

## IM-7: Restrict resource access based on conditions

| **CIS Controls v8 ID(s)** | **NIST SP 800-53 r4 ID(s)** | **PCI-DSS ID(s) v3.2.1** |
| ------------------------- | --------------------------- | ------------------------ |
| 3.3, 6.4, 13.5            | AC-2, AC-3, AC-6            | 7.2                      |

Security principle: Explicitly validate trusted signals to allow or deny user access to resources, as part of a zero-trust access model. Signals to validate should include strong authentication of user account, behavioral analytics of user account, device trustworthiness, user or group membership, locations and so on.<br>

Azure guidance: Use Microsoft Entra ID conditional access for more granular access controls based on user-defined conditions, such as requiring user logins from certain IP ranges (or devices) to use MFA. Microsoft Entra ID Conditional Access allows you to enforce access controls on your organization’s apps based on certain conditions.

Define the applicable conditions and criteria for Microsoft Entra ID conditional access in the workload. Consider the following common use cases:

 -  Requiring multi-factor authentication for users with administrative roles.
 -  Requiring multi-factor authentication for Azure management tasks.
 -  Blocking sign-ins for users attempting to use legacy authentication protocols.
 -  Requiring trusted locations for Microsoft Entra ID Multi-Factor Authentication registration.
 -  Blocking or granting access from specific locations.
 -  Blocking risky sign-in behaviors.
 -  Requiring organization-managed devices for specific applications.

Note: Granular authentication session management controls can also be implemented through Microsoft Entra ID conditional access policy, such as sign-in frequency and persistent browser session.

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
