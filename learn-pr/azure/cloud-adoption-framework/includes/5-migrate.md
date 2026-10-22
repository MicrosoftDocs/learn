
Migrations involve planning, executing, and optimizing workload migrations from on-premises data centers and other cloud platforms to Azure. The recommendations help organizations minimize migration risks, reduce costs, and achieve successful cloud adoption outcomes.

## Plan migration

Follow these steps to build a migration plan that accounts for team readiness, workload requirements, and business priorities:

1. **Assess migration readiness and skills.** Evaluate your team's Azure capabilities across infrastructure, security, and application domains, then engage Microsoft partners or Azure solution architects to fill expertise gaps.

1. **Choose your data migration path.** Select ExpressRoute for high-bandwidth transfers, VPN gateways for encrypted connections, Azure Data Box for offline migrations, or public internet for non-sensitive data.

1. **Determine the migration sequence.** Map application dependencies using Azure Migrate, prioritize workloads by business criticality, and create migration schedules that avoid peak business periods.

1. **Choose the migration method for each workload.** Select near-zero downtime migration for mission-critical workloads or planned downtime migration for applications that accommodate maintenance windows.

1. **Define rollback plan.** Develop backup strategies with automated recovery scripts, establish rollback timeframes, and test recovery procedures in non-production environments.

1. **Engage stakeholders on migration plan.** Document migration approaches with business justification, present tested rollback procedures, validate schedules against business constraints, and establish clear success criteria.

## Prepare workloads for the cloud

Complete these steps to resolve compatibility issues and prepare workloads for reliable deployment in Azure:

1. **Fix compatibility issues in Azure.** Deploy workload resources in test subscriptions, identify compatibility problems, move hardcoded secrets to [Azure Key Vault](/azure/key-vault/secrets/secure-secrets) and store nonsecret settings in [Azure App Configuration](/azure/azure-app-configuration/overview), and eliminate local dependencies through Azure-native services.

1. **Validate workload functionality.** Test network connectivity, verify authentication flows, conduct functional testing, measure performance with Azure Load Testing, and validate results against source environment baselines.

1. **Create reusable infrastructure.** Develop ARM templates or Bicep files for infrastructure components, create automation scripts for configuration management, and establish version control workflows.

1. **Create deployment documentation.** Document deployment procedures, record configuration requirements, create operational runbooks, and establish troubleshooting guides.

## Execute migrations

Use the following steps to coordinate the migration, move workloads to Azure, and validate the results:

1. **Prepare stakeholders for migration.** Distribute migration schedules with responsibilities, confirm technical support availability, and conduct pre-migration readiness reviews.

1. **Implement a change freeze.** Communicate freeze periods, implement change control procedures, and monitor source systems for unauthorized changes.

1. **Finalize the production environment.** Deploy infrastructure using tested templates, apply security policies, verify Azure services are operational, and confirm network connectivity.

1. **Execute cutover.** For near-zero downtime: configure database replication, migrate static files, pause writes for synchronization, and redirect traffic. For planned downtime: stop operations, migrate data with validation, test functionality, and redirect traffic.

1. **Maintain fallback option.** Retain source infrastructure, maintain network connectivity, document fallback procedures, and establish monitoring for issues.

1. **Validate migration success.** Test performance against success criteria, conduct functional validation, verify data integrity, and obtain formal stakeholder acceptance.

1. **Support workload during stabilization.** Establish dedicated support teams, update configuration databases, maintain enhanced monitoring, and document lessons learned.

## Optimize workloads after migration

After migration, follow these steps to improve workload performance, security, and cost efficiency:

1. **Fine-tune workload configurations.** Apply Azure Advisor recommendations, implement service-specific guidance, address security recommendations, and configure monitoring.

1. **Validate critical configurations.** Verify monitoring captures telemetry, confirm cost tracking aligns with baselines, test backup procedures, and validate security configurations.

1. **Collect and act on user feedback.** Gather feedback through surveys and interviews, document issues in tracking systems, assign ownership for resolution, and communicate improvements.

1. **Schedule regular workload reviews.** Conduct quarterly reviews using Well-Architected Framework tools, evaluate cost optimization opportunities, assess performance metrics, and document optimization actions.

1. **Optimize hybrid and multicloud dependencies.** Use [Azure Arc](/azure/azure-arc/overview) to manage supported non-Azure resources and configure [Azure Network Watcher Connection Monitor](/azure/network-watcher/connection-monitor-overview) to monitor hybrid connectivity between supported endpoints, secure cross-environment communications, identify Azure Platform as a Service replacement opportunities, and plan systematic migration.

1. **Share migration outcomes.** Track cost savings with Azure Cost Management, measure performance improvements, document operational benefits, and present outcomes to stakeholders.

## Decommission source workloads

Once migrated workloads are stable, follow these steps to retire source workloads while meeting licensing, data retention, and documentation requirements:

1. **Obtain stakeholder approval before decommissioning.** Request written approval from business owners, document approval with timelines, record decisions in centralized systems, and establish audit trails.

1. **Reclaim and optimize software licenses.** Identify licenses eligible for Azure Hybrid Benefit, update inventory systems, reallocate unused licenses, and document changes for compliance.

1. **Preserve data for compliance and recovery needs.** Identify data subject to retention requirements, implement compliant storage using Azure Blob Storage, create retrieval procedures, and establish lifecycle management policies.

1. **Update documentation and procedures.** Update architecture diagrams, revise operational procedures, modify monitoring configurations, and archive legacy documentation with deprecation notices.

For the detailed Cloud Adoption Framework guidance, see [Migrate workloads to Azure](/azure/cloud-adoption-framework/migrate/plan-migration).
