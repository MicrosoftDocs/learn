In earlier Microsoft Learn modules for the Cloud Adoption Framework, we shared the narrative of Tailwind Traders. The company's central operations and infrastructure teams have successfully migrated some workloads to the cloud, but they face unanswered questions and unexpected concerns as they prepare for production release.

## Tailwind Traders' balancing act

Tailwind Traders, like most businesses, must attempt to balance two competing business drivers: digital transformation and risk mitigation.

:::image type="content" source="../media/balance.png" alt-text="Image that demonstrates balancing transformation and risk mitigation." border="false":::

*Figure 1: Finding the balance between transformation and risk mitigation.*

In the Getting Started module, we shared a few objectives that Tailwind Traders included in its cloud-adoption plan. Most relevant to this module is its effort to migrate out of two leased datacenters in the next 24 months. The datacenters host a large portfolio of production workloads that support in-store and e-commerce operations. One of the datacenters also hosts dev/test environments, and other hosts preproduction innovations from the retail innovation team.

Tailwind's effort is driving digital transformation and pushing the boundaries of what the business can do in the cloud. It has migrated low-risk workloads to the cloud. Tailwind also has begun to use cloud-native technologies to innovate and create new solutions that couldn't be delivered on-premises. The value of the cloud is proving out. As Tailwind's adoption plans progress, the need for balance becomes more apparent.

## Governance needs

To balance digital transformation efforts, the central operations and infrastructure team needs to find a way to meet the following basic governance needs:

- Maintain compliance
- Create better cost visibility and control
- Apply security posture consistently
- Remain agile to support scale and transformation

Before Tailwind Traders adopted the cloud, governance was delivered in a series of manual processes of review, acceptance, and change control. The employees, processes, and tools that delivered governance functions in the on-premises environment aren't scaling to consistently govern cloud deployments.

## Blocked by current policies

The current policy at Tailwind Traders states that "Customer and financial data can only be hosted in a specific network segment of the *existing datacenters*, referred to as protected assets." The policy is problematic, as the business plans its move from primarily using on-premises datacenters to cloud datacenters.

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
