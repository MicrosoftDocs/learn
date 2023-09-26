## Introduction

This project contains two threads that are synchronized with an event flags group, and you get to observe the result of adding a third thread to be synchronized. We use Visual Studio, and you have a C project named `ProjectEventFlags.c` to modify.

> [!TIP]
> Refer to [Set up your environment](/training/modules/introduction-azure-rtos/2-set-up-environment?azure-portal=true) before getting started on the exercises in this module.

## Use GitHub Codespaces

1. Open the codespace you have created from GitHub repo. Once done, you can view the sample projects repo within VS Code web.

1. Expand the **TASK EXPLORER** pane and expand the **vscode** node to find the **Build / Clean / Run Project** tasks. Choose **Build Project** and select the run button.

   ![VSCode Web Task Explorer](../../introduction-azure-rtos/media/vscode-web-tasks.png)

1. Choose **ProjectEventFlags** to build the project.

1. Now choose **Run Project** in the same **TASK EXPLORER**.

## Use Visual Studio

1. Open the solution `azure_rtos_threadx_training.sln` in Visual Studio.

1. In the **Solution Explorer**, right-click on **ProjectEventFlags** and select **Set as Startup Project**.

1. Select the **Build** tab and choose **Build ProjectEventFlags** to build your project. Then select the **Debug** tab, followed by **Start debugging** to debug your project.

## Complete the sample

If all has gone well, you should see initial output appearing on the screen similar to this example:

:::image type="content" alt-text="Diagram of partial output when you debug the project." source="../media/partial-output.png" loc-scope="Azure":::

> [!NOTE]
> The urgent thread has about twice as many resumptions and suspensions as the routine thread.

Your task is to add a third thread called Important, which has a priority of 10.

The following image contains a description of your project with the addition of the Important thread:

:::image type="content" alt-text="Diagram of modified project activities." source="../media/modified-activities.svg" loc-scope="Azure":::

The attributes of Urgent thread and Routine thread remain the same.

The building blocks unit has modifications you need to make; here's a summary:

- [Declarations](/training/modules/threadx-event-flags-group-sync-threads/7-building-blocks#declarations):
  - Define the Important thread.
  - Add another counter, thread performance variables, and a prototype.
- [Application definitions](/training/modules/threadx-event-flags-group-sync-threads/7-building-blocks#application-definitions): Create the Important thread.
- [Important thread entry function](/training/modules/threadx-event-flags-group-sync-threads/7-building-blocks#important-thread-entry): Add the thread entry function for the Important thread.
- [print_stats application timer function](/training/modules/threadx-event-flags-group-sync-threads/7-building-blocks#print-stats): Add a performance info get for the Important thread, and add three printf statements to display performance information for the Important thread

After you've made your modifications, build and debug *ProjectEventFlags* project to produce output similar to this example:

:::image type="content" alt-text="Diagram of the final output when you debug the project." source="../media/final-output.png" loc-scope="Azure":::

After 200 timer ticks, we observe that the Urgent and Important threads produce identical results. Even though the priorities and the sleep times of the threads are different, they're synchronized by the Monitor thread that sets the event flags group every 10 timer ticks.
