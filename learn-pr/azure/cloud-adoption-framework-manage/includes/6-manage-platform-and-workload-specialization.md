## Workload specialization

Workload-specific management usually requires in-depth knowledge about the specific workload, which is why the workload team or development team often does it. A workload-specific solution doesn't scale quickly to other workloads. Centralized IT can still guide and share knowledge with the workload-specialized team on operations.

## Platform specialization

Decentralized, workload-specific operations aren't scalable across an enterprise, but a study of the portfolio often identifies common platforms on which those workloads run. Those technology platforms (also known as technology stacks) are often at the heart of workload-specific incidents. When priority workloads share a common technology platform, it might be more valuable for central IT to focus on improving those platforms' operations, and thereby reduce or avoid workload-specific operations.

Examples of technology platforms might include data platforms, analytics platforms, container platforms, Azure Virtual Desktop platforms, enterprise resource planning (ERP) platforms, or even mainframes.

## Advanced operations

Platform and workload specialization consists of disciplined execution of the following four processes in an iterative approach:

- **Improve system design**: Technical debt and architectural flaws are the root cause of most business workload outages. By reviewing the platform or workload design, you can improve stability. The Azure Well-Architected Framework includes recommendations for improving the quality of the platform or a specific workload.
- **Automate remediation**: Some design improvements aren't cost-effective, because the technical debt can be too costly or complex to improve. In such cases, it might make more sense to automate remediation and reduce the effect of interruptions.
- **Scale the solution**: As system design and automated remediation are improved, those changes can be scaled across the environment through the service catalog. You can publish optimized platforms and solutions in Azure Managed Applications Center to easily reuse them for other workloads or external customers.
- **Continuously improve**: You'll gain valuable information for the next system review by collecting feedback from users, administrators, and customers. Collecting and visualizing critical system logs and performance data are also important. Both the feedback and the data collected will be used as a foundation for making new decisions about future system improvements.

The following table shows tools used for workload-specific management:

| Tool | Description | Link to more information |
| -----|-------------|--------------------------|
| Application Insights | Advanced application monitoring with dependency mapping, application dashboard, application map, usage, and deep tracking | [Application Insights overview](/azure/azure-monitor/app/app-insights-overview) |