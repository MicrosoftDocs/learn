Poor governance policies create unnecessary constraints and may not protect the company. In this module, we'll evaluate ways to create proper, actionable corporate policies.

## Example: Improper corporate policy

What's wrong with Tailwind Traders' existing policy from the customer narrative?

**"Customer and financial data can only be hosted in a specific network segment of the existing datacenters, referred to as protected assets."**

Corporate policies are designed to instruct teams on the best way to address tangible risks that aren't deemed tolerable by the organization. They are not designed to require a specific technical implementation.

## Evaluate existing corporate policy

When evaluating existing policies for application to the cloud or any other new technology, you should be able to answer the following questions:

- What risk does this policy attempt to mitigate?
- Why is that risk not within organizational risk tolerance?
- Who determined that the risk isn't tolerable?
- When should this policy be applied (workload classification, situational, etc.)? When should exceptions be reviewed?
- How is this process enforced? How often should the policy be reviewed for applicability?
- For technology focused processes: Does this policy add risk by creating a dependency on a specific technology solution or technology vendor?

The Tailwind Traders policy on protected data fails to answer these questions. Some of them may be addressed elsewhere in policy handbooks, so we should give them some grace. But, the final technology-focused question is an undeniable miss. Instead of mitigating risk, it actually introduced long-term risks by locking in a single solution.

## Define corporate policy

Defining corporate policy focuses on identifying and mitigating business risks regardless of the cloud platform. Healthy cloud governance strategy begins with sound corporate policy. The following three-step process guides the iterative development of such policies.

