Before you create new policies or update existing policies, you need to assess cloud risks to help define the new or updated policy. To effectively assess risks in the cloud:

- **Identify risks** and catalog them. Use Azure tools to list cloud assets and discover cloud risks.

- **Analyze risks** and assign a qualitative or quantitative value to each risk. Prioritize the risks by severity.
- **Determine the impact of a risk**, for example downtime or cost.
- **Document risks**, and inform all necessary parties in your organization about the risks.
- **Review risks** regularly and in response to events to ensure that they remain valid and accurate.

## Example risks and high-risk areas

Risk often increases as your workload expands. Consider the following examples of risk levels at various points of your adoption effort:

- During early experimentation, you deploy a few assets that have little to no relevant data. The risk is small.

- When you deploy your first workload, risk slightly increases. To remediate this risk, you can choose an inherently low-risk application that has a small user base.
- When more workloads go online, risks change at each release. New applications go live, and risks might increase.
- When your company brings the first 10 or 20 applications online, the risk is lower than when the thousandth application goes into production in the cloud.

During your cloud risk assessment, you must determine which risks are a top priority. Consider the following areas in which risks occur most often.

| &nbsp; | &nbsp; |
|--|--|
|**AI**| Consider risks that are associated with use, access, and output of AI systems. Regularly [test AI systems](/azure/ai-services/openai/concepts/red-teaming), and incorporate [automated risk identification tools](https://github.com/Azure/PyRIT#python-risk-identification-tool-for-generative-ai-pyrit) for AI.|
| **Cost management** | Cost is a primary concern for cloud users. Develop policies for cost control for all cloud platforms. |
|**Data**|Data management is important for [mitigating security risks](/azure/defender-for-cloud/data-security-review-risks). Ensure that you properly encrypt your data and use Azure tools to manage data lifecycle policies.
| **Operations** | A centralized, standardized, and consistent deployment and configuration approach improves governance practices. Use cloud-based governance tooling to perform operations. |
|**Regulatory compliance**| Know the [regulatory requirements](/azure/compliance/) of your industry so that you can identify and resolve noncompliance that affects your cloud data and operations.|
| **Resource management** | Cloud operations depend on consistent resource configuration. Through governance tooling, you can consistently configure resources to manage risks that are related to onboarding, drift, discoverability, and recovery. |
| **Security** | Security is a complex subject that's unique to each company. After you establish security requirements, use cloud governance policies and enforcement to apply those requirements across network, data, and asset configurations.|

Risk is relative. A small company with a few IT assets in a building that's offline has low risk. If the company adds users and an internet connection with access to those assets, the risk intensifies. If that small company grows to Fortune 500 status, the risks are exponentially greater. Risks increase and coalesce as revenue, business processes, employee counts, and IT assets accumulate. IT assets help generate revenue. An outage might stop that revenue stream. Every moment of downtime results in loss. As data accumulates, the risk for customers also grows.

## Tailwind Traders' risks

According to the Tailwind Traders customer narrative, the top risks that concern the Tailwind CIO include:

- Overspending in the cloud

- Not meeting organizational security or compliance requirements
- Asset configuration that creates operations management problems or oversights
- Unauthorized access that compromises systems or data
- Immature processes or lack of team skills, which creates inconsistent governance

The cloud governance team must create cloud governance policies to address these risks in collaboration with the people that the policies affect.

