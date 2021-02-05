Azure Arc allows you to extend the scope of several Azure services to non-Azure Windows and Linux servers. This helps companies like Contoso to standardize their management strategy when operating in hybrid scenarios. In this unit, you will learn about the capabilities of Azure Arc, focusing on those available exclusively to Azure and Azure Arc enabled servers. 

## What are the key capabilities of Azure Arc?

A number of Azure Arc benefits are independent of the resource type, since they reflect the capabilities of Azure Resource Manager. These benefits include:

- The ability to organize all organizational resources by using Azure management groups, subscriptions, resource groups, and tags.
- A single, comprehensive inventory of organizational assets across multi-clouds and on-premises, including support for searching and indexing by using Azure Resource Graph.
- A consolidated view of Azure and Azure Arc enabled resources via the Azure portal, Azure Command Line Interface (CLI), Azure PowerShell, and Representational state transfer (REST) Application Programming Interface (API). 
- Direct access from the Azure portal to most of the management features of the Azure Arc enabled servers: 

  - Role Based Access Control for viewing logs and server inventory data
  - VM extensions to deploy software agents and run scripts on your server
  - Azure Policy guest configuration to audit operating system and software configuration
  - An Azure Active Directory system assigned managed identity for apps running on the server to use when authenticating to other Azure services

![Screenshot of the Access control (IAM) page in the Azure portal for the selected VM: ContosoVM1. The details pane displays a number of tabs: Check access (selected), Role assignments, Deny assignments, Classic administrators, and Roles.](../media/3-access-control.png)

There are also benefits specific to Azure Arc enabled servers, such as:

- The ability to apply Azure Virtual Machine (VM) extensions to automate configuration of Azure and non-Azure Windows and Linux servers in the consistent manner.
- The Support for Azure Policy guest configuration. Azure Policy supports auditing Azure Arc enabled servers in the same way as their Azure-resident counterparts. This allows you to use the same approach to evaluate whether configurations of all servers in your environment comply with organizational standards.

### What are VM extensions?

VM extensions are lightweight software components that automate post-operating system deployment configuration and automation tasks. Traditionally, VM extensions were available only on Azure VMs, but now it is possible to use selected ones on Azure Arc enabled servers. The following table describes the extensions that you can add to Azure Arc enabled servers running Windows Server or Linux operating system:

| Extension | Additional information |
| --- | --- |
| Custom Script Extension | Executes a script on the target Arc enabled server. |
| Desired State Configuration | Applies a PowerShell DSC configuration on the target Arc enabled server. |
| Log Analytics agent | Installs the Log Analytics agent on the target Arc enabled server and configures it for log forwarding to a Log Analytics workspace. |
| Dependency agent | Installs the Dependency agent on the target Arc enabled server to facilitate identifying internal and external dependencies of server workloads. |
| Azure Key Vault agent | Synchronizes certificates from an Azure Key Vault instance to the Arc enabled server. |
| Qualys extension | Azure Defender for servers vulnerability assessment scanning solution. |

### What is the role of Azure Policy in managing Arc enabled servers?

Azure Policy is a service that can help organizations manage and evaluate internal and regulatory compliance of their Arc enabled servers, in addition to a wide range of Azure services. Azure Policy uses declarative rules based on properties of target resource types, including Windows and Linux operating systems. These rules form policy definitions, which administrators can apply through policy assignment to resource groups, subscriptions, or management groups that host Azure Arc enabled servers. To simplify management of policy definitions, it is possible to combine multiple policies into initiatives, and then create a few initiative assignments in lieu of multiple policy assignments.

Azure Policy supports auditing the state of Arc enabled server with Guest Configuration policies. Guest Configuration policies do not apply configurations, but they audit settings within the target operating system and evaluate their compliance. You can, however, use Azure Policy to apply configuration of the Azure resource representing an Arc enabled server. You can also use Azure Policy to deploy configurations by using VM extensions.

For example, Contoso could use Azure Policy to implement the following rules:

- Assigning a specific tag to resources representing Arc enabled servers during their registration.
- Identify Arc enabled servers running Windows with Windows Defender Exploit Guard disabled.
- Identify Arc enabled servers running Windows that are not joined to a specific Active Directory Domain Services (AD DS) domain.
- Identify Arc enabled servers running Windows or Linux without Log Analytics agent installed.
- Identify Arc enabled servers running Linux that are not using SSH keys for authentication.

> [!NOTE] 
> Policies that support remediation do not have to evaluate the policy logic inside the operating system of the Azure Arc enabled server, but instead rely on Azure resource metadata. Examples of such policies include enforcement of tag compliance or deployment of VM extensions. 

> [!NOTE] 
> Azure Policy supports Azure VMs and Azure Arc enabled servers, providing consistent, organization-wide view of compliance information.

### Assign policies to Azure Arc enabled servers

You can manage and assign Azure policies to Azure Arc enabled servers directly from the Azure portal. 

![The screenshot depicts the Assign policy page in the Azure portal. The administrator is selecting from a list of available policies.](../media/3-assign-policy.png)

Once you create a policy assignment, shortly afterwards, you will be able to review the outcome of the policy evaluation on the target Azure Arc enabled servers.

![The screenshot depicts the applied policies on ContosoVM1. Two policies are applied, and the VM is compliant with one but not the other.](../media/3-review-policies.png)

Choose the best response for each of the following questions. Then select "Check your answers".
