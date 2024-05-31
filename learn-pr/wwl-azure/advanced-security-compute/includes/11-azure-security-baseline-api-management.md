The Azure security baseline for API Management applies guidance from Microsoft's Cloud Security Benchmark version 1.0 to API Management. The Microsoft cloud security benchmark provides recommendations on how you can secure your cloud solutions on Azure. The content is grouped by the security controls defined by the Microsoft cloud security benchmark and the related guidance applicable to API Management.

You can monitor this security baseline and its recommendations using Microsoft Defender for Cloud. Azure Policy definitions will be listed in the Regulatory Compliance section of the Microsoft Defender for Cloud portal page.

When a feature has relevant Azure Policy Definitions, they're listed in this baseline to help you measure compliance with the Microsoft cloud security benchmark controls and recommendations. Some recommendations might require a paid Microsoft Defender plan to enable certain security scenarios.

## Network security

### **NS-1**: **Establish network segmentation boundaries**

Feature: Virtual Network Integration

Description: Service supports deployment into customer's private Virtual Network (VNet).

Configuration Guidance: Deploy Azure API Management inside an Azure Virtual Network (VNET), so it can access backend services within the network. The developer portal and API Management gateway can be configured to be accessible either from the Internet (External) or only within the Vnet (Internal).

 -  External: the API Management gateway and developer portal are accessible from the public internet via an external load balancer. The gateway can access resources within the virtual network.
    
    
     -  External Virtual Network Configuration
 -  Internal: the API Management gateway and developer portal are accessible only from within the virtual network via an internal load balancer. The gateway can access resources within the virtual network.
    
    
     -  Internal Virtual Network Configuration

Feature: Network Security Group Support

Description: Service network traffic respects Network Security Groups rule assignment on its subnets.

Configuration Guidance: Deploy network security groups (NSG) to your API Management subnets to restrict or monitor traffic by port, protocol, source IP address, or destination IP address. Create NSG rules to restrict your service's open ports (such as preventing management ports from being accessed from untrusted networks). Be aware that by default, NSGs deny all inbound traffic but allow traffic from virtual network and Azure Load Balancers.

> [!CAUTION]
> When configuring an NSG on the API Management subnet, there is a set of ports that are required to be open. If any of these ports are unavailable, API Management might not operate properly and might become inaccessible.

### **NS-2**: **Secure cloud services with network controls**

Feature: Azure Private Link

Description: Service native IP filtering capability for filtering network traffic (not to be confused with NSG or Azure Firewall).

Configuration Guidance: In instances where you're unable to deploy API Management instances into a virtual network, you should instead deploy a private endpoint to establish a private access point for those resources.

> [!NOTE]
> To enable private endpoints, the API Management instance can't already be configured with an external or internal virtual network. A private endpoint connection supports only incoming traffic to the API Management instance.

Feature: Disable Public Network Access

Description: Service supports disabling public network access either through using service-level IP ACL filtering rule (not NSG or Azure Firewall) or using a 'Disable Public Network Access' toggle switch.

Configuration Guidance: Disable public network access either using the IP ACL filtering rule on the NSGs assigned to the service's subnets or a toggling switch for public network access.

> [!NOTE]
> API Management supports deployments into a virtual network, as well as locking down non-network-based deployments with a private endpoint and disabling public network access.

**Feature**: Microsoft Defender for Cloud monitoring

Azure Policy built-in definitions - Microsoft.ApiManagement:

| Name<br>(Azure portal)                                                                     | **Description**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | **Effect(s)**              | Version<br>(GitHub) |
| ------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------- | ------------------- |
| API Management services should use a virtual network                                       | Azure Virtual Network deployment provides enhanced security, isolation and allows you to place your API Management service in a non-internet routable network that you control access to. These networks can then be connected to your on-premises networks using various VPN technologies, which enables access to your backend services within the network and/or on-premises. The developer portal and API gateway can be configured to be accessible either from the Internet or only within the virtual network. | Audit, Deny, Disabled      | 1.0.2               |
| API Management should disable public network access to the service configuration endpoints | To improve the security of API Management services, restrict connectivity to service configuration endpoints, like direct access management API, Git configuration management endpoint, or self-hosted gateways configuration endpoint.                                                                                                                                                                                                                                                                               | AuditIfNotExists, Disabled | 1.0.1               |

**NS-6**: **Deploy web application firewall**

