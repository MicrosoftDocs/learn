### Understand Cloud migration in the Cloud Adoption Framework

The Microsoft Cloud Adoption Framework for Azure is provided to help you drive adoption of Azure in your organization. It provides recommendations, best practice guidance, documentation, and tools. The framework supports several methodologies:

- **Define strategy**: Define business justification and expected outcomes of adoption.

- **Plan**: Align actionable adoption plans to business outcomes.

- **Ready**: Prepare the cloud environment for the planned changes.

- **Migrate**: Migrate and modernize existing workloads.

- **Innovate**: Develop new cloud-native or hybrid solutions.

- **Govern**: Govern the environment and workloads.

- **Manage**: Operations management for cloud and hybrid solutions.

- **Organize**: Align the teams and roles supporting your organization's cloud adoption efforts.

Each of the methodologies is a phase within a cloud adoption lifecycle.

 

:::image type="content" source="../media/cloud-adoption-framework.png" alt-text="Cloud adoption framework with strategy, plan, ready, adopt, govern, and manage.":::

 

Tailwind Traders shouldn’t undertake cloud adoption without considerable planning. This is especially true with the migrate phase in the cloud adoption lifecycle. To prepare you for this phase, you should review the following documentation:

- [Azure migration guide overview](/azure/cloud-adoption-framework/migrate/azure-migration-guide?azure-portal=true): Review the Azure migration guide to learn about Azure native tools and a relevant approach to migration.

- [The One Migrate approach to migrating the IT portfolio](/azure/cloud-adoption-framework/scenarios?azure-portal=true). Review the scenarios captured in this Migrate methodology: They demonstrate the same set of consistent guidelines and processes for migrating both Microsoft and third-party technologies.

- [Azure cloud migration best practices checklist](/azure/cloud-adoption-framework/migrate/azure-best-practices?azure-portal=true): Review this document to learn how best to address common migration needs through the application of consistent best practices.

- [Cloud Adoption Framework migration model](/azure/cloud-adoption-framework/migrate/migration-considerations?azure-portal=true): Review this document to understand mitigation. Migration can be process intensive activity. As you increase migration effort, review these process improvements to help to optimize aspects of your migration.

### Understand the migration effort

The actions required to migrate Tailwind Traders' workloads will almost certainly fall into three efforts (or phases) for each workload:

- Assess

- Deploy

- Release

This section of the Cloud Adoption Framework explains how to maximize the return from each of the phases required to migrate a workload to production. The following table provides an overview of the phases of this process, as displayed in the diagram below:

 

| **Phase**| **Explanation** |
| - | - |
| Assess| Assess your workloads to determine costs, modernization, and required deployment tools. |
| Deploy| After workloads are assessed, the existing functionality of those workloads is replicated (or improved) in the cloud. |
| Release| After workloads are replicated to the cloud, you can test, optimize, and document your migrated workloads. When satisfied, you can release these workloads to users. During this phase, ensure that you hand off the workloads to governance, operations management, and security teams for ongoing support of those workloads. |


:::image type="content" source="../media/migrate-methodology.png" alt-text="Migration adoption with assess workloads, deploy workloads, and release workloads.":::
