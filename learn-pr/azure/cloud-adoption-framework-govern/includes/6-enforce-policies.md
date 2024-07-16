Cloud governance enforcement refers to the controls and procedures that you incorporate to align cloud use to your cloud governance policies. Your cloud governance team must delegate enforcement responsibilities so that each team or individual in your organization can enforce cloud governance policies within their area of responsibility.

To effectively enforce cloud governance policies:

**Define an approach for enforcing policies.** Delegate governance responsibilities, adopt an inheritance model for policies, apply tagging and naming conventions to the resources in the inheritance model, and implement a monitor-first approach to ensure a smooth transition to enforcement.

**Automate cloud governance.** Use cloud governance tools to automate compliance on a small set of policies and then add more policies. Incorporate infrastructure as code (IaC) tools or custom scripts or applications. Automate areas of governance such as:  
 - AI
 - Cost
 - Data
 - Operations
 - Regulatory compliance
 - Resource management
 - Security

**Review and update enforcement mechanisms.** Keep cloud governance policy enforcement aligned with your current needs, including developer, architect, workload, platform, and business requirements. Track changes in regulations and standards to ensure compliance. 

## Align with cloud governance policies

The cloud provides guardrails to help reduce human overhead due to recurring processes. You can use these guardrails to help align with the policies that you incorporate.

The following table outlines triggers and actions that can address the risks that concern the Tailwind Traders CIO. The actions align their organization with their new policies.

| Risk | Sample trigger | Sample action |
|-----------------------------|----------------|---------------|
| Overspending in the cloud | Monthly cloud spending is 20% higher than expected. | Notify the billing unit leader so that they can review resource usage. |
| Overspending in the cloud | Deployed assets don't use the allocated CPU or memory. | Notify the billing unit leader and automatically resize to fit actual usage, when possible. |
| Not meeting organizational security or compliance requirements | Deviations from defined security or compliance requirements. | Notify the IT security team and automate remediation, when possible. |
| Asset configurations create operations management problems or oversights | CPU usage for a workload is higher than 90%. | Notify the IT operations team, and scale out more resources to handle the load. |
| Asset configurations create operations management problems or oversights | Assets that fail to meet patching, business continuity, or disaster recovery requirements trigger an operational compliance warning. | Notify the IT security team, and automatically resolve the deviation, when possible. |
| Unauthorized access that compromises systems or data | Traffic patterns deviate from approved network topologies. | Notify the IT security team, and automatically close attack vectors, when possible.|
| Unauthorized access that compromises systems or data | Assets are configured without proper role assignments or elevated privileges. | Notify the IT security team, and automatically resolve the deviation, when possible. |
| Immature processes or lack of team skills creates inconsistent governance | Identified assets aren't included in required governance processes. | Notify the IT governance team, and automatically resolve the deviation, when possible. |

You can use Azure governance tools to automate notifications for each of these triggers. Other cloud providers might require a more manual approach, but the defined policies still apply. Don't define policies that lock you into using a specific vendor so that you don't have to repeat this process in the future.

After you establish your cloud policy statements and draft a design guide, you need to create a strategy to ensure that your cloud deployment remains compliant with your policy requirements. This strategy must encompass your cloud governance team's ongoing review and communication processes and establish criteria for when policy violations require action. This strategy must also define the requirements for automated monitoring and compliance systems that detect violations and trigger remediation actions.

## Governance design consideration

To accommodate long-term governance needs, apply a hierarchical governance model in which specific workloads inherit governance policies from the platform. This model helps ensure that organizational standards apply to the correct environments, such as purchasing requirements for cloud services.

:::image type="content" source="../media/management-group-hierarchy.png" alt-text="Diagram that shows the management group hierarchy." border="false" lightbox="../media/management-group-hierarchy.png":::

- **Management groups**: Such as a business unit, geography, or environment

- **Subscriptions**: For each application category, such as preproduction, development, and production environments
- **Resource groups**: For each application

## Define a tagging and naming strategy

Define a tagging and naming strategy to provide a structured framework for resource categorization, cost management, security, and compliance across the cloud environment. Tag resources to set up your environment so that you can take advantage of automated tools. Consider the following suggested tags for workloads:

- Workload or application
- Data sensitivity
- Mission criticality
- Owner
- Department, such as cost center
- Environment

For more information and examples, see [Define your tagging strategy](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-tagging).

### Exercise: Assign a tagging policy

You can apply Azure policies to all subscriptions in a management group. To understand the role of policy in your governance foundation, follow the [tutorial to assign a policy](/azure/governance/policy/tutorials/create-and-manage#assign-a-policy) to one of your management groups.

:::image type="content" source="../media/select-assign-policy.png" alt-text="Screenshot that shows the assign policy button in the Azure portal." lightbox="../media/select-assign-policy.png":::

On step 4 of the tutorial, select a management group to ensure that you apply the policies to all subscriptions in the management group.

On steps 6 and 7 of the tutorial, select one of the built-in policies related to [tagging](/azure/governance/policy/samples/built-in-policies#tags). Specifically, the policy that requires a [tag on all resources](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F1e30110a-5ceb-460c-a204-c1c3969c6d62) helps establish a governance foundation.

> [!IMPORTANT]
> On step 9, set **Policy enforcement** to **Disabled**. When you disable this setting, you can audit your environment without making any changes, and you don't block future deployments.

## Tailwind Traders example

To enforce their new policy "Avoid overspending," Tailwind Traders can:

- Define clear spending limits for each individual or team in the organization.
- Create a budget in Microsoft Cost Management to track spending.
- Create alerts for overspending.
- Put aside extra funds for unexpected costs.
- Optimize resource usage.

