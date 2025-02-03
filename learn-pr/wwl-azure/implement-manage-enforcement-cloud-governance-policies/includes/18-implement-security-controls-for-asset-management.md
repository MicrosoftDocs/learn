## Security Control: Asset management

Asset Management covers controls to ensure security visibility and governance over your resources, including recommendations on permissions for security personnel, security access to asset inventory, and managing approvals for services and resources (inventory, track, and correct).

### AM-1: Track asset inventory and their risks

| **CIS Controls v8 ID(s)** | **NIST SP 800-53 r4 ID(s)** | **PCI-DSS ID(s) v3.2.1** |
| ------------------------- | --------------------------- | ------------------------ |
| 1.1, 1.5, 2.1, 2.4        | CM-8, PM-5                  | 2.4                      |

Security principle: Track your asset inventory by query and discover all your cloud resources. Logically organize your assets by tagging and grouping your assets based on their service nature, location, or other characteristics. Ensure your security organization has access to a continuously updated inventory of assets.

Ensure your security organization can monitor the risks to cloud assets by always having security insights and risks aggregated centrally.<br>Azure guidance: The Microsoft Defender for Cloud inventory feature and Azure Resource Graph can query for and discover all resources in your subscriptions, including Azure services, applications, and network resources. Logically organize assets according to your organization's taxonomy using tags as well as other metadata in Azure (Name, Description, and Category).

Ensure that security organizations have access to a continuously updated inventory of assets on Azure. Security teams often need this inventory to evaluate their organization's potential exposure to emerging risks, and as an input for continuous security improvements.

Ensure security organizations are granted Security Reader permissions in your Azure tenant and subscriptions so they can monitor for security risks using Microsoft Defender for Cloud. Security Reader permissions can be applied broadly to an entire tenant (Root Management Group) or scoped to management groups or specific subscriptions.

Note: Additional permissions might be required to get visibility into workloads and services.

GCP guidance: Use Google Cloud Asset Inventory to provide inventory services based on a time series database. This database keeps a five-week history of GCP asset metadata. The Cloud Asset Inventory export service allows you to export all asset metadata at a certain timestamp or export event change history during a timeframe.

Additionally, Google Cloud Security Command Center supports a different naming convention. Assets are an organization’s Google Cloud resources. The IAM roles for Security Command Center can be granted at the organization, folder, or project level. Your ability to view, create, or update findings, assets, and security sources depends on the level for which you are granted access.

