In this exercise, you review a few common blockers to find the most applicable getting started guide to overcome the blockers. This exercise will focus all of the various points of guidance from the Cloud Adoption Framework into manageable, actionable steps.

## Getting started guides

The Cloud Adoption Framework spans the entire cloud adoption lifecycle. Throughout that lifecycle you may use a variety of methodologies, which are each designed to help a specific role deliver a defined function. But when you are dealing with an adoption blocker, there isn't time to mature along all of those potential roles and methodologies. The getting started guides pull out the actionable tasks and deliverables from each relevant methodologies to help a smaller team deliver results faster.

Those guides categorize blockers into the following areas on the [getting started help page](https://docs.microsoft.com/azure/cloud-adoption-framework/get-started/help?azure-portal=true):

- **Establish teams:** Depending on your adoption strategy and operating model, you might need to establish a few teams. This section helps you get those new teams started or redistribute duties if a dedicated team isn't needed.
- **Improve controls:** As adoption of the cloud grows, you need a solid operating model to ensure wise decisions and proper organizational change. Align people and improve operations to develop your cloud operating model.
- **Accelerate adoption:** Cloud adoption requires technical change, but to digitally transform with the cloud, it requires more than just IT. Use these guides to start aligning various teams to accelerate migration and innovation efforts.
- **Align foundation:** Your company's cloud is built on a set of foundational decisions that can impact all cloud-based outcomes. This guide and conceptual information can help you make core decisions and document them.

## Scenario 1: The Chief Information Officer is concerned with progress

In the previous unit the Tailwind Traders team was considering migrating two datacenters to avoid costly contract renewals and move to modern operating model in the cloud. A migration team has been assembled consisting of a project manager, central operations/infrastructure team, and an IT manager.

In the last three months, the team has migrated a few hundred virtual machines (VMs) to Azure. They've retired 30 percent of the VMs in the existing datacenter. To the team, it feels like they are ahead of schedule, but they haven't retired any production hosts yet. As the deadline for this project rapidly approaches, the Chief Information Officer (CIO) has begun to express concerns with progress towards retiring the physical infrastructure in the existing datacenters. Unfortunately, the team doesn't have a clear dependency map to show the hosts for which each VM and when a host is no longer needed.

This is a common experience for customers who are new to cloud migration. Engaging an experience partner can help with these concerns. As can proper planning and data-driven decisions. The getting started guide on [accelerating migration](https://docs.microsoft.com/azure/cloud-adoption-framework/get-started/migrate?azure-portal=true) will help the Tailwind Traders team through this concern. In particular, that guide will help the team create a data-driven dialog with leadership around stakeholder expectations and the general strategy. It will also help the team collect data on the overall portfolio and map that data to actionable cloud adoption plans.

## Scenario 2: Cost misalignment

The Tailwind Traders team has gotten their migration factory processes running smoothly. The finance director recently joined the team to review the budget and overall progress. That meeting didn't go as expected. Progress towards business objectives was well received. But, the actual cloud costs are rising at a much higher pace than expected. Updated forecasts suggest that the final costs of hosting in the cloud will be significantly higher than expected.

As cloud adoption scales, customers commonly experience issues related to proper controls. By accelerating the migration effort, the migration team has skipped important steps around governance and establishing proper guard rails. Cost is the first indicator of this missed step. Fortunately, it's the easiest to get back under control.

The getting started guide on [managing cloud costs](https://docs.microsoft.com/azure/cloud-adoption-framework/get-started/manage-costs?azure-portal=true) is the best starting point for this common blocker. That article outlines a series of best practices to quickly optimize enterprise costs and resolve the finance director's concerns. But it then builds on those best practices by establishing recurring processes to minimize budgetary surprises in the future.

## Scenario 3: Operations support

When a migration results in a production workload being hosted in the cloud, the business now takes a dependency on the operations of those cloud assets. For our friends at Tailwind Traders, they didn't account for this dependency. It was just assumed that the central operations team would use their existing tools and processes to manage operations. That assumption may prove accurate.

Before operational management processes could be kicked off, the CIO asked a few basic questions. Since the team didn't have an answer readily available, she advised that production traffic remain with the current datacenter until the team knew the answers to the following:

- We can stick with our existing processes, but should we? Is that the best thing for our business, or do we need a dedicated cloud operations team?
- As we democratize decisions and empower workload teams to drive innovation, how do those teams interact with the operations team?
- What services are included in our operations baseline for all workloads?
- What things can a workload team add on to go deeper into operations monitoring and optimization?
- Are we capitalizing on the advanced operations built into the Azure platform?
- What guard rails will be in place to ensure that all workload teams meet best practices for stable operations?

You don't need to change how you operate to adopt the cloud. But, the team should be able to answer these basic operations management questions during any migration of a full datacenter. Transitioning to an operations team after migration is often a blocker for migration efforts. The getting started guide on [building a cloud operations team](https://docs.microsoft.com/azure/cloud-adoption-framework/get-started/team/cloud-operations?azure-portal=true) walks through nine steps to answer each of these questions and determine whether you need a dedicated cloud operations teams.
