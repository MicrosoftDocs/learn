This unit summarizes the [Azure security baseline for Azure Arc-enabled servers](https://learn.microsoft.com/en-us/security/benchmark/azure/baselines/azure-arc-enabled-servers-security-baseline)

## Network security

### NS-2: Secure cloud services with network controls

* Azure Private Link - Deploy private endpoints for all Azure resources that support the Private Link feature to establish a private access point for the resources.

* Disable Public Network Access - Disable public network access either using the service-level IP ACL filtering rule or a toggling switch for public network access.

## Identity management

### IM-1: Use centralized identity and authentication system

* Azure AD Authentication Required for Data Plane Access (enabled by default)

* Local Authentication Methods for Data Plane Access - Restrict the use of local authentication methods for data plane access. Instead, use Azure Active Directory (Azure AD) as the default authentication method to control your data plane access.

### IM-3: Manage application identities securely and automatically

* Managed Identities (enabled by default)
* Service Principals (no guidance)

## Privileged access

### PA-1: Separate and limit highly privileged/administrative users

* Local Admin Accounts - If not required for routine administrative operations, disable or restrict any local admin accounts for only emergency use.

### PA-7: Follow just enough administration (least privilege) principle

* Azure RBAC for Data Plane (enabled by default)

## Data protection

### DP-3: Encrypt sensitive data in transit

* Data in Transit Encryption (enabled by default)

### DP-4: Enable data at rest encryption by default

* Data at Rest Encryption Using Platform Keys (enabled by default)

## Asset management

_For more information, see the [Microsoft cloud security benchmark: Asset management](https://learn.microsoft.com/en-us/security/benchmark/azure/mcsb-asset-management)._

### AM-2: Use only approved services

#### Features

##### Azure Policy Support

**Description**: Service configurations can be monitored and enforced via Azure Policy. [Learn more](https://learn.microsoft.com/en-us/azure/governance/policy/tutorials/create-and-manage).

**Configuration Guidance**: Use Microsoft Defender for Cloud to configure Azure Policy to audit and enforce configurations of your Azure resources. Use Azure Monitor to create alerts when there is a configuration deviation detected on the resources. Use Azure Policy [deny] and [deploy if not exists] effects to enforce secure configuration across Azure resources.

**Reference**: [Azure Policy built-in definitions for Azure Arc-enabled servers](https://learn.microsoft.com/en-us/azure/azure-arc/servers/policy-reference)

## Logging and threat detection

_For more information, see the [Microsoft cloud security benchmark: Logging and threat detection](https://learn.microsoft.com/en-us/security/benchmark/azure/mcsb-logging-threat-detection)._

### LT-1: Enable threat detection capabilities

#### Features

##### Microsoft Defender for Service / Product Offering

**Description**: Service has an offering-specific Microsoft Defender solution to monitor and alert on security issues. [Learn more](https://learn.microsoft.com/en-us/azure/security-center/azure-defender).

**Configuration Guidance**: Use Azure Active Directory (Azure AD) as the default authentication method to control your management plane access. When you get an alert from Microsoft Defender for Key Vault, investigate and respond to the alert.

**Reference**: [Introduction to Microsoft Defender for Servers](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/hybrid/server/best-practices/arc-security-center)
