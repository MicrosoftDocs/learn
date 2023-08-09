
In this demonstration, you'll investigate Stages.

## Steps

Look at the other section in our release pipeline: Stages.

1.  Click on **Stage 1,** and in the Stage properties pane, set **Stage name** to **Development** and close the pane.

    :::image type="content" source="../media/stage-name-fb59c679.png" alt-text="Screenshot of stage creation and properties pane.":::


> [!NOTE]
> *Stages can be based on templates. For example, you might deploy a web application using node.js or Python. For this walkthrough that won't matter because we're focusing on defining a strategy.*

2.  To add a second stage, click **+Add** in the Stages section and note the available options. You have a choice to create a new stage or clone an existing stage. Cloning a stage can help minimize the number of parameters that need to be configured. But for now, click **New stage**.

    :::image type="content" source="../media/add-a-stage-3d64b72d.png" alt-text="Screenshot of adding a second stage and available options.":::


3.  When the **Select a template** pane appears, scroll down to see the available templates. We don't need any of these, so click **Empty job** at the top, then in the Stage properties pane, set **Stage name** to **Test**, and then close the pane.

    :::image type="content" source="../media/select-template-8c994184.png" alt-text="Screenshot of the template selection and available templates.":::


4.  Hover over the **Test** stage and notice that two icons appear below. These are the same options that were available in the menu drop-down that we used before. Click the **Clone** icon to clone the stage to a new stage.

    :::image type="content" source="../media/clone-icon-4b070b1a.png" alt-text="Screenshot of clone icon option to close stages.":::


5.  Click on the **Copy of Test** stage, and in the stage properties pane, set **Stage name** to **Production** and close the pane.

    :::image type="content" source="../media/three-stages-development-test-production-57000c3c.png" alt-text="Screenshot of three stages. Development, test, production.":::


We've now defined a traditional deployment strategy. Each stage contains a set of tasks, and we'll look at those tasks later in the course.

> [!NOTE]
> The same artifact sources move through each of the stages.

The lightning bolt icon on each stage shows that we can set a trigger as a pre-deployment condition. The person icon on both ends of a stage shows that we can have pre and post-deployment approvers.

## Concurrent stages

You'll notice that now, we have all the stages one after each other in a sequence. It's also possible to have concurrent stages. Let's see an example.

6.  Click the **Test** stage, and on the stage properties pane, set the **Stage name** to **Test Team A** and close the pane.
7.  Hover over the **Test Team A** stage and click the **Clone** icon that appears to create a new cloned stage.
8.  Click the **Copy of Test Team A** stage, and on the stage properties pane, set **Stage name** to **Test Team B** and close the pane.
9.  Click the **Pre-deployment conditions** icon (that is, the lightning bolt) on **Test Team B** to open the pre-deployment settings.

    :::image type="content" source="../media/pre-deployment-conditions-9bf2a1cc.png" alt-text="Screenshot of pre-deployment conditions.":::


10. In the Pre-deployment conditions pane, the stage can be triggered in three different ways:

    :::image type="content" source="../media/pre-deployment-options-4c95c53d.png" alt-text="Screenshot of pre-deployment options pane.":::


The stage can immediately follow Release. (That is how the Development stage is currently configured). It can require manual triggering. Or, more commonly, it can follow another stage. Now, it's following **Test Team A,** but that's not what we want.

11. Choose Development from the **Stages** drop-down list**,** uncheck **Test Team A,** and then close the pane.

    We now have two concurrent Test stages.

    :::image type="content" source="../media/concurrent-test-stages-fbe8e9e0.png" alt-text="Screenshot of multiple test stages, two as example.":::


## Stage versus Environment

You may have wondered why these items are called **Stages** and not **Environments**.

In the current configuration, we're using them for different environments. But it's not always the case. Here's a deployment strategy based upon regions instead:

:::image type="content" source="../media/region-based-deployment-strategy-1821beef.png" alt-text="Screenshot of region-based deployment strategy.":::


Azure Pipelines are configurable and support a wide variety of deployment strategies. The name **Stages** is a better fit than **Environment** even though the stages can be used for environments.

Let's give the pipeline a better name and save the work.

12. At the top of the screen, hover over the **New release pipeline** name and click it to edit the name when a pencil appears. Type **Release to all environments** as the name and hit enter or click elsewhere on the screen.

    :::image type="content" source="../media/change-the-pipeline-name-bc059674.png" alt-text="Screenshot of change the pipeline name.":::


13. For now, save the environment-based release pipeline you've created by clicking **Save.** Then, **click OK** in the Save dialog box.
