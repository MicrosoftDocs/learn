Tailwind Traders' ecommerce website is experiencing intermittent errors and they're unsure of the cause.  Given the nature of the errors, they suspect it's either a database or caching issue. What are the circumstances surrounding the errors? Does it happen only during peak usage times? What is the state of their Azure SQL instance? What is the state of their Redis caching server? How can they trace down the issues to a root cause?

## Which service should we choose?

Just like we did in the previous unit, let's apply the decision criteria we learned about in the previous unit to find the right option.

First, in this scenario, does Tailwind Traders need an analysis of their Azure usage for the sake of optimization? No, optimization is not their objective in this scenario, so Azure Service Health is not a candidate.

Second, in this scenario, does Tailwind Traders want to monitor the health of Azure's services affecting all customers or the resources deployed on Azure? Given that this issue happens intermittently, it's unlikely that it affects an entire Azure region or service.  It's more likely that there's a logic issue somewhere in their ecommerce website code, or some other issue causing database failures or caching locks.  In this scenario, Azure Monitor could be used to pinpoint a specific user session, and look at the performance of each service involved in the issue to identify the underlying issue.

Third, in this scenario, does Tailwind Traders want to measure custom events along side other usage metrics? Yes, software developers can send additional information about the state of the web application via Application Insights to help locate the root cause of the issue.  Application Insights relies on the Azure Monitor platform to store custom event information.

Fourth, in this scenario, does Tailwind Traders want to set up alerts for outages or when autoscaling is about to deploy new instances?  No, alerting is not their objective in this scenario.

Azure Monitor is the best option for helping Tailwind Traders track down this intermittent issue.  They can use a wealth of tools to help them gain insight into the application's performance at a high level and dive deep into specific issues.