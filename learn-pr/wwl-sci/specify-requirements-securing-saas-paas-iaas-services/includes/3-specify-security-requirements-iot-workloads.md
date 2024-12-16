This unit summarizes the [Azure security baseline for IoT Hub](/security/benchmark/azure/baselines/iot-hub-security-baseline) to assist you in creating new requirements specifications for IoT workloads.

Please refer to [Introduction to Microsoft Cybersecurity Reference Architecture and cloud security benchmark](/training/modules/design-solutions-microsoft-cybersecurity-cloud-security-benchmark/1-introduction-reference-architecture-benchmark) for more background on Microsoft Cloud Security Benchmark. 

In the table below, we have included controls from the full baseline where:

* Security controls were *supported* but *not* enabled by default
* There was explicit guidance which contained action to be taken on the part of the customer

| Area | Control | Feature | Guidance Summary |
|---|---|---|---|
| Network security    | NS-2: Secure cloud services with network controls  | Azure Private Link  | Deploy private endpoints for all Azure resources that support the Private Link feature, to establish a private access point for the resources.  |
|   | NS-2: Secure cloud services with network controls  | Disable Public Network Access  | Disable public network access either using the service-level IP ACL filtering rule or a toggling switch for public network access.  |
| Identity management  | IM-1: Use centralized identity and authentication system  | Local Authentication Methods for Data Plane Access  | Restrict the use of local authentication methods for data plane access. Instead, use Microsoft Entra ID as the default authentication method to control your data plane access.  |
|   | IM-3: Manage application identities securely and automatically  | Managed Identities  | Use Azure managed identities instead of service principals when possible, which can authenticate to Azure services and resources that support Microsoft Entra authentication. Managed identity credentials are fully managed, rotated, and protected by the platform, avoiding hard-coded credentials in source code or configuration files.  |
|   |   | Service Principals  | There is no current Microsoft guidance for this feature configuration. Please review and determine if your organization wants to configure this security feature.  |
|   | IM-7: Restrict resource access based on conditions  | Conditional Access for Data Plane  | Define the applicable conditions and criteria for Microsoft Entra Conditional Access in the workload.  |
| Privileged access  | PA-7: Follow just enough administration (least privilege) principle  | Azure RBAC for Data Plane  | With Azure AD and RBAC, IoT Hub requires the principal requesting the API to have the appropriate level of permission for authorization. To give the principal the permission, give it a role assignment.  |
| Data protection | DP-6: Use a secure key management process  | Key Management in Azure Key Vault  | Use Azure Key Vault to create and control the life cycle of your encryption keys, including key generation, distribution, and storage. Rotate and revoke your keys in Azure Key Vault and your service based on a defined schedule or when there's a key retirement or compromise.   |
| Asset management  | AM-2: Use only approved services  | Azure Policy Support  | Use Microsoft Defender for Cloud to configure Azure Policy to audit and enforce configurations of your Azure resources. |
| Logging and threat detection | LT-4: Enable logging for security investigation  | Azure Resource Logs  | Enable resource logs for the service.  |
