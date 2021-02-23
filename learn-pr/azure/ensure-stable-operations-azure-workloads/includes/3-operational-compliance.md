## Operational compliance
This discipline is the cornerstone for maintaining the balance between security, governance, performance, and cost. Effective operational compliance requires consistency in a few critical processes:
-	Resource consistency. If all resources are organized the same way and tagged the same way, other management tasks become more manageable. 
-	Environment consistency. If all landing zones are organized the same way, both management and troubleshooting become much more manageable. 
-	Resource configuration consistency. As with resources and landing zones, it is crucial to monitor resource configuration. If a configuration setting is changed, it can trigger an automation job to restore the environment. 
-	Update consistency. All updates to the environment should be done in a scheduled, controlled, and possibly automated way. Controlled change management will reduce unnecessary outages and troubleshooting. 
-	Remediation automation. Automation for quick remediation of common incidents is a great way to increase customer satisfaction and minimize outages. Known issues should be fixed by their root cause. But often fixing the root cause is a long going process, and automation is a quick fix.   

This discipline can be fulfilled per workload, for example, in one of your landing zones.  

The following table lists some of the operation and compliance discipline tools in Azure. Remember that all of these tools don't need to be part of the default management baseline. 

| Tool | Description | Link to more information |	
| -----|-------------|--------------------------|	
| Azure Automation Update Management | Management and scheduling of updates. | [More information at Microsoft Docs](https://docs.microsoft.com/en-us/azure/automation/update-management/overview) |	
| Azure Policy | Policy enforcement to ensure environmental and guest compliance. |  [More information at Microsoft Docs](https://docs.microsoft.com/en-us/azure/governance/policy/overview) |	
| Azure Blueprints | Automated compliance for core services. |  [More information at Microsoft Docs](https://docs.microsoft.com/en-us/azure/governance/blueprints/overview) |	
| Desired State Configuration	| Automated configuration on the guest OS and some aspects of the environment. | [More information at Microsoft Docs](https://docs.microsoft.com/en-us/azure/automation/automation-dsc-overview) |	
