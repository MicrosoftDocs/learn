The Microsoft Cloud Adoption Framework for Azure provides recommendations, best practice guidance, documentation, and tools to help you drive adoption of Azure in your organization. The Cloud Adoption Framework supports methodologies for defining your strategy, planning and preparing for your migration, and establishing organizational structure to align your teams and roles. You can migrate and modernize existing workloads and develop new cloud-native or hybrid solutions. You can employ Cloud Adoption Framework tools to govern your environment and workloads and manage operations for cloud and hybrid solutions.

This diagram illustrates Cloud Adoption Framework methodologies within a cloud adoption lifecycle.

:::image type="content" source="../media/cloud-adoption-framework.png" alt-text="Diagram that shows Cloud Adoption Framework methodologies, including strategy, plan, ready, adopt, govern, and manage." border="false":::

### Things to know about cloud adoption and migration

Tailwind Traders shouldn't undertake cloud adoption without considerable planning. Proceeding with caution is especially recommended for the migrate phase in the cloud adoption lifecycle. To prepare for migration, review the following documentation:

- [The Cloud Adoption Framework migration model](/azure/cloud-adoption-framework/scenarios) is a structured roadmap that helps organizations successfully adopt Azure and integrate it into their existing IT environments. It provides best practices and guidance to help organizations make the right decisions for their business throughout the cloud journey.
  
- [Plan the migration](/azure/cloud-adoption-framework/migrate/plan-migration) defines the specific order, timing, and approach for migrating workloads to Azure. This plan translates high-level migration strategies into actionable deployment sequences. It builds on the cloud adoption plan by addressing tactical decisions such as workload prioritization, migration sequencing, and data transfer methods.

### Things to consider when implementing migration adoption

The migration adoption process for Tailwind Traders should consist of three phases or _efforts_ for each workload: _Assess_, _Deploy_, and _Release_. The following table and illustration summarize the migration adoption efforts.

| Effort | Description |
| --- | --- |
| _Assess_ | Assess your workloads to determine costs, modernization, and required deployment tools. |
| _Deploy_ | After you assess your workloads, the existing workload functionality is replicated (or improved) in the cloud. |
| _Release_ | After your workloads are deployed (replicated) to the cloud, you can test, optimize, and document your migrated workloads. When you're ready, you can release the workloads to your users. During the _Release_ effort, be sure to hand off the workloads to governance, operations management, and security teams for ongoing support of the workloads. |

:::image type="content" source="../media/migrate-methodology.png" alt-text="Diagram of migration adoption efforts for workloads, including assess, deploy, and release." border="false":::
