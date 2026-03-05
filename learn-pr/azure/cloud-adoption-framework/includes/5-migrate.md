
Migrations involve planning, executing, and optimizing workload migrations from on-premises data centers and other cloud platforms to Azure. The recommendations help organizations minimize migration risks, reduce costs, and achieve successful cloud adoption outcomes.

## Plan migration

1. **Assess migration readiness and skills.** Evaluate your team's Azure capabilities across infrastructure, security, and application domains, then engage Microsoft partners or Azure solution architects to fill expertise gaps.

2. **Choose your data migration path.** Select ExpressRoute for high-bandwidth transfers, VPN gateways for encrypted connections, Azure Data Box for offline migrations, or public internet for non-sensitive data.

3. **Determine the migration sequence.** Map application dependencies using Azure Migrate, prioritize workloads by business criticality, and create migration schedules that avoid peak business periods.

4. **Choose the migration method for each workload.** Select near-zero downtime migration for mission-critical workloads or planned downtime migration for applications that accommodate maintenance windows.

5. **Define rollback plan.** Develop backup strategies with automated recovery scripts, establish rollback timeframes, and test recovery procedures in non-production environments.

6. **Engage stakeholders on migration plan.** Document migration approaches with business justification, present tested rollback procedures, validate schedules against business constraints, and establish clear success criteria.

## Prepare workloads for the cloud

1. **Fix compatibility issues in Azure.** Deploy workload resources in test subscriptions, identify compatibility problems, replace hardcoded configurations with Azure Key Vault, and eliminate local dependencies through Azure-native services.

2. **Validate workload functionality.** Test network connectivity, verify authentication flows, conduct functional testing, measure performance with Azure Load Testing, and validate results against source environment baselines.

3. **Create reusable infrastructure.** Develop ARM templates or Bicep files for infrastructure components, create automation scripts for configuration management, and establish version control workflows.

4. **Create deployment documentation.** Document deployment procedures, record configuration requirements, create operational runbooks, and establish troubleshooting guides.

## Execute migrations

1. **Prepare stakeholders for migration.** Distribute migration schedules with responsibilities, confirm technical support availability, and conduct pre-migration readiness reviews.

2. **Implement a change freeze.** Communicate freeze periods, implement change control procedures, and monitor source systems for unauthorized changes.

3. **Finalize the production environment.** Deploy infrastructure using tested templates, apply security policies, verify Azure services are operational, and confirm network connectivity.

4. **Execute cutover.** For near-zero downtime: configure database replication, migrate static files, pause writes for synchronization, and redirect traffic. For planned downtime: stop operations, migrate data with validation, test functionality, and redirect traffic.

5. **Maintain fallback option.** Retain source infrastructure, maintain network connectivity, document fallback procedures, and establish monitoring for issues.

6. **Validate migration success.** Test performance against success criteria, conduct functional validation, verify data integrity, and obtain formal stakeholder acceptance.

7. **Support workload during stabilization.** Establish dedicated support teams, update configuration databases, maintain enhanced monitoring, and document lessons learned.

## Optimize workloads after migration

1. **Fine-tune workload configurations.** Apply Azure Advisor recommendations, implement service-specific guidance, address security recommendations, and configure monitoring.

2. **Validate critical configurations.** Verify monitoring captures telemetry, confirm cost tracking aligns with baselines, test backup procedures, and validate security configurations.

3. **Collect and act on user feedback.** Gather feedback through surveys and interviews, document issues in tracking systems, assign ownership for resolution, and communicate improvements.

4. **Schedule regular workload reviews.** Conduct quarterly reviews using Well-Architected Framework tools, evaluate cost optimization opportunities, assess performance metrics, and document optimization actions.

5. **Optimize hybrid and multicloud dependencies.** Monitor hybrid connections with Azure Arc, secure cross-environment communications, identify Azure Platform as a Service replacement opportunities, and plan systematic migration.

6. **Share migration outcomes.** Track cost savings with Azure Cost Management, measure performance improvements, document operational benefits, and present outcomes to stakeholders.

## Decommission source workloads

1. **Obtain stakeholder approval before decommissioning.** Request written approval from business owners, document approval with timelines, record decisions in centralized systems, and establish audit trails.

2. **Reclaim and optimize software licenses.** Identify licenses eligible for Azure Hybrid Benefit, update inventory systems, reallocate unused licenses, and document changes for compliance.

3. **Preserve data for compliance and recovery needs.** Identify data subject to retention requirements, implement compliant storage using Azure Blob Storage, create retrieval procedures, and establish lifecycle management policies.

4. **Update documentation and procedures.** Update architecture diagrams, revise operational procedures, modify monitoring configurations, and archive legacy documentation with deprecation notices.

For the detailed Cloud Adoption Framework guidance, see [Migrate workloads to Azure](/azure/cloud-adoption-framework/migrate/plan-migration).
