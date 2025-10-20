Cloud-native solutions create new business value by building applications or adding features that use cloud capabilities for scalability, resilience, and agility. This guidance provides a structured approach to plan cloud-native development projects that align with business goals and minimize delivery risks.

## Planning cloud-native solutions on Azure

1. **Define business objectives for cloud-native solutions.** Start with clear, measurable business goals, identify constraints and success criteria, and validate stakeholder alignment to ensure everyone shares the same expectations from project inception.

2. **Define requirements for cloud-native solutions.** Document functional requirements that tie to business objectives, establish nonfunctional requirements including reliability metrics and security baselines, and control scope by clearly defining what is in-scope versus out-of-scope for the initial release.

3. **Plan the cloud-native architectures.** Explore validated reference architectures from Azure Architecture Center, select appropriate architecture styles based on workload characteristics, apply design best practices and cloud patterns, integrate the Well-Architected Framework's five pillars into design decisions, plan integrations with existing systems, select appropriate Azure services and service tiers based on requirements, determine regional deployment strategy based on reliability targets, and document architectures with detailed diagrams and design decisions.

4. **Plan the cloud-native deployment strategy.** Establish DevOps practices for deployment automation, plan operational readiness with monitoring and incident response procedures, define development practices that support reliable deployments, use progressive exposure for new workloads starting with pilot groups, plan feature integration using change management processes with appropriate deployment patterns (in-place updates for minor changes, blue-green for major changes), and define ownership and support responsibilities for post-deployment operations.

5. **Define rollback plan for cloud-native solutions.** Create comprehensive rollback procedures to quickly recover from deployment issues and ensure business continuity during release activities.

## Build cloud-native solutions

1. **Develop new cloud-native solutions.** Apply Well-Architected Framework principles during development, build in nonproduction environments that mirror production, implement source control with CI/CD pipelines, integrate monitoring tools like Azure Monitor and Application Insights from the start, and validate your solution through comprehensive testing including functional, performance, security, and user acceptance testing.

2. **Create reusable infrastructure.** Establish standardized, repeatable infrastructure patterns that can be deployed consistently across environments and projects to reduce deployment time and ensure configuration consistency.

3. **Create deployment documentation.** Document your deployment processes, configurations, and operational procedures to enable reliable deployments and effective knowledge transfer to operations teams.

## Deploy cloud-native solutions

1. **Prepare stakeholders for cloud-native deployments.** Announce deployment schedules and expected impacts to all relevant stakeholders before beginning production deployments. Notify support teams and affected groups about what is being released so they can handle user issues. Set clear expectations for functionality during deployment windows and conduct predeployment readiness reviews to confirm all teams understand their roles and have necessary access.

2. **Execute the cloud-native deployments.** Create production environments using validated CI/CD pipelines with the same build artifacts and IaC templates tested in staging. Perform smoke tests to verify core functionality and service availability. Implement progressive rollouts by exposing new systems to small user groups first, then gradually expand based on monitoring results and user feedback.

3. **Validate deployment success.** Verify critical user journeys work correctly in the live environment beyond basic smoke tests. Check background processes, integrations, and scheduled jobs are functioning properly. Review monitoring dashboards for system health anomalies and inspect alerting systems for unexpected triggers. Conduct stakeholder check-ins and declare deployment complete only after full validation against acceptance criteria.

4. **Support workloads during stabilization.** Establish heightened monitoring and support posture with development teams on call alongside operations teams. Track system metrics and user feedback continuously during the first week or two as a stabilization period. Adjust configurations based on observed behavior and log all issues discovered. Define clear exit criteria for transitioning from stabilization to standard operations.

## Optimize the cloud-native solutions after deployment

1. **Fine-tune service configurations.** Apply Azure Advisor recommendations weekly to implement critical cost, performance, reliability, and security improvements. Use Well-Architected Framework Azure services guides to align configurations with best practices, and address security findings immediately using Microsoft Defender for Cloud to maintain compliance and protect workloads.

2. **Validate operational readiness.** Enable comprehensive logging and metrics for all critical components through Azure Monitor, test alerting functionality by simulating failure scenarios, and review dashboards to ensure they provide actionable insights. Document monitoring coverage to support future audits and team onboarding.

3. **Establish cost monitoring and optimize costs.** Set up automated cost alerts and budgets in Azure to track spending against thresholds, apply Well-Architected Framework cost optimization strategies systematically across monitoring, governance, rates, usage, and components. Review resource utilization patterns regularly to identify and decommission underused resources while scheduling nonproduction environments to shut down during off-hours.

4. **Test backup and recovery procedures.** Confirm backup coverage for all critical data using Azure Backup, perform trial restores in nonproduction environments to verify data integrity and recovery time objectives. Document infrastructure and data recovery procedures with step-by-step instructions, and conduct regular disaster recovery drills to validate team readiness.

5. **Collect user feedback and measure outcomes.** Establish structured feedback channels through surveys and support ticket analysis to identify pain points in business-critical workflows. Track and resolve feedback systematically using Azure DevOps or GitHub Issues, prioritizing by value and urgency while communicating resolutions back to stakeholders.

6. **Continue to evolve and improve.** Schedule periodic Well-Architected Framework reviews to assess architecture against changing requirements and usage patterns. Implement automated optimization using Azure Policy for governance, autoscaling for load management, and cost anomaly detection for spending control, while sharing lessons learned and best practices across your organization to drive cloud maturity forward.

For the detailed Cloud Adoption Framework guidance, see [Build cloud-native solutions](/azure/cloud-adoption-framework/cloud-native/plan-cloud-native-solutions).