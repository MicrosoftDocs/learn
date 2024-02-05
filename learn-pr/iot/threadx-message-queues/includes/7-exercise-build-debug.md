## Introduction

*ProjectMessageQueues.c* contains three threads and two queues, where one of the threads sends messages to the queues. The other two threads are waiting for messages from the queues, and they receive them as they're sent. You get to observe the behavior of the queues and the threads, and then modify the project by adding one thread and one queue.

> [!TIP]
> Refer to [Set up your environment](/training/modules/introduction-azure-rtos/2-set-up-environment?azure-portal=true) before getting started on the exercises in this module.

## Use GitHub Codespaces

1. Open the codespace you've created from GitHub repo. Once done, you can view the sample projects repo within VS Code web.

1. Expand the **TASK EXPLORER** pane and expand the **vscode** node to find the **Build / Clean / Run Project** tasks. Choose **Build Project** and select the run button.

   ![VSCode Web Task Explorer](../../introduction-azure-rtos/media/vscode-web-tasks.png)

1. Choose **ProjectMessageQueues** to build the project.

1. Now choose **Run Project** in the same **TASK EXPLORER**.

## Use Visual Studio

1. Open the solution `azure_rtos_threadx_training.sln` in Visual Studio.

1. In the **Solution Explorer**, right-click on **ProjectMessageQueues** and select **Set as Startup Project**.

1. Select the **Build** tab and choose **Build ProjectMessageQueues** to build your project. Then select the **Debug** tab, followed by **Start debugging** to debug your project.

## Complete the sample

If all has gone well, you should see initial output appearing on the screen similar to the following image:

:::image type="content" source="../media/figure-21-partial-output-from-project-message-queues.png" alt-text="Sample initial output." border="false":::

At 200 timer ticks, the Urgent thread received 14 messages, the Routine thread received 12 messages, and there was one message remaining in the Routine Queue. Can you predict what happens when another thread and another queue are added to the project?

Your task is to add a third thread called Important and a third queue that is also called Important. The Important thread has a priority of 12. The following diagram contains a modified scenario of your project with the addition of the Important thread and queue. The attributes of Urgent thread and Routine thread remain the same.

:::image type="content" source="../media/modified-scenario-message-queues.svg" alt-text="Diagram showing modified scenario of project message queues." border="false":::

The following diagram contains a description of the thread activities with the queue.

:::image type="content" source="../media/modified-activities-message-queues.svg" alt-text="Thread activities with the queue." border="false":::

> [!NOTE]
> The building blocks described in a previous unit contain tips about the modifications you need. We've summarized them here:

> - [Building block 1, part 2](/training/modules/threadx-message-queues/6-building-blocks#building-block-1-part-2) - Add one thread, two counters, one queue, and one prototype.
> - [Building block 3, part 1](/training/modules/threadx-message-queues/6-building-blocks#building-block-3-part-1) - Add one stack pointer and one queue pointer.
> - [Building block 3, part 2](/training/modules/threadx-message-queues/6-building-blocks#building-block-3-part-2) - Allocate stack space, create another thread, allocate queue space, create another queue.
> - [Building block 4 `dispatcher thread entry`](/training/modules/threadx-message-queues/6-building-blocks#building-block-4-dispatcher-thread-entry) - Increment the message counter and send messages to the new queue with a sleep time of 5.
> - [Building block 4 `routine thread entry`](/training/modules/threadx-message-queues/6-building-blocks#building-block-4-routine-thread-entry) - Use the Routine entry function as a guide to create the new Important entry function with a sleep time of 21.
> - [Building block 4 `print_stats`](/training/modules/threadx-message-queues/6-building-blocks#building-block-4-print-stats) - Get contents for the Important queue. Add `printf` statements to include the new thread counter, message number, and queue contents.

When you finish your modifications, save *ProjectMessageQueues.c*, and build and debug *ProjectMessageQueues* to produce output similar to the following image:

:::image type="content" source="../media/figure-25-final-output.png" alt-text="Final output for this project." border="false":::

At 200 timer ticks, the Dispatcher thread sent 30 messages, the Urgent thread received 10 messages, the Routine thread received 10 messages, and the Important thread received nine messages. There was one message in ImportantQueue, and the other two queues were empty. If you would allow this project to run longer, what would happen to the queues?
