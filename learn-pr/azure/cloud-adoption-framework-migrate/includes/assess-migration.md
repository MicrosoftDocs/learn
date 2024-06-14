In the assess phase, you evaluate the readiness of your workload and plan for the migrated state. After you complete this phase, you can deploy the workload for migration.

Your cloud adoption team should evaluate technical compatibility, the required architecture, performance and sizing expectations, and dependencies. Use this information to ensure that you can deploy the migrated workload to the cloud effectively.

## Classify workloads for a migration

Classification helps clarify governance, security, operations, and cloud-scale analytics requirements. You can classify data based on how a potential leak of that data affects a business or customers. More sensitive data increases the security risk.

Workload criticality is based on how significantly an outage affects a business. Share your workload classifications with your supporting teams. Low or unsupported workloads are likely to have little influence on your supporting teams. However, as workloads approach mission-critical or unit-critical classifications, their operational dependencies become more visible.

## Evaluate workload readiness

When you want to migrate a workload, your cloud adoption team must ensure that all assets and associated dependencies are compatible with your deployment model and cloud provider. The team documents any required efforts to remediate compatibility problems.

Evaluate your assumptions. Use assessment tools to determine if you have any blockers for migration.

Evaluate cross-datacenter dependencies if you migrate workloads from  multiple datacenters. Visualize and group those dependencies to identify IP addresses and ports of assets that support the workload.

Use Azure Migrate and Modernize for replication activities. You can use your Azure Migrate and Modernize project to:

- Assess workloads.
- Calculate the cost of operating in Azure.
- Assess readiness for migration.
- Translate your server size to Azure subscriptions based on actual use.

Be sure to document any discrepancies in host configuration, replicated VM configuration, storage requirements, or network configuration. Use that information to estimate the bandwidth considerations for your migration. As part of your server migration, you might also consider [migrating SQL Server instances or other database servers](/azure/cloud-adoption-framework/migrate/assess/evaluate#common-database-evaluation-activities).

## Design a workload architecture

Design your
- Architecture for a landing zone.
- Workload network architecture.
- Workload dependencies.
- Confidential computing.

As you finish your architecture design, revisit your cloud estimate to make sure that you're still within the planned budget. 

Migrations tend to focus on maintaining an existing architecture and transitioning it to your cloud platform. However, there are times when you might need to rearchitect your workload, even for migration. 
You might need to [make architectural changes](/azure/cloud-adoption-framework/migrate/assess/architect#know-when-to-change-your-architecture) before you migrate if you need to:

- Pay for technical debt.
- Improve reliability.
- Optimize high-cost workloads.
- Meet performance requirements.
- Secure applications.