Other guidance for NS-6: To protect critical Web/HTTP APIs configure API Management within a Virtual Network (VNET) in internal mode and configure an Azure Application Gateway. Application Gateway is a PaaS service. It acts as a reverse-proxy and provides L7 load balancing, routing, web application firewall (WAF), and other services. Learn more.

Combining API Management provisioned in an internal VNET with the Application Gateway frontend enables the following scenarios:

 -  Use a single API Management resource for exposing all APIs to both internal consumers and external consumers.<br>
 -  Use a single API Management resource for exposing a subset of APIs to external consumers.
 -  Provide a way of switching access to API Management from the public Internet on and off.

## Identity management

### IM-1: Use centralized identity and authentication system

Feature: Azure AD Authentication Required for Data Plane Access

Description: Service supports using Azure AD authentication for data plane access.

Configuration Guidance: Use Azure Active Directory (Azure AD) as the default authentication method for API Management where possible.

 -  Configure your Azure API Management Developer Portal to authenticate developer accounts by using Azure AD.<br>
 -  Configure your Azure API Management instance to protect your APIs by using the OAuth 2.0 protocol with Azure AD.

Feature: Local Authentication Methods for Data Plane Access

Description: Local authentications methods supported for data plane access, such as a local username and password.

Feature notes: Avoid the usage of local authentication methods or accounts, these should be disabled wherever possible. Instead use Azure AD to authenticate where possible.

Configuration Guidance: Restrict the use of local authentication methods for data plane access, maintain inventory of API Management user accounts and reconcile access as needed. In API Management, developers are the consumers of the APIs that exposed with API Management. By default, newly created developer accounts are Active, and associated with the Developers group. Developer accounts that are in an active state can be used to access all of the APIs for which they have subscriptions.

Also, Azure API Management subscriptions are one means of securing access to APIs and come with a pair of generated subscription keys which support rotation.

Instead of using other auth methods, where possible use Azure Active Directory (Azure AD) as the default authentication method to control your data plane access.

### IM-3: Manage application identities securely and automatically

Feature: Managed Identities

Description: Data plane actions support authentication using managed identities.

Configuration Guidance: Use a Managed Service Identity generated by Azure Active Directory (Azure AD) to allow your API Management instance to easily and securely access other Azure AD-protected resources, such as Azure Key Vault instead of using service principals. Managed identity credentials are fully managed, rotated, and protected by the platform, avoiding hard-coded credentials in source code or configuration files.

Feature: Service Principals

Description: Data plane supports authentication using service principals.

Configuration Guidance: There's no current Microsoft guidance for this feature configuration. Please review and determine if your organization wants to configure this security feature.

### IM-5: Use single sign-on (SSO) for application access

Other guidance for IM-5: Azure API Management can be configured to leverage Azure Active Directory (Azure AD) as an identity provider for authenticating users on the Developer Portal in order to benefit from the SSO capabilities offered by Azure AD. Once configured, new Developer Portal users can choose to follow the out-of-the-box sign-up process by first authenticating through Azure AD and then completing the sign-up process on the portal once authenticated.

Alternatively, the sign-in/sign-up process can be further customized through delegation. Delegation allows you to use your existing website for handling developer sign in/sign up and subscription to products, as opposed to using the built-in functionality in the developer portal. It enables your website to own the user data and perform the validation of these steps in a custom way.

### IM-7: Restrict resource access based on conditions

Features: Conditional Access for Data Plane

Description: Data plane access can be controlled using Azure AD Conditional Access Policies.

Configuration Guidance: This feature isn't supported to secure this service.

### IM-8: Restrict the exposure of credential and secrets

Feature: Service Credential and Secrets Support Integration and Storage in Azure Key Vault

Description: Data plane supports native use of Azure Key Vault for credential and secrets store.

Configuration Guidance: Set up integration of API Management with Azure Key Vault. Ensure that secrets for API Management (Named values) are stored an Azure Key Vault so they can be securely accessed and updated.

## Privileged access

### PA-1: Separate and limit highly privileged/administrative users

**Feature**: Local Admin Accounts

Description: Service has the concept of a local administrative account.

Feature notes: Avoid the usage of local authentication methods or accounts, these should be disabled wherever possible. Instead use Azure AD to authenticate where possible.

Configuration Guidance: If not required for routine administrative operations, disable or restrict any local admin accounts for only emergency use.

> [!NOTE]
> API Management allows creation of local user account. Instead of creating these local accounts, enable Azure Active Directory (Azure AD) authentication only, and assign permissions to these Azure AD accounts.

### PA-7: Follow just enough administration (least privilege) principle