GCP implementation and additional context:

 -  [Cloud Asset Inventory](https://cloud.google.com/asset-inventory)
 -  [Introduction to Cloud Asset Inventory](https://cloud.google.com/asset-inventory/docs/overview)
 -  [Supported asset types in Security Command Center](https://cloud.google.com/security-command-center/docs/supported-asset-types)

Azure implementation and additional context:

 -  [How to create queries with Azure Resource Graph Explorer](/azure/governance/resource-graph/first-query-portal)
 -  [Microsoft Defender for Cloud asset inventory management](/azure/security-center/asset-inventory)
 -  [For more information about tagging assets, see the resource naming and tagging decision guide](/azure/cloud-adoption-framework/decision-guides/resource-tagging/?toc=/azure/azure-resource-manager/management/toc.json)
 -  [Overview of Security Reader Role](/azure/role-based-access-control/built-in-roles#security-reader)

AWS guidance: Use the AWS Systems Manager Inventory feature to query for and discover all resources in your EC2 instances, including application level and operating system level details. In addition, use AWS Resource Groups - Tag Editor to browse AWS resource inventories.

Logically organize assets according to your organization's taxonomy using tags as well as other metadata in AWS (Name, Description, and Category).

Ensure that security organizations have access to a continuously updated inventory of assets on AWS. Security teams often need this inventory to evaluate their organization's potential exposure to emerging risks, and as an input for continuous security improvements.

Note: Additional permissions might be required to get visibility into workloads and services.

AWS implementation and additional context:

 -  [AWS Systems Manager Inventory](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-inventory.html)
 -  [AWS Resource Groups and Tags](https://docs.aws.amazon.com/ARG/latest/userguide/tag-editor.html)

GCP guidance: Use Google Cloud Organization Policy Service to audit and restrict which services users can provision in your environment. You can also use Cloud Monitoring in Operations Suite and/or Organization Policy to create rules to trigger alerts when a non-approved service is detected.

GCP implementation and additional context:

 -  [Introduction to the Organization Policy Service](https://cloud.google.com/resource-manager/docs/organization-policy/overview)
 -  [Creating and managing organization policies](https://cloud.google.com/resource-manager/docs/organization-policy/creating-managing-policies)

Customer security stakeholders ([Learn more](/azure/cloud-adoption-framework/organize/cloud-security#security-functions)):

 -  [Infrastructure and endpoint security](/azure/cloud-adoption-framework/organize/cloud-security-infrastructure-endpoint)
 -  [Security Compliance Management](/azure/cloud-adoption-framework/organize/cloud-security-compliance-management)

## AM-2: Use only approved services

| **CIS Controls v8 ID(s)** | **NIST SP 800-53 r4 ID(s)** | **PCI-DSS ID(s) v3.2.1** |
| ------------------------- | --------------------------- | ------------------------ |
| 2.5, 2.6 , 2.7, 4.8       | CM-8, PM-5                  | 6.3                      |

Security principle: Ensure that only approved cloud services can be used, by auditing and restricting which services users can provision in the environment.<br>

Azure guidance: Use Azure Policy to audit and restrict which services users can provision in your environment. Use Azure Resource Graph to query for and discover resources within their subscriptions. You can also use Azure Monitor to create rules to trigger alerts when a non-approved service is detected.

Azure implementation and additional context:

 -  [Configure and manage Azure Policy](/azure/governance/policy/tutorials/create-and-manage)
 -  [How to deny a specific resource type with Azure Policy](/azure/governance/policy/samples/not-allowed-resource-types)
 -  [How to create queries with Azure Resource Graph Explorer](/azure/governance/resource-graph/first-query-portal)

AWS guidance: Use AWS Config to audit and restrict which services users can provision in your environment. Use AWS Resource Groups to query for and discover resources within their accounts. You can also use CloudWatch and/or AWS Config to create rules to trigger alerts when a non-approved service is detected.

AWS implementation and additional context:

 -  [AWS Resource Groups](https://docs.aws.amazon.com/ARG/latest/userguide/gettingstarted.html)

GCP guidance: Establish or update security policies/process that address asset lifecycle management processes for potentially high impact modifications. These modifications include changes to identity providers and access, sensitive data, network configuration, and administrative privilege assessment. Use Google Cloud Security Command Center and check Compliance tab for assets at risk.

Additionally, use Automated Cleanup of Unused Google Cloud Projects, and Cloud Recommender service to provide recommendations and insights for using resources on Google Cloud. These recommendations and insights are per-product or per-service, and are generated based on heuristic methods, machine learning, and current resource usage.

GCP implementation and additional context:

 -  [Cloud Recommender](https://cloud.google.com/recommender/docs/overview)
 -  [Automated Cleanup of Unused Google Cloud Projects.](https://cloud.google.com/blog/topics/developers-practitioners/automated-cleanup-unused-google-cloud-projects)

Customer security stakeholders ([Learn more](/azure/cloud-adoption-framework/organize/cloud-security#security-functions)):

 -  [Security Compliance Management](/azure/cloud-adoption-framework/organize/cloud-security-compliance-management)
 -  [Posture management](/azure/cloud-adoption-framework/organize/cloud-security-posture-management)

## AM-3: Ensure security of asset lifecycle management

| **CIS Controls v8 ID(s)** | **NIST SP 800-53 r4 ID(s)** | **PCI-DSS ID(s) v3.2.1** |
| ------------------------- | --------------------------- | ------------------------ |
| 1.1, 2.1                  | CM-8, CM-7                  | 2.4                      |

Security principle: Ensure security attributes or configurations of the assets are always updated during the asset lifecycle.<br>

Azure guidance: Establish or update security policies/process that address asset lifecycle management processes for potentially high impact modifications. These modifications include changes to identity providers and access, data sensitivity level, network configuration, and administrative privilege assignment.

Identify and remove Azure resources when they are no longer needed.

Azure implementation and additional context:

 -  [Delete Azure resource group and resource](/azure/azure-resource-manager/management/delete-resource-group)

AWS guidance: Establish or update security policies/process that address asset lifecycle management processes for potentially high impact modifications. These modifications include changes to identity providers and access, data sensitivity level, network configuration, and administrative privilege assignment.

Identify and remove AWS resources when they are no longer needed.

AWS implementation and additional context:

 -  [How do I check for active resources that I no longer need on my AWS account?](https://aws.amazon.com/premiumsupport/knowledge-center/check-for-active-resources/)
 -  [How do I terminate active resources that I no longer need on my AWS account?](https://aws.amazon.com/premiumsupport/knowledge-center/terminate-resources-account-closure/)

GCP guidance: Use Google Cloud Identity and Access Management (IAM) to restrict access to specific resource. You can specify allow or deny actions as well as conditions under which actions are triggered. You can specify one condition or combined methods of resource-level permissions, resource based policies, tag-based authorization, temporary credentials, or service-linked roles to have fine-grain control access controls for your resources.

Additionally, you can use VPC Service Controls to protect against accidental or targeted action by external entities or insiders entities, which helps to minimize unwarranted data exfiltration risks from Google Cloud services. You can use VPC Service Controls to create perimeters that protect the resources and data of services that you explicitly specify.

GCP implementation and additional context:

 -  [Identity and Access Management (IAM)](https://cloud.google.com/iam)
 -  [Overview of VPC Service Controls](https://cloud.google.com/vpc-service-controls/docs/overview)
 -  [Resource Manager](https://cloud.google.com/resource-manager)

Customer security stakeholders ([Learn more](/azure/cloud-adoption-framework/organize/cloud-security#security-functions)):

 -  [Infrastructure and endpoint security](/azure/cloud-adoption-framework/organize/cloud-security-infrastructure-endpoint)
 -  [Posture management](/azure/cloud-adoption-framework/organize/cloud-security-posture-management)
 -  [Security Compliance Management](/azure/cloud-adoption-framework/organize/cloud-security-compliance-management)

## AM-4: Limit access to asset management

| **CIS Controls v8 ID(s)** | **NIST SP 800-53 r4 ID(s)** | **PCI-DSS ID(s) v3.2.1** |
| ------------------------- | --------------------------- | ------------------------ |
| 3.3                       | AC-3                        | N/A                      |

Security principle: Limit users' access to asset management features, to avoid accidental or malicious modification of the assets in your cloud.<br>

Azure guidance: Azure Resource Manager is the deployment and management service for Azure. It provides a management layer that enables you to create, update, and delete resources (assets) in Azure. Use Azure AD Conditional Access to limit users' ability to interact with Azure Resource Manager by configuring "Block access" for the "Microsoft Azure Management" App.

Use Azure Role-based Access Control (Azure RBAC) to assign roles to identities to control their permissions and access to Azure resources. For example, a user with only the 'Reader' Azure RBAC role can view all resources, but is not allowed to make any changes.

Use Resource Locks to prevent either deletions or modifications to resources. Resource Locks may also be administered through Azure Blueprints.

Azure implementation and additional context:

 -  [How to configure Conditional Access to block access to Azure Resources Manager](/azure/role-based-access-control/conditional-access-azure-management)
 -  [Lock your resources to protect your infrastructure](/azure/azure-resource-manager/management/lock-resources?tabs=json)
 -  [Protect new resources with Azure Blueprints resource locks](/azure/governance/blueprints/tutorials/protect-new-resources)

AWS guidance: Use AWS IAM to restrict access to a specific resource. You can specify allowed or deny actions as well as the conditions under which actions are triggered. You may specify one condition or combine methods of resource-level permissions, resource-based policies, tag-based authorization, temporary credentials, or service-linked roles to have a fine-grain control access control for your resources.

AWS implementation and additional context:

 -  [AWS services that work with IAM](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-services-that-work-with-iam.html)

GCP guidance: Use Google Cloud VM Manager to discover the applications installed on Compute Engines instances. OS inventory and configuration management can be used ensure that non-authorized software is blocked from executing on Compute Engine instances.

You can also use a third-party solution to discover and identify unapproved software.

GCP implementation and additional context:

 -  [VM Manager](https://cloud.google.com/compute/docs/vm-manager)
 -  [OS configuration management](https://cloud.google.com/compute/docs/os-configuration-management)

Customer security stakeholders ([Learn more](/azure/cloud-adoption-framework/organize/cloud-security#security-functions)):

 -  [Posture management](/azure/cloud-adoption-framework/organize/cloud-security-posture-management)
 -  [Infrastructure and endpoint security](/azure/cloud-adoption-framework/organize/cloud-security-infrastructure-endpoint)

## AM-5: Use only approved applications in virtual machine

| **CIS Controls v8 ID(s)** | **NIST SP 800-53 r4 ID(s)** | **PCI-DSS ID(s) v3.2.1** |
| ------------------------- | --------------------------- | ------------------------ |
| 2.5, 2.6, 2.7, 4.8        | CM-8, CM-7, CM-10, CM-11    | 6.3                      |

Security principle: Ensure that only authorized software executes by creating an allow list and block the unauthorized software from executing in your environment.<br>

Azure guidance: Use Microsoft Defender for Cloud adaptive application controls to discover and generate an application allow list. You can also use ASC adaptive application controls to ensure that only authorized software can executes, and all unauthorized software is blocked from executing on Azure Virtual Machines.

Use Azure Automation Change Tracking and Inventory to automate the collection of inventory information from your Windows and Linux VMs. Software name, version, publisher, and refresh time information are available from the Azure portal. To get the software installation date and other information, enable guest-level diagnostics and direct the Windows Event Logs to a Log Analytics workspace.

Depending on the type of scripts, you can use operating system-specific configurations or third-party resources to limit users' ability to execute scripts in Azure compute resources.

You can also use a third-party solution to discover and identify unapproved software.

Azure implementation and additional context:

 -  [How to use Microsoft Defender for Cloud adaptive application controls](/azure/security-center/security-center-adaptive-application)
 -  [Understand Azure Automation Change Tracking and Inventory](/azure/automation/change-tracking)
 -  [How to control PowerShell script execution in Windows environments](/powershell/module/microsoft.powershell.security/set-executionpolicy)

AWS guidance: Use the AWS Systems Manager Inventory feature to discover the applications installed in your EC2 instances. Use AWS Config rules to ensure that non-authorized software is blocked from executing on EC2 instances.

You can also use a third-party solution to discover and identify unapproved software.

AWS implementation and additional context:

 -  [Preventing prohibited applications with AWS Systems Manager and AWS Config](https://aws.amazon.com/blogs/mt/preventing-blacklisted-applications-with-aws-systems-manager-and-aws-config/)

Customer security stakeholders ([Learn more](/azure/cloud-adoption-framework/organize/cloud-security#security-functions)):

 -  [Infrastructure and endpoint security](/azure/cloud-adoption-framework/organize/cloud-security-infrastructure-endpoint)
 -  [Posture management](/azure/cloud-adoption-framework/organize/cloud-security-posture-management)
 -  [Security Compliance Management](/azure/cloud-adoption-framework/organize/cloud-security-compliance-management)
