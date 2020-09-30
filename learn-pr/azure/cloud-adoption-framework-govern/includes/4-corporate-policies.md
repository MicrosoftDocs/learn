Poor governance policies create unneccessary constraints & may not actually protect the company. In this module, we'll evaluate ways to create proper, actionable corporate policies.

## Example: Improper corporate policy

What's wrong with Tailwind Traders' existing policy from the customer narrative?

**"customer and financial data can only be hosted in a specific network segment of the existing data centers, referred to as protected assets."**

Corporate policies are designed to instruct teams on the best way to address tangible risks that aren't deemed tolerable by the organization. They are not designed to require a specific technical implementation.

## Evaluate existing corporate policy

When evaluating existing policies for application to the cloud (or any other new technology), you should be able to easily answer the following questions:

- What risk does this policy attempt to mitigate?
- Why is that risk not within organizational risk tolerance?
- Who determined that the risk is not tolerable?
- When should this policy be applied (workload classification, situational, etc...)? When should exceptions be reviewed?
- How is this process enforced? How often should the policy be reviewed for applicability?
- For technology focused processes: Does this policy add risk by creating a dependency on a specific technology solution or technology vendor?

The Tailwind Trader policy on protected data fails to answer any of these questions. Some of them may be addressed elsewhere in policy handbooks, so we should give them some grace. But, the final technology focused question is an undeniable miss. Instead of mitigating risk, it actually introduced long term risks by locking in a single solution.

## Define corporate policy

Defining corporate policy focuses on identifying and mitigating business risks regardless of the cloud platform. Healthy cloud governance strategy begins with sound corporate policy. The following three-step process guides the iterative development of such policies.

|  |  |
|--|--|
| <br> :::image type="content" source="../media/business-risk.png" alt-text="Business risk icon" border="false"::: | <br> [Business risk](https://docs.microsoft.com/azure/cloud-adoption-framework/govern/policy-compliance/business-risk.md): Investigate current cloud adoption plans and data classification to identify risks to the business. Work with the business to balance risk tolerance and mitigation costs. |
| <br> :::image type="content" source="../media/corporate-policy.png" alt-text="Policy and compliance" border="false"::: | <br> [Policy and compliance](https://docs.microsoft.com/azure/cloud-adoption-framework/govern/policy-compliance/policy-definition.md): Evaluate risk tolerance to inform minimally invasive policies that govern cloud adoption and manage risks. In some industries, third-party compliance affects initial policy creation. |
| <br> :::image type="content" source="../media/enforcement.png" alt-text="Processes" border="false"::: | <br> [Processes](https://docs.microsoft.com/azure/cloud-adoption-framework/govern/policy-compliance/processes.md): The pace of adoption and innovation activities will naturally create policy violations. Executing relevant processes will aid in monitoring and enforcing adherence to policies. |

## Business risk

During cloud adoption, you will encounter a number of risks. The following are a few examples of those risks may evolve during different points of your adoption effort.

- During early experimentation, a few assets are deployed with little to no relevant data. The risk is small.
- When the first workload is deployed, risk goes up a little. This risk is easily remediated by choosing an inherently low risk application with a small user base.
- As more workloads come online, risks change at each release. New applications go live and risks change.
- When a company brings the first 10 or 20 applications online, the risk profile is much different than when the 1000th application goes into production in the cloud.

Risk is relative. A small company with a few IT assets, in a closed building has little risk. Add users and an internet connection with access to those assets, the risk is intensified. When that small company grows to Fortune 500 status, the risks are exponentially greater. As revenue, business process, employee counts, and IT assets accumulate, risks increase and coalesce. IT assets that aid in generating revenue are at tangible risk of stopping that revenue stream in the event of an outage. Every moment of downtime equates to losses. Likewise, as data accumulates, the risk of harming customers grows.

The customer narrative unit outlined the risks that the CIO is most concerned with for Tailwind Traders:

- Risk of overspending in the cloud
- Risk of not meeting security or compliance requirements
- Risk of asset configuration creating operations management issues or oversights
- Risk of improper access compromising systems or data
- Risk of inconsistent governance due to immature processes and lack of skills on the team

Deeper investigation of the stakeholder concerns and the cloud adoption plan will likely expose additional risks that can't be tolerated by the organization. 

## Policy and compliance

Corporate policies establish the requirements, standards, and goals that your IT staff and automated systems will need to support. Individual policy statements are guidelines for addressing specific risks identified during your risk assessment process. Below are a few examples of proper corporate policies to guide adoption in public and private cloud deployments, avoiding vendor lock-in:

- **Overspend:** There is a risk of overspending, especially for self-service deployments. Any deployment must be allocated to a billing unit with approved budget and a mechanism for budgetary limits.
    - **Design consideration:** In Azure, budget can be controlled with [Azure Cost Management](/azure/cost-management/manage-budgets). [Azure Advisor](/azure/advisor/advisor-cost-recommendations) can provide optimization recommendations to reduce spending per asset.
- **Securing sensitive data:** Assets that interact with sensitive data may not receive sufficient protections, leading to potential data leaks or business disruptions. All assets that interact with sensitive data must be identified and reviewed by the security team to ensure proper levels of protection.
    - **Design consideration:** In Azure, all deployed assets must be tagged with proper data classification levels. Classifications must be reviewed by the cloud governance team and the application owner before deployment to the cloud.

## Process

The cloud provides guardrails that can reduce the human overhead of recurring processes by providing validation triggers based on implementation configuration. The following are a few examples of triggers and actions for each discipline:

<!-- docsTest:ignore "Cost Management" "Deployment Acceleration" "Identity Baseline" "Resource Consistency" "Security Baseline" -->

| Cloud governance discipline | Sample trigger | Sample action |
|-----------------------------|----------------|---------------|
| Cost Management | Monthly cloud spending is more than 20% higher than expected. | Notify the billing unit leader who will begin a review of resource usage. |
| Security Baseline | Detect suspicious user activity. | Notify the IT security team and disable the suspect user account. |
| Resource Consistency | CPU utilization for a workload is greater than 90%. | Notify the IT operations team and scale out additional resources to handle the load. |

After establishing your cloud policy statements and drafting a design guide, you'll need to create a strategy for ensuring your cloud deployment stays in compliance with your policy requirements. This strategy will need to encompass your cloud governance team's ongoing review and communication processes, establish criteria for when policy violations require action, and defining the requirements for automated monitoring and compliance systems that will detect violations and trigger remediation actions.

