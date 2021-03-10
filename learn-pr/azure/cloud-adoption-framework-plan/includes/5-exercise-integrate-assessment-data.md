In this exercise, you'll pull in data from the prior assessment step to populate the templated cloud adoption plan. That data driven plan will help manage the work related to migration and deployment of new innovative workloads.

## Customize your cloud adoption plan

It's tempting to build a plan that accounts for all workloads and every asset needed in the cloud. If your team doesn't have well established processes for cloud adoption and extensive experience with your chosen cloud provider, such a plan could create false perceptions and inject unnecessary risk into your digital transformation program.

Instead, customize and test your plan using a small set of well-defined workloads to create your first wave of cloud adoption. In this unit, we'll walk through how Tailwind Traders build out their first adoption plan. That initial plan was developing using the following steps:

1) Add your first wave of workloads
2) Associate dependent assets with each workload
3) Prioritize workloads
4) Evaluate migration tasks as a team
5) Estimate tasks & attempt to complete them in the estimated time
6) Test the deployed workloads
7) Retrospective to refine processes and estimates
8) Apply your initial learning to a more comprehensive adoption plan

## Open your cloud adoption plan template

In the first unit of this module, you created a backlog in Azure DevOps using the cloud adoption plan template. The last step of that unit suggested saving/bookmarking the URL to the "Epic hierarchy view" of that project plan. Use that link (or the steps from the first unit) to open your backlog or project plan that was created by that template.

## Add workloads

Lets add some workloads to the project plan. At the end of the last unit, we identified a series of workloads from the Tailwind Traders' digital estate. When building real world plans, we suggest targeting 10 workloads for your first migration. But for brevity, we'll plan for our first wave to include the six workloads identified in the last unit.

> [!NOTE]
> Many would argue that virtual desktop and backup solution are technology platforms & not workloads. But, during migrate efforts that distinction will have little bearing on how the collection of assets is deployed to the cloud.

**Open the form to add a workload** Expand the Cloud Migration epic in your backlog to see all workloads slated for migration. Click on the ellipse to the right of the the Cloud Migration epic to see the menu. In the pop-up menu, hover on 'Add link'. Then click on 'New Item'.

:::image type="content" source="../media/customize-plan-new-workload.png" alt-text="Add workload (feature) menu" border="false":::

**Add a new workload in the plan** The first form will ask for some basic data to add this workload to your plan. The questions will be in Azure DevOps terms, not workload terms. All workloads to be migrated should be added to the backlog as 'Child' elements of the 'Cloud Migration' epic. All workloads are entered as features, given the amount of work required to migrate all of the dependent assets supporting a workload. Enter the workload name to complete this form. For this exercise, enter 'Mobile coupon' as your first workload. Click 'Ok' at the bottom of the form to move to the next step.

:::image type="content" source="../media/customize-plan-create-new-workload.png" alt-text="Create new workload (feature)" border="false":::

**Enter workload data** For these first few workloads, focus on the minimum amount of data that you believe the migration team will need to complete a migration through to production. The name of the workload should carry over from the prior form. Fill in the description box with critical information that should be tagged for all assets associated with this workload, such as, Criticality, Data Sensitivity, Workload tag, Business group, Workload owner, Operations commitment, or other information that should persist throughout the workload's lifecycle. To establish best practices from the beginning, start your first discussion in this form by outlining the testing requirements that would validate successful migration of this workload. Click 'Save and close' to save the workload information.

:::image type="content" source="../media/customize-plan-workitem-new-workload.png" alt-text="New feature form" border="false":::

Repeat these steps for each of the workloads in your first migration wave. For this exercise, create features in the plan to represent each of the six tailwind trader workloads: Mobile coupon, Video shelf, Remote store POS, Employee scheduling, Virtual desktop, and backup solution.

## Add assets

Each of the inventoried assets required to support a workload needs to be added to the plan to manage the actual work. The following process will show how to add each asset under the corresponding workload.

> [!NOTE]
> For simplicity, we will number each asset, instead of providing names for each. In real-world projects, the name and other metadata aspects would need to be recorded to guide the technical efforts.

**Open the form to add a new asset** Expand the 'Mobile Coupon' feature in your backlog. Click on the ellipse to the right of the 'Mobile Coupon' to see the menu. In the pop-up menu, hover on 'Add link'. Then click on 'New Item'.

:::image type="content" source="../media/customize-plan-new-asset.png" alt-text="Add asset (user story) menu" border="false":::

**Add a new asset in the plan** Similar to adding a new workload, the first form will ask for some basic data to add this asset to your plan. All assets to be migrated should be added to the backlog as 'Child' elements of the relevant 'workload' feature. All assets are entered as 'User Stories', since the migration of that asset is a discrete and measurable outcome based on a series of tasks. Enter the assets name to complete this form. For this exercise, enter 'Asset #1' as your first asset. Click 'Ok' at the bottom of the form to move to the next step.

:::image type="content" source="../media/customize-plan-create-new-asset.png" alt-text="Create new asset (user story)" border="false":::

**Enter asset data** The name of the asset should carry over from the prior form. Fill in the description box with critical information about this asset, such as, asset type (VM, Data, App), current network segmentation, known dependencies, asset specific tags, or other information that could help with migration of the asset. To establish best practices from the beginning, start thinking about acceptance criteria from the beginning. Use the 'acceptance criteria' box to fill in details about how and by whom this asset will be tested once its deployed to the cloud. Click 'Save and close' to save the asset information.

:::image type="content" source="../media/customize-plan-workitem-new-asset.png" alt-text="New user story form" border="false":::

## Prioritize workloads

