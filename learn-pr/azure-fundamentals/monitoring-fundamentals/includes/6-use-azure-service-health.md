Tailwind Traders wants to operationalize their cloud environment. Specifically, their cloud operations team wants to let stakeholders know about upcoming planned downtime in advance.  They also want their solution architectures to be forewarned about Microsoft's plans to sunset services so they can rearchitect their software products accordingly.

Furthermore, when outages do happen, they want to quickly ascertain whether the issue is specific to their services or if it's a service interruption affecting many Azure customers. They also want to provide key stakeholders with reports when outages happen explaining how and why the incident occurred, and so on.

## Which service should we choose?

Once again, let's apply the decision criteria we learned about in the previous unit to find the right product.

First, in this scenario, does Tailwind Traders need an analysis of their Azure usage for the sake of optimization?  No. Not in this scenario. In that case, Azure Advisor is not a candidate for this scenario.

Second, in this scenario, does Tailwind Traders want to monitor the health of Azure's services affecting all customers or the resources deployed on Azure? In this scenario, the requirement is to stay abreast of upcoming planned downtime. Furthermore, they want to capture official incident reports. For this reason, Azure Service Health is the strongest candidate to choose for this scenario.

While it's likely that Azure Service Health will be chosen, let's continue evaluating the remaining decision criteria.

Third, in this scenario, does Tailwind Traders want to measure custom events along side other usage metrics? No, measuring custom events is not mentioned as a requirement and is not a consideration in this scenario.

Fourth, in this scenario, does Tailwind Traders want to set up alerts for outages or when autoscaling is about to deploy new instances? Setting up alerts for outages is a requirement in this scenario, but creating alerts for other events like autoscaling are not in scope. Use Azure Service Health to set up alerts specific to Azure outages that affect all Azure customers.  Use Azure Monitor to set up alerts for outages and other events that only affect your specific resources.

In this scenario, Azure Service Health is the correct option to choose.