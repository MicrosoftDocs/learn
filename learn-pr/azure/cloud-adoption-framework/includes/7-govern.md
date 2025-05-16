You can use the [Govern methodology](/azure/cloud-adoption-framework/govern/) to help maintain consistent control of your environment and address tangible risks. The Govern methodology provides a structured approach that you can use to establish and optimize governance in Azure. The Govern methodology consists of five steps.

:::image type="content" source="../media/govern.svg" alt-text="Diagram that shows the steps of the Govern methodology." border="false":::

## Build a team

Select a [small, diverse team](/azure/cloud-adoption-framework/govern/build-cloud-governance-team) to encourage quick decision-making and include various perspectives. Define the [functions](/azure/cloud-adoption-framework/govern/build-cloud-governance-team#define-the-functions-of-the-cloud-governance-team), [authority](/azure/cloud-adoption-framework/govern/build-cloud-governance-team#define-the-authority-of-the-cloud-governance-team), and [scope](/azure/cloud-adoption-framework/govern/build-cloud-governance-team#define-the-scope-of-the-cloud-governance-team) of your team. Ensure that your organization supports your cloud governance team so that you can enforce important security policies. 

## Assess cloud risks

Before you create new policies or update existing policies, you need to [assess cloud risks](/azure/cloud-adoption-framework/govern/assess-cloud-risks) to help define the new or updated policy. To effectively assess risks in the cloud:

- **Identify risks** and catalog them. Use Azure tools to list cloud assets and discover cloud risks.

- **Analyze risks** and assign a qualitative or quantitative value to each risk. Prioritize the risks by severity.

- **Determine the impact of a risk**, for example downtime or cost.

- **Document risks**, and inform all necessary parties in your organization about the risks.

- **Review risks** regularly and in response to events to ensure that they remain valid and accurate.

## Document policies

After you identify business risks that are associated with the cloud, you must [document or update policies](/azure/cloud-adoption-framework/govern/document-cloud-governance-policies) to mitigate the risks. Healthy cloud governance strategy begins with sound cloud governance policy.

Cloud governance policies establish the requirements, standards, and goals that your IT staff and automated systems must align with. Individual policy statements are guidelines that you can use to address specific risks that you identify during your risk analysis. Define an approach to document your policies, including how to create, maintain, and update rules that govern the use of your cloud services. Add policies to a centralized repository to inform everyone who needs to adhere to the policies.

## Enforce policies

To [enforce cloud governance](/azure/cloud-adoption-framework/govern/enforce-cloud-governance-policies), incorporate controls and procedures to align cloud use to your cloud governance policies. Use cloud governance tools to automate compliance on a small set of policies and then add more policies over time. To ensure a smooth transition to enforcement, do the following tasks:

- Delegate governance responsibilities.
- Adopt an inheritance model for policies.
- Apply tagging and naming conventions to the resources in the inheritance model.
- Implement a monitor-first approach.

## Monitor cloud governance

After you establish your policies and align your organization's processes and procedures to the policies, you must [monitor your cloud governance](/azure/cloud-adoption-framework/govern/monitor-cloud-governance). Use monitoring to determine areas that lack compliance and make changes to reduce noncompliance problems.

Configure alerts to notify teams or individuals about deviations from your governance policies. Define clear thresholds that trigger the alerts to the appropriate people. Develop a remediation plan to quickly address violations, and prioritize high-risk problems. To prevent future occurrences, update your governance policies and enforcement mechanisms. 