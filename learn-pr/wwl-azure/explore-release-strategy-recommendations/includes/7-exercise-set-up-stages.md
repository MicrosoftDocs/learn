In this demonstration, you'll investigate Stages.

## Steps

Let's now look at the other section in the release pipeline that we've created: Stages.

1.  Click on **Stage 1,** and in the Stage properties pane, set **Stage name** to **Development** and close the pane.

    :::image type="content" source="../media/stage-name-fb59c679.png" alt-text="Stage name.":::


> [!NOTE]
> *Stages can be based on templates. For example, you might be deploying a web application using node.js or Python. For this walkthrough, that won't matter because we're focusing on defining a strategy.*

2.  To add a second stage, click **+Add** in the Stages section and note the available options. You have a choice to create a new stage or to clone an existing stage. Cloning a stage can help minimize the number of parameters that need to be configured. But for now, click **New stage**.

    :::image type="content" source="../media/add-a-stage-3d64b72d.png" alt-text="Add a stage.":::


3.  When the **Select a template** pane appears, scroll down to see the available templates. For now, we don't need any of these, so click **Empty job** at the top, then in the Stage properties pane, set **Stage name** to **Test**, then close the pane.

    :::image type="content" source="../media/select-template-8c994184.png" alt-text="Select a template.":::


4.  Hover over the **Test** stage and notice that two icons appear below. These are the same options that were available in the menu drop-down that we used before. Click the **Clone** icon to clone the stage to a new stage.

    :::image type="content" source="../media/clone-icon-4b070b1a.png" alt-text="Clone icon.":::


5.  Click on the **Copy of Test** stage, and in the stage properties pane, set **Stage name** to **Production** and close the pane.

    :::image type="content" source="../media/three-stages-development-test-production-57000c3c.png" alt-text="Three stages. Development, test, production.":::


We've now defined a traditional deployment strategy. Each stage contains a set of tasks, and we'll look at those tasks later in the course.

> [!NOTE]
> The same artifact sources move through each of the stages.

The lightning bolt icon on each stage shows that we can set a trigger as a pre-deployment condition. The person icon on both ends of a stage shows that we can have pre and post-deployment approvers.

## Concurrent stages

You'll notice that now, we have all the stages one after each other in a sequence. It's also possible to have concurrent stages. Let's see an example.

6.  Click the **Test** stage, and on the stage properties pane, set **Stage name** to **Test Team A** and close the pane.
7.  Hover over the **Test Team A** stage and click the **Clone** icon that appears to create a new cloned stage.
8.  Click the **Copy of Test Team A** stage, and on the stage properties pane, set **Stage name** to **Test Team B** and close the pane.
9.  Click the **Pre-deployment conditions** icon (that is, the lightning bolt) on **Test Team B** to open the pre-deployment settings.

    :::image type="content" source="../media/pre-deployment-conditions-9bf2a1cc.png" alt-text="Pre-deployment conditions.":::


10. In the Pre-deployment conditions pane, the stage can be triggered in three different ways:

    :::image type="content" source="../media/pre-deployment-options-4c95c53d.png" alt-text="Pre-deployment options.":::


The stage can immediately follow Release. (That is how the Development stage is currently configured). It can require manual triggering. Or, more commonly, it can follow another stage. Now, its following **Test Team A,** but that's not what we want.

11. From the **Stages** drop-down list, choose **Development** and uncheck **Test Team A**, then close the pane.

    We now have two concurrent Test stages.

    :::image type="content" source="../media/concurrent-test-stages-fbe8e9e0.png" alt-text="Multiple test stages.":::


## Stage versus Environment

You may have wondered why these items are called **Stages** and not **Environments**.

In the current configuration, we're using them for different environments. But it's not always the case. Here's a deployment strategy based upon regions instead:

:::image type="content" source="../media/region-based-deployment-strategy-1821beef.png" alt-text="Region-based deployment strategy.":::


Azure Pipelines are configurable and support a wide variety of deployment strategies. The name **Stages** is a better fit than **Environment** even though the stages can be used for environments.

For now, let's give the pipeline a better name and save the work.

12. At the top of the screen, hover over the **New release pipeline** name and when a pencil appears, click it to edit the name. Type **Release to all environments** as the name and hit enter or click elsewhere on the screen.

    :::image type="content" source="../media/change-the-pipeline-name-bc059674.png" alt-text="Change the pipeline name.":::


13. For now, save the environment-based release pipeline you've created by clicking **Save.** Then, **click OK** in the Save dialog box.
