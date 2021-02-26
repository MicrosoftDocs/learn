Migration is a highly repeatable process. Today, you have a collection of binary assets (VMs, Apps, and Data) that reside in a local datacenter. Tomorrow, you want to replicate those binary assets to the cloud and shift your production traffic to use the new copy of the same assets. On the surface migration is a simple, repeatable process.

Like most repeatable processes, most of the work can be automated, reducing repetitive human tasks. Automation of that process led to the first iterations of the Azure Migrate product. But as most migration teams quickly discover, the repeatable process is the easy part. Hidden within this repeatable process is a change management effort that requires decisions and human intervention. The following disciplines of migration outlines how the Azure Migrate tool and the Cloud Adoption Framework work together to shape the required human intervention into a repeatable process.

## Mass migration vs Iterative migration

The binary assets being moved to the cloud could theoretically be migrated in one large batch. Some organizations have been successful in mass migrations of all assets using Azure Migrate. Doing so requires a planned effort of analysis and remediation to ensure that all assets are compatible with the cloud. It also requires a detailed plan to test and certify performance for each of the workloads that run on those assets.

The degree of planning and the impact on business users makes the mass migration approach unattractive for most organizations. An alternative approach, is to apply the principles of Agile methodologies, such as Scrum, to break down the mass migration into waves, migrating a smaller collection of workloads on a regular cadence. The iterative approach to migration allows the business to absorb the changes in smaller units, produces less business disruption. It also allows the team to measure and learn from each iteration, gain speed and expertise progressively from one iteration to the next.

For the remainder to this learn module, assume that Tailwind Traders will be following an iterative approach to migration.

## Disciplines

In any iterative migration process, the team will complete three sets of tasks or disciplines to successful migrate each workload to Azure:

**Assess workloads:** During assessment of the workloads in each wave, the architects are looking primarily for cloud compatibility and dependencies between assets. But, they will also be looking for compatibility with modernization and optimization opportunities. At times, they will get close to the architecture of individual workloads to perform advanced optimization tasks with the Well-Architected Review.

**Migrate workloads** During migration, the team will use a migration tool to complete the replication of assets (VMs, Apps, and Data) to the cloud. In this step, the team is largely directing and supervising the repeatable process to ensure accurate replication of the selected workloads' assets.

**Release workloads**  Once each technology platform and workload is migrated to the cloud, the team will need to test, optimize, and release production traffic to their newly migrated workloads. Testing may also require an evaluation of end user routing and optimization of the network path to the newly deployed workloads.

Repeating these three disciplines for each workload in the migration plan will ensure a successful migration to the cloud.

## Sprint planning

When planning migration efforts, one of the first step is to break down the list of workloads to be migrated into smaller groups. As you learn about your team's velocity (how many workloads they can move in a sprint), we suggest starting with the Power of 10 approach. In that approach, you define groups of common like & kind workloads consistently of 10 workloads in each wave. Then map those groups of 10 workloads to two week iterations or sprints, using your cloud adoption plan in Azure DevOps. See the Cloud Adoption Plan Learn module for step-by-step guidance.

Before each sprint, the migration team should evaluate the next wave of workloads to be migrated. The objective of this evaluation is to ensure that the team has all of the necessary information and access required to be successful in the current sprint. It also gives the team a chance to adjust the next 10 workloads based on what they've learned from past sprints. Once the team is committed to the sprint, the actual work can begin.

## Team organization

Basic organizing principles can be applied to your team structure to maximize the output of each sprint, based on available velocity. The following are the two most common forms of team organization:

- **Self-organizing teams:** Holding true to agile methodologies, self-organizing teams ensure that the members of the migration team can collectively deliver on each of the disciplines. In each sprint, the team will identify who performs the tasks associated with each of the disciplines across each workload in the wave. In this organization, the objective is to complete all three disciplines for each workload in the current sprint. 
- **Migration factory:** The repetitive nature of the migration disciplines lends themselves to a division of labor across highly specialized teams. In this approach, one team would be dedicated to each of the migration disciplines. The Assess team would always be 1-2 waves ahead of the Migration team. The Release team would always be 1-2 sprints behind the Migration team. The approach can be effective in large migration efforts including thousands of assets and hundreds of workloads.

## Common blockers

Technology is seldom the blocker to the migration process flow. Most of the blockers to migration come from steps missed in upstream or downstream dependencies on the migration process.

**Strategy & plan blockers:** The most common blocker to a successful migration stems from missed steps during strategy or planning efforts. Failure to set the right expectations with executive, project managers, or technical staff can create blockers, even when all of the technical disciplines are running as planned. Before beginning any migration effort at scale, ensure that a cloud adoption strategy and cloud adoption plan has been created and reviewed by stakeholders. For assistance building your [cloud adoption strategy](https://docs.microsoft.com/learn/modules/cloud-adoption-framework-strategy/), or [cloud adoption plan](https://docs.microsoft.com/learn/modules/cloud-adoption-framework-plan/), see the cloud adoption framework modules on each topic.

**Environmental blockers:** Improperly configured environments are the next most common blocker to migration success. Specifically, the migration effort will require a minimum of networking and identity configuration to allow for proper connectivity and access requirements. For most migration efforts, governance and operations considerations should be addressed early in the migration, if not prior to migration. To ensure proper environmental configuration, see the Cloud Adoption Framework learn module on [preparing your environment](https://docs.microsoft.com/learn/modules/cloud-adoption-framework-ready/).

**Governance blockers:** Most organizations have requirements for cost, security, consistency, and identity management that go beyond basic environment configuration. Sadly, a large percentage of migration efforts don't have an understanding of those requirements until they attempt to migrate production traffics to the cloud. It is advised that all migration teams review the Learn module of [Cloud Adoption Framework Govern](https://docs.microsoft.com/learn/modules/cloud-adoption-framework-govern/), prior to beginning a scale migration effort to avoid late-bound surprises.

**Operations blockers:** Similarly, most organizations have set operations requirements for their production workloads in the current datacenter. It is often assumed that those operations will work when they move production traffic to the cloud. Prior to beginning any scale migration effort, the migration team should review the [Cloud Adoption Framework Manage](https://docs.microsoft.com/learn/modules/cloud-adoption-framework-strategy/) Learn module to understand basic operations management expectations in the cloud.

**Technical blockers to migration disciplines:** Occasionally, workloads may be blocked due to increased needs in remediation, modernization, or changes to the rationalization strategy. When individual workloads are blocked, they can be addressed by technical spikes, which remove problematic workloads from the standard flow.

Technical spikes are usually addressed in a parallel sprint by a seperate team. Many of the technical issues around remediation and modernization can be addressed using the CAF migration scenarios to be shared at the end of this module.

When a workload requires comprehensive changes that impact the application architecture, workload teams should review the [Well-Architected Framework](https://docs.microsoft.com/learn/modules/azure-well-architected-introduction/) Learn module for additional guidance.
