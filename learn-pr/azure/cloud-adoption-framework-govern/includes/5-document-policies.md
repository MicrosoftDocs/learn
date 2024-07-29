After you identify business risks that are associated with the cloud, you must document or update policies to mitigate the risks. Healthy cloud governance strategy begins with sound cloud governance policy. 

Cloud governance policies establish the requirements, standards, and goals that your IT staff and automated systems must align with. Individual policy statements are guidelines that you can use to address specific risks that you identify during your risk analysis.

The following examples describe proper cloud governance policies that help guide adoption in public and private cloud deployments.

- **Policy**: *Workload teams must set budgets alerts at the resource group level.* Cloud deployments have a risk of overspending, especially for self-service deployments. An organization must allocate deployments to a billing unit with an approved budget and with a mechanism to apply budgetary limits.

  **Design consideration:** In Azure, an organization can control budget with [Microsoft Cost Management](/azure/cost-management-billing/). And [Azure Advisor](/azure/advisor/advisor-cost-recommendations) can provide optimization recommendations to reduce spending for each asset.

- **Policy**: *Microsoft Purview must be used to monitor sensitive data.* An organization must identify, classify, protect, and govern sensitive information.

  **Design consideration:** In Azure, an organization must tag all deployed assets with proper data classification levels. A cloud governance team and application owner must review the classifications before deployment to the cloud.

## How to document cloud governance policies

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
