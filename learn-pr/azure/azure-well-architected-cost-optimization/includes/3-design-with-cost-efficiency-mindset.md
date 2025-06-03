| :::image type="icon" source="../media/goal.svg"::: Buy only what you need to get the most return on investment. |
| :----------------------------------------------------------------------------------------------------------------------------- |

Every architectural decision affects your budget, such as whether you build or buy, what tools you use, or how you license and train. It's important to weigh those options and make trade-offs that still meet your app's needs without overspending.

**Example scenario**

Contoso Manufacturing runs a custom-built warehouse management system (WMS) that handles its four warehouses across South America. They want to update and move the WMS to the cloud. They're deciding between lifting and shifting the current setup or building something new with modern tools. Leadership wants to keep costs under control, so the team needs a plan that balances cost with performance.

The WMS solution is a .NET application that runs on Internet Information Services (IIS) and uses SQL Server for its databases.

## Understand the full cost of your design

**Establish a cost baseline that includes the cost for technology, automation, acquisition, training, and change management. Your design should meet all the key requirements including return on investment (ROI) and still be flexible enough to grow with your needs.**

Keeping ROI in mind helps avoid overbuilding something that ends up costing more than it's worth.

*Contoso's challenge*

- The engineering team at Contoso is excited to move their warehouse system to the cloud, just like other teams have done.

- They know the current app has some technical debt, so they're planning to rewrite much of the application code and switch to newer cloud-native tools.
- The engineering team wants to redesign everything into microservices and run it on Azure Kubernetes Service (AKS), which is a new and exciting platform for them.

*Applying the approach and outcomes*

- The team is excited about doing a significant redesign during the cloud move, but they know that they need to maintain the workload's ROI. So they must stick with tools that they already know and avoid major rewrites that require extra engineering team training.

- The workload team takes a practical approach to designing the system. They want it to be cost-effective, meet expectations, and avoid overcomplicating things. To keep the ROI in check and make the migration smooth, they decide to go with an equivalent solution in the cloud, such as Azure App Service.

- During the migration, the team plans to clean up some of the technical debt that makes sense to tackle now. That way, after everything's running on Azure, they'll be in a better spot to keep improving the platform while still keeping the ROI in mind when making those choices.

## Design your architecture to support cost guardrails

**Set up cost limits in your architecture to keep spending within a safe range, and ensure that your team follows those limits.**

Enforcing limits helps avoid surprise charges and makes sure you only use what you actually budget for.

*Contoso's challenge*

- The current system doesn't have cost guardrails, but since it rarely changes, no one's pushed to add them.

- The HCI environment owners have set a resource cap, so the workload can't use more compute or storage than allowed.
- The team's worried that moving to the cloud could lead to unexpected costs, and they're not sure how to avoid that.

*Applying the approach and outcomes*

- The team learns how to use Microsoft Cost Management solutions.

- They plan to set scale limits for the App Service plans.
- They plan to set up a deny policy to block certain expensive virtual machine SKUs from being used.
- They plan to add automation to save on storage. Older or less-used data will automatically move to cheaper storage tiers like cold or archive. This kind of automation wasn't possible in their old HCI environment.

## Optimize your deployment environments

**Use different setups for each stage of development, and only run as many environments as you need. Production should be where most of your costs go.**

You can save money by understanding that not all environments need to match production. Nonproduction environments can have different features, SKUs, instance counts, and even logging.

You can also save costs by creating preproduction environments only when you need them, and shutting them down when you're done.

*Contoso's challenge*

- Contoso sets up all their environments, including development, test, preproduction, and production, the same way.

- Even environments that sit idle most of the time arere using full-scale resources, driving up costs.
- They also don't have automation in place to turn environments on or off based on actual usage, which leads to a lot of waste.

*Applying the approach and outcomes*

- Development moves to smaller, cheaper virtual machines that only run when needed.

- Test environments are set to autoscale, but only during active testing times.
- Preproduction setups are created on-demand by using templates and automatically shut down after use.
- They add monitoring and automation to make sure environments only run when they're actually being used.
- By rightsizing their environments and automating when they're active, Contoso cut cloud costs significantly, without sacrificing speed or quality in their software delivery.