|  |  |
|--|--|
| <br> :::image type="content" source="../media/business-risk.png" alt-text="Business risk icon." border="false"::: | <br> [Business risk](https://docs.microsoft.com/azure/cloud-adoption-framework/govern/policy-compliance/business-risk?azure-portal=true): Investigate current cloud adoption plans and data classification to identify risks to the business. Work with the business to balance risk tolerance and mitigation costs. |
| <br> :::image type="content" source="../media/corporate-policy.png" alt-text="Policy and compliance icon." border="false"::: | <br> [Policy and compliance](https://docs.microsoft.com/azure/cloud-adoption-framework/govern/policy-compliance/policy-definition?policy-definition=true): Evaluate risk tolerance to inform minimally invasive policies that govern cloud adoption and manage risks. In some industries, third-party compliance affects initial policy creation. |
| <br> :::image type="content" source="../media/enforcement.png" alt-text="Process enforcement icon." border="false"::: | <br> [Processes](https://docs.microsoft.com/azure/cloud-adoption-framework/govern/policy-compliance/processes?Azure-portal=true): The pace of adoption and innovation activities will naturally create policy violations. Executing relevant processes will help to monitor and enforce adherence to policies. |

## Business risk

During cloud adoption, you will encounter a number of risks. The following are a few examples of those risks may evolve during different points of your adoption effort.

- During early experimentation, a few assets are deployed with little to no relevant data. The risk is small.
- When the first workload is deployed, risk goes up a little. This risk is easily remediated by choosing an inherently low-risk application with a small user base.
- As more workloads come online, risks change at each release. New applications go live and risks change.
- When a company brings the first 10 or 20 applications online, the risk profile is much different than when the thousandth application goes into production in the cloud.

Risk is relative. A small company in a closed building with a few IT assets has little risk. Add users and an internet connection with access to those assets, and the risk intensifies. When that small company grows to Fortune 500 status, the risks are exponentially greater. As revenue, business process, employee counts, and IT assets accumulate, risks increase and coalesce. IT assets that help to generate revenue are at tangible risk of stopping that revenue stream in the event of an outage. Every moment of downtime equates to losses. Likewise, as data accumulates, the risk of harming customers grows.

According to the outline from the Tailwind Traders customer narrative unit, the risks with which the Chief Information Officer (CIO) is most concerned are:

- Overspending in the cloud.
- The organization not meeting security or compliance requirements.
- Asset configuration creating operations management issues or oversights.
- Unauthorized access compromising systems or data.
- Inconsistent governance due to immature processes and lack of skills on the team.

It's important to note, that none of the actual concerns are related to, "a specific network segment of the existing data centers," cited in their current policy. To create sound governance policies that will scale into the cloud, we need to dig a bit deeper and look at the tangible risks captured in the current policy versus the current-state solution.

Deeper investigation of the stakeholder concerns and the cloud adoption plan will likely expose additional risks that can't be tolerated by the organization. But for now, we have enough to start shaping governance policies that address these tangible risks.

## Policy and compliance

Corporate policies establish the requirements, standards, and goals that your IT staff and automated systems will need to support. Individual policy statements are guidelines for addressing specific risks identified during your risk assessment process. Below are a few examples of proper corporate policies to guide adoption in public and private cloud deployments, avoiding vendor lock-in:

- **Overspend:** There is a risk of overspending, especially for self-service deployments. Any deployment must be allocated to a billing unit with approved budget and a mechanism for budgetary limits.
    - **Design consideration:** In Azure, budget can be controlled with [Azure Cost Management](https://docs.microsoft.com/azure/cost-management-billing/). [Azure Advisor](https://docs.microsoft.com/azure/advisor/advisor-cost-recommendations?azure-portal=true) can provide optimization recommendations to reduce spending per asset.
- **Securing sensitive data:** Assets that interact with sensitive data may not receive sufficient protections, leading to potential data leaks or business disruptions. All assets that interact with sensitive data must be identified and reviewed by the security team to ensure proper levels of protection.
    - **Design consideration:** In Azure, all deployed assets must be tagged with proper data classification levels. Classifications must be reviewed by the cloud governance team and the application owner before deployment to the cloud.

## Process

The cloud provides guardrails that can reduce the human overhead of recurring processes by providing validation triggers based on implementation configuration. The following tables outlines a few triggers and actions that can address the risks with which Tailwind Traders' CIO is concerned:

| Risk | Sample trigger | Sample action |
|-----------------------------|----------------|---------------|
| Overspending in the cloud | Monthly cloud spending is 20 percent higher than expected. | Notify the billing unit leader, who will start reviewing resource usage. |
| Overspending in the cloud | Deployed assets aren't using the allocated CPU or memory. | Notify the billing unit leader and automatically resize to fit actual usage, when possible. |
| The organization not meeting security or compliance requirements | Detect any deviation from defined security or compliance. | Notify the IT security team and automate remediation, when possible. |
| Asset configurations creating operations management issues or oversights | CPU utilization for a workload is greater than 90 percent. | Notify the IT operations team and scale out additional resources to handle the load. |
| Asset configurations creating operations management issues or oversights | Assets that fail to meet patching or business continuity and disaster requirements trigger operational compliance warning. | Notify the IT security team and automatically resolve the deviation, when possible. |
| Unauthorized access compromising systems or data | Traffic patterns deviate from approved network topologies. | Notify the IT security team and automatically close attack vectors, when possible. |
| Unauthorized access compromising systems or data | Assets are configured without proper role assignments or elevated privileges. | Notify the IT security team and automatically resolve the deviation, when possible. |
| Inconsistent governance due to immature processes and lack of skills on the team | Assets identified that aren't included in required governance processes | Notify the IT governance team and automatically resolve the deviation, when possible. |

Each of the above triggers and actions can be automated using Azure governance tools. Other cloud providers may require a more manual approach, but the defined policies would still be applicable. Take care to avoid defining policies that would create lock-in with a specific vendor to avoid having to repeat this process again in the future.

After establishing your cloud policy statements and drafting a design guide, you'll need to create a strategy for ensuring your cloud deployment stays in compliance with your policy requirements. This strategy will need to encompass your cloud governance team's ongoing review and communication processes, establish criteria for when policy violations require action, and defining the requirements for automated monitoring and compliance systems that will detect violations and trigger remediation actions.

In the next unit, we'll group these types of risks into actionable cloud disciplines.
