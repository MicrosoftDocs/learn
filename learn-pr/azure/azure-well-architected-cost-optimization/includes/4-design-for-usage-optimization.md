| :::image type="icon" source="../media/goal.svg"::: Get the most out of your tools and operations. Make sure they meet both functional and nonfunctional requirements of the solution. |
| :----------------------------------------------------------------------------------------------------------------------------- |

Different services come with different features and price points. After you pick a plan, don't let those features go to waste. Find ways to use them fully and get your money's worth. Also, keep an eye on your billing models. It's smart to check if there's a better billing model that fits how you're actually using the service.

**Example scenario**

Contoso University hosts a commercial off-the-shelf (COTS) system that helps faculty manage courses and lets students register. It's connected to a cloud-based education management system that they plan to fully switch to in a few years. For now, they want to optimize costs on the custom integration parts.

The technology solution of the COTS offering is generally treated like a black box, except for its database, which runs on Azure Database for MySQL. The custom integration is an Azure durable function that runs fanned out on a Standard Azure App Service plan that used to host the university's website, but doesn't anymore. The durable function is a Python app that uses Azure Storage. It syncs data every night from the MySQL database to the cloud-based API.

## Use the full value of your resources

**Buy only what you need, and use everything that you're paying for.**

Some resource SKUs come with built-in features for performance, security, or reliability. If you're paying for them, make sure you're using them. And if you don't need those features, pick a simpler SKU to save money.

*Contoso's challenge*

- The durable function runs on a Standard App Service plan that was originally sized for a public website, but that website has since been retired.

- The team never re-evaluated the SKU, so they're still paying for features and capacity that they don't use.
- They're unsure which features are actually needed for the integration workload.

*Applying the approach and outcomes*

- The team reviews the App Service plan and realizes the integration doesn't need high availability or autoscaling.

- They move the function to a lower-tier plan that still supports durable functions but costs much less.
- They also check their MySQL SKU and confirm that it's rightsized for the current workload.
- These changes help them reduce costs without affecting performance or reliability.

## Use commitment-based discounts where it makes sense

**Plan ahead to save more. If you know that you'll be using certain resources for a while, commit to them.**

Reserved instances and savings plans can lower costs significantly. Use commitment-based resources when you're building new features, setting up extra environments, or improving performance and reliability.

*Contoso's challenge*

- The MySQL database and App Service plan have been running steadily for over a year.

- The team has been using pay-as-you-go pricing the whole time.
- They didn't realize they could save money by committing to longer-term usage.

*Applying the approach and outcomes*

- The team reviews usage patterns and confirms that the services are stable and long-term.

- They purchase reserved capacity for the MySQL database and a savings plan for App Service.
- These commitments reduce their monthly costs and make budgeting easier.
- They also set a reminder to review usage again before the commitment period ends.

## Scale smart with demand

**Adjust capacity based on what you actually need.**

Instead of provisioning for peak usage all the time, scale up when demand increases and scale down when it drops. This approach keeps your costs aligned with real usage.

*Contoso's challenge*

- The integration function runs every night, but the App Service plan always stays active.

- They're paying for compute resources that sit idle most of the day.
- They haven't explored options for scaling down or pausing the service when it's not in use.

*Applying the approach and outcomes*

- The team configures the App Service plan to scale down during off-hours.

- They explore moving the function to Azure Container Apps or the Azure Functions Consumption plan, which can scale to zero.
- They also set up alerts to monitor usage and adjust scaling rules as needed.
- These changes help them align costs with actual usage and reduce waste.
