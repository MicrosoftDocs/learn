Tailwind Traders wants to operationalize its cloud environment. Specifically, its cloud operations team wants to let stakeholders know about upcoming planned downtime in advance. The team also wants its solution architects to be forewarned about any Microsoft plans to sunset services so it can rearchitect its software products accordingly.

When outages do happen, the team wants to quickly ascertain whether the issue is specific to their services or a service interruption that affects many Azure customers. The team also wants to provide key stakeholders with reports that explain how and why the incident occurred.

## Which service should you choose?

Again, apply the decision criteria you learned about earlier to find the right product.

First, in this scenario, does Tailwind Traders need to analyze its Azure usage for the sake of optimization?  No, so Azure Advisor isn't a candidate for this scenario.

Second, does Tailwind Traders want to monitor the health of Azure services that affect all customers or the resources deployed on Azure? In this scenario, the requirement is to stay abreast of upcoming planned downtime. Additionally, the team wants to capture official incident reports. For this reason, Azure Service Health is the strongest candidate to choose for this scenario.

Although it's likely that you would choose Azure Service Health, let's continue evaluating the remaining decision criteria.

Third, in this scenario, does Tailwind Traders want to measure custom events alongside other usage metrics? No, measuring custom events isn't mentioned as a requirement and isn't a consideration in this scenario.

Fourth, in this scenario, does Tailwind Traders want to set up alerts for outages or when autoscaling is about to deploy new instances? Setting up alerts for outages is a requirement in this scenario, but creating alerts for other events such as autoscaling aren't in scope. Use Azure Service Health to set up alerts that are specific to Azure outages that affect all Azure customers. Use Azure Monitor to set up alerts for outages and other events that affect only your specific resources.

In this scenario, Azure Service Health is the correct option to choose.
