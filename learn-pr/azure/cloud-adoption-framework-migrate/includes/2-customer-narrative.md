In the getting-started module, we shared a few of Tailwind Traders' objectives. The Tailwind Traders cloud-strategy team has defined an executive-level strategy that addressed financial and technical considerations.

A cloud adoption plan is in place to manage the various projects that contribute to that strategic program. The central operations and infrastructure team has deployed an Azure landing zone that meets its short-term compliance and operations needs.

Most relevant to this module is the company's effort to migrate out of two leased datacenters before those leases expire. Those datacenters host a large portfolio of production workloads that support in-store and e-commerce operations. The second datacenter also hosts dev/test environments and other pre-production innovations from the retail innovation team.

We resume the Tailwind story just as the migration team is preparing to start migrating workloads into the cloud.

## The Tailwind Traders migration plan

In the planning module, we rationalized the company's digital estate by using Azure Migrate and created a backlog to guide the migration in Azure DevOps. Now the migration team is ready to begin migrating the existing datacenters to the cloud. In the remaining 12 months, the team will migrate waves of workloads incrementally. Given the scope and timeline for this migration, the team has chosen the following migration-factory approach:

:::image type="content" source="../media/methodology-effort-only.png" alt-text="Diagram of the three common task groups in a migration process." border="false":::

*Figure 1: Common tasks required in each sprint of a migration process.*

- One small team will focus on migrating a wave of workloads in each two-week sprint by using Azure Migrate.
- A second small team of architects will stay one to two waves ahead of the migration team. Its focus will be on the assessment and design of each workload to be migrated.

  This team will discover and remediate any compatibility issues between the current-state application and the desired rationalization target. It will also evaluate sizing from the initial rationalization effort to ensure proper resource allocation.
- A third small team of Azure experts will work one to two waves behind the migration team. Its focus will be on the testing, fine-tuning, and architecture of the migrated workloads.

  This team will test the migrated workloads with business users to validate performance before releasing production traffic to the migrated workloads. This team will also use the Azure Well-Architected Framework and Azure Well-Architected Review for any workloads that require architectural tuning before production release.

> [!IMPORTANT]
> This migration-factory approach is imperative for Tailwind Traders because of the volume of workloads and the limited time window to complete this first migration. Typically, organizations can operate all three functions within a single, self-organizing migration team. That team can complete the assessment, migration, and release of each workload wave in a single sprint.

## Preparing for technology platform diversity

Like most customers, Tailwind Traders supports a diverse collection of technology platforms. The company's main concern is the large and growing collection of open-source solutions running on Linux and OSS data platforms. The company is also evaluating how to host its Azure Virtual Desktop solution in the cloud. At some point, the company will also need to migrate its SAP HANA solution to the cloud.

As the team prepares for this migration project, it will need to ensure that it has the skills required to migrate and modernize Windows and SQL Server assets. It must also be able to handle other technology platforms in the same processes.

The remaining units of this module will demonstrate processes, tools, and approaches for success in a variety of team structures and across several technology platforms.
