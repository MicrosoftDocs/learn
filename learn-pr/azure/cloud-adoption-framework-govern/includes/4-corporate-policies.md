*Governance* is a large subject, and it might be intimidating at first. Governance seeks to establish the proper scope of corporate actions by mitigating tangible risks through corporate policy.

Poor governance policies create unnecessary constraints, and they might not protect the company. This unit evaluates ways to create proper, actionable corporate policies.

## Tailwind Traders' improper corporate policy

What's wrong with Tailwind Traders' existing policy?

Tailwind Traders' policy: *Customer and financial data can only be hosted in a specific network segment of the existing datacenters, referred to as protected assets.*

Corporate policies are designed to instruct teams on the best way to address tangible risks that the organization deems intolerable. Corporate policies aren't designed to require a specific technical implementation.

## Evaluate existing corporate policy

When you evaluate existing corporate policies to apply them to the cloud or to any other new technology, you should be able to answer the following questions:

- What risk does this policy attempt to mitigate?

- Why is that risk not within your organizational risk tolerance?
- Who determined that the risk is intolerable?
- When should you apply this policy (workload classification or situational)? When should you review exceptions?
- How do you enforce this process? How often should you review the policy for applicability?
- For technology-focused processes, does this policy create a dependency on a specific technology solution or technology vendor and add risk to your organization?

In the next unit, you learn that the Tailwind Traders' policy on protected data fails to answer these questions. Other sources, such as policy handbooks, might address some of these questions. But Tailwind Traders doesn't have an answer for the final technology-focused question. The existing policy doesn't mitigate risks. It actually introduces long-term risks because it confines Tailwind Traders to a single solution.

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

## Assess cloud risks

During cloud adoption, you encounter various risks. Here are some examples of risks that might evolve at various points of your adoption effort:

- During early experimentation, you deploy a few assets that have little to no relevant data. The risk is small.

- When you deploy your first workload, risk slightly increases. You can choose an inherently low-risk application that has a small user base to remediate this risk.
- When more workloads go online, risks change at each release. New applications go live and risks change.
- When your company brings the first 10 or 20 applications online, the risk is lower than when the thousandth application goes into production in the cloud.

To effectively assess risks in the cloud:

- **Identify risks** and catalog them. Use Azure tools to list cloud assets and discover cloud risks.

- **Analyze risks** and assign a qualitative or quantitative value to each risk. Prioritize the risks by severity.
- **Determine the impact of a risk**, for example downtime or cost.
- **Document risks**, and inform all necessary parties in your organization about the risks.
- **Review risks** regularly and in response to events to ensure that they remain valid and accurate.

If Tailwind Traders had assessed their risks before they moved resources to the cloud, they might have avoided their blockage due to an improper policy.

## Example risks and high-risk areas

You must determine which risks are a top priority. Consider the following areas where risks often occur:

| &nbsp; | &nbsp; |
|--|--|
| <br> :::image type="content" source="../media/cost-management-icon.png" alt-text="Cost management icon." border="false"::: | <br> **Cost management**: Cost is a primary concern for cloud users. Develop policies for cost control for all cloud platforms. |
| <br> :::image type="content" source="../media/security-baseline-icon.png" alt-text="Security baseline icon." border="false"::: | <br> **Security**: Security is a complex subject that's unique to each company. After you establish security requirements, use cloud governance policies and enforcement to apply those requirements across network, data, and asset configurations.|
| <br> :::image type="content" source="../media/identity-baseline-icon.png" alt-text="Identity baseline icon." border="false"::: | <br> **Identity**: Ensure that you consistently apply identity requirements across cloud adoption efforts to mitigate the risk of breach. |
| <br> :::image type="content" source="../media/resource-consistency-icon.png" alt-text="Resource consistency icon." border="false"::: | <br> **Resource consistency**: Cloud operations depend on consistent resource configuration. Through governance tooling, you can consistently configure resources to manage risks that are related to onboarding, drift, discoverability, and recovery. |
| <br> :::image type="content" source="../media/deployment-acceleration-icon.png" alt-text="Deployment acceleration icon." border="false"::: | <br> **Deployment acceleration**: Create centralized, standardized, and consistent deployment and configuration approaches to improve governance practices. Use cloud-based governance tooling to accelerate deployment activities. |