Feature: Azure RBAC for Data Plane

Description: Azure Role-Based Access Control (Azure RBAC) can be used to managed access to service's data plane actions.

Configuration Guidance: Use Azure role-based access control (Azure RBAC) for controlling access to Azure API Management. Azure API Management relies on Azure role-based access control to enable fine-grained access management for API Management services and entities (for example, APIs and policies).

### PA-8: Determine access process for cloud provider support

Feature: Customer Lockbox

Description: Customer Lockbox can be used for Microsoft support access.

Configuration Guidance: In support scenarios where Microsoft needs to access your data, use Customer Lockbox to review, then approve or reject each of Microsoft's data access requests.

## Data protection

### DP-1: Discover, classify, and label sensitive data

Feature: Sensitive Data Discovery and Classification

Description: Tools (such as Azure Purview or Azure Information Protection) can be used for data discovery and classification in the service.

Configuration Guidance: This feature isn't supported to secure this service.

### DP-2: Monitor anomalies and threats targeting sensitive data

Feature: Data Leakage/Loss Prevention

Description: Service supports DLP solution to monitor sensitive data movement (in customer's content).

Configuration Guidance: This feature isn't supported to secure this service.

### DP-3: Encrypt sensitive data in transit

Feature: Data in Transit Encryption

Description: Service supports data in-transit encryption for data plane.

Configuration Guidance: No additional configurations are required as this is enabled on a default deployment.

Other guidance for DP-3: Management plane calls are made through Azure Resource Manager over TLS. A valid JSON web token (JWT) is required. Data plane calls can be secured with TLS and one of supported authentication mechanisms (for example, client certificate or JWT).

### DP-6: Use a secure key management process

Feature: Key Management in Azure Key Vault

Description: The service supports Azure Key Vault integration for any customer keys, secrets, or certificates.

Configuration Guidance: Set up integration of API Management with Azure Key Vault. Ensure that keys used by API Management are stored an Azure Key Vault so they can be securely accessed and updated.

### DP-7: Use a secure certificate management process

Feature: Certificate Management in Azure Key Vault

Description: The service supports Azure Key Vault integration for any customer certificates.

Configuration Guidance: Set up integration of API Management with Azure Key Vault. Ensure that secrets for API Management (Named values) are stored an Azure Key Vault so they can be securely accessed and updated.

Use Azure Key Vault to create and control the certificate lifecycle, including creation, importing, rotation, revocation, storage, and purging of the certificate. Ensure the certificate generation follows defined standards without using any insecure properties, such as: insufficient key size, overly long validity period, insecure cryptography. Setup automatic rotation of the certificate in Azure Key Vault and the Azure service (if supported) based on a defined schedule or when there's a certificate expiration. If automatic rotation isn't supported in the application, ensure they're still rotated using manual methods in Azure Key Vault and the application.

## Asset management

### AM-2: Use only approved services

Feature: Azure Policy Support

Description: Service configurations can be monitored and enforced via Azure Policy.

Configuration Guidance: Use built-in Azure Policy to monitor and enforce secure configuration across API Management resources. Use Azure Policy aliases in the "Microsoft.ApiManagement" namespace to create custom Azure Policy definitions where required.

## Logging and threat detection

### LT-1: Enable threat detection capabilities

Features: Microsoft Defender for Service / Product Offering

Description: Service has an offering-specific Microsoft Defender solution to monitor and alert on security issues.

Configuration Guidance: This feature isn't supported to secure this service.

### LT-4: Enable logging for security investigation

Feature: Azure Resource Logs

Description: Service produces resource logs that can provide enhanced service-specific metrics and logging. The customer can configure these resource logs and send them to their own data sink like a storage account or log analytics workspace.

Configuration Guidance: Enable resource logs for API Management, resource logs provide rich information about operations and errors that are important for auditing and troubleshooting purposes. Categories of resource logs for API Management include:

 -  GatewayLogs<br>
 -  WebSocketConnectionLogs

## Backup and recovery

### BR-1: Ensure regular automated backups

Feature: Azure Backup

Description: The service can be backed up by the Azure Backup service.

Configuration Guidance: This feature isn't supported to secure this service.

Feature: Service Native Backup Capability

Description: Service supports its own native backup capability (if not using Azure Backup).

Additional Guidance: Leverage the backup and restore capabilities in Azure API Management service. When leveraging backup capabilities, Azure API Management writes backups to customer-owned Azure Storage accounts. Backup and restore operations are provided by Azure API Management to perform full system backup and restore.
