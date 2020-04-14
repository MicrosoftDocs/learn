We started out by talking about how to ensure you are in control of your consumption as well as optimize it. Here are some of the key aspects that were covered:

- Tracking cloud spend: the importance of gathering and looking at cloud consumption data to understand your cloud spend.
- Organizing to optimize: the relevance of a subscription and resource group hierarchy and how tags can further help provide various dimensions.
- There are several possibilities to optimize IaaS costs: right-sizing, reducing runtime hours, and compute cost discounts.
- Some examples were shown to optimize PaaS costs: for example, using Azure SQL Database elastics pools to optimize Azure SQL costs or Azure Blob storage tiering to optimize Azure Storage costs.

Next, we covered the operational insights you could gain from understanding and implementing monitoring and analytics. We determined that there are various levels on which we can apply monitoring.

- Monitoring is the act of collecting and analyzing data to determine the performance, health, and availability of your business application and the resources that it depends on.
- There are various depths of monitoring. Core monitoring covers aspects close to the Azure platform such as activity logging, cloud services health, and metrics and diagnostics.
- Deep infrastructure monitoring allows you to gather information besides what the Azure fabric can provide. For typical IaaS workloads, we can monitor at the network or operating system level.
- Deep application monitoring takes it even further by gathering metrics and diagnostics information close to the application, allowing you to identity performance issues, usage trends, and overall availability information.

We wrapped up by discussing that there are various ways to automate tasks to improve your operational capabilities. Here are some of the key things we covered:

- **Automating the deployment of resources can take two different approaches:** imperative (scripting) or declarative (templates).
- **After the VM is deployed, we can look at how to customize it.** Either by using custom images and thus remove the need for customization in the first place. Or by running a script post deployment.
- **Automation of Azure tasks:** Azure Automation can help with installing updates or shutting down virtual machines on a schedule.
- **Automation lab environments:** Azure DevTest Labs takes automation one step further by providing an easy-to-use interface that allows you to use various automation capabilities like images or shutting down VMs without having to worry about the actual implementation of those tasks.
