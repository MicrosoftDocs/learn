Virtual machine (VM) extensions are small applications that provide post-deployment configuration and automation tasks on Azure VMs. For example, if a virtual machine requires software installation, anti-virus protection, or to run a script in it, a VM extension can be used. Tailwind Manufacturing can install VM extensions on their Arc-enabled infrastructure at scale using Azure Policy. Azure Policy also provides insight into the state of compliance for these extensions.

Azure Policy uses *definitions* to enforce certain requirements on your virtual machines. Each definition contains rules and parameters that define conditions that must be met and how the policy should operate. Azure Policy has many built-in definitions you can apply to your hybrid and multicloud VMs that install extensions and make sure your VMs remain in compliance.

## Create a policy assignment

To use a policy definition, you create a policy assignment containing the applicable definition you want to implement, and then define the scope of the assignment. In this case, you'll want the scope to include all of your Arc-enabled VMs on which you want to install a particular extension.


> [!NOTE]
> If you don't have an Azure subscription, create a [free](https://azure.microsoft.com/free/) account
> before you begin.
> 

In the example below, you'll create a policy assignment and assign the policy definition _\[Preview]: Log Analytics extension should be installed on your Linux Azure Arc machines_:

1. Launch the Azure Policy service in the Azure portal by selecting **All services**, then searching
   for and selecting **Policy**.

   :::image type="content" source="../media/all-services-page.png" alt-text="Screenshot of All services window showing search for policy service." border="true":::

1. Select **Assignments** on the left side of the Azure Policy page. An assignment is a policy that
   has been assigned to take place within a specific scope.

    :::image type="content" source="../media/assignments-tab.png" alt-text="Screenshot of All services Policy window showing policy assignments." border="true":::

1. Select **Assign Policy** from the top of the **Policy - Assignments** page.

1. On the **Assign Policy** page, select the **Scope** by clicking the ellipsis and selecting either
   a management group or subscription. Optionally, select a resource group. A scope determines what
   resources or grouping of resources the policy assignment gets enforced on. Then click **Select**
   at the bottom of the **Scope** page.

1. Resources can be excluded based on the **Scope**. **Exclusions** start at one level lower than
   the level of the **Scope**. **Exclusions** are optional, so leave it blank for now.

1. Select the **Policy definition** ellipsis to open the list of available definitions. Azure Policy
   comes with built-in policy definitions you can use. Many are available, such as:

   - Enforce tag and its value
   - Apply tag and its value
   - Inherit a tag from the resource group if missing

1. Search through the policy definitions list to find the _\[Preview]: Log Analytics extension should be installed on your Windows Azure Arc machines_
   definition (if you have enabled the Azure Connected Machine agent on a Windows-based machine). For a Linux-based machine, find the corresponding _\[Preview]: Log Analytics extension should be installed on your Linux Azure Arc machines_ policy definition. Click on that policy and click **Select**.

1. The **Assignment name** is automatically populated with the policy name you selected, but you can
   change it. For this example, leave the policy name as is, and don't change any of the remaining options on the page.
 
1. For this example, we don't need to change any settings on the other tabs. Select **Review + Create** to review your new policy assignment, then select **Create**.

You're now ready to identify non-compliant resources to understand the compliance state of your
environment.

## Identify non-compliant resources

Select **Compliance** in the left side of the page. Then locate the **\[Preview]: Log Analytics extension should be installed on your Windows Azure Arc machines** or **\[Preview]: Log Analytics extension should be installed on your Linux Azure Arc machines** policy assignment you created.

:::image type="content" source="../media/compliance-policy.png" alt-text="Screenshot of Policy Compliance page showing policy compliance for the selected scope." border="true":::

If there are any existing resources that aren't compliant with this new assignment, they appear
under **Non-compliant resources**.

When a condition is evaluated against your existing resources and found true, then those resources
are marked as non-compligitant with the policy. The following table shows how different policy effects
work with the condition evaluation for the resulting compliance state. Although you don't see the
evaluation logic in the Azure portal, the compliance state results are shown. The compliance state
result is either compliant or non-compliant.

| **Resource state** | **Effect** | **Policy evaluation** | **Compliance state** |
| --- | --- | --- | --- |
| Exists | Deny, Audit, Append\*, DeployIfNotExist\*, AuditIfNotExist\* | True | Non-compliant |
| Exists | Deny, Audit, Append\*, DeployIfNotExist\*, AuditIfNotExist\* | False | Compliant |
| New | Audit, AuditIfNotExist\* | True | Non-compliant |
| New | Audit, AuditIfNotExist\* | False | Compliant |

\* The Append, DeployIfNotExist, and AuditIfNotExist effects require the IF statement to be TRUE.
The effects also require the existence condition to be FALSE to be non-compliant. When TRUE, the IF
condition triggers evaluation of the existence condition for the related resources.

