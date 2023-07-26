The Tailwind Traders e-commerce website is experiencing intermittent errors, and the team is unsure of the cause. Because of the nature of the errors, the team suspects that it's either a database or caching issue. What are the circumstances surrounding the errors? Does it happen only during peak usage times? What is the state of the team's Azure SQL instance? What is the state of its Redis caching server? How can it trace the issues to a root cause?

## Which service should you choose?

As in the preceding unit, apply the decision criteria that you learned about earlier to find the right option.

First, in this scenario, does Tailwind Traders need an analysis of its Azure usage for the sake of optimization? No, optimization isn't the team's objective in this scenario, so Azure Advisor isn't a candidate.

Second, in this scenario, does Tailwind Traders want to monitor the health of Azure services that affect all customers or the resources deployed on Azure? Because this issue happens intermittently, it's unlikely to affect an entire Azure region or service. It's more likely that a logic issue exists somewhere in their e-commerce website code, or another issue is causing database failures or caching locks. In this scenario, the team could use Azure Monitor to pinpoint a specific user session and look at the performance of each service that's involved in the issue.

Third, in this scenario, does Tailwind Traders want to measure custom events alongside other usage metrics? Yes. Software developers can send additional information about the state of the web application via Application Insights to help locate the root cause of the issue. Application Insights relies on the Azure Monitor platform to store custom event information.

Fourth, in this scenario, does Tailwind Traders want to set up alerts for outages or for when autoscaling is about to deploy new instances?  No, alerting isn't their objective in this scenario.

Azure Monitor is the best option for helping Tailwind Traders track this intermittent issue. The team can use a wealth of tools to help it gain insight into the application's performance at a high level and dive deep into specific issues.
