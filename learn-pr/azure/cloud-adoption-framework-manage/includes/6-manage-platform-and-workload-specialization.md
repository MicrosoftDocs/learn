## Workload Specialization

Workload-specific management usually requires in-deep knowledge about the specific workload. Therefore workload-specific management is often done by the workload team or development team. A workload-specific solution does not scale quickly to other workloads. Centralized IT can still guide and share knowledge to the workload-specialized team on operations. 

## Platform Specialization

Decentralized, workload-specific operations isn't scalable across an enterprise. But a study of the portfolio will often identify common platforms that those workloads run on. Those technology platforms (also known as technology stacks) are often at the heart of workload-specific incidents. When priority workloads share a common technology platform, it may be more valuable for central IT to focus on improving the operations of those platforms & thereby reduce or avoid workload-specific operations. 

Examples of technology platforms could include things like Data platforms, Analytics platforms, Container platforms, Windows Virtual Desktop platforms, ERP platforms, or even mainframes.

## Advanced operations

Platform and workload specialization consists of disciplined execution of the following four processes in an iterative approach.  
-	Improve system design. Technical debt and architectural flaws are the root cause of most business workload outages. By review the platform or workload design, you can improve stability. Microsoft Azure Well-Architected Framework includes recommendations for improving the quality of the platform or a specific workload. 
-	Automate remediation. Some design improvements aren't cost-effective, the technical debt can be too costly or complex to improve. In such cases, it might make more sense to automate remediation and reduce the effect of interruptions.
-	Scale the solution: As systems design and automated remediation are improved, those changes can be scaled across the environment through the service catalog. Publish optimized platforms and solutions in your Azure Managed Application Center to easily reuse them for other workloads or external customers.
-	Continuous improvement: Collecting feedback from users, administrators and customers will gather valuable information for the next system review. Collecting and visualize critical system logs and performance data are also important. Both the feedback and the data collected will be used as a foundation when making new decisions about future system improvements. 

The following table shows tools used for workload-specific management. 

| Tool | Description | Link to more information |	
| -----|-------------|--------------------------|	
| Application Insights | Advanced application monitoring with dependency mapping, application dashboard, application map, usage, and deep tracking. | [More information at Microsoft Docs](https://docs.microsoft.com/azure/azure-monitor/app/app-insights-overview) |	

