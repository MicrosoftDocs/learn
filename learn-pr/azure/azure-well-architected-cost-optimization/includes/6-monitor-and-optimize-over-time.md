| :::image type="icon" source="../media/goal.svg"::: Keep adjusting your spending as your workload grows and changes. |
| :----------------------------------------------------------------------------------------------------------------------------- |

What was important yesterday might not be important today. As you learn more from running workloads in production, expect changes. Your setup, business needs, workflows, and even your team might shift. You might need to tweak how you build and release software. External factors might also change, like the cloud platform, its resources, and your agreements.

Keep an eye on how changes affect your costs. Check in regularly to see if your return on investment (ROI) is trending in the right direction, and adjust your goals or requirements if needed.

**Example scenario**

Contoso Air provides a baggage tracking solution for airlines. The workload is hosted in Azure and runs on Azure Kubernetes Service (AKS) with Azure Cosmos DB for its database and uses Azure Event Hubs for messaging. The workload is deployed in both the West US and East US regions.

## Track and monitor your spending

**Use a cost tracking system to regularly review how much you're spending on resources, data, and support. If you have underused resources, think about shutting them down, replacing them, or reworking them to be more efficient.**

Understanding where your money goes is the first step to controlling it. By tagging resources, classifying expenses, and setting up alerts, you can track spending across teams, services, and environments. 

This visibility helps you catch unexpected charges early, support showback or chargeback models, and make smarter decisions about where to cut or invest.

*Contoso's challenge*

- The workload team has always stayed under budget, so reducing costs hasn't been a focus.

- But next year, they're planning to boost the workload's reliability, which means higher Azure costs. That could push them over budget, so they're thinking about asking for a bigger budget to cover it.

*Applying the approach and outcomes*

- Before the team asks for more budget, they decide to take a closer look at their current Azure and support costs to see if there's any room to save. They dig into the cost breakdowns by resource, resource group, and tags by using their cost tracking system. They find unexpected spending.

- The team finds some virtual machines (VMs) still running that were used for an old build system that they don't need anymore. There's also old data sitting in Azure Storage that could be moved to a cheaper tier. On top of that, they're paying for a support contract that includes consult hours, but they haven't been using them.
- The team optimizes their Azure costs by deleting the unused VMs and moving the old data to Archive storage. They begin working more closely with their cloud provider to make good use of their consulting services.
- They add a recurring task to their backlog to regularly review and optimize their workload costs going forward.

## Tune your workload continuously

**Continuously adjust architecture design decisions, resources, code, and workflows based on ROI data.**

Cloud environments evolve, and so should your architecture. Review your metrics, performance, billing, and feature usage regularly. You might find small tweaks that save money and make things run smoother. Even small adjustments can add up to big savings over time.

*Contoso's challenge*

- Since the team has stayed under budget historically, they haven't looked at other ways to do things. Instead, most of their planning focused on building new features.

- But after finding waste during their first cost review, they decided to take a closer look at the rest of their setup to find more ways to optimize.

*Applying the approach and outcomes*

- The team realizes that they're putting too many resources into low-priority flows. They can scale back on the throughput without disrupting performance. Instead of over-preparing for peak times, they'll switch to a queue-based load leveling system.

- They also notice that their compute platform now includes a new feature in their chosen SKU that replaces some of the authentication code. Using this feature means less code to maintain and test.

## Keep your cloud environment tidy

**Make it a habit to regularly check for unused resources or old data in your cloud setup and clean them out. Over time, these components that were once useful can stick around and quietly accrue costs. Keep your environment clean to help keep things efficient and save money.**

Shutting down resources that you're not using and deleting data that you don't need frees up budget for more important work.

*Contoso's challenge*

- Over the past year, the team created several temporary environments for testing new features and running performance experiments. Many of these environments were never cleaned up.

- They discovered multiple Event Hubs namespaces and Azure Cosmos DB containers that haven't received any traffic in months but are still incurring storage and throughput costs.
- Old baggage tracking data from previous airline partners is still stored in hot-access tiers, even though it's no longer needed for operations or compliance.
- The team lacks a regular process for identifying and removing unused resources, so clutter continues to build up unnoticed.

*Applying the approach and outcomes*

- The team sets up a monthly cleanup routine that includes tagging resources with expiration dates and reviewing usage metrics to flag idle services.

- They decommission unused AKS node pools, delete inactive Event Hubs, and consolidate Azure Cosmos DB containers where possible.
- For historical baggage data, they implement lifecycle policies to automatically archive or delete data based on age and access patterns.
- They also review their resource SKUs and downgrade services that are over-provisioned.
- These actions help them reduce unnecessary spend, improve operational efficiency, and keep their cloud environment clean and manageable.
