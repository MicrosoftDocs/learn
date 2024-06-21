In the [assess phase](/azure/cloud-adoption-framework/migrate/assess/), you evaluate the readiness of your workload and plan for the migrated state. After you complete this phase, you can deploy the workload for migration.

Your cloud adoption team should evaluate technical compatibility, the required architecture, performance and sizing expectations, and dependencies. Use this information to ensure that you can deploy the migrated workload to the cloud effectively.

## Classify workloads for a migration

[Classify your workloads](/azure/cloud-adoption-framework/migrate/assess/classify) to help clarify governance, security, operations, and cloud-scale analytics requirements. [Classify data](/azure/cloud-adoption-framework/migrate/assess/classify#data-sensitivity) based on how a potential leak of that data affects a business or customers. More sensitive data increases the security risk.

[Workload criticality](/azure/cloud-adoption-framework/migrate/assess/classify#mission-criticality) is based on how significantly an outage affects a business. After you classify workloads, share those details with your supporting teams. Low or unsupported workloads are likely to have little influence on your supporting teams. But when workloads approach mission-critical or unit-critical classifications, they have more operational dependencies.

## Evaluate workload readiness

When you want to migrate a workload, your cloud adoption team must ensure that all assets and associated dependencies are compatible with your deployment model and cloud provider. Your team documents any required efforts to remediate compatibility problems.

- **Evaluate your assumptions**. Use assessment tools to [determine if you have any blockers for migration](/azure/cloud-adoption-framework/migrate/assess/evaluate#evaluation-assumptions).

- **Evaluate cross-datacenter dependencies** if you [migrate workloads from  multiple datacenters](/azure/cloud-adoption-framework/migrate/assess/evaluate#evaluate-cross-datacenter-dependencies). Visualize and group those dependencies to identify IP addresses and ports of assets that support the workload.

- **Use Azure Migrate and Modernize** for replication activities. You can [use your Azure Migrate and Modernize](/azure/cloud-adoption-framework/migrate/assess/evaluate#common-evaluation-activities-for-azure-migrate-and-modernize) project to:

  - Assess workloads.
  - Calculate the cost of operating in Azure.
  - Assess readiness for migration.
  - Translate your server size to Azure subscriptions based on actual use.

  As part of your server migration, you might also [migrate SQL Server instances or other database servers](/azure/cloud-adoption-framework/migrate/assess/evaluate#common-database-evaluation-activities).

- **Document any discrepancies** in your host configuration, replicated VM configuration, storage requirements, or network configuration. Use that information to estimate the bandwidth considerations for your migration.

## Design your workload architecture

Before you migrate, you must [design the intended migrated state of your workload](/azure/cloud-adoption-framework/migrate/assess/architect#know-when-to-change-your-architecture). 

Consider [common design assumptions](/azure/cloud-adoption-framework/migrate/assess/architect#base-architecture-design-on-common-assumptions) to design your:
- Architecture for a [landing zone](/azure/cloud-adoption-framework/migrate/assess/architect#design-architecture-for-a-landing-zone) during the Ready phase of the Cloud Adoption Framework.
- [Workload network architecture](/azure/cloud-adoption-framework/migrate/assess/architect#design-workload-network-architecture) with resources, like load balancers and other application-delivery resources.
- [Workload dependencies](/azure/cloud-adoption-framework/migrate/assess/architect#design-workload-dependencies) to account for communication between components.
- [Confidential computing](/azure/cloud-adoption-framework/migrate/assess/architect#prepare-for-adopting-confidential-computing).

As you finish your architecture design, [revisit your cloud estimate](/azure/cloud-adoption-framework/migrate/assess/architect#update-your-initial-cloud-estimate) to make sure that you're still within the planned budget. 

Migrations tend to focus on maintaining an existing architecture and transitioning it to your cloud platform. But there are times when you might need to rearchitect your workload, even for migration. 
You might need to [make architectural changes](/azure/cloud-adoption-framework/migrate/assess/architect#know-when-to-change-your-architecture) before you migrate if you need to:

- Pay for technical debt.
- Improve reliability.
- Optimize high-cost workloads.
- Meet performance requirements.
- Secure applications.