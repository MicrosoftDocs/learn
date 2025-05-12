| :::image type="icon" source="../media/goal.svg"::: Keep adjusting your spending as your workload grows and changes. |
| :----------------------------------------------------------------------------------------------------------------------------- |

What was important yesterday might not be important today. As you learn more from running workloads in production, expect changes. Your setup, business needs, workflows, and even your team might shift. You might need to tweak how you build and release software. External factors might also change, like the cloud platform, its resources, and your agreements.

Keep an eye on how changes affect your costs. Check in regularly to see if your return on investment (ROI) is trending in the right direction, and adjust your goals or requirements if needed.

**Example scenario**

Contoso Air provides a baggage tracking solution for airlines. The workload is hosted in Azure and runs on Azure Kubernetes Service (AKS) with Azure Cosmos DB for its database and uses Azure Event Hubs for messaging. The workload is deployed in both the West US and East US regions.

## Continuously evaluate and optimize your environment and support costs

**Use a cost tracking system to regularly review how much you're spending on resources, data, and support. If you have underused resources, think about shutting them down, replacing them, or reworking them to be more efficient.**

Reduce costs by using what you actually need. If resources are sitting idle or oversized, think about shrinking them, switching to cheaper options, or removing them altogether. Knowing how pricing works helps you make smarter decisions that match your cost model and avoid unexpected charges.

You might also be able to save some costs by evaluating the use of your support contracts with your technology suppliers and scaling them down.

*Contoso's challenge*

- The workload team has always stayed under budget, so reducing costs hasn't been a focus.

- But next year, they're planning to boost the workload's reliability, which means higher Azure costs. That could push them over budget, so they're thinking about asking for a bigger budget to cover it.

*Applying the approach and outcomes*

- Before the team asks for more budget, they decide to take a closer look at their current Azure and support costs to see if there's any room to save. They dig into the cost breakdowns by resource, resource group, and tags by using their cost tracking system. They find unexpected spending.

- The team finds some virtual machines (VMs) still running that were used for an old build system that they don't need anymore. There's also old data sitting in Azure Storage that could be moved to a cheaper tier. On top of that, they're paying for a support contract that includes consult hours, but they haven't been using them.
- The team optimizes their Azure costs by deleting the unused VMs and moving the old data to Archive storage. They begin working more closely with their cloud provider to make good use of their consulting services.
- They add a recurring task to their backlog to regularly review and optimize their workload costs going forward.

## Continuously tune your workload

**Continuously adjust architecture design decisions, resources, code, and workflows based on ROI data.**

Review your metrics, performance, billing, and feature usage regularly. You might find small tweaks that save money and make things run smoother.

*Contoso's challenge*

- Since the team has stayed under budget historically, they haven't looked at other ways to do things. Instead, most of their planning focused on building new features.

- But after finding waste during their first cost review, they decided to take a closer look at the rest of their setup to find more ways to optimize.

*Applying the approach and outcomes*

- The team realizes that they're putting too many resources into low-priority flows. They can scale back on the throughput without disrupting performance. Instead of over-preparing for peak times, they'll switch to a queue-based load leveling system.

- They also notice that their compute platform now includes a new feature in their chosen SKU that replaces some of the authentication code. Using this feature means less code to maintain and test.

## Optimize your deployment environments

**Use different setups for each stage of development, and only run as many environments as you need. Production should be where most of your costs go.**

You can save money by understanding that not all environments need to match production. Nonproduction environments can have different features, SKUs, instance counts, and even logging.

You can also save costs by creating preproduction environments only when you need them, and shutting them down when you're done.

*Contoso's challenge*

- The workload team is spending more on preproduction than production, which might make sense in some cases, but it feels excessive for this workload.

- They've built preproduction to closely match production, which gives them confidence that things will behave the same.

*Applying the approach and outcomes*

- After the team thinks it through, they decide it's worth taking on a little extra risk to save money by not making every environment exactly the same.

- The team decides to combine a few of the test environments into the same infrastructure and to shut down unused environments overnight.
- The team also finds ways to do more early inner-loop development and testing on local developer workstations.
- These small changes in how they build and test have freed up budget they can now use to invest in automation.
