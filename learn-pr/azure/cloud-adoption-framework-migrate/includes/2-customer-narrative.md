In the Getting Started module, we shared a few of Tailwind Traders' objectives. The Tailwind Traders cloud-strategy team has defined an executive-level strategy that addresses financial and technical considerations.

A cloud-adoption plan is in place to manage the various projects that contribute to that strategic program. The central operations and infrastructure team has deployed an Azure landing zone that meets its short-term compliance and operations needs.

Most relevant to this module is the company's effort to migrate out of two leased datacenters before those leases expire. Those datacenters host an extensive portfolio of production workloads that support in-store and e-commerce operations. The second datacenter also hosts dev/test environments and other preproduction innovations from the retail innovation team.

We resume the Tailwind story just as the migration team prepares to start migrating workloads into the cloud.

## The Tailwind Traders migration plan

In the Planning module, we rationalized the company's digital estate by using Azure Migrate and created a backlog to guide the migration in Azure DevOps. Now, the migration team is ready to begin migrating the existing datacenters to the cloud. In the remaining 12 months, the team plans to migrate waves of workloads incrementally. Given the scope and timeline for this migration, the team has chosen the following migration-factory approach:

:::image type="content" source="../media/methodology-effort-only.png" alt-text="Diagram of the three common task groups in a migration process." border="false":::

*Figure 1: Common tasks required in each sprint of a migration process.*

- One small team focuses on migrating a wave of workloads in each two-week sprint by using Azure Migrate.
- A second small team of architects stays one to two waves ahead of the migration team. It focuses on the assessment and design of each workload to migrate.

  This team discovers and remediates any compatibility issues between the current-state application and the desired rationalization target. It also evaluates sizing from the initial rationalization effort to ensure proper resource allocation.
- A third small team of Azure experts works one to two waves behind the migration team. It focuses on the testing, fine-tuning, and architecture of the migrated workloads.

  This team tests the migrated workloads with business users to validate performance before releasing production traffic to the migrated workloads. This team also uses the [Azure Well-Architected Framework](/azure/well-architected/) and [Azure Well-Architected Review assessment](/assessments/azure-architecture-review/) for any workloads that require architectural tuning before production release.

> [!IMPORTANT]
> This migration-factory approach is imperative for Tailwind Traders because of the volume of workloads and the limited time window to complete this first migration. Typically, organizations can operate all three functions within a single, self-organizing migration team. That team can complete the assessment, migration, and release of each workload wave in a single sprint.

## Preparing for technology platform diversity

Like most customers, Tailwind Traders must support a diverse collection of technology platforms. The company's main concern is the large and growing collection of open-source solutions running on Linux and OSS data platforms. The company also evaluates how to host its Azure Virtual Desktop solution in the cloud. At some point, the company must also migrate its SAP HANA solution to the cloud.

As the team prepares for this migration project, it needs to ensure that it has the skills required to migrate and modernize Windows and SQL Server assets. It must also be able to handle other technology platforms in the same processes.

The remaining units of this module demonstrate processes, tools, and approaches for success in various team structures across several technology platforms.
