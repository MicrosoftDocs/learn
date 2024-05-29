Governance seeks to mitigate tangible risks through corporate policy. The policies establish the proper scope of corporate actions. Poor governance policies can create unnecessary constraints, and they might not provide protection. This unit describes how to create proper, actionable corporate policies.

## Blocked by current policy

Tailwind Traders has policies already in place. A current policy states that "Customer and financial data can only be hosted in a specific network segment of the *existing datacenters*, referred to as protected assets." The policy is problematic, because the business plans to move its on-premises datacenters to the cloud.

Corporate policies are designed to instruct teams on the best way to address tangible risks that the organization deems intolerable. Corporate policies aren't designed to require a specific technical implementation.

The CIO is working to change the policy, but the central operations and infrastructure team must apply the following controls before the CIO is comfortable approving policy changes:

- Control costs to deliver on the promised savings as adoption scales

- Adhere to security and third-party compliance requirements
- Configure asset management to prepare all workloads to be ready for operations management
- Apply and meet identity and access-management requirements
- Follow a path to ensure that all these controls are consistently applied to all workloads while acknowledging the scale and learning curve challenges across the technology teams

To give the CIO confidence that the team is ready to migrate more complex, higher-risk workloads to the cloud. They must demonstrate that these controls are in place. It also provides the required governance balance.

Unfortunately, the governance requirement for the "existing datacenters" was discovered only as the team prepared to deploy its first mission-critical workload to production. The policy has frozen the effort to migrate the company's current datacenters. More foresight would have helped the team address this policy sooner as they moved lower-risk workloads to production.

Currently, the governance policy hasn't affected the retail innovation team, and it has been delivering new innovations in the cloud faster than expected. However, the same challenges can block the following teams and efforts:

- The application development teams are working in a dev/test capacity to learn about cloud-native capabilities.

- The business intelligence team is experimenting with big data in the cloud and curing data on new platforms.

The remaining units in this module demonstrate the Govern methodology's approach to meeting Tailwind Traders' governance needs, preferably in parallel to cloud-adoption efforts to avoid unexpected project interruptions.

## Assess cloud risks

Before you create new policies or update existing policies, you need to assess cloud risks to help define the new or updated policy. To effectively assess risks in the cloud:

- **Identify risks** and catalog them. Use Azure tools to list cloud assets and discover cloud risks.

- **Analyze risks** and assign a qualitative or quantitative value to each risk. Prioritize the risks by severity.
- **Determine the impact of a risk**, for example downtime or cost.
- **Document risks**, and inform all necessary parties in your organization about the risks.
- **Review risks** regularly and in response to events to ensure that they remain valid and accurate.

## Example risks and high-risk areas

During cloud adoption, you encounter various risks. As your workload gets larger, risk often increases. Consider the following examples of risk levels at various points of your adoption effort:

- During early experimentation, you deploy a few assets that have little to no relevant data. The risk is small.

- When you deploy your first workload, risk slightly increases. You can choose an inherently low-risk application that has a small user base to remediate this risk.
- When more workloads go online, risks change at each release. New applications go live and risks might increase.
- When your company brings the first 10 or 20 applications online, the risk is lower than when the thousandth application goes into production in the cloud.

During your cloud risk assessment, you must determine which risks are a top priority. Consider the following areas in which risks often occur:

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
- Asset configuration that creates operations management problems or oversights
- Unauthorized access that compromises systems or data
- Immature processes or lack of team skills, which creates inconsistent governance

Note that none of the concerns are related to "a specific network segment of the existing datacenters," as cited in Tailwind's current policy. To create sound governance policies that scale to the cloud, we need to dig a bit deeper. Let's look at the tangible risks that are captured in the current policy versus the current-state solution.

It's likely that deeper investigation of stakeholder concerns and the cloud adoption plan shows more risks that the organization can't tolerate. But for now, we have enough to start shaping governance policies that address these tangible risks.

## Evaluate existing corporate policy

When you evaluate existing corporate policies to apply them to the cloud or to any other new technology, you should be able to answer the following questions:

- What risk does this policy attempt to mitigate?

- Why is that risk not within your organizational risk tolerance?
- Who determined that the risk is intolerable?
- When should you apply this policy (workload classification or situational)? When should you review exceptions?
- How do you enforce this process? How often should you review the policy for applicability?
- For technology-focused processes, does this policy create a dependency on a specific technology solution or technology vendor and add risk to your organization?

The Tailwind Traders' policy on protected data fails to answer these questions. Other sources, such as policy handbooks, might address some of these questions. But Tailwind Traders doesn't have an answer for the final technology-focused question. The existing policy doesn't mitigate risks. It actually introduces long-term risks because it confines Tailwind Traders to a single solution.

<!--Change the second question here-->
