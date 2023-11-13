Poor governance policies create unnecessary constraints, and they might not protect the company. This unit evaluates ways to create proper, actionable corporate policies.

## Tailwind Traders' improper corporate policy

What's wrong with Tailwind Traders' existing policy, from the customer narrative?

Tailwind policy: *Customer and financial data can only be hosted in a specific network segment of the existing datacenters, referred to as protected assets.*

Corporate policies are designed to instruct teams on the best way to address tangible risks that the organization deems not tolerable. Corporate policies aren't designed to require a specific technical implementation.

## Evaluate existing corporate policy

When you evaluate existing corporate policies to apply them to the cloud or to any other new technology, you should be able to answer the following questions:

- What risk does this policy attempt to mitigate?
- Why is that risk not within organizational risk tolerance?
- Who determined that the risk isn't tolerable?
- When should this policy be applied (workload classification, situational, and so on)? When should exceptions be reviewed?
- How is this process enforced? How often should the policy be reviewed for applicability?
- For technology-focused processes, does this policy add risk by creating a dependency on a specific technology solution or technology vendor?

As you'll learn in the next unit, the Tailwind Traders policy on protected data fails to answer these questions. Some of them might be addressed elsewhere, like in policy handbooks, but the final technology-focused question is an undeniable miss. Instead of mitigating risk, it actually introduces long-term risks by locking in a single solution.

## Define corporate policy

Defining corporate policy requires a focus on identifying and mitigating business risks, regardless of the cloud platform the organization uses. Healthy cloud-governance strategy begins with sound corporate policy. The following three-step process guides the iterative development of sound corporate policies:

| &nbsp; | &nbsp;  |
|--|--|
| <br> :::image type="content" source="../media/business-risk.png" alt-text="Business risk icon." border="false"::: | <br> [Business risk](/azure/cloud-adoption-framework/govern/policy-compliance/business-risk?azure-portal=true): Investigate current cloud adoption plans and data classification to identify risks to the business. Work with the business to balance risk tolerance and mitigation costs. |
| <br> :::image type="content" source="../media/corporate-policy.png" alt-text="Policy and compliance icon." border="false"::: | <br> [Policy and compliance](/azure/cloud-adoption-framework/govern/policy-compliance/policy-definition?policy-definition=true): Evaluate risk tolerance to inform policies that govern cloud adoption and manage risks. In some industries, third-party compliance affects initial policy creation. |
| <br> :::image type="content" source="../media/enforcement.png" alt-text="Process enforcement icon." border="false"::: | <br> [Processes](/azure/cloud-adoption-framework/govern/policy-compliance/processes?Azure-portal=true): The pace of adoption and innovation activities are naturally going to create policy violations. Executing relevant processes helps to monitor and enforce adherence to policies. |

## Business risk

During cloud adoption, you encounter various risks. Here are some examples of risks that might evolve at different points of your adoption effort:

- During early experimentation, a few assets with little to no relevant data are deployed. The risk is small.
- When the first workload is deployed, risk increases a little. This risk is easily remediated by choosing an inherently low-risk application that has a small user base.
- As more workloads come online, risks change at each release. New applications go live, and risks change.
- When a company brings the first 10 or 20 applications online, the risk profile is much different than when the thousandth application goes into production in the cloud.

Risk is relative. A small company with a few IT assets in a building that's offline has little risk. Add users and an internet connection with access to those assets, and the risk intensifies. When that small company grows to Fortune 500 status, the risks are exponentially greater. As revenue, business processes, employee counts, and IT assets accumulate, risks increase and coalesce. IT assets that help generate revenue are at tangible risk of stopping that revenue stream if an outage occurs. Every moment of downtime equates to loss. Likewise, as data accumulates, the risk of harm to customers grows.

According to the outline from the Tailwind Traders customer narrative unit, here are the risks the Tailwind CIO is most concerned about:

- Overspending in the cloud
- The organization not meeting security or compliance requirements
- Asset configuration creating operations-management issues or oversights
- Unauthorized access compromising systems or data
- Inconsistent governance due to immature processes and lack of skills on the team

It's important to note that none of the concerns are related to "a specific network segment of the existing datacenters," as cited in Tailwind's current policy. To create sound governance policies that scale to the cloud, we need to dig a bit deeper. Let's look at the tangible risks that are captured in the current policy versus the current-state solution.

It's likely that deeper investigation of stakeholder concerns and the cloud-adoption plan shows more risks that the organization can't tolerate. But for now, we have enough to start shaping governance policies that address these tangible risks.

## Policy and compliance

Corporate policies establish the requirements, standards, and goals that your IT staff and automated systems need to support. Individual policy statements are guidelines for addressing specific risks that are identified during your risk assessment process. Here are a few examples of proper corporate policies that guide adoption in public and private cloud deployments, and which avoid locking in a specific vendor:

- **Avoid overspending**: Cloud deployments involve a risk for overspending, especially for self-service deployments. Any deployment must be allocated to a billing unit, with an approved budget and with a mechanism for applying budgetary limits.

  *Design consideration:* In Azure, you can control budget with [Microsoft Cost Management](/azure/cost-management-billing/). While [Azure Advisor](/azure/advisor/advisor-cost-recommendations?azure-portal=true) can provide optimization recommendations to reduce spending per asset.

- **Secure sensitive data**: Assets that interact with sensitive data might not receive sufficient protections, leading to potential data leaks or business disruptions. The security team must identify and review all assets that interact with sensitive data, to ensure that proper levels of protection are in place.

  *Design consideration*: In Azure, all deployed assets must be tagged with proper data-classification levels. The cloud governance team and the application owner must review the classifications before deployment to the cloud.

## Process

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
