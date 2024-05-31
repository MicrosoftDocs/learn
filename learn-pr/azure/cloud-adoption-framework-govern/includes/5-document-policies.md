After you identify business risks, you must incorporate or update policies to mitigate them, regardless of the cloud platform that your organization uses. Healthy cloud governance strategy begins with sound corporate policy. 

Corporate policies establish the requirements, standards, and goals that your IT staff and automated systems must align with. Individual policy statements are guidelines that you can use to address specific risks that you identify during your risk analysis.

The following examples describe proper corporate policies that help guide adoption in public and private cloud deployments. These policies also avoid restricting resources to a specific vendor.

- **Policy**: *Avoid overspending.* Cloud deployments have a risk of overspending, especially for self-service deployments. An organization must allocate deployments to a billing unit with an approved budget and with a mechanism to apply budgetary limits.

  **Design consideration:** In Azure, an organization can control budget with [Microsoft Cost Management](/azure/cost-management-billing/). And [Azure Advisor](/azure/advisor/advisor-cost-recommendations) can provide optimization recommendations to reduce spending for each asset.

- **Policy**: *Secure sensitive data.* Assets that interact with sensitive data might not receive sufficient protections, which leads to potential data leaks or business disruptions. A security team must identify and review all assets that interact with sensitive data to ensure that proper levels of protection are in place.

  **Design consideration:** In Azure, an organization must tag all deployed assets with proper data classification levels. A cloud governance team and application owner must review the classifications before deployment to the cloud.

## Document cloud governance policies

To effectively document your cloud governance policies:

- **Define an approach to document your cloud governance policies**. Establish an approach for creating, maintaining, and updating the rules and guidelines that govern the use of cloud services. 

- **Define your policies**. Include a policy ID, policy statement, risk ID, policy category, policy purpose, policy scope, and the remediation strategies for a policy violation.
- **Distribute your policies**. Use a centralized policy repository, and create compliance checklists to inform everyone who needs to adhere to cloud governance policies.
- **Review your policies**. Schedule regular and event-based reviews, implement feedback mechanisms, facilitate change control, and identify inefficiencies in cloud architecture and operations.

To mitigate the CIO's concerns, Tailwind Traders incorporates new policies including:

- Avoid overspending.

- Fulfill all organizational security and compliance requirements.
- Ensure that systems and data are secure.
- Test and validate processes regularly to ensure that they remain consistent and effective.

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
