| :::image type="icon" source="../media/goal.svg"::: Gather business requirements with a focus on the intended utility of the workload. |
| :----------------------------------------------------------------------------------------------------------------------------------------- |

Business requirements are defined through collaborative work between business stakeholders and workload architects. Compromises must be made on each side to ensure that the agreed upon requirements are realistic and achievable while properly addressing the reliability targets that the workload must meet. Requirements must cover user experience, data, workflows, and characteristics that are unique to the workload. The outcome of the requirements process must clearly state the expectations. The goals must be achievable and negotiated with the team, given a specified investment. They must be documented to drive technological choices, implementations, and operations.

**Example scenario**

Contoso Insurance is in the early design phase of developing a web application to process claims for their policy holders. Most of the core user and system flows have been determined and the workload team has identified several Azure services that will compose the app: Azure App Service, Azure SQL Database, Azure AI services, Azure Event Grid and Azure Logic Apps.

## Identify reliability targets

**Quantify success by setting targets on indicators for individual components, system and user flows, and the system as a whole.**

Metrics quantify expectations. They enable you to understand complexities and determine whether the downstream costs of those complexities are within the investment limit.

The target values indicate an ideal state. You can use the values as test thresholds that help you detect deviations from that state and how long it takes to return to the target state.

Compliance requirements must also have predictable outcomes for in-scope flows. Prioritizing these flows bring attention to areas that are the most sensitive.

*Contoso's challenge*

- The workload team wants to ensure that they’re optimizing how resources are spent on making the workload reliable.
- They have decomposed the workload into flows and have rated the flows based on their criticality.

*Applying the approach and outcomes*

- The team determines that the Claim Submission and Approval flow will have the highest reliability requirements for the workload due to doctors' and patients' reliance on the availability of that flow.
- The workload team identifies the components that support this flow and determine the reliability measures that achieving the targets requires.

## Understand platform commitments

**Understand the guaranteed reliability metrics provided by your cloud platform and consider the limits, quotas, and capacity constraints for services.**

Service-level agreements (SLAs) vary by service. Not all services and features are covered equally. Having a good understanding of coverage and limits can help you detect drift and build resiliency and recovery mechanisms.

*Contoso's challenge*

- The workload team and stakeholders have determined that the data for the app needs to have a guaranteed recovery time objective (RTO) that can’t exceed 30 seconds to support the criticality of their Claim Submission and Approval flow.

*Applying the approach and outcomes*

- After reviewing Microsoft's published SLAs, the team sees that they’ll need to deploy the Business Critical tier with active geo-replication to achieve this RTO target.

## Determine dependencies and their effect on resiliency

**When decomposing your workload into components, ensure that you’ve documented all dependencies, whether they’re internal or external to the business, and identify how malfunctions with the dependencies may affect your flows**

Keeping track of dependent infrastructure, services, APIs, and functions developed by other teams or third parties helps you determine whether the workload can operate in absence of those dependencies. It also helps you understand cascading failures and improve downstream operations. Developers can implement resilient design patterns to handle potential failures when you use external services that might be susceptible to failures.

*Contoso's challenge*

- The Claim Submission and Approval flow has a dependency on a small reference dataset that is hosted and managed by a different department within Contoso Insurance.
- The dataset is updated multiple times a day, during normal working hours.
- The app is being designed to tolerate some staleness in the reference data, but the data must always be available to the app.

*Applying the approach and outcomes*

- The workload team engages the team supporting the reference dataset and learns that the reliability target for the dataset is lower than that of flow that will use it.
- The team adds design tasks to the backlog to add a local cache of the dataset and a background job to update the cache nightly. The staleness tolerance allowed by the design won’t be breached by this solution.