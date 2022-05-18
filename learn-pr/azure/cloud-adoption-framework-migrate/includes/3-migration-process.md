Migration is a highly repeatable process. Today, you have a collection of binary assets (virtual machines, applications, and data) that reside in a local datacenter. Tomorrow, you want to replicate those binary assets to the cloud and shift your production traffic to use the new copy of the same assets. 

Like most repeatable processes, most of the work can be automated to reduce repetitive human tasks. Automation of that process led to the first iterations of the Azure Migrate product.

But as most migration teams quickly discover, the repeatable process is the easy part. Hidden within this process is a change-management effort that requires decisions and human intervention. The following disciplines of migration outline how the Azure Migrate tool and the Cloud Adoption Framework work together to shape the required human intervention into a repeatable process.

## Mass migration versus iterative migration

The binary assets being moved to the cloud can theoretically be migrated in one large batch. Some organizations have been successful in mass migrations of all assets by using Azure Migrate. Doing so requires a planned effort of analysis and remediation to ensure that all assets are compatible with the cloud. It also requires a detailed plan to test and certify performance for each of the workloads that run on those assets.

The degree of planning and the impact on business users make the mass-migration approach unattractive for most organizations. An alternative approach is to apply the principles of agile methodologies, such as Scrum, to break down the mass migration into waves: migrating a smaller collection of workloads on a regular cadence.

The iterative approach to migration allows the business to absorb the changes in smaller units and produces less business disruption. It also allows the team to measure and learn from each iteration. The team can gain speed and expertise progressively from one iteration to the next.

For the rest of this module, assume that Tailwind Traders will follow an iterative approach to migration.

## Disciplines

In any iterative migration process, the team will complete three sets of tasks or disciplines to successfully migrate each workload to Azure:

- **Assess workloads:** During assessment of the workloads in each wave, the architects primarily look for cloud compatibility and dependencies between assets. They also look for compatibility with modernization and optimization opportunities. At times, they get close to the architecture of individual workloads to perform advanced optimization tasks by using the Azure Well-Architected Review.

- **Migrate workloads:** During migration, the team uses a migration tool to complete the replication of assets (virtual machines, applications, and data) to the cloud. In this step, the team is largely directing and supervising the repeatable process to ensure accurate replication of the selected workloads' assets.

- **Release workloads:** After each technology platform and workload is migrated to the cloud, the team needs to test, optimize, and release production traffic to its newly migrated workloads. Testing might also require an evaluation of user routing and optimization of the network path to the newly deployed workloads.

Repeating these three disciplines for each workload in the migration plan will help ensure a successful migration to the cloud.

## Sprint planning

When you're planning migration efforts, one of the first steps is to break down the list of workloads to be migrated into smaller groups.

As you learn about your team's velocity (how many workloads they can move in a sprint), we suggest starting with the Power of 10 approach. In that approach, you consistently define groups of 10 common workloads in each wave. Then, map those groups of 10 workloads to two-week iterations or sprints by using your cloud-adoption plan in Azure DevOps. See the planning module for step-by-step guidance.

Before each sprint, the migration team should evaluate the next wave of workloads to be migrated. The objective of this evaluation is to ensure that the team has all of the necessary information and access to be successful in the current sprint. It also gives the team a chance to adjust the next 10 workloads based on what it has learned from past sprints. After the team is committed to the sprint, the actual work can begin.

## Team organization

You can apply basic organizing principles to your team structure to maximize the output of each sprint, based on available velocity. These are the two most common forms of team organization:

- **Self-organizing teams:** Holding true to agile methodologies, self-organizing teams ensure that the members of the migration team can collectively deliver on each of the disciplines. In each sprint, the team identifies who performs the tasks associated with each of the disciplines across each workload in the wave.

  In this organization, the objective is to complete all three disciplines for each workload in the current sprint.
- **Migration factory:** The repetitive nature of the migration disciplines lends them to a division of labor across highly specialized teams. In this approach, one team is dedicated to each of the migration disciplines. The assessment team is always one to two waves ahead of the migration team. The release team is always one to two sprints behind the migration team.

  This approach can be effective in large migration efforts that include thousands of assets and hundreds of workloads.

## Common blockers

Technology seldom blocks the migration process. Most of the blockers to migration come from steps missed in upstream or downstream dependencies on the migration process. The following blockers are listed from most common to least common:

- **Strategy and planning:** The most common blocker to a successful migration stems from missed steps during strategy or planning efforts. Failure to set the right expectations with executives, project managers, or technical staff can create blockers, even when all of the technical disciplines are running as planned.

  Before you begin any migration effort at scale, ensure that a [cloud-adoption strategy](/learn/modules/cloud-adoption-framework-strategy/) and [cloud-adoption plan](/learn/modules/cloud-adoption-framework-plan/) have been created and reviewed by stakeholders.

- **Environmental:** Improperly configured environments are the next most common blocker to migration success. Specifically, the migration effort will require a minimum of networking and identity configuration to allow for proper connectivity and access requirements. 

  For most migration efforts, governance and operations considerations should be addressed early in the migration, if not before migration. To ensure proper environmental configuration, see the Cloud Adoption Framework Learn module on [preparing your environment](/learn/modules/cloud-adoption-framework-ready/).

- **Governance:** Most organizations have requirements for cost, security, consistency, and identity management that go beyond basic environment configuration. Many organizations don't understand those requirements until they try to migrate production traffic to the cloud. 

  We recommend that all migration teams review the Learn module for the [Govern methodology](/learn/modules/cloud-adoption-framework-govern/) in the Cloud Adoption Framework before beginning a scale migration effort, to avoid late-bound surprises.

- **Operations:** Most organizations have set operations requirements for their production workloads in the current datacenter. It's often assumed that those operations will work when they move production traffic to the cloud. Before the migration team begins any scale migration effort, it should review the Learn module about [developing a clear strategy](/learn/modules/cloud-adoption-framework-strategy/) to understand basic expectations about operations management in the cloud.

- **Technical:** Occasionally, workloads might be blocked because of increased needs in remediation, modernization, or changes to the rationalization strategy. When individual workloads are blocked, they can be addressed by technical spikes, which remove problematic workloads from the standard flow.

  Technical spikes are usually addressed in a parallel sprint by a separate team. A migration team can address many of the technical issues around remediation and modernization by using the Cloud Adoption Framework migration scenarios shared at the end of this module.

When a workload requires comprehensive changes that affect the application architecture, workload teams should review the [Well-Architected Framework](/learn/modules/azure-well-architected-introduction/) Learn module for more guidance.