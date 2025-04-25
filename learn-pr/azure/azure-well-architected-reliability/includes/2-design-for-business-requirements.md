| :::image type="icon" source="../media/goal.svg"::: Gather business requirements with a focus on the intended utility of the workload. |
| :----------------------------------------------------------------------------------------------------------------------------------------- |

Start by figuring out what your workload needs to do. Work together with business stakeholders and architects to set realistic and achievable business requirements based on your budget. These requirements should cover user experience, data, workflows, and any unique characteristics of your workload. Make sure everyone agrees on what's expected and document these requirements to guide your design and operations. Make sure that they properly address the reliability targets that the workload must meet.

**Example scenario**

Contoso Insurance is in the early design phase of developing a web application to process claims for their policyholders. They've figured out their core user and system flows. The workload team has identified several Azure services that they'll use to create the app: Azure App Service, Azure SQL Database, Azure AI services, Azure Event Grid, and Azure Logic Apps.

## Identify reliability targets

**Set clear targets for how reliable each part of your system needs to be, including individual components, system and user flows, and the system as a whole.**

Metrics define what to aim for. Metrics help you understand complexities and whether the costs are within your budget. Use these targets to test your workload and ensure that it meets your standards. It it doesn't, see how long it takes to return to the ideal state.

Compliance requirements should have clear outcomes for important flows. Focus on these flows to highlight the most sensitive areas.

*Contoso's challenge*

- The workload team wants to optimize resource spending to make the workload reliable.

- They've broken down the workload into flows and rated them based on importance.

*Applying the approach and outcomes*

- The team determines that the Claim Submission and Approval flow has the highest reliability requirements because doctors and patients rely on it.

- The workload team identifies the components that support this flow and set reliability measures to meet the targets.

## Understand platform commitments

**Understand the guaranteed reliability metrics provided by your cloud platform and consider the limits, quotas, and capacity constraints for services.**

Service-level agreements (SLAs) vary by service. Not all services and features are covered equally. Having a good understanding of coverage and limits can help you detect drift and build resiliency and recovery mechanisms.

*Contoso's challenge*

- The workload team and stakeholders need the app's data to have a recovery time objective (RTO) of no more than 30 seconds for critical flows.

*Applying the approach and outcomes*

- After reviewing Microsoft's published SLAs, the team decides to deploy the Business Critical tier with active geo-replication to achieve this RTO target.

## Determine dependencies and their effect on resiliency

**When you break down your workload into parts, document all internal and external dependencies, and identify how problems with these dependencies might disrupt your flows.**

Keeping track of dependent infrastructure, services, APIs, and functions that other teams or partners develop helps you determine whether the workload can run without them. It also helps you understand cascading failures and improve downstream operations. Developers can design resilient systems to handle potential failures when you use external services.

*Contoso's challenge*

- The Claim Submission and Approval flow relies on a small reference dataset that's hosted and managed by a different department within Contoso Insurance.

- The dataset is updated multiple times a day during normal working hours.
- The app is being designed to handle some outdated reference data, but the data must always be available to the app.

*Applying the approach and outcomes*

- The workload team talks to the team that supports the reference dataset. They learn that the reliability target for the dataset is lower than the flow that will use it.

- The team adds design tasks to the backlog to create a local cache of the dataset and a background job to update the cache nightly. This solution ensures the data doesn't become too outdated.