---
title: Introduction to infrastructure threat modeling
description: Improve the state of security for your infrastructure by finding ways to reduce or eliminate risk.
author: rodrigosantos
ms.author: rodsan
ms.date: 03/01/2021
ms.prod: non-product-specific
ms.topic: how-to
ms.custom: infrastructure-threat-modeling-security-guide
ms.customer.intent: As an IT professional, I understand how to reduce or eliminate risk in the infrastructure by using threat modeling.
---

Use the completed data-flow diagram, answers from the security assessment, and existing security requirements to identify potential solutions to enterprise threats and security gaps.

In this example, we used many [security services](https://docs.microsoft.com/azure/security/fundamentals/overview) available in Azure.

Visit [Azure security benchmark](https://docs.microsoft.com/azure/security/benchmarks/overview) to learn about each security category and associated requirements published for public use.

## Access control

![Access Control domain](../media/policies/AccessControl-small.svg)

|Risk|Solution|
|----|--------|
|File access per user|Use [role-based access control](https://docs.microsoft.com/mem/configmgr/core/understand/fundamentals-of-role-based-administration), which allows an administrator to grant access based on roles instead of specific employees. It makes it easier to grant, manage, and revoke access. If an individual employee needs access to a highly classified resource, use [just-in-time access](https://docs.microsoft.com/azure/azure-resource-manager/managed-applications/request-just-in-time-access). It grants the employee access to the resource for a short period of time.|
|No MFA|Enable MFA across each SaaS offering. Integrate with [Microsoft Azure Active Directory Connect](https://docs.microsoft.com/azure/active-directory/hybrid/whatis-azure-ad-connect) (if federation is available).|
|No password or group policy|Configure [security policy settings](https://docs.microsoft.com/windows/security/threat-protection/security-policy-settings/security-policy-settings) for all endpoints with group policy or [Azure Active Directory Domain Services](https://docs.microsoft.com/azure/active-directory-domain-services/password-policy).|
|No shared account protection|Avoid using shared accounts wherever possible. If engineering teams require a service account as part of automation or engineering, use [Group Managed Service Accounts](https://docs.microsoft.com/windows-server/security/group-managed-service-accounts/getting-started-with-group-managed-service-accounts).|
|No dedicated administrator account use|Use [Microsoft Identity Manager](https://docs.microsoft.com/en-us/microsoft-identity-manager/microsoft-identity-manager-2016) for on-premises or [Azure Active Directory Privilege Identity Management](https://docs.microsoft.com/azure/active-directory/privileged-identity-management/pim-configure) for cloud privileged access management.|
|Decentralized identities|Integrate each SaaS offering with [Microsoft Azure Active Directory Connect](https://docs.microsoft.com/azure/active-directory/hybrid/whatis-azure-ad-connect) (if federation is available).|

## Secure development

![Secure Development domain](../media/policies/SecureDevelopment-small.svg)

|Risk|Solution|
|----|--------|
|No SDL practices found|Implement [Microsoft SDL](https://www.microsoft.com/securityengineering/sdl), [Operational Security Assurance](https://www.microsoft.com/securityengineering/osa), and [Secure DevOps](https://www.microsoft.com/securityengineering/devsecops) practices.|

## Business continuity

![Business Continuity domain](../media/policies/BusinessContinuity-small.svg)

|Risk|Solution|
|----|--------|
|Unencrypted backup|Use [Azure Backup](https://azure.microsoft.com/services/backup/), which has a robust set of features, including encryption.|
|No business continuity plan|Use [Azure Paired Regions](https://docs.microsoft.com/azure/best-practices-availability-paired-regions).|
|No disaster recovery plan|Use [Azure Site Recovery](https://azure.microsoft.com/services/site-recovery/).|
|No tests or audits|Follow [Azure Backup](https://docs.microsoft.com/azure/backup/guidance-best-practices) best practices.|

## Cryptography

![Cryptography domain](../media/policies/Cryptography-small.svg)

|Risk|Solution|
|----|--------|
|Use of self-signed certificates on dev environment|Use [Microsoft Azure Directory Services](https://docs.microsoft.com/en-us/windows-server/identity/identity-and-access) to manage your on-premise Public Key Infrastructure (PKI) and [Azure Key-Vault](https://azure.microsoft.com/services/key-vault/) to manage APIs, passwords, certificates, and other secrets.|
|No key rotation|Use [Azure Key-Vault](https://azure.microsoft.com/services/key-vault/) for key rotation.|

## Asset management

![Asset Management domain](../media/policies/Asset-small.svg)

|Risk|Solution|
|----|--------|
|No data retention policy|Use [Azure Data Retention](https://docs.microsoft.com/azure/azure-sql-edge/data-retention-overview) practices and [Azure Time Series Insights](https://docs.microsoft.com/azure/time-series-insights/time-series-insights-concepts-retention). You may also need to create a security policy for the enterprise highlighting how long to keep each resource.|
|No data classification or labeling|Use [Azure Data Discovery & Classification](https://docs.microsoft.com/azure/azure-sql/database/data-discovery-and-classification-overview), [Azure Information Protection](https://docs.microsoft.com/azure/information-protection/what-is-information-protection) for emails and documents, [Azure Purview](https://docs.microsoft.com/azure/purview/apply-classifications), and built-in capabilities in Azure SQL Database, like [dynamic data masking](https://docs.microsoft.com/azure/azure-sql/database/dynamic-data-masking-overview). Also, check out [data encryption best practices](https://docs.microsoft.com/azure/security/fundamentals/data-encryption-best-practices)|
|No folder restrictions||
|No asset disposal or deprecation plan||
|No data encryption on shared drives and servers|Follow [data encryption best practices](https://docs.microsoft.com/azure/security/fundamentals/data-encryption-best-practices). https://docs.microsoft.com/en-us/azure/security/fundamentals/encryption-atrest|
|No Data Leakage Prevention (DLP)||
|NAS used for both backups and file shares||
|OneDrive not fully adopted||
|No disk encryption on enterprise machines|Follow [data encryption best practices](https://docs.microsoft.com/azure/security/fundamentals/data-encryption-best-practices). https://docs.microsoft.com/en-us/azure/security/fundamentals/data-encryption-best-practices|
|No station lock policy||

## Legal

![Legal domain](../media/policies/Legal-small.svg)

Based on the assessment answers, employees sign non-disclosure agreements, have their backgrounds checked, and receive the software and hardware use policy. A specialized team handles financial regulatory compliance, so no other recommendations are needed.

## Incident response

![Incident Response domain](../media/policies/IncidentResponse-small.svg)

|Risk|Solution|
|----|--------|
|No incident response program for enterprise||
|No incident response program for product|Incident management - ServiceNow (ITSM tool for tracking)|

## Network

![Network domain](../media/policies/Network-small.svg)

|Risk|Solution|
|----|--------|
|No network segmentation|Segment the network into multiple subnets. If needed, consider adding a DMZ to secure more sensitive resources.|
|No custom firewall rules|Harden firewall rules by identifying and setting only outbound rules. Consider implementing Azure Firewall in a hub vnet.|
|Weak VPN authentication mechanism|Set VPN to have dedicated connectivity to Azure IaaS.|
|Limited data encryption|Enforce secure communication protocols, like TLS 1.2.|

## Operations

![Operations domain](../media/policies/Operations-small.svg)

|Risk|Solution|
|----|--------|
|No automated process for security patches and updates|Patching - Cloud Service - Azure Kubernetes Service|
|No Antivirus (AV) enforcement|Use [Microsoft Defender Advanced Threat Protection](https://docs.microsoft.com/mem/configmgr/protect/deploy-use/defender-advanced-threat-protection)|
|No timeout session enforcement on machines||
|No Mobile Device Management (MDM) solution|Use [Microsoft Endpoint Configuration Manager](https://docs.microsoft.com/mem/configmgr/) for all Windows devices and [Microsoft Intune](https://docs.microsoft.com/mem/intune/) for Android and iOS.|
|Limited logging and monitoring|Use Azure Monitor [Log Analytics](https://docs.microsoft.com/en-us/azure/azure-monitor/log-query/log-query-overview).|
|No intelligence platform or analytics service|Use [Azure Sentinel](https://azure.microsoft.com/services/azure-sentinel/), Microsoft's Security Information and Event Management (SIEM) solution.|
|Limited logging history||

Dev – move to cloud build server, GitHub enterprise, implement SDL

Service account password rotation

## Physical and environmental

![Physical and environmental domain](../media/policies/Physical-small.svg)

|Risk|Solution|
|----|--------|
|IT room is unlocked|Lock IT room.|
|No cameras or access records for the IT room||
|Building owner has access to all rooms and floors||
|No building cameras or guards||
|No formal visitor registration process||

## Governance

![Governance domain](../media/policies/Governance-small.svg)

|Risk|Solution|
|----|--------|
|No information security policy|Create information security policy.|
|No risk management program|Create risk management program.|
|No security training|Create security training.|

## Security architecture

![Security architecture domain](../media/policies/SecurityArchitecture-small.svg)

|Risk|Solution|
|----|--------|
|No secure template images||
|No security baselines||
|No formal audit to ensure hybrid infrastructure security|https://docs.microsoft.com/en-us/azure/security/fundamentals/iaas|

## Supplier

![Supplier risk domain](../media/policies/Supplier-small.svg)

|Risk|Solution|
|----|--------|
|No supplier management program||
