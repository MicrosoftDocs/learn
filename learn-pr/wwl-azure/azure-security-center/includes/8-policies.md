
## What are security policies, initiatives

Microsoft Defender for Cloud applies security initiatives to your subscriptions. These initiatives contain one or more security policies. Each of those policies results in a security recommendation for improving your security posture. This page explains each of these ideas in detail.

## What is a security policy?

An Azure Policy definition, created in Azure Policy, is a rule about specific security conditions you want to be controlled. Built-in definitions include things like controlling what type of resources can be deployed or enforcing the use of tags on all resources. You can also create your own custom policy definitions.

To implement these policy definitions (whether built-in or custom), you'll need to assign them. You can assign any of these policies through the Azure portal, PowerShell, or Azure CLI. Policies can be disabled or enabled from Azure Policy.

There are different types of policies in Azure Policy. Defender for Cloud mainly uses 'Audit' policies that check specific conditions and configurations and then report on compliance. There are also "Enforce' policies that can be used to apply security settings.

### Example: Built-in security policy

:::image type="content" source="../media/microsoft-defender-for-cloud-assign-policy-vms-basic-policy-definition-7a271105.png" alt-text="Screenshot showing Microsoft Defender for Cloud Assign Policy for VMs Policy Definition.":::


## What is a security initiative?

A security initiative is a collection of Azure Policy definitions or rules that are grouped together towards a specific goal or purpose. Security initiatives simplify the management of your policies by grouping a set of policies together, logically, as a single item.

A security initiative defines the desired configuration of your workloads and helps ensure you comply with the security requirements of your company or regulators.

Like security policies, Defender for Cloud initiatives are also created in Azure Policy. You can use **Azure Policy** to manage your policies, build initiatives, and assign initiatives to multiple subscriptions or entire management groups.

The default initiative automatically assigned to every subscription in Microsoft Defender for Cloud is the Microsoft cloud security benchmark. This benchmark is the Microsoft-authored set of guidelines for security and compliance best practices based on common compliance frameworks. This widely respected benchmark builds on the controls from the Center for Internet Security (CIS) and the National Institute of Standards and Technology (NIST) with a focus on cloud-centric security.

Defender for Cloud offers the following options for working with security initiatives and policies:

 -  **View and edit the built-in default initiative** \- When you enable Defender for Cloud, the initiative named 'Microsoft cloud security benchmark' is automatically assigned to all Defender for Cloud registered subscriptions. To customize this initiative, you can enable or disable individual policies within it by editing a policy's parameters.
 -  **Add your own custom initiatives** \- If you want to customize the security initiatives applied to your subscription, you can do so within Defender for Cloud. You'll then receive recommendations if your machines don't follow the policies you create.
 -  **Add regulatory compliance standards as initiatives** \- Defender for Cloud's regulatory compliance dashboard shows the status of all the assessments within your environment in the context of a particular standard or regulation (such as Azure Center for Internet Security (CIS), National Institute of Standards and Technology (NIST) Special Publications (SP) SP 800-53 Rev.4, Swift’s Customer Security Program (CSP) Call Session Control Function (CSCF) v2020).

### Example: Builtin security initiative

:::image type="content" source="../media/microsoft-defender-for-cloud-cis-initiative-definition-microsoft-azure-foundations-benchmark-v140-regulatory-compliance-4289e289.png" alt-text="Screenshot showing Center for Internet Security Controls and Microsoft  Azure Foundations Benchmark Initiatve  definition page in the Azure dashboard.":::
