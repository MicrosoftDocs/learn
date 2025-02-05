You can use the [Manage methodology](/azure/cloud-adoption-framework/manage/) to manage the digital assets that you migrate.

## Define business commitments

Define business commitments, such as sustainability, service quality, and financial performance. Use calculations to determine the criticality of workloads. The [level of criticality](/azure/cloud-adoption-framework/manage/considerations/criticality) determines the required level of management for each workload. For example, a mission-critical workload might require specialized management. You can [calculate a time/value metric](/azure/cloud-adoption-framework/manage/considerations/impact) to capture the amount of lost revenue for a unit of time.

## Establish a management baseline

A [management baseline](/azure/cloud-adoption-framework/manage/azure-management-guide/) defines the minimum set of tools, processes, and consistent pricing that serve as the foundation for all cloud management in Azure. Most management baselines focus on maintaining inventory, visibility, operational compliance, protection, and recovery. To establish a management baseline, do the following steps:

- [Create an inventory](/azure/cloud-adoption-framework/manage/azure-management-guide/inventory) so that you can understand what services you manage.

- Use tools to get visibility into operations so that you understand your inventory's run state.
- Improve [operational compliance](/azure/cloud-adoption-framework/manage/azure-management-guide/operational-compliance) to reduce the likelihood of an outage related to configuration drift or vulnerabilities related to improperly patched systems. You can use tools like Azure Policy and Azure Automation to enforce policies and manage patches.
- Implement tools to [protect and recover resources](/azure/cloud-adoption-framework/manage/azure-management-guide/protect-recover) if an outage does occur. For example, you can use Azure Backup to back up data and virtual machines or use Azure Site Recovery to replicate virtual machines and workloads to a secondary region.

## Enhance the management baseline or implement specialization

[Enhance the management baseline](/azure/cloud-adoption-framework/manage/azure-management-guide/enhanced-baseline), depending on business commitments and operations decisions. Some workloads require extra management to help ensure their availability and security, like highly critical workloads or workloads that directly affect the customer experience. Enhance the management baseline if most workloads in your portfolio have a shared requirement.

You can also implement [specialization](/azure/cloud-adoption-framework/manage/azure-management-guide/platform-specialization) across an entire platform or individual workloads. Specialization requires changes to design and architecture principles, which might increase time and cost compared to a comprehensive enhanced baseline. Specialization consists of the following [four processes](/azure/cloud-adoption-framework/manage/azure-management-guide/platform-specialization#high-level-process) in an iterative approach.

- **Improve system design:** [Improve the design](/azure/cloud-adoption-framework/manage/azure-management-guide/platform-specialization#improve-system-design) of common systems or platforms to effectively minimize interruptions.

- **Automate remediation:** Some improvements aren't cost effective. In such cases, it might make more sense to [automate remediation](/azure/cloud-adoption-framework/manage/azure-management-guide/platform-specialization#automated-remediation) and reduce the effect of interruptions.
- **Scale the solution:** As system design and automated remediation are improved, you can [scale those changes](/azure/cloud-adoption-framework/manage/azure-management-guide/platform-specialization#scale-the-solution-with-a-service-catalog) across the environment through the service catalog.
- **Implement continuous improvement:** Use monitoring tools to discover [incremental improvements](/azure/cloud-adoption-framework/manage/azure-management-guide/platform-specialization#continuous-improvement). You can address these improvements in the next pass of system design, automation, and scale.
