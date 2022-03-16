## Introduction

We'll use the same scenario for this project as we did for ProjectHelloWorld and ProjectAnalyze. However, we'll modify the processing times for Urgent thread and Routine thread. We'll also introduce a new thread called Monitor that will periodically check the status of Urgent thread and Routine thread to determine whether they're experiencing lengthy delays.

The following image contains an illustration of the ProjectBreakSuspension project activities.

:::image type="content" alt-text="Diagram that shows urgent and routine ProjectBreakSuspension activities." source="../media/thread-activities.svg" loc-scope="Azure":::

The Monitor thread periodically checks the Urgent thread and the Routine thread to determine whether either thread has been idle for an excessive amount of time.

The following image contains an illustration of the Monitor thread:

:::image type="content" alt-text="Diagram that illustrates how the Monitor thread interacts with the Urgent and Routine threads." source="../media/monitor-thread.svg" loc-scope="Azure":::

If the Monitor thread determines that a thread has been idle for a long time, it considers that thread to be stalled, and it aborts the suspension condition for that thread.

The following image contains an illustration of the Monitor thread aborting the suspension of the Urgent thread:

:::image type="content" alt-text="Diagram that illustrates how the Monitor thread aborts the suspension of the Urgent thread." source="../media/monitor-urgent-thread.png" loc-scope="Azure":::

We'll use a counting semaphore to control when each thread checks either the Urgent or the Routine thread for excessive wait times.