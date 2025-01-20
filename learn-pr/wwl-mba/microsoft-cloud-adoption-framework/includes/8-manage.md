The Manage methodology focuses on how to manage the digital assets that you migrate.

**Define business commitments**, such as sustainability, service quality, and financial performance. Use calculations to determine the criticality of workloads. The level of criticality determines the required level of management for each workload. For example, a mission-critical workload might require specialized management.

**Establish a management baseline.** A management baseline defines the minimum set of tools, processes, and consistent pricing that serve as the foundation for all cloud management in Azure. Most management baselines focus on maintaining inventory, visibility, operational compliance, protection, and recovery.

- Create an inventory so that you can understand what services you manage.

- Use tools to get visibility into operations so that you understand your inventory's run state.
- Improve operational compliance to reduce the likelihood of an outage related to configuration drift or vulnerabilities related to improperly patched systems. You can use tools like Azure Policy and Azure Automation to enforce policies and manage patches.
- Ensure that you implement tools to protect and recover resources if an outage does occur. For example, you can use Azure Backup to back up data and virtual machines or use Azure Site Recovery to replicate virtual machines and workloads to a secondary region.

**Expand the management baseline**, depending on business commitments and operations decisions. Some workloads require extra management to help ensure their availability and security, like highly critical workloads or workloads that directly affect the customer experience.

**Implement specialization** across an entire platform or in individual workloads. Specialization consists of the following four processes in an iterative approach.

- *Improve system design:* Improve the design of common systems or platforms to effectively minimize interruptions.

- *Automate remediation:* Some improvements aren't cost effective. In such cases, it might make more sense to automate remediation and reduce the effect of interruptions.
- *Scale the solution:* As systems design and automated remediation are improved, those changes can be scaled across the environment through the service catalog.
- *Continuous improvement:* Different monitoring tools can be used to discover incremental improvements. These improvements can be addressed in the next pass of system design, automation, and scale.