In the 'Epic hierarchy view' of your backlog, you can drag workloads up and down on the list to reflect linear priority & start to establish a sequence of workloads to migrate.

As the number of workloads in your plan grows, this approach may not be robust enough to provide necessary clarity. Click on any workload to open the work item editing form used to add this initial workload. Under the planning section of that form, you can use the field for priority, risk, business value, or time criticality to denote a more lasting value for prioritization.

Most importantly, defining waves of workloads to migrate will establish priority for the work to be completed. On the same form, you can set an iteration for each workload, using the iteration dropdown.

If you use the form to set priority values, remember to click 'Save & close' when you are finished.

:::image type="content" source="../media/prioritize-workloads.png" alt-text="Different waves to record workload prioritization" border="false":::

## Evaluate migration tasks as a team

The Cloud Adoption Plan template deploys a sample workload template to show the various different efforts that a migration may require. Depending on the approach you choose to migrate, the tasks needed may vary.

**Asset migration:** At the core of any migration approach is a simple two step process that must be completed for each asset: Assess compatibility and Migrate the asset. But most teams will also add basic processes to  optimize sizing, configure security and management settings, and document the configuration of that asset. These tasks can be repeated for all assets in the digital estate. The template includes links to instructions for completing each task.

Asset migration is fine for small scale, tactical efforts. But, that approach doesn't scale to meet the needs of sophisticated migrations or adoption efforts, like the one Tailwind Traders needs to complete.

**Workload migration:** To scale these processes, a workload migration may be much more useful. In that approach, you can ignore the tasks associated with each asset in the template. Assets are migrated in bulk using tools like Azure migrate. Assessment, sizing, dependency, testing, and documentation are also completed once for each workload to reduce redundant tasks. As workloads are migrated, existing assets are also decommissioned to retire un-used assets & reduce on-going costs.

Workload migration is much more efficient, but may also hit scale points when the effort begins to focus on thousands of VMs.

**Migration factory:** For the highest scale & most repeatable option, the team will likely build a migration factory as they gain additional experience. The [process improvements section of cloud adoption framework](https://docs.microsoft.com/azure/cloud-adoption-framework/migrate/migration-considerations/?azure-portal=true) provides a number of processes to consider, as the team gains more experience migration workloads.

### Add tasks

Once the team aligns on the tasks required to support your processes, you can begin adding those tasks to each workload and/or asset.

Similar to the steps above, use the ellipse next to any workload or asset to add tasks. The only difference is that you will want to choose 'task' from the 'Work item type' drop down to track the assignments and work associated with this task.

:::image type="content" source="../media/add-task.png" alt-text="Add tasks" border="false":::

If you add tasks directly to a workload, you may also want to add 'user stories' to group the work & help with assignments. Examples of user stories to group work are provided in the template and captured in the image below.

:::image type="content" source="../media/task-grouping.png" alt-text="Group tasks in user stories" border="false":::

## Estimate tasks & attempt to complete them in the estimated time

For each task the team agrees to include, come up with an estimate of time required to complete the work. Enter the estimated time in the 'Original Estimate' text box & click 'Save & close'.

Each day, meet with the team during the first iteration to capture work progress. Update remaining time and completed time in the meeting each day. This will help the team pay close attention to the difficulty of completing each task & help refine estimates for the future. For the first few iterations, practice recording observations about the work being completed in the discussion box to help retain any lessons learned.

> [!NOTE]
> As the team progresses, some of the work they agreed to may appear unnecessary. For the sake of continued learning, try to ensure all tasks are completed during the iteration ot validate those appearances. Then adjust in future iterations. Unless of course an unnecessary task becomes a blocker to delivering on the user story or migration effort.

## Test the deployment

As each asset is deployed, run a test to validate completion & adherence to initial design.

When the final asset for each workload is deployed, validate the architecture, performance, sizing, and most importantly, perform a test of the workload with actual business users whenever possible.

## Retrospective to refine processes and estimates

At the end of your first iteration, come together as a team to discuss what worked and what didn't. Also look at things the team wants to stop doing, keep doing, or do more.

Apply these simple considerations to the list of tasks to include in your next iteration. You can also use the time spent on tasks to inform new estimates from the team.

## Apply your initial learning to a more comprehensive adoption plan

Repeat the steps in this article for your first three iterations to continue learning and refining processes. After a few iterations, the team should have an understanding of the tasks required, the time to require those tasks, & the overall processes that will lead to success across your digital transformation program.

In parallel to completion of each iteration, the project manager(s) should use assessment data from the prior unit to populate the richer plan, including the larger number of workloads and assets required.

As a general rule, project managers should try to load 10 workloads per iteration for the first few iterations. As you complete more retrospectives, it will become clearer how many workloads the team can complete in a two week iteration. For some mature teams, hundreds or even thousands of assets can be migrated in a two week sprint. But testing and production release of the workloads supported by those assets will take more time.

During the first few weeks of initial iteration execution, the majority of your migration project should be able to be loaded, prioritized, assigned to iterations, and estimated. Usually, the accuracy of project duration and timelines stabilizes by the time the third iteration is complete.

## Integrate your digital estate at scale

You can more quickly add workloads, assets, tasks, etc... using the Teams Add-in for Excel. The next steps on the next screen provides an article series that will teach you how to load a large number of workloads and assets using the workload template provided in the initial cloud adoption plan.

## Partner engagement

Microsoft partners who provide CAF approved offers can accelerate the planing and execution of migrations, significantly reducing the amount of recurring work required by the organization. See the [CAF Partner Offer site](https://www.microsoft.com/azure/partners/adopt?filters=migration&azure-portal=true) for offers from experienced partners.
