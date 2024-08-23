Azure Policy is a service in Azure that you use to create, assign, and manage policies. These policies enforce different rules over your resources, so those resources stay compliant with your corporate standards and service level agreements. Azure Policy does this by running evaluations of your resources and scanning for those not compliant with the policies you have created.

The main advantages of Azure policy are in the areas of enforcement and compliance, scaling, and remediation.

- **Enforcement and compliance**. Turn on built-in policies or build custom ones for all resource types. Real-time policy evaluation and enforcement. Periodic and on-demand compliance evaluation.
- **Apply policies at scale**. Apply policies to a Management Group with control across your entire organization. Apply multiple policies and aggregate policy states with policy initiative. Define an exclusion scope.
- **Remediation**. Real-time remediation, and remediation on existing resources.

Azure Policy is important to you if your team runs an environment where you need to govern:

- Multiple engineering teams (deploying to and operating in the environment)
- Multiple subscriptions
- Need to standardize/enforce how cloud resources are configured
- Manage regulatory compliance, cost control, security, or design consistency

Azure compliance monitoring tools for Azure Policy include [Azure Policy Regulatory Compliance controls for Azure Monitor](/azure/azure-monitor/security-controls-policy) and [Microsoft Defender for Cloud](/azure/defender-for-cloud/), and third party tools. Defender for Cloud enables you to apply secure configuration standards across your on-premises and multicloud resources while discovering new resources that are being deployed. Both Azure Monitor and Defender for Cloud can assess your Azure Policy configuration for security best practices, providing a prioritized list of recommendations to help you reduce the attack surface across each of your resources.

For more information on Azure Policy, see [Azure Policy Documentation](/azure/azure-policy/).

## Optional demo

- [Demonstration: Create an Azure Policy](https://go.microsoft.com/fwlink/?linkid=2260471&clcid=0x409)
