Cloud governance enforcement refers to the controls and procedures you use to align cloud use to the cloud governance policies. The cloud governance team must delegate enforcement responsibilities so that each team or individual can enforce cloud governance policies within their area of responsibility.

To effectively enforce cloud governance policies:

- **Define an approach for enforcing policies**: Delegate governance responsibilities, adopt an inheritance model for policies, apply tagging and naming conventions to the resources in the inheritance model, and implement a monitor-first approach to ensure a smooth transition to enforcement.

- **Automate cloud governance**: Use cloud governance tools to automate compliance on a small set of policies and expand out. Incorporate infrastructure as code (IaC) tools or custom scripts or applications. Automate areas of governance such as:  
   - AI
   - Cost
   - Data
   - Operations
   - Regulatory compliance
   - Resource management
   - Security

- **Review and update enforcement mechanisms**: Keep cloud governance policy enforcement aligned with your current needs, including developer, architect, workload, platform, and business requirements. Track changes in regulations and standards to ensure compliance. 

## Governance design consideration

To accommodate long-term governance needs, apply a hierarchical governance model in which specific workloads inherit governance policies from the platform. This model helps ensure that organizational standards apply to the correct environments, such as purchasing requirements for cloud services.

:::image type="content" source="../media/management-group-hierarchy.png" alt-text="Diagram that shows the management group hierarchy." border="false" lightbox="../media/management-group-hierarchy.png":::

- **Management groups**: Such as business unit, geography, or environment

- **Subscriptions**: For each application category, such as preproduction, development, and production environments
- **Resource groups**: For each application

## Define a tagging and naming strategy

Define a tagging and naming strategy to provide a structured framework for resource categorization, cost management, security, and compliance across the cloud environment. Tag resources to set up your environment so that you can take advantage of automated tools. Consider the following suggested tags for workloads:

- Workload or application
- Data sensitivity, see [data sensitivity examples](/azure/cloud-adoption-framework/govern/policy-compliance/data-classification)
- Mission criticality, see [mission criticality examples](/azure/cloud-adoption-framework/manage/considerations/criticality)
- Owner
- Department, such as cost center
- Environment

### Exercise: Assign a tagging policy

You can apply Azure policies to all subscriptions in a management group. To understand the role of policy in your governance foundation, apply a policy to one of your management groups.

:::image type="content" source="../media/select-assign-policy.png" alt-text="Screenshot that shows the assign policy button in the Azure portal." lightbox="../media/select-assign-policy.png":::

To apply a policy, see the [tutorial to assign a policy](/azure/governance/policy/tutorials/create-and-manage#assign-a-policy).

- On step 4, select a management group to ensure that you apply the policies to all subscriptions in the management group.

- On steps 6 and 7, select one of the built-in policies related to [tagging](/azure/governance/policy/samples/built-in-policies#tags). Specifically, the policy that requires a [tag on all resources](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F1e30110a-5ceb-460c-a204-c1c3969c6d62) helps establish a governance foundation.

> [!IMPORTANT]
> On step 9, set **Policy enforcement** to **Disabled**. When you disable this setting, you can audit your environment without making any changes, and you don't block future deployments.

## Tailwind Traders example

To enforce their new policy "Avoid overspending," Tailwind Traders can:

- Define clear spending limits for each individual or team in the organization.

- Create a budget in Microsoft Cost Management to track spending.
- Create alerts for overspending.
- Put aside extra funds for unexpected costs.
- Optimize resource usage.

These exercises help demonstrate a starting point or foundation for governance. In the next unit, you'll build on this foundation to 
