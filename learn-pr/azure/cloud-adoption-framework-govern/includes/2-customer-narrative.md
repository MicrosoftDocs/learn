We shared the narrative for Tailwind Traders in the Getting Started module and other Cloud Adoption Framework (CAF) Learn modules. The central operations and infrastructure team has successfully migrated a number of workloads to the cloud, but they face unanswered questions and unexpected concerns as they prepare for production release.

## Tailwind Traders' balancing act

Like most customers, Tailwind Traders is attempting to balance two competing business drivers: digital transformation and mitigate risk.

:::image type="content" source="../media/balance.png" alt-text="Finding the balance between transformation and risk mitigation." border="false":::
_Figure 1: Finding the balance between transformation and risk mitigation._

In the Getting Started module, we shared a few of the objectives from Tailwind Trader's cloud adoption plan. Most relevant to this module, is their effort to migrate out of two leased datacenters in the next 18 to 24 months. Those datacenters host a large portfolio of production workloads that support in-store and e-commerce operations. The second datacenter also hosts a number of dev/test environments and other pre-production innovations from the retail innovation team.

Their effort is driving digital transformation and pushing the boundaries of what the business can do in the cloud. They've migrated low-risk workloads to the cloud. They've also started using cloud native technologies to innovate and create new solutions that couldn't be delivered on-premises. The value of the cloud is proving out. As their adoption plans progress, the need for balance is becoming more apparent.

## Governance needs

To balance the digital transformation efforts, the central operations/infrastructure team would needs to find a way to meet the following basic governance needs:

- Maintain compliance.
- Create better cost visibility and control.
- Apply security posture consistently.
- Remain agile to support scale and transformation.

Before adopting the cloud, governance was delivered by a series of manual processes of review, acceptance, and change control. The employees, processes, and tools that previously delivered governance functions in the on-premises environment aren't scaling to consistently govern cloud deployments.

## Blocked by current policies

Tailwind Traders has a current policy that states, "Customer and financial data can only be hosted in a specific network segment of the existing datacenters, referred to as protected assets." The Chief Information Officer (CIO) is working to change this policy, but the central operations/infrastructure teams must perform the following controls before she's comfortable with approving the changes:

- Control costs to deliver on the promised savings as adoption scales.
- Adhere to security and third-party compliance requirements.
- Configure asset management to prepare all workloads to be ready for operations management.
- Apply and meet identify and access management requirements.
- Follow a path to ensure that all of these controls are consistently applied to all workloads while acknowledging the scale and learning curve challenges across the technology teams.

Demonstrating these controls will give the CIO confidence that the team is ready to migrate more complex, higher-risk workloads to the cloud. This demonstration would provide the governance balance. Unfortunately, this governance requirement was only discovered as the team prepared to deploy their first mission-critical workload to production. This policy has frozen the effort to migrate their current datacenters. More foresight would have helped the team to address this policy sooner while they moved to lower-risk workloads to production.



The retail innovation team isn't currently impacted by this policy, and they've been delivering new innovations in the cloud faster than expected. However, the same challenges will soon block the following teams and efforts:

- The application development teams are working in a dev/test capacity to learn about cloud-native capabilities.
- The business intelligence team is experimenting with big data in the cloud and curation of data on new platforms.

The remaining units in this module will demonstrate the CAF Govern methodology's approach to meeting these governance needs, preferably in parallel to cloud adoption efforts to avoid unexpected project interruptions.
