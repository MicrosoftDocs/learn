## Overview

*ProjectEventChaining* project contains an example of a multiple object suspension system, and it contains two threads that suspend on two queues. Each thread needs to receive a message from either one of the two queues. A counting semaphore keeps a running count of how many messages are in the two queues combined. If a thread attempts to get an instance of the semaphore and suspends, then there are no messages on either of the queues. If a thread succeeds in getting an instance of the semaphore, then there is at least one message on one of the queues. The thread now needs to determine which queue has the message. Your task is to modify *ProjectEventChaining* project by adding another queue, so that two threads are accessing three queues.

> [!TIP]
> Refer to [Set up your environment](https://docs.microsoft.com/learn/modules/introduction-azure-rtos/2-set-up-environment?azure-portal=true) before getting started on the exercises in this module.

## Use GitHub Codespaces

1. Open the codespace you've created from GitHub repo. Once done, you can view the sample projects repo within VSCode web.

1. Expand the **TASK EXPLORER** pane and expand the **vscode** node you'll find **Build / Clean / Run Project** tasks. Choose **Build Project** and select the run button.

   ![VSCode Web Task Explorer](../../introduction-azure-rtos/media/vscode-web-tasks.png)

1. Choose **ProjectEventChaining** to build the project.

1. Now choose **Run Project** in the same **TASK EXPLORER**.

## Use Visual Studio

1. Open the solution `azure_rtos_threadx_training.sln` in Visual Studio.

1. In the **Solution Explorer**, right click on **ProjectEventChaining** and select **Set as Startup Project**.

1. Select the **Build** tab and choose **Build ProjectEventChaining** to build your project. Then select the **Debug** tab, followed by **Start debugging** to debug your project.

## Complete the sample

If all has gone well, you should see initial output appearing on the screen similar to the following image:

:::image type="content" alt-text="Diagram that illustrates the partial output." source="../media/partial-output.png" loc-scope="Azure":::

At 500 timer ticks, the Urgent thread made 69 cycles with an average time of 7 timer ticks. The Routine thread made 24 cycles with an average time of 24 timer ticks. Queue_1 received 41 messages, and Queue_2 received 55 messages, but 1 message was still in the queue.  

Your task is to modify ProjectEventChaining.c by adding a third queue. The new scenario is illustrated in the following image:

:::image type="content" alt-text="Diagram that illustrates a modified event-chaining scenario." source="../media/modified-project-scenario.svg" loc-scope="Azure":::

This image contains a description of the activities of your modified project:

:::image type="content" alt-text="Diagram that illustrates modified event-chaining activities." source="../media/modified-project-activities.svg" loc-scope="Azure":::

Several comments in the building blocks suggest which modifications need to be performed:

- [Declarations](https://review.docs.microsoft.com/learn/modules/threadx-event-chain-suspend-objects/7-building-blocks#declarations): Use the suggested queue timer intervals, define another queue and queue timer.
- [Variables](https://review.docs.microsoft.com/learn/modules/threadx-event-chain-suspend-objects/7-building-blocks#variables): Add a variable for queue contents, queue timer entry prototype, and event notification function prototype.
- [Application definitions](https://review.docs.microsoft.com/learn/modules/threadx-event-chain-suspend-objects/7-building-blocks#application-definitions): Add another queue pointer. Then, create another queue timer and create another notification function registration.
- [Urgent thread entry function](https://review.docs.microsoft.com/learn/modules/threadx-event-chain-suspend-objects/7-building-blocks#urgent-thread-entry): Modify the if statement to check for three queues.
- [Routine thread entry function](https://review.docs.microsoft.com/learn/modules/threadx-event-chain-suspend-objects/7-building-blocks#routine-thread-entry): Modify the `if statement to check for three queues.
- [print_stats application timer function](https://review.docs.microsoft.com/learn/modules/threadx-event-chain-suspend-objects/7-building-blocks#print-stats): Add one queue info get statement, and add two printf statements to display message information.
- [Notification functions](https://review.docs.microsoft.com/learn/modules/threadx-event-chain-suspend-objects/7-building-blocks#notification-functions): Add another notification function for the new queue.

When you've completed these modifications, built and debugged your project, then output should be similar to what's shown in the following image:

:::image type="content" alt-text="Diagram that illustrates the final output from running the code." source="../media/final-output.png" loc-scope="Azure":::

At 500 timer ticks, the Urgent counter is 68, and the Routine thread counter is 24. The reason these numbers differ from the partial output is that the number of queues changed, and the queue timer intervals also changed. The average times for both Urgent and Routine threads remain unchanged because they still require the same amount of time to process each message, regardless of the number of messages or queues. Queue_3 was sent the largest number of messages because its queue timer interval was the smallest. All three of the queues were empty at 500 timer ticks. How much time would be required before at least one of the queues wasn't empty?