Risk is relative. A small company with a few IT assets in a building that's offline has low risk. If they add users and an internet connection with access to those assets, the risk intensifies. When that small company grows to Fortune 500 status, the risks are exponentially greater. As revenue, business processes, employee counts, and IT assets accumulate, risks increase and coalesce. IT assets help generate revenue. An outage might stop that revenue stream. Every moment of downtime equates to loss. As data accumulates, the risk for customers also grows.

According to the Tailwind Traders customer narrative, the top risks that concern the Tailwind CIO include:

- Overspending in the cloud

- Not meeting organizational security or compliance requirements
- Asset configuration that creates operations-management problems or oversights
- Unauthorized access that compromises systems or data
- Immature processes or lack of team skills, which creates inconsistent governance

Note that none of the concerns are related to "a specific network segment of the existing datacenters," as cited in Tailwind's current policy. To create sound governance policies that scale to the cloud, we need to dig a bit deeper. Let's look at the tangible risks that are captured in the current policy versus the current-state solution.

It's likely that deeper investigation of stakeholder concerns and the cloud adoption plan shows more risks that the organization can't tolerate. But for now, we have enough to start shaping governance policies that address these tangible risks.

## Document cloud governance policies

Corporate policies establish the requirements, standards, and goals that your IT staff and automated systems must align with. Individual policy statements are guidelines that you can use to address specific risks that you identify during your risk assessment process. The following examples describe proper corporate policies that guide adoption in public and private cloud deployments. These policies also avoid restricting resources to a specific vendor.

- **Avoid overspending**: Cloud deployments have a risk of overspending, especially for self-service deployments. The organization must allocate deployments to a billing unit with an approved budget and with a mechanism to apply budgetary limits.

  *Design consideration:* In Azure, the organization can control budget with [Microsoft Cost Management](/azure/cost-management-billing/). And [Azure Advisor](/azure/advisor/advisor-cost-recommendations) can provide optimization recommendations to reduce spending for each asset.

- **Secure sensitive data**: Assets that interact with sensitive data might not receive sufficient protections, which leads to potential data leaks or business disruptions. The security team must identify and review all assets that interact with sensitive data to ensure that proper levels of protection are in place.

  *Design consideration*: In Azure, the organization must tag all deployed assets with proper data classification levels. The cloud governance team and the application owner must review the classifications before deployment to the cloud.

## Enforce cloud governance policies

The cloud provides guardrails to help reduce the human overhead of recurring processes by providing validation triggers based on implementation configuration. The following table outlines a few triggers and actions that can address the risks that concern the Tailwind Traders CIO:

| Risk | Sample trigger | Sample action |
|-----------------------------|----------------|---------------|
| Overspending in the cloud | Monthly cloud spending is 20 percent higher than expected. | Notify the billing unit leader, to start reviewing resource usage. |
| Overspending in the cloud | Deployed assets aren't using the allocated CPU or memory. | Notify the billing unit leader and automatically resize to fit actual usage, when possible. |
| The organization not meeting security or compliance requirements | Detect any deviation from defined security or compliance. | Notify the IT security team and automate remediation, when possible. |
| Asset configurations creating operations management issues or oversights | CPU utilization for a workload is greater than 90 percent. | Notify the IT operations team and scale out more resources to handle the load. |
| Asset configurations creating operations management issues or oversights | Assets that fail to meet patching or business continuity and disaster requirements trigger operational compliance warning. | Notify the IT security team and automatically resolve the deviation, when possible. |
| Unauthorized access compromising systems or data | Traffic patterns deviate from approved network topologies. | Notify the IT security team and automatically close attack vectors, when possible.|
| Unauthorized access compromising systems or data | Assets are configured without proper role assignments or elevated privileges. | Notify the IT security team and automatically resolve the deviation, when possible. |
| Inconsistent governance due to immature processes and lack of skills on the team | Assets identified that aren't included in required governance processes. | Notify the IT governance team and automatically resolve the deviation, when possible. |

You can automate each of these triggers and actions by using Azure governance tools. Other cloud providers might require a more manual approach, but the defined policies would still be applicable. Take care to avoid defining policies that would lock you into using a specific vendor to avoid having to repeat this process again in the future.

After establishing your cloud policy statements and drafting a design guide, you need to create a strategy to ensure that your cloud deployment stays in compliance with your policy requirements. This strategy must encompass your cloud-governance team's ongoing review and communication processes. This strategy must encompass your cloud-governance team's ongoing review and communication processes and establish criteria for when policy violations require action. It must also define the requirements for automated monitoring and compliance systems that detect violations and trigger remediation actions.

In the next unit, we'll group these types of risks into actionable cloud disciplines.

