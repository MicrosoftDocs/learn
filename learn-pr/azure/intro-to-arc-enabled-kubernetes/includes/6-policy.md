


Azure Policy is a service that can help organizations manage and evaluate internal and regulatory compliance of their Arc enabled servers, in addition to a wide range of Azure services. Azure Policy uses declarative rules based on properties of target resource types, including Windows and Linux operating systems. These rules form policy definitions, which administrators can apply through policy assignment to resource groups, subscriptions, or management groups that host Azure Arc enabled servers. To simplify management of policy definitions, it is possible to combine multiple policies into initiatives, and then create a few of initiative assignments in lieu of multiple policy assignments.

Azure Policy supports auditing the state of Arc enabled server with Guest Configuration policies. Guest Configuration policies do not apply configurations, but they audit settings within the target operating system and evaluate their compliance. You can, however, use Azure Policy to apply configuration of the Azure resource representing an Arc enabled server. You also have the ability to use Azure Policy to deploy configurations by leveraging VM extensions.

For example, Contoso could use Azure Policy to implement the following rules:

- Assigning a specific tag to resources representing Arc enabled servers during their registration.
- Identify Arc enabled servers running Windows with Windows Defender Exploit Guard disabled.
- Identify Arc enabled servers running Windows that are not joined to a specific Active Directory Domain Services (AD DS) domain.
- Identify Arc enabled servers running Windows or Linux without Log Analytics agent installed.
- Identify Arc enabled servers running Linux that are not using SSH keys for authentication.

:::image type="content" source="../media/3-assign-policy.png" alt-text="The screenshot depicts the Assign policy page in the Azure portal. The administrator is selecting from a list of available policies." border="false":::







Azure Arc enables you to extend some capabilities of *Azure Policy* to operating systems of computers that are in on-premises datacenters or are hosted on another cloud provider. This functionality applies to auditing the compliance of settings for the OS, applications, and environment.

Additionally, you can configure the time zone on servers that are running the Windows Server OS. You can also use Azure Policy to manage and evaluate compliance for Azure Arc enabled Kubernetes clusters. Enabling this functionality requires that you install the Azure Connected Machine agent on each computer in the scope of management.

> [!NOTE]
> Currently, you can only audit settings in this context. Auto-remediation is not yet available.

## What is Azure Policy?

*Azure Policy* is a service that can help organizations manage and evaluate compliance for their Azure environments' organizational standards. Azure Policy uses declarative rules based on properties of target Azure resource types. These rules form policy definitions, which administrators can apply through policy assignment to a resource group or subscription.

For example, to simplify management of policy definitions, Contoso could consider combining multiple policies into initiatives and then create a few initiative assignments instead of multiple policy assignments.

Azure Policy functionality groups into four main categories:

- Enforcing compliance when provisioning new Azure resources.
- Auditing the compliance of existing Azure resources.
- Remediating noncompliance of existing Azure resources.
- Auditing the compliance of the OS, application configuration, and environment settings within Azure VMs.

> [!TIP]
> The last of these categories implements by using the Azure Policy Guest Configuration client, which is available as an Azure VM extension. Azure Arc for servers uses the same client to provide auditing functionality in hybrid scenarios.

Specifically, Contoso IT support could use Azure Policy to assign tags to resources during their deployment.

After you install the agent, it requires outbound connectivity to Azure Arc over TCP port 443. At that point, any Azure Policy Guest Configuration client-based configuration that's in the assigned policy or initiative definition will automatically take effect.

### Assign policies with Azure Arc

To manage and assign Azure Arc policies for a computer, browse to Azure Arc in the Azure portal. In the returned list of managed servers, select the appropriate server, and then assign a policy to it. You'll need to configure the:

- Scope and any exclusions from the scope of the policy.
- Policy definition.
- Assignment name.
- Description.
- Policy enforcement (Enabled or Disabled).

:::image type="content" source="../media/6-assign-policy.png" alt-text="The screenshot depicts the Assign policy page in the Azure portal. The administrator is selecting from a list of available policies." border="false":::

After assigning policies, you can review the policy settings on the selected server from Azure Arc.

:::image type="content" source="../media/6-review-policies.png" alt-text="The screenshot depicts the applied policies on ContosoVM1. Two policies are applied, and the VM is compliant with one but not the other." border="false":::
