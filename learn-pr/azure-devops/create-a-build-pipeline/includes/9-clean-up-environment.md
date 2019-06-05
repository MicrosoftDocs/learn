You're all done with the tasks for this module. Here, you'll move the work item to the **Done** state on Azure Boards and clean up your Azure DevOps environment.

> [!IMPORTANT]
> This page contains important cleanup steps. Cleaning up helps ensure that you don't run out of free build minutes. Be sure to perform the cleanup steps if you ran the template earlier in this module.

## Move the work item to Done

Here, you'll move the work item you assigned to yourself earlier in this module, **Stabilize the build server**, to the **Done** state.

In practice, the definition of "Done" often means working software in the hands of your users. For learning purposes, here we'll mark this work as complete because you have a working build system on Azure Pipelines.

At the end of each Sprint, or work iteration, you and your team might hold a retrospective meeting, where you share the work you completed and what went well in the Sprint, and what could be improved.

To complete the work item:

1. From Azure DevOps, navigate to **Boards** and then select **Boards** from the menu.
1. Move the **Stabilize the build server** work item from the **Doing** to the **Done** column.

    ![](..//media/9-azure-boards-wi1-done.png)

## Disable the pipeline or delete your project

TODO: Emphasize why this is important (multiple projects pointing to same GitHub repo. Each will trigger builds, which consumes your free build minutes. You don't want to run out of build minutes.)

TODO: Talk about the two options:

1. Disable pipeline
1. Delete the project

TODO: Walk the learner through both options...