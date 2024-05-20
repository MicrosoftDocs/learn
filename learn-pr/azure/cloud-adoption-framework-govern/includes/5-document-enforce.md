## Incorporate cloud governance policies

When you define corporate policy, you must identify and mitigate business risks, regardless of the cloud platform that your organization uses. Healthy cloud governance strategy begins with sound corporate policy. The following four-step process describes the iterative development of sound corporate policies:

| &nbsp; | &nbsp;  |
|--|--|
| <br> :::image type="content" source="../media/business-risk.png" alt-text="Business risk icon." border="false"::: | <br> **Assess cloud risks**: Identify and catalog a comprehensive list of cloud risks. Analyze those risks to prioritize them by severity. Document the risks, and ensure that you inform all necessary parties in your organization. |
| <br> :::image type="content" source="../media/corporate-policy.png" alt-text="Policy and compliance icon." border="false"::: | <br> **Document cloud governance policies**: Define and document policies that help mitigate your risks. Grant policy access to everyone who needs to adhere to the policies. |
| <br> :::image type="content" source="../media/enforcement.png" alt-text="Process enforcement icon." border="false"::: | <br> **Enforce cloud governance policies**: Implement controls and procedures to align cloud use to the cloud governance policies. |
| :::image type="icon" source="../media/business-risk.png" alt-text="Monitoring icon."::: |**Monitor cloud governance**: Configure monitoring solutions to track your compliance.|

<update icon>
<For the following sections, update content>

## Document cloud governance policies

Corporate policies establish the requirements, standards, and goals that your IT staff and automated systems must align with. Individual policy statements are guidelines that you can use to address specific risks that you identify during your risk assessment process.

The following examples describe proper corporate policies that help guide adoption in public and private cloud deployments. These policies also avoid restricting resources to a specific vendor.

- **Policy**: *Avoid overspending.* Cloud deployments have a risk of overspending, especially for self-service deployments. The organization must allocate deployments to a billing unit with an approved budget and with a mechanism to apply budgetary limits.

  **Design consideration:** In Azure, the organization can control budget with [Microsoft Cost Management](/azure/cost-management-billing/). And [Azure Advisor](/azure/advisor/advisor-cost-recommendations) can provide optimization recommendations to reduce spending for each asset.

- **Policy:** *Secure sensitive data.* Assets that interact with sensitive data might not receive sufficient protections, which leads to potential data leaks or business disruptions. The security team must identify and review all assets that interact with sensitive data to ensure that proper levels of protection are in place.

  **Design consideration:** In Azure, the organization must tag all deployed assets with proper data classification levels. The cloud governance team and the application owner must review the classifications before deployment to the cloud.

## Enforce cloud governance policies

The cloud provides guardrails to help reduce human overhead due to recurring processes. The cloud can provide validation triggers based on implementation configuration. The following table outlines triggers and actions that can address the risks that concern the Tailwind Traders CIO:

| Risk | Sample trigger | Sample action |
|-----------------------------|----------------|---------------|
| Overspending in the cloud | Monthly cloud spending is 20 percent higher than expected. | Notify the billing unit leader so they can start reviewing resource usage. |
| Overspending in the cloud | Deployed assets don't use the allocated CPU or memory. | Notify the billing unit leader and automatically resize to fit actual usage, when possible. |
| Not meeting organizational security or compliance requirements | Detect deviations from defined security or compliance requirements. | Notify the IT security team and automate remediation, when possible. |
| Asset configurations create operations management problems or oversights | CPU usage for a workload is greater than 90 percent. | Notify the IT operations team and scale out more resources to handle the load. |
| Asset configurations create operations management problems or oversights | Assets that fail to meet patching, business continuity, or disaster recovery requirements trigger an operational compliance warning. | Notify the IT security team and automatically resolve the deviation, when possible. |
| Unauthorized access that comprises systems or data | Traffic patterns deviate from approved network topologies. | Notify the IT security team and automatically close attack vectors, when possible.|
| Unauthorized access that compromises systems or data | Assets are configured without proper role assignments or elevated privileges. | Notify the IT security team and automatically resolve the deviation, when possible. |
| Immature processes or lack of team skills, which creates inconsistent governance | Identified assets aren't included in required governance processes. | Notify the IT governance team and automatically resolve the deviation, when possible. |

You can use Azure governance tools to automate each of these triggers and actions. Other cloud providers might require a more manual approach, but the defined policies are still applicable. Don't define policies that lock you into using a specific vendor so that you don't have to repeat this process in the future.

After you establish your cloud policy statements and draft a design guide, you need to create a strategy to ensure that your cloud deployment remains compliant with your policy requirements. This strategy must encompass your cloud-governance team's ongoing review and communication processes and establish criteria for when policy violations require action. It must also define the requirements for automated monitoring and compliance systems that detect violations and trigger remediation actions.

In the next unit, we'll group these types of risks into actionable cloud disciplines.