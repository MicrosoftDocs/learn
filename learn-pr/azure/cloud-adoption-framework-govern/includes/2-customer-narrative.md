In the getting started module and other CAF learn modules, we shared the narrative for Tailwind Traders. The central operations/infrastructure team has successfully migrated a number of workloads to the cloud. But, as they prepare for production release they are faced with unanswered questions and unexpected concerns.

## Tailwind Traders' balancing act

Like most customers, Tailwind Traders is attempting to balance two competing business drivers: digital transformation and mitigate risk.

:::image type="content" source="../media/balance.png" alt-text="Finding balance between transformation and risk mitigation" border="false":::

_Figure 1: Finding balance between transformation and risk mitigation._

In the getting started module, we shared a few of the objectives from Tailwind's cloud adoption plan. Most relevant to this module, is their effort to migrate out of two leased data centers in the next 18-24 months. Those data centers host a large portfolio of production workloads that support in-store and ecommerce operations. The second data center also hosts a number of dev/test environments and other pre-production innovations from the retail innovation team.

Their effort is driving digital transformation and pushing the boundaries of what the business can do in the cloud. They've migrated low risk workloads to the cloud. They've also started using cloud native technologies to innovate & create new solutions that couldn't be delivered on-prem. The value of the cloud is proving out. As their adoption plans progress, the need for balance is becoming more apparent.

## Governance needs

To balance the digital transformation efforts, the central operations/infrastructure team would needs to find a way to meet the following basic governance needs:

- Maintaining compliance
- Creating better cost visibility and control
- Consistently applying security posture
- Being agile—to support scale and transformation

Before adopting the cloud, governance was delivered by a series of manual processes of review, acceptance, and change control. The employees, processes, and tools that previously delivered governance functions in the on-premise environment aren't scaling to consistently govern cloud deployments.

## Blocked by existing policies

Tailwind has an existing policy which states "customer and financial data can only be hosted in a specific network segment of the existing data centers, referred to as protected assets.". The CIO is working to change this policy. But before she is comfortable approving a change, the central operations/infrastructure teams must demonstrate the following:

- Cost controls to deliver on the promised savings as adoption scales
- Adherence to security and 3rd party compliance requirements
- Asset configuration management to ensure all workloads are ready for operations management
- Application of identify and access management requirements
- A means to ensure that all of these controls are consistently applied to all workloads, in spite of the scale and learning curve challenges across the technology teams.

Demonstrating these controls will help the CIO have the confidence that the team is ready to migrate more complex, higher risk workloads to the cloud. This demonstration would provide the governance balance.

Unfortunately, this governance requirement was only discovered as the team prepared to deploy their first mission critical workload to production. This policy has essentially frozen the effort to migrate their existing data centers. A bit more foresight would have allowed this policy to be addressed sooner, as they were moving lower risk workloads to production.

Fortunately, the Retail innovation team isn't currently impacted by this policy. But they've been delivering new innovations in the cloud faster than expected. Soon the following two efforts will become blocked by these same challenges:

- The application development teams are working in a dev/test capacity to learn about cloud-native capabilities.
- The business intelligence (BI) team is experimenting with big data in the cloud and curation of data on new platforms.

The remaining units in this module will demonstrate the CAF Govern methodology's approach to meeting these governance needs. Preferably in parallel to cloud adoption efforts, to avoid unexpected project interruptions.
