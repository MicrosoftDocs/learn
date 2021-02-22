In the Getting Started module, we shared a few of Tailwind Traders objectives. The Tailwind Traders cloud strategy team has defined an executive-level strategy that addressed their financial and technical considerations.

A cloud adoption plan is in place to manage the various projects that contribute to that strategic program. The central operations and infrastructure team has deployed an Azure Landing Zone that meets their short-term compliance and operations needs.

Most relevant to this module, is their effort to migrate out of two leased datacenters before those leases expire. Those datacenters host a large portfolio of production workloads that support in-store and e-commerce operations. The second datacenter also hosts a number of dev/test environments and other pre-production innovations from the retail innovation team.

We resume the Tailwind story, just as the migration team is preparing to start migrating workloads into the cloud.

## Tailwind Traders' migration plan

In the Plan module, we rationalized their digital estate using Azure Migrate and created a backlog to guide the migration in Azure Devops. Now the team is ready to begin migrating their existing data centers to the cloud. In the remaining 12 months, the team will migrate waves of workloads incrementally. Given the scope and timeline for this migration, the team has chosen a migration factory approach:

:::image type="content" source="../media/methodology-effort-only.png" alt-text="Visual of the three common task groups in a migration process." border="false":::
_Figure 1: Common tasks required in each sprint of a migration process._

- One small team will focus on migrating a wave of workloads in each two week sprint, using Azure Migrate.
- A second small team of architects will stay 1-2 waves ahead of the migration team. Their focus will be on the assessment and design of each workload to be migrated. Their primary focus is to discover and remediate any compatibility issues between the current state application and the desired rationalization target. They will also evaluate sizing from the initial rationalization effort to ensure proper resource allocation.
- A third small team of Azure experts will work 1-2 waves behind the migration team. Their focus will be on the testing, fine tuning, and architecture of the migrated workloads. This team will test the migrated workloads with business users to validate performance before releasing production traffic to the migrated workloads. This team will also leverage the Well-Architected Framework and Well-Architected Review for any workloads that require architectural tuning prior to production release.

> [!IMPORTANT]
> This migration factory approach is imperative for Tailwind Traders, because of the volume of workloads and the limited time window to complete this first migration. Typically organizations can operate all three functions within a single, self-organizing migration team completing the assessment, migration, and release of each workload wave in a single sprint.

## Preparing for technology platform diversity

Like most customers, Tailwind Traders supports a diverse collection of technology platforms. Their top of mind concern, is the large and growing collection of open-source solutions running on linux and OSS data platforms. They are also evaluating how to host their windows virtual desktop solution in the cloud. At some point, they will also need to migrate their SAP/HANA solution to the cloud.

As the team prepares for this migration project, they will need to ensure they have the skills required to migrate and modernize windows and sql assets but also to be able to handle other technology platforms in the same processes.

The remaining units of this learn module will demonstrate the processes, tools, and approaches needed to be successful in a variety of team structures and across several technology platforms.
