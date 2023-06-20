## Overview

Priority Inversion is a well-known problem with real-time embedded systems. It can result in system failure. Next, we look at the *ProjectPriorityInversion* project that contains a system that suffers from this problem. The purposes of this experiment are as follows:

- Build and debug the project and record the results in a chart.
- Modify the project so that priority inheritance is enabled; then build and debug the project and record the results in a chart.
- Disable priority inheritance and enable preemption-threshold; then build and debug the project, and record the results in a chart.
- Study the completed chart and compare the results.

The following image is a sample chart to record your results:

:::image type="content" alt-text="Diagram of a chart for experiment results." source="../media/results-chart.png" border="false" loc-scope="Azure":::

The actual results you receive vary between different computers, but the general trend of the results should be clear.

> [!TIP]
> Refer to [Set up your environment](/training/modules/introduction-azure-rtos/2-set-up-environment?azure-portal=true) before getting started on the exercises in this module.

## Use GitHub Codespaces

1. Open the codespace you've created from GitHub repo. Once done, you can view the sample projects repo within VS Code web.

1. Expand the **TASK EXPLORER** pane and expand the **vscode** node to find the **Build / Clean / Run Project** tasks. Choose **Build Project** and select the run button.

   ![VSCode Web Task Explorer](../../introduction-azure-rtos/media/vscode-web-tasks.png)

1. Choose **ProjectPriorityInversion** to build the project.

1. Now choose **Run Project** in the same **TASK EXPLORER**.

## Use Visual Studio

1. Open the solution `azure_rtos_threadx_training.sln` in Visual Studio.

1. In the **Solution Explorer**, right-click on **ProjectPriorityInversion** and select **Set as Startup Project**.

1. Select the **Build** tab and choose **Build ProjectPriorityInversion** to build your project. Then select the **Debug** tab, followed by **Start debugging** to debug your project.

## Complete the sample

### Priority inversion experiment

Start Visual Studio, then build and debug *ProjectPriorityInversion.c* (without modifications) to produce output similar to what appears in the following image.

> [!NOTE]
> Each run for this experiment takes several minutes, so please be patient.

:::image type="content" alt-text="Diagram that shows the output of the priority inversion experiment." source="../media/priority-inversion-results.png" loc-scope="Azure":::

These results are from *ProjectPriorityInversion*, where we deliberately created a priority inversion problem. There were 251 Routine solicited preemptions, which means that the Routine thread was preempted 251 times by the Urgent thread. These results imply that there were approximately 251 priority inversions because the Routine thread owns the mutex that the Urgent thread needs.

### Priority inheritance experiment

For our next experiment, let's eliminate priority inversion by enabling priority inheritance. As noted in the preceding unit, the mutex is created by running this code:

```c
/* Create the mutex used by Thread-1 and Thread-3
   **** for PRIORITY INHERITANCE change to TX_INHERIT  */
tx_mutex_create(&my_mutex, "my_mutex", TX_NO_INHERIT);
```

To use priority inheritance, change the mutex option to `tx_mutex_create(&my_mutex, "my_mutex", TX_INHERIT);`.

Build and debug *ProjectPriorityInversion.c* with this modification to produce output that should appear similar to the following output:

:::image type="content" alt-text="Diagram that shows the output of the priority inheritance experiment." source="../media/priority-inheritance-results.png" loc-scope="Azure":::

You get these results when you copy these two sets of experimental results into the chart:

:::image type="content" alt-text="Diagram of a chart with results from two experiments in a table." source="../media/two-results-comparison-chart.png"border="false"  loc-scope="Azure":::

There are several observations we can make immediately. First, there are zero Solicited Preemptions for the priority inheritance solution, which means there are zero priority inversions when priority inheritance is used. Furthermore, there are 514 mutex puts for priority inversion while there are 882 mutex puts for priority inheritance. The number of mutex puts is a reasonable measure for the amount of work produced, so it's clear that priority inversion is causing a significant problem and could lead to system failure.

## Preemption-threshold experiment

For our last experiment, let's eliminate priority inversion by first disabling priority inheritance and enabling preemption-threshold by creating the Routine thread:

```c
/* Create the Routine_thread. 

       **** for PREEMPTION-THRESHOLD, change 20,20 to 20,10  */ 

    tx_thread_create(&Routine_thread, "Routine_thread", 

                     Routine_thread_entry, 1, Routine_stack_ptr, 

                     STACK_SIZE, 20, 20, 

                     TX_NO_TIME_SLICE, TX_AUTO_START);
```

To use preemption-threshold, change the preemption-threshold value to 10. Build and debug *ProjectPriorityInversion.c* with this modification to produce output that should appear similar to this output:

:::image type="content" alt-text="Diagram of the output from the preemption-threshold experiment." source="../media/preemption-threshold-results.png" loc-scope="Azure":::

The following image contains the result of copying the third set of experimental results into the chart:

:::image type="content" alt-text="Diagram of a chart with results from three experiments in a table." source="../media/three-results-comparison-chart.png" border="false" loc-scope="Azure":::

There are zero Routine Solicited Preemptions for preemption-threshold, so the priority inversion problem was eliminated. However, there are 902 mutex puts, which are slightly more than for priority inheritance. There are 470 Routine thread resumptions for preemption-threshold, compared to 1,335 Routine thread resumptions for priority inheritance. These results mean that the preemption-threshold approach used far fewer context switches than priority inheritance, thus reducing system overhead. The same argument can be made for the remainder of the resumptions and suspensions.

The priority inversion results show the fewest number of resumptions and suspensions. Unfortunately, this result doesn't show an advantage because the system was operating at low capacity. It produced relatively little work, as evidenced by the relatively small number of mutex puts.

Both priority inheritance and preemption-threshold have the capability of eliminating priority inversion, which is the desired goal.
