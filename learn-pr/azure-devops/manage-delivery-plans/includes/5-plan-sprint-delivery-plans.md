Here, you'll create a delivery plan and use it to plan a sprint in Azure DevOps.

The Tailspin team is eager to see how Delivery Plans is going to work. They already have two teams with sprints set up in Azure DevOps, so now they can review and optimize the work schedules.

To do this, you:

> [!div class="checklist"]
> * Create a delivery plan.
> * Add team sprints and milestones.
> * Rearrange work items to fit the overall schedule.

## Create a delivery plan

You create a Delivery Plan from the **Delivery Plans** tab of Azure Boards. You can create as many delivery plans as you need to manage different aspects of your organization.

1. From Azure DevOps, navigate to your project.
1. Under **Boards**, select **Delivery Plans**.

    > [!IMPORTANT]
    > Ensure that you select **Delivery Plans** and not **Plans**.

1. Select **New plan**.
1. In the form, enter these fields:
    * **Name**: _Space Game Delivery Plan_.
    * Select the **Backlog items** backlog for the **Space Game Web Team**.
    * Add the **Space Game Engine Team's Backlog items** backlog using the **Add team** option.

    The Web team and the Engine team share a common set of backlog items.

    :::image type="content" source="../media/5-create-delivery-plan.png" alt-text="Screenshot of the final delivery plan settings.":::

1. Select **Create**.

    > [!NOTE]
    > The team project generated for this module uses the *Scrum* process, not the *Basic* process used in other modules in this learning path. While the Basic process uses *Issues*, the Scrum process uses *Backlog items*, which are functionally the same for the purposes of this module. You can use Delivery Plans with either process.

### Add schedule milestone markers

Milestone markers can be added to the delivery plan as reference points. They help you plan work within the context of significant or external dates. Let's add a few markers now. To do so:

1. Select your delivery plan.
1. In the top right toolbar, select **Settings**, and then, on the **Plan settings** pane, select **Markers**.

    :::image type="content" source="../media/5-configure-plan-settings.png" alt-text="Screenshot of selecting the Markers tab from the delivery plan settings.":::

1. From the **Markers** tab, select **Add marker**.
1. In the form, enter these fields:
    * **Date**: Select a date one week from now
    * **Label**: Cliffchella
    * **Color**: Red

    :::image type="content" source="../media/5-add-marker.png" alt-text="Screenshot of adding the milestone marker for the Cliffchella event.":::

1. Repeat the process to add markers with labels, dates, and colors:
    * **Beta**: five weeks from today (blue)
    * **Annual company party**: six weeks from today (green)
1. Select **Save**.
1. Use the **Scroll calendar** and **Zoom out** controls to bring all markers into view.

    :::image type="content" source="../media/5-show-all-markers.png" alt-text="Screenshot of bringing all four markers into view.":::

1. Select the **Beta** marker at the top of the design plan. A solid line shows the boundary of the beta milestone.

    :::image type="content" source="../media/5-analyze-milestones.png" alt-text="Screenshot of selecting the Beta milestone to show the boundary of the beta milestone.":::

### Optimize the work schedule

1. Notice that there's a work item for the Web team to **Integrate with beta DB** that's scheduled to be completed before the beta will be ready. This will be a problem because this work item is dependent on that beta.
1. Drag the integration work item from **Sprint 3** to **Sprint 4** to ensure that its dependency will be available.
1. This change opens a significant amount of bandwidth in **Sprint 3**. Because that time is now available for productive work, drag the two **Fix** work items from **Sprint 4** back into **Sprint 3**.

    :::image type="content" source="../media/5-adjust-work-schedule.png" alt-text="Screenshot of the direction in which to move work items.":::

Your final sprint plan should look similar to this:

:::image type="content" source="../media/5-optimized-work-schedule.png" alt-text="Screenshot of the optimized work schedule.":::

Although the team has made some adjustments, they haven't addressed all the dependency issues that are identified in the delivery plan. In the next unit, they learn more about dependencies and how to resolve the issues that can occur in the schedule.  
