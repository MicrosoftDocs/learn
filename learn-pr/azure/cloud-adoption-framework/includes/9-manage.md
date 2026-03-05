Cloud management establishes effective operations for your Azure cloud estate. Successful operations require clear responsibilities and processes across all management areas.

## Ready your Azure cloud operations

1. **Identify management responsibilities.** Cloud management spans compliance, security, resource management, deployment, development, monitoring, cost, reliability, and performance. Distinguish between central responsibilities for your entire Azure estate and workload-specific responsibilities for individual applications.

2. **Establish operations teams.** Choose centralized management for smaller organizations or shared management for diverse workloads. Form dedicated teams for platform tasks and specialized workload teams, then assign owners for each responsibility area.

3. **Document operational procedures.** Create standardized procedures for change management, deployments, and disaster recovery. Develop step-by-step guides for daily tasks and Azure scenarios, storing runbooks in a central repository accessible during incidents.

4. **Manage daily operations.** Establish 24/7 support through global teams or on-call rotations with automated alerts. Automate repetitive tasks using Azure capabilities to reduce errors and focus teams on strategic work.

5. **Improve continuously.** Conduct weekly reviews of metrics, incidents, changes, and risks. Address resource sprawl and technical debt while developing skills through Microsoft credentials and Azure training resources.

## Administer your Azure cloud estate

1. **Define administrative scope.** Determine responsibilities based on your deployment model (IaaS, PaaS, SaaS, on-premises). Focus on areas under your control like change management, security, and compliance.

2. **Control changes.** Implement formal change requests using ticketing tools, assess risk levels with approval workflows, and standardize deployment procedures. Prevent unauthorized changes using Change Analysis, Azure Policy, and Bicep deployment stacks.

3. **Secure your environment.** Use Microsoft Entra ID for identity, implement RBAC with least privilege, and enforce secure configurations through infrastructure as code. Enable multifactor authentication and Conditional Access.

4. **Maintain compliance.** Map governance policies to operational processes using Azure Policy definitions aligned with standards like ISO 27001 and NIST SP 800-53.

5. **Govern data.** Classify data using Microsoft Purview, control residency through region selection, and isolate workloads through management groups. Implement access controls and deletion protection.

6. **Control costs.** Use Microsoft Cost Management to monitor spending centrally and per workload. Provide billing access to teams and implement optimization practices.

7. **Manage code and runtime.** Direct teams to follow the Well-Architected Framework's Operational Excellence checklist for code management, testing, and deployment practices.

8. **Manage resources.** Limit portal deployments to nonproduction, use infrastructure as code with Bicep or Terraform, and implement CI/CD pipelines. Control configuration drift and resource sprawl through governance.

9. **Handle relocations.** Evaluate drivers like compliance or user proximity, assess risks including downtime, calculate costs, and use Azure relocation guidance when justified.

10. **Maintain operating systems.** Automate VM maintenance, implement updates through Azure update management, and monitor using Change Tracking and Machine Configuration services.

## Monitor your Azure cloud estate

1. **Define monitoring scope.** Determine responsibilities based on deployment models. Focus on service health, security, compliance, cost, and data across all models.

2. **Plan monitoring strategy.** Choose centralized or shared management approaches. Inventory resources using Azure Resource Graph, define data requirements, establish alert categories, and test continuously.

3. **Design monitoring solution.** Use Azure Monitor as the central hub with Azure Arc for multi-environment collection. Centralize data storage, automate through Azure Policy, and optimize costs regularly.

4. **Configure comprehensive monitoring.** Monitor service health, security through Microsoft Entra and Defender, compliance via Azure Policy, costs through Cost Management, and application performance with Application Insights.

5. **Set up alerting.** Define thresholds using Azure Monitor alerts with dynamic capabilities. Categorize severity, route notifications through action groups, and use email, SMS, or ITSM integration.

6. **Create visualizations.** Build dashboards using Azure Monitor workbooks for analysis and portal dashboards for overviews. Tailor views for technical teams and management audiences.

## Protect your cloud estate

1. **Ensure reliability.** Implement redundancy and recovery strategies based on workload priority. Assign uptime SLOs and recovery objectives aligned with business criticality.

2. **Protect data.** Configure replication and backup supporting RTO and RPO requirements. Use synchronous replication across zones and cross-region replication for critical workloads.

3. **Build resilient applications.** Design self-healing applications that handle failures gracefully and recover automatically from transient issues.

4. **Deploy redundant infrastructure.** Use multiple availability zones and regions based on priority. Calculate composite SLAs and implement load balancing strategies.

5. **Plan business continuity.** Create tested recovery procedures, detect failures within one minute, respond with appropriate procedures, and analyze incidents for improvement.

6. **Operate security.** Standardize security tools, baseline environments, apply access controls and encryption, and assign clear security responsibilities.

7. **Handle security incidents.** Develop tested response plans with defined roles. Use Microsoft Sentinel for monitoring, activate responses immediately, and analyze incidents for improvement.

For detailed guidance, see [Manage your Azure estate](/azure/cloud-adoption-framework/manage/ready).